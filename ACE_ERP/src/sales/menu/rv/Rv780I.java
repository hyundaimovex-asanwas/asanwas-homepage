package sales.menu.rv;

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

public class Rv780I extends SuperServlet {

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
		StringUtil.printMsg("# Command","선조회",this);
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
				StringUtil.printMsg("name",gauceName,this);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					
					if(gauceName.equals("DS2")){
						//StringUtil.printMsg("arr_sql[0].toString()",arr_sql[0].toString(),this);								
						stmt = conn.getGauceStatement(arr_sql[0].toString());
					}
					if(gauceName.equals("DS3")){
						//StringUtil.printMsg("arr_sql[1].toString()",arr_sql[1].toString(),this);								
						stmt = conn.getGauceStatement(arr_sql[1].toString());
					}						
					if(gauceName.equals("DS5")){
						//StringUtil.printMsg("arr_sql[3].toString()",arr_sql[3].toString(),this);								
						stmt = conn.getGauceStatement(arr_sql[3].toString());
					} 												
					if(gauceName.equals("DS6")){
						//StringUtil.printMsg("arr_sql[4].toString()",arr_sql[4].toString(),this);								
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
		////StringUtil.printMsg("# Command","조회",this);
		/* DataBase */
		GauceDataSet ds1 = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			String 		sCustGu		= HDUtil.nullCheckStr(req.getParameter("sCustGu"));
			String  	sManegeNo	= HDUtil.nullCheckStr(req.getParameter("sManegeNo"));		// 관리번호
			String 		sCustNm		= HDUtil.nullCheckStr(req.getParameter("sCustNm"));
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
							res.enableFirstRow(ds1);
							
							cstmt = conn.prepareCall("{call SALES.PR_RV780I_01(?, ?, ?) }");
							
							cstmt.setString(1, sCustGu);
							cstmt.setString(2, sManegeNo);
							cstmt.setString(3, sCustNm);
							
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
		String iParamIp = fParamIp;
		try{
			if(inputDs!=null){
				
				
				int colNm_CustSid               = inputDs.indexOfColumn("CUST_SID");
				int colNm_SouthPermitYn			= inputDs.indexOfColumn("SOUTH_PERMIT_YN");
				int colNm_NorthPermitYn         = inputDs.indexOfColumn("NORTH_PERMIT_YN");
				int colNm_CancelCd              = inputDs.indexOfColumn("CANCEL_CD");
				int colNm_CustNm                = inputDs.indexOfColumn("CUST_NM");
				int colNm_ManageNo              = inputDs.indexOfColumn("MANAGE_NO");
				int colNm_ADDRESS1              = inputDs.indexOfColumn("ADDRESS1");
				int colNm_TelNo                 = inputDs.indexOfColumn("TEL_NO");
				int colNm_CompanyNm             = inputDs.indexOfColumn("COMPANY_NM");
				int colNm_Positions             = inputDs.indexOfColumn("POSITIONS");
					
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
								 cstmt = conn.prepareCall("{call SALES.PR_RV780I_02( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");						
								 cstmt.setInt(1, rows[i].getInt(colNm_CustSid));
								 if ( rows[i].getString(colNm_SouthPermitYn).equals("T") )
								 	cstmt.setString(2, "Y");							
								 else
									cstmt.setString(2, "N");	
								 if ( rows[i].getString(colNm_NorthPermitYn).equals("T") )
									cstmt.setString(3, "Y");							
								 else
									cstmt.setString(3, "N");						
								 cstmt.setString(4, rows[i].getString(colNm_CancelCd));
								 cstmt.setString(5, iParamEmpno);
								 cstmt.setString(6, iParamIp);
								 cstmt.setString(7, "1");
								 cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
								 cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
								 cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); 						
										
								 cstmt.executeUpdate();
															
								//메시지처리
								 if (cstmt.getString(8).equals("Y") ) {
									if ( !cstmt.getString(9).equals("0000") ) {
										//StringUtil.printMsg("성공메시지",cstmt.getString(10),this);
										GauceDataRow row = msgDS.newDataRow();
										row.addColumnValue(cstmt.getString(10));								
										msgDS.addDataRow(row);
									}
								 } else {
									//StringUtil.printMsg("실패메시지",cstmt.getString(10),this);								
									conn.rollback();
									GauceDataRow row = msgDS.newDataRow();
									row.addColumnValue(cstmt.getString(10));							
									msgDS.addDataRow(row);
									fail = true;
									break inner;						
								}  		
								if(cstmt!=null) cstmt.close();
								break;
							//업데이트
							case GauceDataRow.TB_JOB_UPDATE:
							cstmt = conn.prepareCall("{call SALES.PR_RV780I_02( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");						
							
							cstmt.setInt(1, rows[i].getInt(colNm_CustSid));
							if ( rows[i].getString(colNm_SouthPermitYn).equals("T") )
								cstmt.setString(2, "Y");							
							else
								cstmt.setString(2, "N");	
							if ( rows[i].getString(colNm_NorthPermitYn).equals("T") )
								cstmt.setString(3, "Y");							
							else
								cstmt.setString(3, "N");						
							cstmt.setString(4, rows[i].getString(colNm_CancelCd));
							cstmt.setString(5, iParamEmpno);
							cstmt.setString(6, iParamIp);
							cstmt.setString(7, "3");
							cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
							cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); 						
		
							cstmt.executeUpdate();
							
							//메시지처리
							if (cstmt.getString(8).equals("Y") ) {
								if ( !cstmt.getString(9).equals("0000") ) {
									//StringUtil.printMsg("성공메시지",cstmt.getString(10),this);
									GauceDataRow row = msgDS.newDataRow();
									row.addColumnValue(cstmt.getString(10));								
									msgDS.addDataRow(row);
								}
							} else {
								//StringUtil.printMsg("실패메시지",cstmt.getString(10),this);								
								conn.rollback();
								GauceDataRow row = msgDS.newDataRow();
								row.addColumnValue(cstmt.getString(10));							
								msgDS.addDataRow(row);
								fail = true;
								break inner;						
							}  		
							
							if(cstmt!=null) cstmt.close();
							break;
							
							//DELETE
							case GauceDataRow.TB_JOB_DELETE:
							cstmt = conn.prepareCall("{call SALES.PR_RV780I_02( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");						
							cstmt.setInt(1, rows[i].getInt(colNm_CustSid));
								if ( rows[i].getString(colNm_SouthPermitYn).equals("T") )
									cstmt.setString(2, "Y");							
								else
									cstmt.setString(2, "N");	
								if ( rows[i].getString(colNm_NorthPermitYn).equals("T") )
									cstmt.setString(3, "Y");							
								else
									cstmt.setString(3, "N");						
									cstmt.setString(4, rows[i].getString(colNm_CancelCd));
									cstmt.setString(5, iParamEmpno);
									cstmt.setString(6, iParamIp);
									cstmt.setString(7, "2");
									cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
									cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
									cstmt.registerOutParameter(10, java.sql.Types.VARCHAR); 						
									cstmt.executeUpdate();
							//메시지처리
								if (cstmt.getString(8).equals("Y") ) {
									if ( !cstmt.getString(9).equals("0000") ) {
										//StringUtil.printMsg("성공메시지",cstmt.getString(10),this);
										GauceDataRow row = msgDS.newDataRow();
										row.addColumnValue(cstmt.getString(10));								
										msgDS.addDataRow(row);
									}
								} else {
										//StringUtil.printMsg("실패메시지",cstmt.getString(10),this);								
										conn.rollback();
										GauceDataRow row = msgDS.newDataRow();
										row.addColumnValue(cstmt.getString(10));							
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
