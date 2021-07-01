package sales.menu.rv;

//import java.io.File;
//import java.io.FileOutputStream;
//import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.ArrayList;
import java.util.HashMap;
import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.io.*;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.SuperServlet;
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

import kr.co.imjk.board.bean.Tbrd_board_ma_bean;
import kr.co.imjk.board.dao.CommonBoard;
import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.util.DAOHome;
import kr.co.imjk.util.Selecter;
import kr.co.imjk.util.Util;
import kr.co.imjk.reservation.bean.Reservation_bean;
import kr.co.imjk.reservation.bean.Schedule_bean;


public class Rv271I extends SuperServlet {

   String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_REQ;
	public void makeSql(){
	  /**
	   * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다
	   **/
	   String iParamEmpno = fParamEmpno;
	   String iParamIp = fParamIp;

	  for(int i=0; i<arr_sql.length; i++)
		 arr_sql[i] = new StringBuffer();

	  arr_sql[0].append (" SELECT                            \n")
		.append ("   T1.CLIENT_SID,                  \n")
		.append ("   T1.CLIENT_DAM_NM,                  \n")
		.append ("   T1.TEL_NO                      \n")
		.append("   FROM SALES.TCU030   T1      \n");
		

		//	요청등록_서비스(trv030) 저장
		arr_sql[1].append ("{call SALES.PR_RV271I_05(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?)}");
   }
 
