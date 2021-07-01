package sales.menu.rv;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
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

public class Rv270I extends SuperServlet {

	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_REQ;
	
	public void makeSql(){
		//StringUtil.printMsg("# Command","sql 생성",this);    	
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
			
			arr_sql[0].append (" SELECT						    		\n")
			  .append ("   				T1.CLIENT_SID,                  	\n")		
			  .append ("   				T1.CLIENT_DAM_NM,            \n")
			  .append ("   				T1.TEL_NO                      	\n")
			  .append("				FROM SALES.TCU030	T1		\n");
		//	Master 조회
			arr_sql[1].append ("{call SALES.PR_RV270I_03(?, ?, ?,?)}");
		//	Detail 조회
				arr_sql[2].append ("{call SALES.PR_RV270I_04(?)}");
		//	이용일자 조회
				arr_sql[3].append ("{call SALES.PR_RV270I_05(?)}");
		//	요청등록_서비스(trv030) 저장
			  arr_sql[4].append ("{call SALES.PR_RV270I_07(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,?,?)}");
				
				  
   }
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
//		StringUtil.printMsg("# Command","선조회",this);

		/* DataSet */
		GauceDataSet ds_default = null;
		GauceStatement stmt = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		try{
			int 	sClientSid	= HDUtil.nullCheckNum(req.getParameter("sClientSid"));
			String 	sStatusCd	= HDUtil.nullCheckStr(req.getParameter("sStatusCd"));			
			String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
			String 	sEndDate	= HDUtil.nullCheckStr(req.getParameter("sEndDate"));			
			int 		sSaupSid	= HDUtil.nullCheckNum(req.getParameter("sSaupSid"));
			String 	sManageNo	= HDUtil.nullCheckStr(req.getParameter("sManageNo"));
			String 	sDepartDate 	= HDUtil.nullCheckStr(req.getParameter("sDepartDate"));
			/*
			StringUtil.printMsg("sClientSid:::" , sClientSid, this);
			StringUtil.printMsg("sStatusCd:::" , sStatusCd, this);
			StringUtil.printMsg("sBgnDate:::" , sBgnDate, this);
			StringUtil.printMsg("sEndDate:::" , sEndDate, this);
			StringUtil.printMsg("sDepartDate:::" , sDepartDate, this);
			StringUtil.printMsg("sSaupSid:::" , sSaupSid, this);
			StringUtil.printMsg("sManageNo:::" , sManageNo, this);
			*/
			Iterator it = req.getGauceDataSetKeys();

			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds_default = req.getGauceDataSet(gauceName);
			
				if(ds_default!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds_default);
							if(gauceName.equals("CLIENTINFO")){
								//StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);
								stmt = conn.getGauceStatement(arr_sql[0].toString());
								
								rs = stmt.executeQuery(); // DataSet set
								getDataSet(rs, ds_default).flush();								
							}
							
							if(gauceName.equals("DEFAULT")){
								//StringUtil.printMsg("Init:default","Init:default",this);
								cstmt = conn.prepareCall("{call SALES.PR_RV270I_01(?,?,?,?,?,  ?,?) }");
								cstmt.setInt(1, sClientSid);								
								cstmt.setString(2, sStatusCd);
								cstmt.setString(3, sBgnDate);
								cstmt.setString(4, sEndDate); 								
								cstmt.setInt(5, sSaupSid); 								
								cstmt.setString(6, sManageNo);
								cstmt.setString(7, sDepartDate);
								rs = cstmt.executeQuery(); // DataSet set
								
								getDataSetHead(rs, ds_default).flush();
								
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
			if(cstmt!=null) cstmt.close();
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
		ResultSet rs = null;
		int 		sSaupSid	= HDUtil.nullCheckNum(req.getParameter("sSaupSid"));
		int 		sClientSid	= HDUtil.nullCheckNum(req.getParameter("sClientSid"));
		String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
		String 	sStatusCd	= HDUtil.nullCheckStr(req.getParameter("sStatusCd"));			
		String 	sManageNo	= HDUtil.nullCheckStr(req.getParameter("sManageNo"));
		String 	sEndDate	= HDUtil.nullCheckStr(req.getParameter("sEndDate"));	
		//ds_master param
		int 		sUpjangSid		= HDUtil.nullCheckNum(req.getParameter("sUpjangSid"));
		String 	sDepartDate 	= HDUtil.nullCheckStr(req.getParameter("sDepartDate"));
		int 		sRsvSid 		= HDUtil.nullCheckNum(req.getParameter("sRsvSid"));
		String 	sUseDate 		= HDUtil.nullCheckStr(req.getParameter("sUseDate"));
		/*		
		StringUtil.printMsg("sClientSid:::" , sClientSid, this);
		StringUtil.printMsg("sStatusCd:::" , sStatusCd, this);
		StringUtil.printMsg("sBgnDate:::" , sBgnDate, this);
		StringUtil.printMsg("sEndDate:::" , sEndDate, this);
		StringUtil.printMsg("sUpjangSid:::" , sUpjangSid, this);
		StringUtil.printMsg("sDepartDate:::" , sDepartDate, this);
		StringUtil.printMsg("sRsvSid:::" , sRsvSid, this);
		StringUtil.printMsg("sSaupSid:::" , sSaupSid, this);
		StringUtil.printMsg("sManageNo:::" , sManageNo, this);
		*/
		try {
			Iterator it = req.getGauceDataSetKeys();
			// 검색시 조건
			// dataset 구분 param
			//int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
			while(it.hasNext()){
					String gauceName = (String)it.next();
					ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DEFAULT")){
							StringUtil.printMsg("DEFAULT:::" , "DEFAULT", this);
							cstmt = conn.prepareCall("{call SALES.PR_RV270I_01(?,?,?,?,?   ,?,?) }");
							cstmt.setInt(1, sClientSid);								
							cstmt.setString(2, sStatusCd);
							cstmt.setString(3, sBgnDate);
							cstmt.setString(4, sEndDate);
							cstmt.setInt(5, sSaupSid); 								
							cstmt.setString(6, sManageNo);
							cstmt.setString(7, sDepartDate);
							
							rs = cstmt.executeQuery(); // DataSet set
							getDataSet(rs, ds1).flush();
					
					} else if(gauceName.equals("MASTER")){	
							/*
							StringUtil.printMsg("DS_MASTER:::" , "DS_MASTER", this);
							StringUtil.printMsg("sUpjangSid:::" , sUpjangSid, this);
							StringUtil.printMsg("sDepartDate:::" , sDepartDate, this);
							StringUtil.printMsg("sRsvSid:::" , sRsvSid, this);
							StringUtil.printMsg("sUseDate:::" , sUseDate, this);
							*/
							cstmt = conn.prepareCall(arr_sql[1].toString());
							cstmt.setInt(1, sUpjangSid);
							cstmt.setString(2,sDepartDate );
							cstmt.setInt(3, sRsvSid); 								
							cstmt.setString(4,sUseDate );

							rs = cstmt.executeQuery(); // DataSet set
							getDataSet(rs, ds1).flush();
					} else if(gauceName.equals("DETAIL")){
							//StringUtil.printMsg("DETAIL:::" , "DETAIL", this);
							//StringUtil.printMsg("sRsvSid" , sRsvSid, this);
							cstmt = conn.prepareCall(arr_sql[2].toString());
							cstmt.setInt(1, sRsvSid);
							rs = cstmt.executeQuery();
							getDataSet(rs, ds1).flush();						
					}  else if(gauceName.equals("USE_DATE")){
							//StringUtil.printMsg("DS_USE_DATE:::" , "DS_USE_DATE", this);
							//StringUtil.printMsg("sRsvSid" , sRsvSid, this);
							cstmt = conn.prepareCall(arr_sql[3].toString());
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
			//if(stmt!=null) stmt.close();
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
		//StringUtil.printMsg("# Command","저장",this);
		GauceDataSet ds1 = null;
		GauceDataSet ds_result = null;
		GauceDataSet reqNoDS = req.getGauceDataSet("reqNoDS");	
		GauceDataSet msgDS = req.getGauceDataSet("msgDS");		
		CallableStatement cstmt = null;		
		GauceStatement stmt = null;		
		String reqNo="";
		ResultSet rs = null;
		boolean fail=false;
		
		String 	sRsvPayYn = "";
		String 	sJobStatus = "";
				
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;

		// trv510 제어.
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DEFAULT")){
						int colNm_ReqNo                 = ds1.indexOfColumn("REQ_NO");
						int colNm_ClientSid               = ds1.indexOfColumn("CLIENT_SID");
						int colNm_AcceptDate            = ds1.indexOfColumn("ACCEPT_DATE");
						int colNm_AcceptTime            = ds1.indexOfColumn("ACCEPT_TIME");				
						int colNm_StatusCd              = ds1.indexOfColumn("STATUS_CD");
						int colNm_ClientDam_nm          = ds1.indexOfColumn("CLIENT_DAM_NM");
						int colNm_MobileNo              = ds1.indexOfColumn("MOBILE_NO");
						int colNm_DepartDate            = ds1.indexOfColumn("DEPART_DATE");
						int colNm_AcceptSid             = ds1.indexOfColumn("ACCEPT_SID");
						int colNm_AcceptNo              = ds1.indexOfColumn("ACCEPT_NO");
						int colNm_RsvSid                = ds1.indexOfColumn("RSV_SID");
						int colNm_CustSid               = ds1.indexOfColumn("CUST_SID");
						int colNm_CustNm                = ds1.indexOfColumn("CUST_NM");
						int colNm_ManageNo              = ds1.indexOfColumn("MANAGE_NO");
						int colNm_Reason                  = ds1.indexOfColumn("REASON");				
						
				GauceDataRow[] 		rows = ds1.getDataRows();
				GauceDataColumn[] 	cols = ds1.getDataColumns();
				
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
						/*
						StringUtil.printMsg("call","SALES.PR_RV510i_02-INSERT",this);
						StringUtil.printMsg("colNm_ReqNo",rows[i].getString(colNm_ReqNo),this);
						StringUtil.printMsg("colNm_ClientSid",rows[i].getString(colNm_ClientSid),this);
						StringUtil.printMsg("colNm_AcceptDate",rows[i].getString(colNm_AcceptDate),this);
						StringUtil.printMsg("colNm_AcceptTime",rows[i].getString(colNm_AcceptTime),this);
						StringUtil.printMsg("colNm_StatusCd",rows[i].getString(colNm_StatusCd),this);
						StringUtil.printMsg("colNm_ClientDam_nm",rows[i].getString(colNm_ClientDam_nm),this);
						StringUtil.printMsg("colNm_MobileNo",rows[i].getString(colNm_MobileNo),this);
						StringUtil.printMsg("colNm_DepartDate",rows[i].getString(colNm_DepartDate),this);
						StringUtil.printMsg("colNm_AcceptSid",rows[i].getString(colNm_AcceptSid),this);
						StringUtil.printMsg("colNm_AcceptNo",rows[i].getString(colNm_AcceptNo),this);
						StringUtil.printMsg("colNm_RsvSid",rows[i].getString(colNm_RsvSid),this);
						StringUtil.printMsg("colNm_CustSid",rows[i].getString(colNm_CustSid),this);
						StringUtil.printMsg("colNm_CustNm",rows[i].getString(colNm_CustNm),this);
						StringUtil.printMsg("colNm_ManageNo",rows[i].getString(colNm_ManageNo),this);
						StringUtil.printMsg("colNm_Desc",rows[i].getString(colNm_Desc),this);
						*/
						cstmt = conn.prepareCall("{call SALES.PR_RV270i_06(?,?,?,?,?   ,?,?,?,?,?,   ?,?,?,?,?,   ?,?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_ReqNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setInt(2, rows[i].getInt(colNm_ClientSid));
						cstmt.setString(3, rows[i].getString(colNm_AcceptDate));
						cstmt.setString(4, rows[i].getString(colNm_AcceptTime));						
						cstmt.setString(5, rows[i].getString(colNm_StatusCd));
						cstmt.setString(6, rows[i].getString(colNm_ClientDam_nm));
						cstmt.setString(7, rows[i].getString(colNm_MobileNo));
						cstmt.setString(8, rows[i].getString(colNm_DepartDate));
						cstmt.setInt(9, rows[i].getInt(colNm_AcceptSid));
						cstmt.setInt(10, rows[i].getInt(colNm_RsvSid));
						cstmt.setString(11, rows[i].getString(colNm_Reason));
						cstmt.setString(12, iParamEmpno);
						cstmt.setString(13, iParamIp);
						cstmt.setString(14, "1");
						cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						GauceDataRow row = reqNoDS.newDataRow();
						row.addColumnValue(cstmt.getString(1));						
						reqNoDS.addDataRow(row);
						
						//메시지처리
						if (!cstmt.getString(15).equals("Y") ) 
							throw new Exception(cstmt.getString(17));
						
						if (cstmt.getString(15).equals("Y") ) {
							if ( !cstmt.getString(16).equals("0000") ) {
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(17));
								msgDS.addDataRow(row2);
							}
						}  
						
						if(cstmt!=null) cstmt.close();						
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("call","SALES.PR_RV270i_06-UPDATE",this);
						cstmt = conn.prepareCall("{call SALES.PR_RV270i_06(?,?,?,?,?   ,?,?,?,?,?,   ?,?,?,?,?,   ?,?) }");
						
						//StringUtil.printMsg("colNm_ReqNo",rows[i].getString(colNm_ReqNo),this);
						
						cstmt.setString(1, rows[i].getString(colNm_ReqNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setInt(2, rows[i].getInt(colNm_ClientSid));
						cstmt.setString(3, rows[i].getString(colNm_AcceptDate));
						cstmt.setString(4, rows[i].getString(colNm_AcceptTime));						
						cstmt.setString(5, rows[i].getString(colNm_StatusCd));
						cstmt.setString(6, rows[i].getString(colNm_ClientDam_nm));
						cstmt.setString(7, rows[i].getString(colNm_MobileNo));
						cstmt.setString(8, rows[i].getString(colNm_DepartDate));
						cstmt.setInt(9, rows[i].getInt(colNm_AcceptSid));
						cstmt.setInt(10, rows[i].getInt(colNm_RsvSid));
						cstmt.setString(11, rows[i].getString(colNm_Reason));
						cstmt.setString(12, iParamEmpno);
						cstmt.setString(13, iParamIp);
						cstmt.setString(14, "3");
						cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						//메시지처리
						if (!cstmt.getString(15).equals("Y") ) 
							throw new Exception(cstmt.getString(17));
						
						if (cstmt.getString(15).equals("Y") ) {
							if ( !cstmt.getString(16).equals("0000") ) {
								StringUtil.printMsg("성공메시지",cstmt.getString(17),this);
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(17));
								msgDS.addDataRow(row2);
							}
						}  
						
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_DELETE:
						//StringUtil.printMsg("call","SALES.PR_RV270i_06-DELETE",this);
						cstmt = conn.prepareCall("{call SALES.PR_RV270i_06(?,?,?,?,?   ,?,?,?,?,?,   ?,?,?,?,?,  ?,?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_ReqNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setInt(2, rows[i].getInt(colNm_ClientSid));
						cstmt.setString(3, rows[i].getString(colNm_AcceptDate));
						cstmt.setString(4, rows[i].getString(colNm_AcceptTime));						
						cstmt.setString(5, rows[i].getString(colNm_StatusCd));
						cstmt.setString(6, rows[i].getString(colNm_ClientDam_nm));
						cstmt.setString(7, rows[i].getString(colNm_MobileNo));
						cstmt.setString(8, rows[i].getString(colNm_DepartDate));
						cstmt.setInt(9, rows[i].getInt(colNm_AcceptSid));
						cstmt.setInt(10, rows[i].getInt(colNm_RsvSid));
						cstmt.setString(11, rows[i].getString(colNm_Reason));
						cstmt.setString(12, iParamEmpno);
						cstmt.setString(13, iParamIp);
						cstmt.setString(14, "2");
						cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						//메시지처리
						if (!cstmt.getString(15).equals("Y") ) 
							throw new Exception(cstmt.getString(17));
						
						if (cstmt.getString(15).equals("Y") ) {
							if ( !cstmt.getString(16).equals("0000") ) {
								StringUtil.printMsg("성공메시지",cstmt.getString(17),this);
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(17));
								msgDS.addDataRow(row2);
							}
						}  
						
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
				reqNoDS.flush();
			}else if(gauceName.equals("DETAIL")){
				//int sRsvSid 			= HDUtil.nullCheckNum(req.getParameter("RSV_SID"));
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
					  cstmt = conn.prepareCall(arr_sql[4].toString());
	
					  if(rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
						  sJobStatus = "1";
					  else if(rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
						  sJobStatus = "2";
					  else if(rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
						  sJobStatus = "3";
					  else sJobStatus = "0";
	
					  sRsvPayYn = rows[i].getString(ds1.indexOfColumn("RSV_PAY_YN"));
					  if(sRsvPayYn.equals("T")) {
						  sRsvPayYn = "Y";
					  }else{
						  sRsvPayYn = "N";
					  } ;
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
							  cstmt.setString (5, sRsvPayYn);
							  cstmt.setInt    (6, rows[i].getInt(ds1.indexOfColumn("UNIT_AMT")));
							  cstmt.setInt    (7, rows[i].getInt(ds1.indexOfColumn("SALE_QTY")));
							  cstmt.setString (8, rows[i].getString(ds1.indexOfColumn("CURRENCY_CD")));	//pCURRENCY_CD
							  cstmt.setInt (9, rows[i].getInt(ds1.indexOfColumn("EXCH_AMT")));//pEXCH_AMT	단가
							  cstmt.setString (10, rows[i].getString(ds1.indexOfColumn("REMARKS")));
							  cstmt.setString (11, rows[i].getString(ds1.indexOfColumn("USE_DATE")));
							  cstmt.setString (12, rows[i].getString(ds1.indexOfColumn("USE_SEQ")));
							  cstmt.setString (13, fParamEmpno);
							  cstmt.setString (14, fParamIp);
							  cstmt.setString (15, sJobStatus);
								
							  cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);	//성공여부
							  cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);	//메세지 코드
							  cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);	//메세지
					
							  cstmt.executeUpdate();
			
							  //if(!cstmt.getString(12).equals("Y"))
							  if(!cstmt.getString(16).equals("Y"))					
								  throw new Exception (cstmt.getString(18));
					
							  if(ds_result!=null){
								  GauceDataRow row1 = ds_result.newDataRow();
								  //row1.addColumnValue(cstmt.getBigDecimal(4).intValue());

								  row1.addColumnValue(cstmt.getString(16));
								  row1.addColumnValue(cstmt.getString(17));
								  row1.addColumnValue(cstmt.getString(18));

								  ds_result.addDataRow(row1);
							  }
							  if(cstmt!=null) cstmt.close();
						  }
					  }
					  if(ds_result!=null) ds_result.flush();
				}
			}
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			msgDS.flush();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
			if( fail == true ) throw new Exception("");			
		}
	}
}