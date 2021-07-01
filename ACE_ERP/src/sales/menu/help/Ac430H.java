package sales.menu.help;
/**********************************************************************************
 * 환불처리상세 팝업 
 **********************************************************************************/
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
  
public class Ac430H extends SuperServlet {
	                                       
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC430H_01(?,?,?)"); // 조회1
		
		arr_sql[2].append("{call SALES.PR_AC430H_03(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");	// 저장
	}

	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		CallableStatement cstmt = null;		
		//GauceStatement stmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null; //  
		
		/*
		 * 검색시 필요한 조건
		 */
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		String sRsv_sid 	= HDUtil.nullCheckStr(greq.getParameter("sRsv_sid"));	// RSV_SID
		
		//StringUtil.printMsg("java:::::::::sRsv_sid::",sRsv_sid+"",this);
		

		try {
			
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput();
			
			 ds1 = new GauceDataSet(); // Dataset(TRM030) 
			
						switch(dsType){
							case 1:
							
							  //res.enableFirstRow(ds1);	
								cstmt = conn.prepareCall(arr_sql[1].toString());
							
								cstmt.setString(1,sRsv_sid);
							  cstmt.setInt(2,dsType);
							
							  cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
								
								cstmt.executeQuery();
								rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 			
								gos.write(getDataSet(rs, ds1));
							
						}
		} catch (SQLException sqle){
			//gres..writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			//gres..writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
			/* DataSet */
	
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			/* DataSet */
			GauceDataSet ds1 = gis.read("DEFAULT");
			GauceDataSet msgDS = gis.read("msgDS");
				
			CallableStatement cstmt = null;	
			ResultSet 		rs 			= null;
			boolean fail=false;			

			/** 
			 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
			 **/
			String iParamEmpno = fParamEmpno;
			String iParamIp = fParamIp;		
		try {
			
			
				if(ds1!=null){
				
							int colNm_PAY_SID                 = ds1.indexOfColumn("PAY_SID");                 //결재SID 
							int colNm_RSV_SID                 = ds1.indexOfColumn("RSV_SID");                // 예약번호
							int colNm_PAY_MANAGE_NO  = ds1.indexOfColumn("PAY_MANAGE_NO");  // 결재관리번호
							int colNm_PAY_CD                  = ds1.indexOfColumn("PAY_CD");                 // 입금구분
							int colNm_PAY_AMT3              = ds1.indexOfColumn("PAY_AMT3");             // 환불
							int colNm_PAY_AMT4              = ds1.indexOfColumn("PAY_AMT4");             // 환입 
						
							GauceDataRow[] 	 	   rows = ds1.getDataRows();
							GauceDataColumn[]  cols = ds1.getDataColumns();
				
							//메시지처리
							//res.enableFirstRow(msgDS);
							msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));				
				
							inner : {
							for(int i=0; i<rows.length; i++){
									int j=1;
									switch(rows[i].getJobType()){
									case GauceDataRow.TB_JOB_UPDATE:
									  									
										//cstmt = conn.prepareCall("{call SALES.PR_AC430H_03(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");  //12개		
										cstmt = conn.prepareCall(arr_sql[2].toString());
										
										cstmt.setInt(1, rows[i].getInt(colNm_PAY_SID));
										cstmt.setInt(2, rows[i].getInt(colNm_RSV_SID));
										cstmt.setString(3, rows[i].getString(colNm_PAY_MANAGE_NO));									
										cstmt.setString(4, rows[i].getString(colNm_PAY_CD));
										cstmt.setInt(5, rows[i].getInt(colNm_PAY_AMT3));
										cstmt.setInt(6, rows[i].getInt(colNm_PAY_AMT4));						
										
										cstmt.setString(7, iParamEmpno);
										cstmt.setString(8, iParamIp);
										cstmt.setString(9, "3");
										
										cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
										cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
										cstmt.registerOutParameter(12, java.sql.Types.VARCHAR); 						
		
										cstmt.executeUpdate();
							
										//메시지처리
										if (cstmt.getString(10).equals("Y") ) {
											if ( !cstmt.getString(11).equals("0000") ) {
												StringUtil.printMsg("성공메시지",cstmt.getString(12),this);
												GauceDataRow row = msgDS.newDataRow();
												row.addColumnValue(cstmt.getString(12));								
												msgDS.addDataRow(row);
											}
										} else {
											StringUtil.printMsg("실패메시지",cstmt.getString(12),this);								
											conn.rollback();
											GauceDataRow row = msgDS.newDataRow();
											row.addColumnValue(cstmt.getString(12));							
											msgDS.addDataRow(row);
											fail = true;
											break inner;						
										}  		
							
										if(cstmt!=null) cstmt.close();
										break;
									}
								}
							}
						}
			
			
			
			/*******막음.
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					if ("DS1".equals(gauceName)) {
						GauceDataRow[] 		    rows = ds1.getDataRows();
						GauceDataColumn[] 	cols = ds1.getDataColumns();
						
						int colNm_CalnDate    = ds1.indexOfColumn("DEPART_DATE");
						int colNm_GoodsSid  = ds1.indexOfColumn("GOODS_SID");
						int colNm_CloseYn	  = ds1.indexOfColumn("CLOSE_YN");

						//StringUtil.printMsg("출발일",colNm_CalnDate+"",this);
						//StringUtil.printMsg("상품",colNm_GoodsSid+"",this);
						//StringUtil.printMsg("마감여부",colNm_CloseYn+"",this);
						
						for(int i=0; i<rows.length; i++){
						switch(rows[i].getJobType()){
							case GauceDataRow.TB_JOB_UPDATE:
								
								cstmt = conn.prepareCall(arr_sql[2].toString());
								
								//StringUtil.printMsg("=============================== 마스터 신규 =========================",this);
								
								cstmt.setString(1, rows[i].getString(colNm_CalnDate));
								cstmt.setInt(2, rows[i].getInt(colNm_GoodsSid));
								cstmt.setString(3, rows[i].getString(colNm_CloseYn));
								cstmt.setString(4, iParamEmpno);
								cstmt.setString(5, iParamIp);
								cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
								cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
								// 쿼리실행
								cstmt.executeUpdate();
								
								break;
							}
						}//FOR
					}//IF
				}//IF
			}//WHILE
			**/
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
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}