   public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	  //StringUtil.printMsg("# Command","선조회",this);
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
			   switch(dsType){
				  case 1:
					 res.enableFirstRow(ds1);
					  if(gauceName.equals("CLIENTINFO")){
						//StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);
						stmt = conn.getGauceStatement(arr_sql[0].toString());
						rs = stmt.executeQuery(); // DataSet set
						getDataSet(rs, ds1).flush();
					 }
					 break;
			   }
			}
		 }
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
	  //StringUtil.printMsg("# Command","조회",this);

	  /* DataBase */
	  GauceDataSet ds1 = null;
	  CallableStatement cstmt = null;
	  GauceStatement stmt = null;
	  ResultSet rs = null;
	  ResultSetMetaData rsmd = null;
	  String[] columnName = null;
	  
	  //	검색시 조건
	  int	     sClientSid    = HDUtil.nullCheckNum(req.getParameter("sClientSid"));
	  String    sStatusCd     = HDUtil.nullCheckStr(req.getParameter("sStatusCd"));
	  String    sBgnDate      = HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
	  String    sEndDate      = HDUtil.nullCheckStr(req.getParameter("sEndDate"));
	  String    sCustNm       = HDUtil.nullCheckStr(req.getParameter("sCustNm"));
	  String    sManageNo     = HDUtil.nullCheckStr(req.getParameter("sManageNo"));
	  String    sDpBgnDate    = HDUtil.nullCheckStr(req.getParameter("sDpBgnDate"));
	  String    sDpEndDate    = HDUtil.nullCheckStr(req.getParameter("sDpEndDate"));
	  int  	 sRsvSid 		= HDUtil.nullCheckNum(req.getParameter("sRsvSid"));
	
	 
	  try {
		 // dataset 구분 param
		 Iterator it = req.getGauceDataSetKeys();
		 while(it.hasNext()){
		 String gauceName = (String)it.next();
		 ds1 = req.getGauceDataSet(gauceName);
			
			if(ds1!=null){
					 res.enableFirstRow(ds1);
					 if(gauceName.equals("DEFAULT")){
						 cstmt = conn.prepareCall("{call SALES.PR_RV271I_01N(?,?,?,?,?,   ?,?,?) }");
						 cstmt.setInt	(1, sClientSid);
						 cstmt.setString(2, sBgnDate);
						 cstmt.setString(3, sEndDate);
						 cstmt.setString(4, sDpBgnDate);
						 cstmt.setString(5, sDpEndDate);
						 cstmt.setString(6, sStatusCd);
						 cstmt.setString(7, sCustNm);
						 cstmt.setString(8, sManageNo);
						
						 rs = cstmt.executeQuery(); // DataSet set
						getDataSet(rs, ds1).flush();
					 } else if(gauceName.equals("DETAIL")){
						//StringUtil.printMsg("sRsvSid" , sRsvSid, this);
						cstmt = conn.prepareCall("{call SALES.PR_RV271I_03(?) }");
						cstmt.setInt(1, sRsvSid);
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();												
					 } else{
						 throw new Exception ("알수 없는 DataSet Name입니다.");
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
		 if(cstmt!=null) cstmt.close();
	  }
   }
   /**
	* 기능 :
	* @param req
	* @param res
	* @param dsNum = 1
	*
	*/

   public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
	  //StringUtil.printMsg("apply::::::::::::::::::::::::::::","apply::::::::::::::::::::::::",this);
	  GauceDataSet ds1 = null;
	  GauceDataSet ds_result = null;
	  GauceDataSet reqNoDS = req.getGauceDataSet("reqNoDS");	
	  GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
	  CallableStatement cstmt = null;
	  ResultSet rs = null;
	  boolean fail=false;
	 
	  /**
	   * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다
	   **/
	  String iParamEmpno = fParamEmpno;
	  String iParamIp = fParamIp;
	  String 	sJobStatus = "";
	  //	trv510 제어.
	  try{
		Iterator it = req.getGauceDataSetKeys();
		   while(it.hasNext()){
			   String gauceName = (String)it.next();
			   ds1 = req.getGauceDataSet(gauceName);
				
			   if(ds1!=null){
				   res.enableFirstRow(ds1);
				   if(gauceName.equals("DEFAULT")){
						//StringUtil.printMsg("DEFAULT:::::::::::::::::::::::::::::;;;;","DEFAULT:::::::::::::::::::::::::::::::::;",this);
						int colNm_ReqNo                 = ds1.indexOfColumn("REQ_NO");
						int colNm_StatusCd              = ds1.indexOfColumn("STATUS_CD");
						int colNm_Desc                   = ds1.indexOfColumn("DESC");
						int colNm_JobType               = ds1.indexOfColumn("JOB_TYPE");
						GauceDataRow[]       rows = ds1.getDataRows();
						GauceDataColumn[]    cols = ds1.getDataColumns();
						//메시지처리
						res.enableFirstRow(msgDS);
						msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));

						for(int i=0; i<rows.length; i++){
						   int j=1;
						   switch(rows[i].getJobType()){
						   case GauceDataRow.TB_JOB_UPDATE:
							  //StringUtil.printMsg("call","SALES.PR_RV511i_02-UPDATE",this);
							  cstmt = conn.prepareCall("{call SALES.PR_RV271i_04(?,?,?,?,?,    ?,?,?,?,?) }");
							  //StringUtil.printMsg("rows[i].getString(colNm_StatusCd)",rows[i].getString(colNm_StatusCd),this);
							  cstmt.setString(1, rows[i].getString(colNm_ReqNo));
							  cstmt.setString(2, rows[i].getString(colNm_StatusCd));
							  cstmt.setString(3, rows[i].getString(colNm_Desc));
							  cstmt.setString(4, rows[i].getString(colNm_JobType));
							  cstmt.setString(5, iParamEmpno);
							  cstmt.setString(6, iParamIp);
							  cstmt.setString(7, "3");
							  cstmt.registerOutParameter(8,  java.sql.Types.VARCHAR);
							  cstmt.registerOutParameter(9,  java.sql.Types.VARCHAR);
							  cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			
							  cstmt.executeUpdate();
			
							  //메시지처리
							  if (cstmt.getString(8).equals("Y") ) {
								 if ( !cstmt.getString(9).equals("0000") ) {
									//StringUtil.printMsg("성공메시지",cstmt.getString(10),this);
									GauceDataRow row2 = msgDS.newDataRow();
									row2.addColumnValue(cstmt.getString(10));
									msgDS.addDataRow(row2);
								 }
							  }
			
							  if(cstmt!=null) cstmt.close();
							  break;
						   }
						}
						//reqNoDS.flush();
				   }else if(gauceName.equals("DETAIL")){
						  int sRsvSid 		= HDUtil.nullCheckNum(req.getParameter("RSV_SID"));
						  String sDepartDate = HDUtil.nullCheckStr(req.getParameter("DEPART_DATE"));
							if(ds_result!=null){
								res.enableFirstRow(ds_result);
								ds_result.addDataColumn(new GauceDataColumn("KEY_SEQ", GauceDataColumn.TB_NUMBER));
								ds_result.addDataColumn(new GauceDataColumn("S_YN", GauceDataColumn.TB_STRING));
								ds_result.addDataColumn(new GauceDataColumn("MSG_CD", GauceDataColumn.TB_STRING));
								ds_result.addDataColumn(new GauceDataColumn("MSG", GauceDataColumn.TB_STRING));
							}
							GauceDataRow[] 		rows = ds1.getDataRows();
							for(int i = 0; i < rows.length; i++) {
								cstmt = conn.prepareCall(arr_sql[1].toString());
						
								if(rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
									sJobStatus = "1";
								else if(rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
									sJobStatus = "2";
								else if(rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
									sJobStatus = "3";
								else sJobStatus = "0";
							 /*
							 StringUtil.printMsg("Trv030 Save:::" , "Trv030 Save:::", this);
							 StringUtil.printMsg("RSV_SID",rows[i].getInt(ds1.indexOfColumn("RSV_SID")), this); 
							 StringUtil.printMsg("MENU_SID:::" , rows[i].getInt(ds1.indexOfColumn("MENU_SID")), this);
							 StringUtil.printMsg("sDepartDate:::" , sDepartDate, this);
							 StringUtil.printMsg("KEY_SEQ:::" , rows[i].getInt(ds1.indexOfColumn("KEY_SEQ")), this);
							 StringUtil.printMsg("sRsvPayYn:::" , sRsvPayYn, this);
							 StringUtil.printMsg("UNIT_AMT:::" , rows[i].getInt(ds1.indexOfColumn("UNIT_AMT")), this);
							 StringUtil.printMsg("SALE_QTY:::" , rows[i].getInt(ds1.indexOfColumn("SALE_QTY")), this);
							 //StringUtil.printMsg("CURRENCY_NM:::" , rows[i].getInt(ds1.indexOfColumn("CURRENCY_NM")), this);
							 StringUtil.printMsg("REMARKS:::" , rows[i].getString(ds1.indexOfColumn("REMARKS")), this);
							 StringUtil.printMsg("USE_DATE:::" , rows[i].getString(ds1.indexOfColumn("USE_DATE")), this);
							 StringUtil.printMsg("USE_SEQ:::" , rows[i].getString(ds1.indexOfColumn("USE_SEQ")), this);
							 StringUtil.printMsg("fParamEmpno:::" , fParamEmpno, this);
							 StringUtil.printMsg("fParamIp:::" , fParamIp, this);
							 StringUtil.printMsg("sJobStatus:::" , sJobStatus, this);
							 */
							 cstmt.setInt	(1, rows[i].getInt(ds1.indexOfColumn("RSV_SID")));
							 cstmt.setInt    (2, rows[i].getInt(ds1.indexOfColumn("MENU_SID")));
							 cstmt.setString (3, sDepartDate);
							 cstmt.setInt    (4, rows[i].getInt(ds1.indexOfColumn("KEY_SEQ")));
							 cstmt.registerOutParameter(4, java.sql.Types.DECIMAL);	//KEY_SEQ
							 cstmt.setInt    (5, rows[i].getInt(ds1.indexOfColumn("UNIT_AMT")));
							 cstmt.setInt    (6, rows[i].getInt(ds1.indexOfColumn("SALE_QTY")));
							 cstmt.setString (7, rows[i].getString(ds1.indexOfColumn("CURRENCY_CD")));	//pCURRENCY_CD
							 cstmt.setInt (8, rows[i].getInt(ds1.indexOfColumn("EXCH_AMT")));//pEXCH_AMT	단가
							 cstmt.setString (9, rows[i].getString(ds1.indexOfColumn("REMARKS")));
							 cstmt.setString (10, rows[i].getString(ds1.indexOfColumn("USE_DATE")));
							 cstmt.setString (11, rows[i].getString(ds1.indexOfColumn("USE_SEQ")));
							 cstmt.setString (12, fParamEmpno);
							 cstmt.setString (13, fParamIp);
							 cstmt.setString (14, sJobStatus);
										
							 cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);	//성공여부
							 cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);	//메세지 코드
							 cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);	//메세지
							
							 cstmt.executeUpdate();
					
							 //if(!cstmt.getString(12).equals("Y"))
							 if(!cstmt.getString(15).equals("Y"))					
								 throw new Exception (cstmt.getString(17));
							
							 if(ds_result!=null){
								 GauceDataRow row1 = ds_result.newDataRow();
								 //row1.addColumnValue(cstmt.getBigDecimal(4).intValue());
		
								 row1.addColumnValue(cstmt.getString(15));
								 row1.addColumnValue(cstmt.getString(16));
								 row1.addColumnValue(cstmt.getString(17));
		
								 ds_result.addDataRow(row1);
							 }
							 if(cstmt!=null) cstmt.close();
						 }
					 }else if(gauceName.equals("DRAFT")){
							String req_no     = HDUtil.nullCheckStr(req.getParameter("req_no"));
							String array10     = HDUtil.nullCheckStr(req.getParameter("array10"));		//담당
							String array11    = HDUtil.nullCheckStr(req.getParameter("array11"));		//담당
							String array12     = HDUtil.nullCheckStr(req.getParameter("array12"));		//담당
							String array13      = HDUtil.nullCheckStr(req.getParameter("array13"));		//담당
							String array20      = HDUtil.nullCheckStr(req.getParameter("array20"));		//검토
							String array21      = HDUtil.nullCheckStr(req.getParameter("array21"));		//검토
							String array22      = HDUtil.nullCheckStr(req.getParameter("array22"));		//검토
							String array23      = HDUtil.nullCheckStr(req.getParameter("array23"));		//검토
							String array30      = HDUtil.nullCheckStr(req.getParameter("array30"));		//확인
							String array31     = HDUtil.nullCheckStr(req.getParameter("array31"));		//확인
							String array32     = HDUtil.nullCheckStr(req.getParameter("array32"));		//확인
							String array33     = HDUtil.nullCheckStr(req.getParameter("array33"));		//확인
							String array40     = HDUtil.nullCheckStr(req.getParameter("array40"));		//승인
							String array41     = HDUtil.nullCheckStr(req.getParameter("array41"));		//승인
							String array42     = HDUtil.nullCheckStr(req.getParameter("array42"));		//승인
							String array43     = HDUtil.nullCheckStr(req.getParameter("array43"));		//승인
							/*
							StringUtil.printMsg("Draft:::::::::::::::::::::::::::::","Draft::::::::::::::::::::::::",this);
							StringUtil.printMsg("ReqNo",req_no,this);
							StringUtil.printMsg("array10",array10,this);
							StringUtil.printMsg("array11",array11,this);
							StringUtil.printMsg("array12",array12,this);
							StringUtil.printMsg("array13",array13,this);
							StringUtil.printMsg("array20",array20,this);
							StringUtil.printMsg("array21",array21,this);
							StringUtil.printMsg("array22",array22,this);
							StringUtil.printMsg("array23",array23,this);
							StringUtil.printMsg("array30",array30,this);
							StringUtil.printMsg("array31",array31,this);
							StringUtil.printMsg("array32",array32,this);
							StringUtil.printMsg("array33",array33,this);
							StringUtil.printMsg("array40",array40,this);
							StringUtil.printMsg("array41",array41,this);
							StringUtil.printMsg("array42",array42,this);
							StringUtil.printMsg("array43",array43,this);
							*/
							GauceDataRow[]       rows = ds1.getDataRows();
							GauceDataColumn[]  cols = ds1.getDataColumns();
							//메시지처리
							res.enableFirstRow(msgDS);
							msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));
							   int j=1;
								  cstmt = conn.prepareCall("{call SALES.PR_RV271i_06(?,?,?,?,?,    ?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?,  ?,?) }");
								  cstmt.setString(1, req_no);
								  cstmt.setString(2, array10);
								  cstmt.setString(3, array11);
								  cstmt.setString(4, array12);
								  cstmt.setString(5, array13);
								  cstmt.setString(6, array20);
								  cstmt.setString(7, array21);
								  cstmt.setString(8, array22);
								  cstmt.setString(9, array23);
								  cstmt.setString(10, array30);
								  cstmt.setString(11, array31);
								  cstmt.setString(12, array32);
								  cstmt.setString(13, array33);
								  cstmt.setString(14, array40);
								  cstmt.setString(15, array41);
								  cstmt.setString(16, array42);
								  cstmt.setString(17, array43);
								  cstmt.setString(18, iParamEmpno);
								  cstmt.setString(19, iParamIp);
								  cstmt.registerOutParameter(20,  java.sql.Types.VARCHAR);
								  cstmt.registerOutParameter(21,  java.sql.Types.VARCHAR);
								  cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);

								  cstmt.executeUpdate();
			
								  //메시지처리
								  if (cstmt.getString(20).equals("Y") ) {
									 if ( !cstmt.getString(21).equals("0000") ) {
										GauceDataRow row2 = msgDS.newDataRow();
										row2.addColumnValue(cstmt.getString(22));
										msgDS.addDataRow(row2);
									 }
								  if(cstmt!=null) cstmt.close();
							   }
							}
					}
					if(ds_result!=null) ds_result.flush();
			   }
	}  catch (SQLException sqle){
		 res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
		 throw sqle;
	  } catch (Exception e) {
		 res.writeException("ERROR", "", e.toString());
		 throw e;
	  } finally {
		 msgDS.flush();
		 if(rs!=null) rs.close();
		 if(cstmt!=null) cstmt.close();
		 if( fail == true ) throw new Exception("");			
	  }
   }
}
