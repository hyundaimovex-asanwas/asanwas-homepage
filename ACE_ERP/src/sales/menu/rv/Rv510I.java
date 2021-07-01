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

public class Rv510I extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_REQ;
	
    public void makeSql(){
//		StringUtil.printMsg("# Command","sql 생성",this);    	
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		arr_sql[0].append (" SELECT						    		\n")
		  .append ("   T1.CLIENT_SID,                  \n")		
		  .append ("   T1.CLIENT_DAM_NM,                  \n")
		  .append ("   T1.TEL_NO                      \n")
		  .append("	FROM SALES.TCU030	T1		\n")
		  .append ("WHERE 1 = 1                                                                             \n");
   	
   }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
//		StringUtil.printMsg("# Command","선조회",this);

		/* DataSet */
    	/* DataBase */
    	CallableStatement cstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
		
		try{
			int 	sClientSid	= HDUtil.nullCheckNum(greq.getParameter("sClientSid"));
			String 	sStatusCd	= HDUtil.nullCheckStr(greq.getParameter("sStatusCd"));			
			String 	sBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String 	sEndDate	= HDUtil.nullCheckStr(greq.getParameter("sEndDate"));			

			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput(); 

			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" 컴포넌트의 데이터셋 네임 ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
					if(dSets[i].getName().equals("imgDs")){
						GauceDataSet ds1 = gis.read("IMAGE");
						ds1.addDataColumn(new GauceDataColumn("REQ_NO", GauceDataColumn.TB_STRING));
						ds1.addDataColumn(new GauceDataColumn("PICTURE_INFO", GauceDataColumn.TB_STRING));
						ds1.addDataColumn(new GauceDataColumn("PICTURE_URL", GauceDataColumn.TB_URL, 1024));
						//StringUtil.printMsg("IMAGE","HEAD CREATE",this);
						//ds1.flush();		
						gos.write(ds1);
					}
					if(dSets[i].getName().equals("ds_client_info")){
						GauceDataSet ds1 = gis.read("CLIENTINFO");
						//StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);
						arr_sql[0].append (" AND T1.client_sid = '999988' ");
						cstmt = conn.prepareCall(arr_sql[0].toString());
						rs = cstmt.executeQuery(); 
			   			gos.write(getDataSet(rs, ds1));// DataSet set								
					}
					if(dSets[i].getName().equals("ds1")){
						GauceDataSet ds1 = gis.read("DEFAULT");
					
						cstmt = conn.prepareCall("{call SALES.PR_RV510I_01(?,?,?,?,?) }");
						cstmt.setInt(1, sClientSid);								
						cstmt.setString(2, sStatusCd);
						cstmt.setString(3, sBgnDate);
						cstmt.setString(4, sEndDate); 								
						cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
						cstmt.executeQuery();
						rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 			
						gos.write(getDataSet(rs, ds1));
					}
					break;
				}
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
	
	// 조회 method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		//StringUtil.printMsg("# Command","조회",this);		

		/* DataBase */
		CallableStatement cstmt = null;		
		//GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			int 	sClientSid	= HDUtil.nullCheckNum(greq.getParameter("sClientSid"));
			String 	sStatusCd	= HDUtil.nullCheckStr(greq.getParameter("sStatusCd"));			
			String 	sBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String 	sEndDate	= HDUtil.nullCheckStr(greq.getParameter("sEndDate"));			
			
			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput();
			
			GauceDataSet ds1 = gis.read("DS1");
			GauceDataSet imgDs = gis.read("IMAGE");
			
				
				if(ds1!=null){
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							//res.enableFirstRow(ds1);
							//res.enableFirstRow(imgDs);
							
							//StringUtil.printMsg("call","SALES.PR_RV510i_01",this);
							cstmt = conn.prepareCall("{call SALES.PR_RV510I_01(?,?,?,?,?) }");
							cstmt.setInt(1, sClientSid);								
							cstmt.setString(2, sStatusCd);
							cstmt.setString(3, sBgnDate);
							cstmt.setString(4, sEndDate); 								
							cstmt.registerOutParameter(5, OracleTypes.CURSOR);	//결과를 받을 커서
							
							cstmt.executeQuery();
							rs = (ResultSet)cstmt.getObject(5);	//커서 OUT param. 			
							gos.write(getDataSet(rs, ds1));
							
							rsmd = rs.getMetaData();
							
							columnName = new String[rsmd.getColumnCount()];
							for(int i=0; i<columnName.length; i++){
								columnName[i] = rsmd.getColumnName(i+1);
								if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));										
								else
									ds1.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));										
							}
							
							imgDs.addDataColumn(new GauceDataColumn("REQ_NO", GauceDataColumn.TB_STRING));
							imgDs.addDataColumn(new GauceDataColumn("PICTURE_INFO", GauceDataColumn.TB_STRING));
							imgDs.addDataColumn(new GauceDataColumn("PICTURE_URL", GauceDataColumn.TB_URL, 1024));
							
							while ( rs.next()) {
								GauceDataRow row = ds1.newDataRow();
								for(int i=0; i<columnName.length; i++) {
									if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
										row.addColumnValue(rs.getInt(columnName[i]));
									else
										row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
								}
								ds1.addDataRow(row);
								
								GauceDataRow imgRow = imgDs.newDataRow();
								File imgFile = new File(SAVE_FILE + rs.getString("REQ_NO")+".JPG");
								imgRow.addColumnValue(rs.getString("REQ_NO"));

								//StringUtil.printMsg("저장파일이름",SAVE_FILE +rs.getString("REQ_NO")+".JPG",this);
								if(imgFile.isFile()){
									//StringUtil.printMsg("이미지 패스",dir_path + HDConstant.FILE_DOWNLOAD_PATH_REQ + rs.getString("REQ_NO")+".JPG",this);
									imgRow.addColumnValue(HDConstant.FILE_DOWNLOAD_PATH_REQ + rs.getString("REQ_NO")+".JPG");
									imgRow.addColumnValue(HDConstant.FILE_DOWNLOAD_PATH_REQ + rs.getString("REQ_NO")+".JPG");
								} else {
									imgRow.addColumnValue("");
									imgRow.addColumnValue("");
								}
								imgDs.addDataRow(imgRow);
								
							}//End of while
							if(rs!=null) rs.close();
							if(cstmt!=null) cstmt.close();
		
							//StringUtil.printMsg("# ResultSet Total Count",ds1.getDataRowCnt(),this);
							break;
					}
				}
				//gos.write(getDataSet(rs, ds1));
				//gos.write(getDataSet(rs, imgDs));
				//ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.
				//imgDs.flush();
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

	/**
	 * 기능 :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;	
		ResultSet 		rs 			= null;
    	
    	//StringUtil.printMsg("# Command","저장",this);
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		/* DataSet */
		GauceDataSet inputDs = gis.read("DEFAULT");
		GauceDataSet reqNoDS = gis.read("reqNoDS");
		GauceDataSet imgDs = gis.read("IMAGE");
		GauceDataSet msgDS = gis.read("msgDS");
		
		String reqNo="";
		boolean fail=false;
	
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;


		try{
			if(inputDs!=null){
                
				int colNm_ReqNo                 = inputDs.indexOfColumn("REQ_NO");
				int colNm_ClientSid             = inputDs.indexOfColumn("CLIENT_SID");
				int colNm_AcceptDate            = inputDs.indexOfColumn("ACCEPT_DATE");
				int colNm_AcceptTime            = inputDs.indexOfColumn("ACCEPT_TIME");				
				int colNm_StatusCd              = inputDs.indexOfColumn("STATUS_CD");
				int colNm_ClientDam_nm          = inputDs.indexOfColumn("CLIENT_DAM_NM");
				int colNm_MobileNo              = inputDs.indexOfColumn("MOBILE_NO");
				int colNm_DepartDate            = inputDs.indexOfColumn("DEPART_DATE");
				int colNm_AcceptSid             = inputDs.indexOfColumn("ACCEPT_SID");
				int colNm_AcceptNo              = inputDs.indexOfColumn("ACCEPT_NO");
				int colNm_RsvSid                = inputDs.indexOfColumn("RSV_SID");
				int colNm_CustSid               = inputDs.indexOfColumn("CUST_SID");
				int colNm_CustNm                = inputDs.indexOfColumn("CUST_NM");
				int colNm_ManageNo              = inputDs.indexOfColumn("MANAGE_NO");
				int colNm_CompanyNm             = inputDs.indexOfColumn("COMPANY_NM");
				int colNm_Positions             = inputDs.indexOfColumn("POSITIONS");
				int colNm_CustMobile_no         = inputDs.indexOfColumn("CUST_MOBILE_NO");
				int colNm_PayAmt                = inputDs.indexOfColumn("PAY_AMT");
				int colNm_RqAmt           		= inputDs.indexOfColumn("RQ_AMT");
				int colNm_ChargeCd              = inputDs.indexOfColumn("CHARGE_CD");
				int colNm_ChargeRate            = inputDs.indexOfColumn("CHARGE_RATE");				
				int colNm_Bancod                = inputDs.indexOfColumn("BANCOD");
				int colNm_Bannm                 = inputDs.indexOfColumn("BANNM");
				int colNm_BankAcc_no            = inputDs.indexOfColumn("BANK_ACC_NO");
				int colNm_BankAcct_nm           = inputDs.indexOfColumn("BANK_ACCT_NM");
				int colNm_Reason                = inputDs.indexOfColumn("REASON");
				int colNm_Desc                  = inputDs.indexOfColumn("DESC");				
				int colNm_JobType				= inputDs.indexOfColumn("JOB_TYPE");
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				GauceDataRow[] 		imgRow = imgDs.getDataRows();
				GauceDataColumn[] 	imgCol = imgDs.getDataColumns();				
				
				//메시지처리
				//res.enableFirstRow(msgDS);
				msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));
				
				//블록번호
				//res.enableFirstRow(reqNoDS);
				reqNoDS.addDataColumn(new GauceDataColumn("req_no", GauceDataColumn.TB_STRING));

				for(int i=0; i<rows.length; i++){
					int j=1;
					switch(rows[i].getJobType()){
					case GauceDataRow.TB_JOB_INSERT:
						/*StringUtil.printMsg("call","SALES.PR_RV510i_02-INSERT",this);
						StringUtil.printMsg("colNm_ReqNo",rows[i].getString(colNm_ReqNo),this);
						StringUtil.printMsg("colNm_ClientSid",rows[i].getString(colNm_ClientSid),this);
						StringUtil.printMsg("colNm_AcceptDate",rows[i].getString(colNm_AcceptDate),this);
						StringUtil.printMsg("colNm_StatusCd",rows[i].getString(colNm_StatusCd),this);
						StringUtil.printMsg("colNm_ClientDam_nm",rows[i].getString(colNm_ClientDam_nm),this);
						StringUtil.printMsg("colNm_MobileNo",rows[i].getString(colNm_MobileNo),this);
						StringUtil.printMsg("colNm_DepartDate",rows[i].getString(colNm_DepartDate),this);
						StringUtil.printMsg("colNm_AcceptSid",rows[i].getString(colNm_AcceptSid),this);
						StringUtil.printMsg("colNm_RsvSid",rows[i].getString(colNm_RsvSid),this);
						StringUtil.printMsg("colNm_ChargeCd",rows[i].getString(colNm_ChargeCd),this);
						StringUtil.printMsg("colNm_Bancod",rows[i].getString(colNm_Bancod),this);
						StringUtil.printMsg("colNm_BankAcc_no",rows[i].getString(colNm_BankAcc_no),this);
						StringUtil.printMsg("colNm_BankAcct_nm",rows[i].getString(colNm_BankAcct_nm),this);
						StringUtil.printMsg("colNm_Reason",rows[i].getString(colNm_Reason),this);
						StringUtil.printMsg("colNm_Desc",rows[i].getString(colNm_Desc),this);*/
						 						
						cstmt = conn.prepareCall("{call SALES.PR_RV510i_02(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?) }");
						
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
						cstmt.setString(11, rows[i].getString(colNm_ChargeCd));
						cstmt.setString(12, rows[i].getString(colNm_ChargeRate));						
						cstmt.setString(13, rows[i].getString(colNm_Bancod));
						cstmt.setString(14, rows[i].getString(colNm_BankAcc_no));
						cstmt.setString(15, rows[i].getString(colNm_BankAcct_nm));
						cstmt.setInt(16, rows[i].getInt(colNm_RqAmt));
						cstmt.setString(17, rows[i].getString(colNm_Reason));
						cstmt.setString(18, rows[i].getString(colNm_Desc));
						cstmt.setString(19, rows[i].getString(colNm_JobType));
						cstmt.setString(20, iParamEmpno);
						cstmt.setString(21, iParamIp);
						cstmt.setString(22, "1");
						cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						GauceDataRow row = reqNoDS.newDataRow();
						row.addColumnValue(cstmt.getString(1));						
						reqNoDS.addDataRow(row);
						
						//StringUtil.printMsg("길이",imgRow.length,this);
						for(int k=0; k<imgRow.length; k++){
							if ( imgRow[k].getString(0).equals("")) {
								imgRow[k].setString(0,cstmt.getString(1).trim());
								break;
							}
						}

						//메시지처리
						if (!cstmt.getString(23).equals("Y") ) 
							throw new Exception(cstmt.getString(25));
						
						if (cstmt.getString(23).equals("Y") ) {
							if ( !cstmt.getString(24).equals("0000") ) {
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(25));
								msgDS.addDataRow(row2);
							}
						}  
						
						if(cstmt!=null) cstmt.close();						
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("call","SALES.PR_RV510i_02-UPDATE",this);
						cstmt = conn.prepareCall("{call SALES.PR_RV510i_02(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?) }");
						
						//StringUtil.printMsg("colNm_ReqNo",rows[i].getString(colNm_ReqNo),this);
						//StringUtil.printMsg("colNm_RqAmt",rows[i].getInt(colNm_RqAmt),this);
						
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
						cstmt.setString(11, rows[i].getString(colNm_ChargeCd));
						cstmt.setString(12, rows[i].getString(colNm_ChargeRate));						
						cstmt.setString(13, rows[i].getString(colNm_Bancod));
						cstmt.setString(14, rows[i].getString(colNm_BankAcc_no));
						cstmt.setString(15, rows[i].getString(colNm_BankAcct_nm));
						cstmt.setInt(16, rows[i].getInt(colNm_RqAmt));
						cstmt.setString(17, rows[i].getString(colNm_Reason));
						cstmt.setString(18, rows[i].getString(colNm_Desc));
						cstmt.setString(19, rows[i].getString(colNm_JobType));
						cstmt.setString(20, iParamEmpno);
						cstmt.setString(21, iParamIp);
						cstmt.setString(22, "3");
						cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						//메시지처리
						if (!cstmt.getString(23).equals("Y") ) 
							throw new Exception(cstmt.getString(25));
						
						if (cstmt.getString(23).equals("Y") ) {
							if ( !cstmt.getString(24).equals("0000") ) {
								StringUtil.printMsg("성공메시지",cstmt.getString(25),this);
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(25));
								msgDS.addDataRow(row2);
							}
						}  
						
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_DELETE:
						//StringUtil.printMsg("call","SALES.PR_RV510i_02-DELETE",this);
						cstmt = conn.prepareCall("{call SALES.PR_RV510i_02(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?) }");
						
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
						cstmt.setString(11, rows[i].getString(colNm_ChargeCd));
						cstmt.setString(12, rows[i].getString(colNm_ChargeRate));						
						cstmt.setString(13, rows[i].getString(colNm_Bancod));
						cstmt.setString(14, rows[i].getString(colNm_BankAcc_no));
						cstmt.setString(15, rows[i].getString(colNm_BankAcct_nm));
						cstmt.setInt(16, rows[i].getInt(colNm_RqAmt));
						cstmt.setString(17, rows[i].getString(colNm_Reason));
						cstmt.setString(18, rows[i].getString(colNm_Desc));
						cstmt.setString(19, rows[i].getString(colNm_JobType));
						cstmt.setString(20, iParamEmpno);
						cstmt.setString(21, iParamIp);
						cstmt.setString(22, "2");
						cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						//메시지처리
						if (!cstmt.getString(23).equals("Y") ) 
							throw new Exception(cstmt.getString(25));
						
						if (cstmt.getString(23).equals("Y") ) {
							if ( !cstmt.getString(24).equals("0000") ) {
								//StringUtil.printMsg("성공메시지",cstmt.getString(25),this);
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(25));
								msgDS.addDataRow(row2);
							}
						}  
						
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
				//StringUtil.printMsg("img길이",imgRow.length,this);
				
				for(int i=0; i<imgRow.length; i++){
					switch(imgRow[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							//StringUtil.printMsg("i",i,this);
							// 사진 정보 등록
							int data_name = imgDs.indexOfColumn("PICTURE_INFO");
							int data_url  = imgDs.indexOfColumn("PICTURE_URL");
							String d_name = imgRow[i].getString(data_name);
							//StringUtil.printMsg("d_name",d_name,this);		
							//StringUtil.printMsg("imgRow[i]",imgRow[i].getString(1).trim(),this);
							
							if(!imgRow[i].getString(1).trim().equals("") && d_name!=null && !d_name.equals("")){
								String o_name = imgRow[i].getString(0).trim() + ".JPG";
								//StringUtil.printMsg("o_name",o_name,this);								
									
								InputStream is = (InputStream)imgRow[i].getInputStream(data_url);
								FileOutputStream os = new FileOutputStream(SAVE_FILE + o_name);
								copy(is, os, 1024*1024*10 );
								is.close();
								os.close();
							}
							break;
					}
				}	
				//gos.write(getDataSet(rs, reqNoDS));
				//reqNoDS.flush();
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
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}
