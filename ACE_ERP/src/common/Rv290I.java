package common;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

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

public class Rv290I extends SuperServlet {

	public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//사업소
		arr_sql[0].append ("SELECT SAUP_SID,			\n")
					.append ("				SAUP_NM			\n")
					.append ("FROM SALES.TSY200			\n");
		
		//	출경시간	
		arr_sql[1].append ("SELECT ''                 AS DEPART_TIME,				\n")
					.append ("		'전체'             AS DEPART_TIME_NM				\n")
					.append ("FROM SYSIBM.SYSDUMMY1				\n")
					.append ("UNION ALL				\n")
					.append ("SELECT DETAIL,				\n")
					.append ("		DETAIL_NM				\n")
					.append ("FROM SALES.TSY010				\n")
					.append ("WHERE HEAD  = 'RM014'				\n")
					.append ("	AND ITEM1 = 'Y'					\n");
		
		//상품
		arr_sql[2].append ("SELECT 0                   AS GOODS_SID,					\n")     
					.append ("		'전체'              AS GOODS_NM       					\n")
					.append ("FROM SYSIBM.SYSDUMMY1					\n")
					.append ("UNION ALL					\n")
					.append ("SELECT GOODS_SID,					\n")
					.append ("		GOODS_NM					\n")
					.append ("FROM SALES.TRM200 R1					\n")
					.append ("WHERE SAUP_SID    =  ?					\n")
					.append ("	AND USE_YN      =  'Y'					\n");
		
