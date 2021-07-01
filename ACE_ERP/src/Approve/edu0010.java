package Approve;

import sales.common.SuperServlet;

import java.util.*;
import java.sql.*;
import java.io.*;

import javax.servlet.ServletException;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
 
public class edu0010 extends SuperServlet{
	/**
	 * 사진 이미지 저장 
	 * 환경에 맞추어 경로 변경 요함
	 */ 
	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_COST;
	
    public void makeSql(){
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
   
		arr_sql[0].append ("SELECT										\n")
			  .append ("	'' HEAD, '' DETAIL, '전체' DETAIL_NM    \n")
			  .append ("FROM SYSIBM.SYSDUMMY1                       \n")
			  .append ("UNION ALL                                   \n")
			  .append ("SELECT                                      \n")
			  .append ("	B.HEAD, B.DETAIL, B.DETAIL_NM           \n")
			  .append ("FROM                                        \n")
			  .append ("	SALES.TSY011 A,                         \n")
			  .append ("	SALES.TSY010 B                          \n")
			  .append ("WHERE 1=1                                   \n")
			  .append (" AND A.HEAD = B.HEAD                        \n")
			  .append (" AND B.HEAD = ?                             \n")
			  .append (" AND LENGTH (B.DETAIL) > 0                  \n");
		
		arr_sql[1].append ("SELECT										\n")
					  .append ("	EMPNO, SEQ, REQ_DT, START_DT, END_DT, SUBJECT, EDU_YN, EDU_CO, EDU_PL, EDU_DAY, EDU_EVA, EDU_INST, EDU_COST, \n")
					  .append ("	REFUND_YN, REFUND_COST, APP_DATE, APP_ID, APP_DONE_DATE, APP_DONE_ID, REMARKS, EDUFILE, EDUFILES, EDUFNAME  \n")
					  .append ("	,START_TIME,END_TIME  \n")
					  .append ("FROM                                        \n")
					  .append ("	PAYROLL.HEDUCATION_N                     \n")
					  .append ("WHERE    1=1                                \n");
					  
		arr_sql[2].append ("SELECT 																										\n")
						  .append (" *	\n")	
						  .append ("FROM                                                                                    \n")
						  .append ("   PAYROLL.HEDUCATION_N  \n")
						  .append ("WHERE EMPNO='6080001' AND REQ_DT='20110101'                     \n");
	}
		
	// 초기
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
			
		int v_rowcnt = 0;
			
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		//StringUtil.printMsg("DS TYPE","선조회",this);
			
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
					
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							if(gauceName.equals("REFUND")){//환급여부
								stmt = conn.getGauceStatement(arr_sql[0].toString());
								stmt.setString(1, "RF001");
							} else if(gauceName.equals("DEFAULT")){//기본조회
								stmt = conn.getGauceStatement(arr_sql[2].toString());
							} 
							else if(gauceName.equals("IMAGE")){
								ds1.addDataColumn(new GauceDataColumn("CUST_SID", GauceDataColumn.TB_NUMBER));
								ds1.addDataColumn(new GauceDataColumn("PICTURE_INFO", GauceDataColumn.TB_STRING));
								ds1.addDataColumn(new GauceDataColumn("PICTURE_URL", GauceDataColumn.TB_URL, 1024));
							}
							if(!gauceName.equals("IMAGE")){
								rs = stmt.executeQuery(); // DataSet set
								rsmd = rs.getMetaData();
								columnName = new String[rsmd.getColumnCount()];
								for(int i=0; i<columnName.length; i++){
									columnName[i] = rsmd.getColumnName(i+1);
									if(rsmd.getColumnTypeName(i+1).equals("NUMERIC")) {
										ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
									} else {
										ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
									}
								}
									
								if(!gauceName.equals("DEFAULT")){
									while ( rs.next()) {
										GauceDataRow row = ds1.newDataRow();
											
										for(int i=0; i<columnName.length; i++) {
											if(rsmd.getColumnTypeName(i+1).equals("NUMERIC")) {
												row.addColumnValue(rs.getInt(columnName[i]));
											} else {
												row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
											}
										}
			
										ds1.addDataRow(row);
										v_rowcnt++ ;
									}//End of while
									if(rs!=null) rs.close();
									if(stmt!=null) stmt.close();
								}
							}
	
