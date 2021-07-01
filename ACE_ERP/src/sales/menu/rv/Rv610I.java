package sales.menu.rv;

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

public class Rv610I extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Main 조회
		arr_sql[0].append ("{call SALES.PR_RV610I_01(?,?,?) }" );
		
		//Sub 조회
		arr_sql[1].append ("{call SALES.PR_RV610I_02(?,?) }" );
		
		//Main 저장
		arr_sql[2].append ("{call SALES.PR_RV610I_03(?, ?, ?, ?, ?, ?, ?, ?) }");
		
		//Sub 저장
		arr_sql[3].append ("{call SALES.PR_RV610I_04(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
   }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}	
	
	// 조회 method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	/* DataBase */
    	CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			// 검색시 조건
			String 	v_fr_date		= HDUtil.nullCheckStr(greq.getParameter("v_fr_date"));
			String 	v_to_date		= HDUtil.nullCheckStr(greq.getParameter("v_to_date"));
			String 	v_depart_date	= HDUtil.nullCheckStr(greq.getParameter("v_depart_date"));
			
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("ds_master")){
						GauceDataSet ds1 = gis.read("MASTER");
						cstmt = conn.prepareCall(arr_sql[0].toString());							
						cstmt.setString(1, v_fr_date);
						cstmt.setString(2, v_to_date);
						cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
					} else  if(dSets[i].getName().equals("ds_detail")){
						GauceDataSet ds2 = gis.read("DETAIL");
						cstmt = conn.prepareCall(arr_sql[1].toString());							
						cstmt.setString(1, v_depart_date);
						cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(2);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds2));
					}
				}
				
				if(rs!=null) rs.close();
				if(cstmt!=null) cstmt.close();
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

	/**
	 * 기능 :
	 * @param req
	 * @param res
	 *
	 */
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
    	GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		
		GauceDataSet inputDs = gis.read("DEFAULT");
		GauceDataSet ds_result = gis.read("RESULT");
		
		GauceDataSet ds1 = gis.read("MASTER");
		GauceDataSet ds2 = gis.read("DETAIL");
		
		CallableStatement cstmt = null;
		
		try{
			String 	v_depart_date	= HDUtil.nullCheckStr(greq.getParameter("v_depart_date"));
			
			//메시지처리
			if(ds_result!=null){
				//res.enableFirstRow(ds_result);
				ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
				ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
			}
			
			if(ds1!=null){
				//StringUtil.printMsg("ds1!=null","ds1!=null",this);
				GauceDataRow[] 		rows = ds1.getDataRows();
					for(int i=0; i<rows.length; i++){
							switch(rows[i].getJobType()){
								case GauceDataRow.TB_JOB_UPDATE:
									cstmt = conn.prepareCall(arr_sql[2].toString());
									
									cstmt.setString(1, rows[i].getString(0));
									cstmt.setString(2, rows[i].getString(2));
									cstmt.setString(3, fParamEmpno);
									cstmt.setString(4, fParamIp);
									cstmt.setString(5, "3");
									cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
									cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
									cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
									
									cstmt.executeUpdate();
						
									String r_s_yn		= cstmt.getString(6);
									String r_msg_cd	 	= cstmt.getString(7);
									String r_msg		= cstmt.getString(8);
									
									if(!r_s_yn.equals("Y"))
										throw new Exception(r_msg);
									
									if(ds_result!=null){
										/*
										GauceDataRow row1 = ds_result.newDataRow();
										row1.addColumnValue(r_s_yn);
										row1.addColumnValue(r_msg_cd);
										row1.addColumnValue(r_msg);
										
										ds_result.addDataRow(row1);
										*/
										ds_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
										ds_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
										ds_result.put("MSG", 	r_msg, 200);//커서 OUT param.
										ds_result.heap();	
									}
									if(cstmt!=null) cstmt.close();
									
									break;
							}
							if(ds_result!=null) gos.write(ds_result);
						}//for(int i=0; i<rows.length; i++) the end...
					}//if(gauceName.equals("MASTER")) the end...
					
			if(ds2!=null){
				//StringUtil.printMsg("ds2!=null","ds2!=null",this);
				GauceDataRow[] 		rows = ds2.getDataRows();
						String v_row_status = "";
						
						for(int i=0; i<rows.length; i++){
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_INSERT)
								v_row_status = "1";
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_DELETE)
								v_row_status = "2";
							if(rows[i].getJobType()==GauceDataRow.TB_JOB_UPDATE)
								v_row_status = "3";
							
							switch(rows[i].getJobType()){
								case GauceDataRow.TB_JOB_UPDATE:
								case GauceDataRow.TB_JOB_INSERT:
									cstmt = conn.prepareCall(arr_sql[3].toString());
									
									cstmt.setString(1, v_depart_date);
									cstmt.setString(2, rows[i].getString(0));
									cstmt.setString(3, rows[i].getString(2));
									cstmt.setString(4, rows[i].getString(4));
									cstmt.setString(5, fParamEmpno);
									cstmt.setString(6, fParamIp);
									cstmt.setString(7, v_row_status);
									cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
									cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
									cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
									
									cstmt.executeUpdate();
						
									String r_s_yn		= cstmt.getString(8);
									String r_msg_cd	 	= cstmt.getString(9);
									String r_msg		= cstmt.getString(10);
									
									if(!r_s_yn.equals("Y"))
										throw new Exception(r_msg);
									
									if(ds_result!=null){
										/*
										GauceDataRow row1 = ds_result.newDataRow();
										row1.addColumnValue(r_s_yn);
										row1.addColumnValue(r_msg_cd);
										row1.addColumnValue(r_msg);
										
										ds_result.addDataRow(row1);
										*/
										ds_result.put("S_YN", 	r_s_yn, 1);//커서 OUT param.
										ds_result.put("MSG_CD", r_msg_cd, 4);//커서 OUT param.
										ds_result.put("MSG", 	r_msg, 200);//커서 OUT param.
										ds_result.heap();	
									}
									if(cstmt!=null) cstmt.close();
									
									break;
							}
							if(ds_result!=null) gos.write(ds_result);
					}//if(gauceName.equals("MASTER")) the end...
			}//if(gauceName.equals("MASTER")) the end...
			gos.close();
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e) {
			gres.addException(e);
			throw e;
		} finally {
			//msgDS.flush();
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}
