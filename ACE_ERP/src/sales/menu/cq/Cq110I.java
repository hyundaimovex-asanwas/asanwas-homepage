package sales.menu.cq;

import oracle.jdbc.OracleTypes;

import java.util.*;
import java.sql.*;
import java.io.*;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

public class Cq110I extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		/*
		 * 사업소SID, 상품SID, 작업구분, 출경일자, 출경시간
		 */
		arr_sql[1].append("CALL SALES.PR_CQ110I_01(?,?,?,?,?		,?)");	// 조회
		
		/*
		 * 예약 SId, 선택 T, F
		 */
		arr_sql[2].append("CALL SALES.PR_CQ110I_02(?,?)"); // 업데이트 (저장)
		
	}

	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		ResultSetMetaData rsmd = null;
		
		String[] 			columnName 	= null;
		
		
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		/*
		 * 검색시 필요한 조건
		 */
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		int sSaup_sid 		= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));	// 사업소
		int sGood_sid 		= HDUtil.nullCheckNum(greq.getParameter("sGoodSid")); 	// 상품 
		String sSaup_gu		= HDUtil.nullCheckStr(greq.getParameter("sSaup_gu"));	// 사업구분(작업구분)
		String sDepatrDate 	= HDUtil.nullCheckStr(greq.getParameter("sDepartDate")); 	// 출경일자
		String sDepartTime	= HDUtil.nullCheckStr(greq.getParameter("sDepartTime")); // 출경시간
		
		//StringUtil.printMsg("사업소", sSaup_sid,this);
		//StringUtil.printMsg("상품",sGood_sid ,this);
		//StringUtil.printMsg("사업구분",sSaup_gu ,this);
		///StringUtil.printMsg("출경일자",sDepatrDate ,this);
		//StringUtil.printMsg("출경시간", sDepartTime,this);
		
		
		try {
			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int j=0; j<dSets.length;j++){	
				//기본 검색 내역
				if(dSets[j].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					switch(dsType){
						case 1:
							//res.enableFirstRow(ds1);
							
							cstmt = conn.prepareCall(arr_sql[1].toString());
							
							cstmt.setInt(1, sSaup_sid);
							cstmt.setInt(2, sGood_sid);
							cstmt.setString(3, sSaup_gu);
							cstmt.setString(4, sDepatrDate);
							cstmt.setString(5, sDepartTime);
							cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//결과를 받을 커서
							cstmt.executeQuery();
							rs = (ResultSet)cstmt.getObject(6);	//커서 OUT param. 			
							gos.write(getDataSet(rs, ds1));							
							
							rsmd = rs.getMetaData();
							columnName = new String[rsmd.getColumnCount()];
							for(int i=0; i<columnName.length; i++){
								columnName[i] = rsmd.getColumnName(i+1);
								
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
								else
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1) ));
							}
							
							ds1.addDataColumn(new GauceDataColumn("IS_FLAG", GauceDataColumn.TB_STRING));
							
							while ( rs.next()) {
								GauceDataRow row = ds1.newDataRow();
								for(int i=0; i<columnName.length; i++) {
									if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
										row.addColumnValue(rs.getInt(columnName[i]));
									else
										row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
								}
								
								row.addColumnValue("Y");	
								
								ds1.addDataRow(row);
							}
							
							if(rs!=null) rs.close();
							if(stmt!=null) stmt.close();

							break;
						case 2:
							break;
						case 3:
							break;
					}
				}
				
			}//gos.close();
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}


	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {			
				
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt = null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        /* DataSet */
		GauceDataSet ds1 	= gis.read("DS1");
		
		try {
			if (ds1 != null) {
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
				int colNm_RsvSid      = ds1.indexOfColumn("RSV_SID");	//이게 DS의 컬럼명과 대소문자 구분을 하네..-_-;
				int colNm_StatusCd	  = ds1.indexOfColumn("STATUS_CD");
				 
				for(int i=0; i<rows.length; i++){
				switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_UPDATE:
						
						cstmt = conn.prepareCall(arr_sql[2].toString());
						
						cstmt.setInt(1, rows[i].getInt(colNm_RsvSid));
						cstmt.setString(2, rows[i].getString(colNm_StatusCd));
						// 쿼리실행
						cstmt.executeUpdate();
						
						break;
					}
				}
			}
			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			//msgDS.flush();
			//if(stmt!=null) stmt.close();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}