							ds1.flush();
							break;
					}
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
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null;
		
		/**********************************************************************************
		 * Command 
		 **********************************************************************************
		 * Parameter 설정
		 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
		 **********************************************************************************/

		// 검색시 조건
		String  sEmpNo		= HDUtil.nullCheckStr(req.getParameter("sEmpNo")); 		// 사번
		String  sBgnDate		= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));		// 신청일자_fr
		String  sEndDate		= HDUtil.nullCheckStr(req.getParameter("sEndDate"));		// 신청일자_to
		//StringUtil.printMsg("sEmpNo ------->" + sEmpNo , this);
		//StringUtil.printMsg("sBgnDate ------->" + sBgnDate , this);
		//StringUtil.printMsg("sEndDate ------->" + sEndDate , this);
		// dataset 구분 param
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		try{
			//StringUtil.printMsg("dsType ------->" + dsType , this);
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					ds1 = req.getGauceDataSet("DEFAULT");
					if(ds1!=null){
						res.enableFirstRow(ds1);
						
							if (!"".equals(sEmpNo)) 
								arr_sql[1].append (" AND EMPNO = ? ");
							
							if (!"".equals(sBgnDate))
								arr_sql[1].append (" AND REQ_DT >= ? ");
			
							if (!"".equals(sEndDate)) 
								arr_sql[1].append (" AND REQ_DT <= ? ");
						}
						//쿼리 실행
						//StringUtil.printMsg("고객조회 ------->" + arr_sql[2].toString(), this);//여기까지 정상
						stmt = conn.getGauceStatement(arr_sql[1].toString()); 
							if (!"".equals(sEmpNo)) {
								stmt.setString(sCnt1++, sEmpNo);
							}					
							if (!"".equals(sBgnDate)) {
								stmt.setString(sCnt1++, sBgnDate);
							}
							if (!"".equals(sEndDate)) {
								stmt.setString(sCnt1++, sEndDate);
							}
						rs = stmt.executeQuery(); // DataSet set
						rsmd = rs.getMetaData();
						columnName = new String[rsmd.getColumnCount()];
						for(int i=0; i<columnName.length; i++){
							columnName[i] = rsmd.getColumnName(i+1);
							
							if(rsmd.getColumnTypeName(i+1).equals("NUMERIC") || rsmd.getColumnTypeName(i+1).equals("INTEGER"))
								ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
							else
								ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1) ));
						}
						
						
						//StringUtil.printMsg("여기서 루프? ------->" + dsType , this);
						while ( rs.next()) {
							GauceDataRow row = ds1.newDataRow();
							for(int i=0; i<columnName.length; i++) {
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC") || rsmd.getColumnTypeName(i+1).equals("INTEGER"))
									row.addColumnValue(rs.getInt(columnName[i]));
								else
									row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
							}
							ds1.addDataRow(row);

							v_rowcnt++ ;
						}//End of while
						
						if(rs!=null) rs.close();
						if(stmt!=null) stmt.close();

						//ds1.flush();
					break;
				}
				ds1.flush();
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}
	
	/**
	 * 기능 : 
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 * 
	 */
	// 입력, 수정, 삭제
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		GauceDataSet inputDs = req.getGauceDataSet("DEFAULT");
		GauceDataSet reqNoDS = req.getGauceDataSet("reqNoDS");	
		GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
		CallableStatement cstmt = null;		
		String reqNo="";
		ResultSet rs = null;
		boolean fail=false;		
	
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
		try{
			if(inputDs!=null){
                
				int colNm_ReqDt                  = inputDs.indexOfColumn("REQ_DT");
				int colNm_Seq             		= inputDs.indexOfColumn("SEQ");
				int colNm_Subject            	= inputDs.indexOfColumn("SUBJECT");
				int colNm_EduInst              	= inputDs.indexOfColumn("EDU_INST");
				int colNm_EduPl                  = inputDs.indexOfColumn("EDU_PL");
				int colNm_StartDt              	= inputDs.indexOfColumn("START_DT");
				int colNm_EndDt            		= inputDs.indexOfColumn("END_DT");
				int colNm_StartTime            	= inputDs.indexOfColumn("START_TIME");
				int colNm_EndTime            	= inputDs.indexOfColumn("END_TIME");
				int colNm_EduCost             	= inputDs.indexOfColumn("EDU_COST");
				int colNm_RefundYn             = inputDs.indexOfColumn("REFUND_YN");
				int colNm_Remarks              = inputDs.indexOfColumn("REMARKS");				
				int colNm_Empno                = inputDs.indexOfColumn("EMPNO");				
				int colNm_EduYn               	= inputDs.indexOfColumn("EDU_YN");
				int colNm_EduCo                	= inputDs.indexOfColumn("EDU_CO");
				int colNm_EduDay                = inputDs.indexOfColumn("EDU_DAY");				
				int colNm_EduEva                = inputDs.indexOfColumn("EDU_EVA");
				int colNm_RefundCost           = inputDs.indexOfColumn("REFUND_COST");				
				int colNm_AppDate               = inputDs.indexOfColumn("APP_DATE");				
				int colNm_AppId                	= inputDs.indexOfColumn("APP_ID");				
				int colNm_AppDoneDate        = inputDs.indexOfColumn("APP_DONE_DATE");
				int colNm_AppDoneId            = inputDs.indexOfColumn("APP_DONE_ID");
				int colNm_EduFile                = inputDs.indexOfColumn("EDUFILE");				
				int colNm_EduFiles               = inputDs.indexOfColumn("EDUFILES");
				int colNm_EduFName            = inputDs.indexOfColumn("EDUFNAME");				
	
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				//메시지처리
				res.enableFirstRow(msgDS);
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));
				
				//블록번호
				res.enableFirstRow(reqNoDS);
				reqNoDS.addDataColumn(new GauceDataColumn("req_no", GauceDataColumn.TB_STRING));
				
				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						//StringUtil.printMsg("call","SALES.PR_RV540i_02-INSERT",this);
						//StringUtil.printMsg("colNm_ReqNo",rows[i].getString(colNm_ReqNo),this);
						//StringUtil.printMsg("colNm_ClientSid",rows[i].getString(colNm_ClientSid),this);
						//StringUtil.printMsg("colNm_AcceptDate",rows[i].getString(colNm_AcceptDate),this);
						//StringUtil.printMsg("colNm_StatusCd",rows[i].getString(colNm_StatusCd),this);
						//StringUtil.printMsg("colNm_MobileNo",rows[i].getString(colNm_MobileNo),this);
						//StringUtil.printMsg("colNm_DepartDate",rows[i].getString(colNm_DepartDate),this);
						//StringUtil.printMsg("colNm_AcceptSid",rows[i].getString(colNm_AcceptSid),this);
						//StringUtil.printMsg("colNm_Reason",rows[i].getString(colNm_Reason),this);
						//StringUtil.printMsg("colNm_Desc",rows[i].getString(colNm_Desc),this);						
						cstmt = conn.prepareCall("{call COMMON.PR_ED0010_01(?,?,?,?,?,     ?,?,?,?,?,         ?,?,?,?,?,    ?,?,?,?,?      ,?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_ReqDt));
						//cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setString(2, rows[i].getString(colNm_Subject));
						cstmt.setString(3, rows[i].getString(colNm_EduInst));
						cstmt.setString(4, rows[i].getString(colNm_EduPl));
						cstmt.setString(5, rows[i].getString(colNm_StartDt));
						cstmt.setString(6, rows[i].getString(colNm_EndDt));
						cstmt.setString(7, rows[i].getString(colNm_StartTime));
						cstmt.setString(8, rows[i].getString(colNm_EndTime));
						cstmt.setInt(9, rows[i].getInt(colNm_EduCost));
						cstmt.setString(10, rows[i].getString(colNm_RefundYn));
						cstmt.setString(11, rows[i].getString(colNm_Remarks));
						cstmt.setString(12, rows[i].getString(colNm_Empno));
						cstmt.setString(13, rows[i].getString(colNm_EduCo));
						cstmt.setInt(14, rows[i].getInt(colNm_RefundCost));
						cstmt.setString(15, iParamEmpno);
						cstmt.setString(16, iParamIp);
						cstmt.setString(17, "1");
						cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
						cstmt.setString(21, rows[i].getString(colNm_Seq));
						
						cstmt.executeUpdate();
						
						//GauceDataRow row = reqNoDS.newDataRow();
						//row.addColumnValue(cstmt.getString(1));						
						//reqNoDS.addDataRow(row);
						
						//StringUtil.printMsg("길이",imgRow.length,this);
						//메시지처리
						if (cstmt.getString(18).equals("Y") ) {
							if ( !cstmt.getString(19).equals("0000") ) {
								//StringUtil.printMsg("성공메시지",cstmt.getString(19),this);
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(18));
								msgDS.addDataRow(row2);
							}
						} else {
							//StringUtil.printMsg("실패메시지",cstmt.getString(19),this);								
							conn.rollback();
							GauceDataRow row2 = msgDS.newDataRow();								
							row2.addColumnValue(cstmt.getString(20));
							msgDS.addDataRow(row2);
							fail=true;
							break;						
						} 	
						if(cstmt!=null) cstmt.close();		
						break;
						
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("call","SALES.PR_RV540i_02-UPDATE",this);
						//StringUtil.printMsg("colNm_ReqNo",rows[i].getString(colNm_ReqNo),this);
						//StringUtil.printMsg("colNm_ClientSid",rows[i].getString(colNm_ClientSid),this);
						//StringUtil.printMsg("colNm_AcceptDate",rows[i].getString(colNm_AcceptDate),this);
						//StringUtil.printMsg("colNm_StatusCd",rows[i].getString(colNm_StatusCd),this);
						//StringUtil.printMsg("colNm_MobileNo",rows[i].getString(colNm_MobileNo),this);
						//StringUtil.printMsg("colNm_DepartDate",rows[i].getString(colNm_DepartDate),this);
						//StringUtil.printMsg("colNm_AcceptSid",rows[i].getString(colNm_AcceptSid),this);
						//StringUtil.printMsg("colNm_Reason",rows[i].getString(colNm_Reason),this);
						//StringUtil.printMsg("colNm_Desc",rows[i].getString(colNm_Desc),this);						
						cstmt = conn.prepareCall("{call COMMON.PR_ED0010_01(?,?,?,?,?,     ?,?,?,?,?,         ?,?,?,?,?,    ?,?,?,?,?          ,?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_ReqDt));
						//cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setString(2, rows[i].getString(colNm_Subject));
						cstmt.setString(3, rows[i].getString(colNm_EduInst));
						cstmt.setString(4, rows[i].getString(colNm_EduPl));
						cstmt.setString(5, rows[i].getString(colNm_StartDt));
						cstmt.setString(6, rows[i].getString(colNm_EndDt));
						cstmt.setString(7, rows[i].getString(colNm_StartTime));
						cstmt.setString(8, rows[i].getString(colNm_EndTime));
						cstmt.setInt(9, rows[i].getInt(colNm_EduCost));
						cstmt.setString(10, rows[i].getString(colNm_RefundYn));
						cstmt.setString(11, rows[i].getString(colNm_Remarks));
						cstmt.setString(12, rows[i].getString(colNm_Empno));
						cstmt.setString(13, rows[i].getString(colNm_EduCo));
						cstmt.setInt(14, rows[i].getInt(colNm_RefundCost));
						cstmt.setString(15, iParamEmpno);
						cstmt.setString(16, iParamIp);
						cstmt.setString(17, "3");
						cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
						cstmt.setString(21, rows[i].getString(colNm_Seq));
						
						cstmt.executeUpdate();
						
						//GauceDataRow row = reqNoDS.newDataRow();
						//row.addColumnValue(cstmt.getString(1));						
						//reqNoDS.addDataRow(row);
						
						//StringUtil.printMsg("길이",imgRow.length,this);
						//메시지처리
						if (cstmt.getString(18).equals("Y") ) {
							if ( !cstmt.getString(19).equals("0000") ) {
								//StringUtil.printMsg("성공메시지",cstmt.getString(19),this);
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(18));
								msgDS.addDataRow(row2);
							}
						} else {
							//StringUtil.printMsg("실패메시지",cstmt.getString(19),this);								
							conn.rollback();
							GauceDataRow row2 = msgDS.newDataRow();								
							row2.addColumnValue(cstmt.getString(20));
							msgDS.addDataRow(row2);
							fail=true;
							break;						
						} 	
						if(cstmt!=null) cstmt.close();		
						break;
						
						
					case GauceDataRow.TB_JOB_DELETE:
						//StringUtil.printMsg("call","SALES.PR_RV540i_02-DELETE",this);
						//StringUtil.printMsg("colNm_ReqNo",rows[i].getString(colNm_ReqNo),this);
						//StringUtil.printMsg("colNm_ClientSid",rows[i].getString(colNm_ClientSid),this);
						//StringUtil.printMsg("colNm_AcceptDate",rows[i].getString(colNm_AcceptDate),this);
						//StringUtil.printMsg("colNm_StatusCd",rows[i].getString(colNm_StatusCd),this);
						//StringUtil.printMsg("colNm_MobileNo",rows[i].getString(colNm_MobileNo),this);
						//StringUtil.printMsg("colNm_DepartDate",rows[i].getString(colNm_DepartDate),this);
						//StringUtil.printMsg("colNm_AcceptSid",rows[i].getString(colNm_AcceptSid),this);
						//StringUtil.printMsg("colNm_Reason",rows[i].getString(colNm_Reason),this);
						//StringUtil.printMsg("colNm_Desc",rows[i].getString(colNm_Desc),this);						
						cstmt = conn.prepareCall("{call COMMON.PR_ED0010_01(?,?,?,?,?,     ?,?,?,?,?,         ?,?,?,?,?,    ?,?,?,?,?        ,?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_ReqDt));
						//cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setString(2, rows[i].getString(colNm_Subject));
						cstmt.setString(3, rows[i].getString(colNm_EduInst));
						cstmt.setString(4, rows[i].getString(colNm_EduPl));
						cstmt.setString(5, rows[i].getString(colNm_StartDt));
						cstmt.setString(6, rows[i].getString(colNm_EndDt));
						cstmt.setString(7, rows[i].getString(colNm_StartTime));
						cstmt.setString(8, rows[i].getString(colNm_EndTime));
						cstmt.setInt(9, rows[i].getInt(colNm_EduCost));
						cstmt.setString(10, rows[i].getString(colNm_RefundYn));
						cstmt.setString(11, rows[i].getString(colNm_Remarks));
						cstmt.setString(12, rows[i].getString(colNm_Empno));
						cstmt.setString(13, rows[i].getString(colNm_EduCo));
						cstmt.setInt(14, rows[i].getInt(colNm_RefundCost));
						cstmt.setString(15, iParamEmpno);
						cstmt.setString(16, iParamIp);
						cstmt.setString(17, "2");
						cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
						cstmt.setString(21, rows[i].getString(colNm_Seq));
						
						cstmt.executeUpdate();
						
						//GauceDataRow row = reqNoDS.newDataRow();
						//row.addColumnValue(cstmt.getString(1));						
						//reqNoDS.addDataRow(row);
						
						//StringUtil.printMsg("길이",imgRow.length,this);
						//메시지처리
						if (cstmt.getString(18).equals("Y") ) {
							if ( !cstmt.getString(19).equals("0000") ) {
								//StringUtil.printMsg("성공메시지",cstmt.getString(19),this);
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(18));
								msgDS.addDataRow(row2);
							}
						} else {
							//StringUtil.printMsg("실패메시지",cstmt.getString(19),this);								
							conn.rollback();
							GauceDataRow row2 = msgDS.newDataRow();								
							row2.addColumnValue(cstmt.getString(20));
							msgDS.addDataRow(row2);
							fail=true;
							break;						
						} 	
						if(cstmt!=null) cstmt.close();		
						break;
								
					}
				}
				//StringUtil.printMsg("img길이",imgRow.length,this);
				reqNoDS.flush();
			}
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} finally {
			msgDS.flush();
			if( fail == true ) throw new Exception("");				
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}