		//고객구분
		arr_sql[3].append ("SELECT										\n")
					.append ("	'' DETAIL, '전체' DETAIL_NM    \n")
					.append ("FROM SYSIBM.SYSDUMMY1                       \n")
					.append ("UNION ALL                                   \n")		
					.append ("SELECT  					\n")
					.append ("		DETAIL,  					\n") 
					.append ("		DETAIL_NM  					\n")         
					.append ("FROM SALES.TSY010				\n")
					.append ("WHERE HEAD    =  'CU001'		\n")
					.append ("	AND DETAIL  >  ' '						\n")
					.append ("	AND ITEM1   =  'Y'   					\n");
		//취소코드
		arr_sql[4].append ("SELECT DETAIL        AS    CANCEL_CD,			\n")
					.append ("		DETAIL_NM     AS    CANCEL_NM			\n")
					.append ("FROM SALES.TSY010			\n")
					.append ("WHERE HEAD  = 'RV005'			\n")
					.append ("	AND ITEM1 = 'Y'					\n");
	}

    
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DS2")){
						stmt = conn.getGauceStatement(arr_sql[0].toString());
					}
					if(gauceName.equals("DS3")){
						stmt = conn.getGauceStatement(arr_sql[1].toString());
					}						
					if(gauceName.equals("DS5")){
						stmt = conn.getGauceStatement(arr_sql[3].toString());
					} 												
					if(gauceName.equals("DS6")){
						stmt = conn.getGauceStatement(arr_sql[4].toString());
					} 																			
					rs = stmt.executeQuery(); // DataSet set
					getDataSet(rs, ds1).flush();
				}
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	
	}	
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			String 		sSERIAL_NO		= HDUtil.nullCheckStr(req.getParameter("sSERIAL_NO"));  //serial_no
			String  	    sMODEL			    = HDUtil.nullCheckStr(req.getParameter("sMODEL"));		// 모델
 			String 		sKIND					= HDUtil.nullCheckStr(req.getParameter("sKIND")); //품명
			String 		sClient_nm			= HDUtil.nullCheckStr(req.getParameter("sClient_nm")); //소속업체
			String 		sNAME					= HDUtil.nullCheckStr(req.getParameter("sKIND")); //사용자 이름
			String 		sUSE					= HDUtil.nullCheckStr(req.getParameter("sNAME")); //용도
			String 		sfrom_out_dt		= HDUtil.nullCheckStr(req.getParameter("sfrom_out_dt")); //반출일
			String 		sto_out_dt			= HDUtil.nullCheckStr(req.getParameter("sto_out_dt")); //반출일
			String 		sfrom_in_dt			= HDUtil.nullCheckStr(req.getParameter("sfrom_in_dt")); //반입일
			String 		sto_in_dt				= HDUtil.nullCheckStr(req.getParameter("sto_in_dt")); //반입일

			
		
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			

			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
							res.enableFirstRow(ds1);
							
							cstmt = conn.prepareCall("{call SALES.PR_RV290I_01(?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
							
							cstmt.setString(1, sSERIAL_NO);
							cstmt.setString(2, sMODEL);
							cstmt.setString(3, sKIND);
							cstmt.setString(4, sClient_nm);
							cstmt.setString(5, sNAME);
							cstmt.setString(6, sUSE);
							cstmt.setString(7, sfrom_out_dt);
							cstmt.setString(8, sto_out_dt);
							cstmt.setString(9, sfrom_in_dt);
					        cstmt.setString(10, sto_in_dt);
							
							rs = cstmt.executeQuery();							
							getDataSet(rs, ds1).flush();
									
							
							}
				}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	/**
	 * 기능 :
	 */
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceDataSet inputDs = req.getGauceDataSet("DEFAULT");
		GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
		CallableStatement cstmt = null;
		boolean fail=false;	
		
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;

		try{
			if(inputDs!=null){
				
				
				int colNm_KIND             = inputDs.indexOfColumn("KIND");
				int colNm_SN				 = inputDs.indexOfColumn("SN");
				int colNm_CPU              = inputDs.indexOfColumn("CPU");
				int colNm_HDD              = inputDs.indexOfColumn("HDD");
				int colNm_RAM              = inputDs.indexOfColumn("RAM");
				int colNm_MODEL          = inputDs.indexOfColumn("MODEL");
				int colNm_CLIENT_NM    = inputDs.indexOfColumn("CLIENT_NM");
				int colNm_NAME             = inputDs.indexOfColumn("NAME");
				int colNm_OUT_DT          = inputDs.indexOfColumn("OUT_DT");
				int colNm_IN_DT              = inputDs.indexOfColumn("IN_DT");
				int colNm_USE        	    = inputDs.indexOfColumn("USE");
				int colNm_NOTE             	= inputDs.indexOfColumn("NOTE");
	
					
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				//메시지처리
				res.enableFirstRow(msgDS);
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));				
				
				inner : {
					for(int i=0; i<rows.length; i++){
						int j=1;
						switch(rows[i].getJobType()){
							//인서트
							case GauceDataRow.TB_JOB_INSERT:
							cstmt = conn.prepareCall("{call SALES.PR_RV290I_02( ?,?,?,?,?  ,?,?,?,?,?  ,?,?,?,?,?  ,?,?) }");						
							cstmt.setString(1, rows[i].getString(colNm_KIND));
							cstmt.setString(2, rows[i].getString(colNm_SN));
							cstmt.setString(3, rows[i].getString(colNm_CPU));
							cstmt.setString(4, rows[i].getString(colNm_HDD));
							cstmt.setString(5, rows[i].getString(colNm_RAM));
							cstmt.setString(6, rows[i].getString(colNm_MODEL));
							cstmt.setString(7, rows[i].getString(colNm_CLIENT_NM));
							cstmt.setString(8, rows[i].getString(colNm_NAME));
							cstmt.setString(9, rows[i].getString(colNm_OUT_DT));
							cstmt.setString(10, rows[i].getString(colNm_IN_DT));
							cstmt.setString(11, rows[i].getString(colNm_USE));
							cstmt.setString(12, rows[i].getString(colNm_NOTE));	
							cstmt.setString(13, iParamEmpno);							
							cstmt.setString(14, "1");
							cstmt.registerOutParameter(15, java.sql.Types.VARCHAR); 
							cstmt.registerOutParameter(16, java.sql.Types.VARCHAR); 
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR); 					
										
							cstmt.executeUpdate();
															
								//메시지처리
								 if (cstmt.getString(15).equals("Y") ) {
									if ( !cstmt.getString(16).equals("0000") ) {
										StringUtil.printMsg("성공메시지",cstmt.getString(17),this);
										GauceDataRow row = msgDS.newDataRow();
										row.addColumnValue(cstmt.getString(16));								
										msgDS.addDataRow(row);
									}
								 } else {
									StringUtil.printMsg("실패메시지",cstmt.getString(17),this);								
									conn.rollback();
									GauceDataRow row = msgDS.newDataRow();
									row.addColumnValue(cstmt.getString(16));							
									msgDS.addDataRow(row);
									fail = true;
									break inner;						
								}  		
								if(cstmt!=null) cstmt.close();
								break;
							//업데이트
							case GauceDataRow.TB_JOB_UPDATE:
							cstmt = conn.prepareCall("{call SALES.PR_RV290I_02( ?,?,?,?,?  ,?,?,?,?,?   ,?,?,?,?,?  ,?,?) }");						
							
							cstmt.setString(1, rows[i].getString(colNm_KIND));
							cstmt.setString(2, rows[i].getString(colNm_SN));
							cstmt.setString(3, rows[i].getString(colNm_CPU));
							cstmt.setString(4, rows[i].getString(colNm_HDD));
							cstmt.setString(5, rows[i].getString(colNm_RAM));
							cstmt.setString(6, rows[i].getString(colNm_MODEL));
							cstmt.setString(7, rows[i].getString(colNm_CLIENT_NM));
							cstmt.setString(8, rows[i].getString(colNm_NAME));
							cstmt.setString(9, rows[i].getString(colNm_OUT_DT));
							cstmt.setString(10, rows[i].getString(colNm_IN_DT));
							cstmt.setString(11, rows[i].getString(colNm_USE));
							cstmt.setString(12, rows[i].getString(colNm_NOTE));	
							cstmt.setString(14, iParamEmpno);							
							cstmt.setString(15, "3");
							cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(18, java.sql.Types.VARCHAR); 						
													
							cstmt.executeUpdate();
																		
								//메시지처리
								 if (cstmt.getString(15).equals("Y") ) {
									if ( !cstmt.getString(16).equals("0000") ) {
										StringUtil.printMsg("성공메시지",cstmt.getString(17),this);
										GauceDataRow row = msgDS.newDataRow();
										row.addColumnValue(cstmt.getString(16));								
										msgDS.addDataRow(row);
									}
								 } else {
									StringUtil.printMsg("실패메시지",cstmt.getString(17),this);								
									conn.rollback();
									GauceDataRow row = msgDS.newDataRow();
									row.addColumnValue(cstmt.getString(16));							
									msgDS.addDataRow(row);
									fail = true;
									break inner;						
								}  		
								if(cstmt!=null) cstmt.close();
								break;
										//DELETE
							case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall("{call SALES.PR_RV290I_02( ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?, ?) }");						
							
							cstmt.setString(1, rows[i].getString(colNm_KIND));
							cstmt.setString(2, rows[i].getString(colNm_SN));
							cstmt.setString(3, rows[i].getString(colNm_CPU));
							cstmt.setString(4, rows[i].getString(colNm_HDD));
							cstmt.setString(5, rows[i].getString(colNm_RAM));
							cstmt.setString(6, rows[i].getString(colNm_MODEL));
							cstmt.setString(7, rows[i].getString(colNm_CLIENT_NM));
							cstmt.setString(8, rows[i].getString(colNm_NAME));
							cstmt.setString(9, rows[i].getString(colNm_OUT_DT));
							cstmt.setString(10, rows[i].getString(colNm_IN_DT));
							cstmt.setString(11, rows[i].getString(colNm_USE));
							cstmt.setString(12, rows[i].getString(colNm_NOTE));	
							cstmt.setString(13, iParamEmpno);							
							cstmt.setString(14, "2");
							cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(17, java.sql.Types.VARCHAR); 						
													
							cstmt.executeUpdate();
																		
								//메시지처리
								 if (cstmt.getString(15).equals("Y") ) {
									if ( !cstmt.getString(16).equals("0000") ) {
										StringUtil.printMsg("성공메시지",cstmt.getString(17),this);
										GauceDataRow row = msgDS.newDataRow();
										row.addColumnValue(cstmt.getString(16));								
										msgDS.addDataRow(row);
									}
								 } else {
									StringUtil.printMsg("실패메시지",cstmt.getString(17),this);								
									conn.rollback();
									GauceDataRow row = msgDS.newDataRow();
									row.addColumnValue(cstmt.getString(16));							
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
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			msgDS.flush();			
			if(cstmt!=null) cstmt.close();
			if( fail == true ) throw new Exception("");			
		}
	}
}
