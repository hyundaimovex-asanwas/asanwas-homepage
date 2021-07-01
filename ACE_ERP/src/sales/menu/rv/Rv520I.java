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

public class Rv520I extends SuperServlet {
	
	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_REQ;
	
    public void makeSql(){
		/** 
		 * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다 
		 **/
    	String iParamEmpno = fParamEmpno;
    	String iParamIp = fParamIp;
    	
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
		arr_sql[0].append (" SELECT						    		\n")
		  .append ("   T1.CLIENT_SID,                  \n")		
		  .append ("   T1.CLIENT_DAM_NM,                  \n")
		  .append ("   T1.TEL_NO                      \n")
		  .append("	FROM SALES.TCU030	T1		\n");    	
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
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							res.enableFirstRow(ds1);
							if(gauceName.equals("IMAGE")){
								ds1.addDataColumn(new GauceDataColumn("REQ_NO", GauceDataColumn.TB_STRING));
								ds1.addDataColumn(new GauceDataColumn("PICTURE_INFO", GauceDataColumn.TB_STRING));
								ds1.addDataColumn(new GauceDataColumn("PICTURE_URL", GauceDataColumn.TB_URL, 1024));
								StringUtil.printMsg("IMAGE","HEAD CREATE",this);
								ds1.flush();									
							}
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
		GauceDataSet imgDs = null;		
		CallableStatement cstmt = null;		
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		try {
			// 검색시 조건
			String 	sClientSid	= HDUtil.nullCheckStr(req.getParameter("sClientSid"));
			String 	sStatusCd	= HDUtil.nullCheckStr(req.getParameter("sStatusCd"));			
			String 	sBgnDate	= HDUtil.nullCheckStr(req.getParameter("sBgnDate"));
			String 	sEndDate	= HDUtil.nullCheckStr(req.getParameter("sEndDate"));			
			
			//StringUtil.printMsg("sClientSid",sClientSid,this);
			//StringUtil.printMsg("sStatusCd",sStatusCd,this);			
			//StringUtil.printMsg("sBgnDate",sBgnDate,this);
			//StringUtil.printMsg("sEndDate",sEndDate,this);			

			// dataset 구분 param
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			ds1 = req.getGauceDataSet("DS1");
			imgDs = req.getGauceDataSet("IMAGE");				
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							res.enableFirstRow(ds1);
							res.enableFirstRow(imgDs);
							
							//StringUtil.printMsg("call","SALES.PR_RV520i_01",this);
							cstmt = conn.prepareCall("{call SALES.PR_RV520I_01(?, ?, ?, ?) }");
							cstmt.setInt(1, Integer.parseInt(sClientSid));								
							cstmt.setString(2, sStatusCd);
							cstmt.setString(3, sBgnDate);
							cstmt.setString(4, sEndDate); 								
							
							rs = cstmt.executeQuery(); // DataSet set
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
								//StringUtil.printMsg("저장파일경로",SAVE_FILE +rs.getString("REQ_NO")+".JPG",this);
								
								File imgFile = new File(SAVE_FILE + rs.getString("REQ_NO")+".JPG");
								imgRow.addColumnValue(rs.getString("REQ_NO"));
								if(imgFile.isFile()){
									//StringUtil.printMsg("이미지 패스",HDConstant.FILE_DOWNLOAD_PATH_REQ + rs.getString("REQ_NO")+".JPG",this);
									imgRow.addColumnValue(HDConstant.FILE_DOWNLOAD_PATH_REQ + rs.getString("REQ_NO")+".JPG");
									imgRow.addColumnValue(HDConstant.FILE_DOWNLOAD_PATH_REQ + rs.getString("REQ_NO")+".JPG");
								} else {
									//System.out.println("PICTURE NAME : " + rs.getString("REQ_NO"));
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
				ds1.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.
				imgDs.flush();				
		} catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
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
		GauceDataSet inputDs = req.getGauceDataSet("DEFAULT");
		GauceDataSet reqNoDS = req.getGauceDataSet("reqNoDS");	
		GauceDataSet imgDs = req.getGauceDataSet("IMAGE");	
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
                
				int colNm_ReqNo                 = inputDs.indexOfColumn("REQ_NO");
				int colNm_ClientSid             = inputDs.indexOfColumn("CLIENT_SID");
				int colNm_AcceptDate            = inputDs.indexOfColumn("ACCEPT_DATE");
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
				int colNm_CustMobile_no                 = inputDs.indexOfColumn("CUST_MOBILE_NO");
				//int colNm_Amt           = inputDs.indexOfColumn("AMT");
				int colNm_AdJobSel             = inputDs.indexOfColumn("AD_JOB_SEL");
				/*int colNm_ARoomTypeSid                = inputDs.indexOfColumn("A_ROOM_TYPE_SID");
				int colNm_ARoomTypeCd                 = inputDs.indexOfColumn("A_ROOM_TYPE_CD");
				int colNm_ARoomTypeNm                 = inputDs.indexOfColumn("A_ROOM_TYPE_NM");
				int colNm_AUpjangSid           = inputDs.indexOfColumn("A_UPJANG_SID");
				int colNm_AUpjangCd            = inputDs.indexOfColumn("A_UPJANG_CD");
				int colNm_AUpjangNm            = inputDs.indexOfColumn("A_UPJANG_NM");
				int colNm_RoomTypeSid                  = inputDs.indexOfColumn("ROOM_TYPE_SID");
				int colNm_RoomTypeCd           = inputDs.indexOfColumn("ROOM_TYPE_CD");
				int colNm_RoomTypeNm           = inputDs.indexOfColumn("ROOM_TYPE_NM");
				int colNm_UpjangSid             = inputDs.indexOfColumn("UPJANG_SID");
				int colNm_UpjangCd              = inputDs.indexOfColumn("UPJANG_CD");
				int colNm_UpjangNm              = inputDs.indexOfColumn("UPJANG_NM");
				*/
				int colNm_Reason                = inputDs.indexOfColumn("REASON");
				int colNm_Desc                  = inputDs.indexOfColumn("DESC");				
				
				GauceDataRow[] 		rows = inputDs.getDataRows();
				GauceDataColumn[] 	cols = inputDs.getDataColumns();
				
				GauceDataRow[] 		imgRow = imgDs.getDataRows();
				GauceDataColumn[] 	imgCol = imgDs.getDataColumns();					

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
						//StringUtil.printMsg("call","SALES.PR_RV520i_02-INSERT",this);
						cstmt = conn.prepareCall("{call SALES.PR_RV520i_02(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_ReqNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setInt(2, rows[i].getInt(colNm_ClientSid));
						cstmt.setString(3, rows[i].getString(colNm_AcceptDate));
						cstmt.setString(4, rows[i].getString(colNm_StatusCd));
						cstmt.setString(5, rows[i].getString(colNm_ClientDam_nm));
						cstmt.setString(6, rows[i].getString(colNm_MobileNo));
						cstmt.setString(7, rows[i].getString(colNm_DepartDate));
						cstmt.setInt(8, rows[i].getInt(colNm_AcceptSid));
						cstmt.setInt(9, rows[i].getInt(colNm_RsvSid));
						cstmt.setString(10, rows[i].getString(colNm_AdJobSel));
						cstmt.setString(11, rows[i].getString(colNm_Reason));
						cstmt.setString(12, rows[i].getString(colNm_Desc));
						cstmt.setString(13, iParamEmpno);
						cstmt.setString(14, iParamIp);
						cstmt.setString(15, "1");						
						cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
						
						cstmt.executeUpdate();
						
						GauceDataRow row = reqNoDS.newDataRow();
						row.addColumnValue(cstmt.getString(1));						
						reqNoDS.addDataRow(row);
						
						for(int k=0; k<imgRow.length; k++){
							if ( imgRow[k].getString(0).equals("")) {
								imgRow[k].setString(0,cstmt.getString(1).trim());
								break;
							}
						}						

						//메시지처리
						if (cstmt.getString(16).equals("Y") ) {
							if ( !cstmt.getString(17).equals("0000") ) {
								StringUtil.printMsg("성공메시지",cstmt.getString(18),this);
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(18));
								msgDS.addDataRow(row2);
							}
						} else {
							StringUtil.printMsg("실패메시지",cstmt.getString(18),this);								
							conn.rollback();
							GauceDataRow row2 = msgDS.newDataRow();								
							row2.addColumnValue(cstmt.getString(18));
							msgDS.addDataRow(row2);
							fail=true;
							break;						
						} 
						
						if(cstmt!=null) cstmt.close();		
						break;
					case GauceDataRow.TB_JOB_UPDATE:
						//StringUtil.printMsg("call","SALES.PR_RV520i_02-UPDATE",this);
						cstmt = conn.prepareCall("{call SALES.PR_RV520i_02(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_ReqNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setInt(2, rows[i].getInt(colNm_ClientSid));
						cstmt.setString(3, rows[i].getString(colNm_AcceptDate));
						cstmt.setString(4, rows[i].getString(colNm_StatusCd));
						cstmt.setString(5, rows[i].getString(colNm_ClientDam_nm));
						cstmt.setString(6, rows[i].getString(colNm_MobileNo));
						cstmt.setString(7, rows[i].getString(colNm_DepartDate));
						cstmt.setInt(8, rows[i].getInt(colNm_AcceptSid));
						cstmt.setInt(9, rows[i].getInt(colNm_RsvSid));
						cstmt.setString(10, rows[i].getString(colNm_AdJobSel));
						cstmt.setString(11, rows[i].getString(colNm_Reason));
						cstmt.setString(12, rows[i].getString(colNm_Desc));
						cstmt.setString(13, iParamEmpno);
						cstmt.setString(14, iParamIp);
						cstmt.setString(15, "3");						
						cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);

						
						cstmt.executeUpdate();
						
						//메시지처리
						if (cstmt.getString(16).equals("Y") ) {
							if ( !cstmt.getString(17).equals("0000") ) {
								//StringUtil.printMsg("성공메시지",cstmt.getString(18),this);
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(18));
								msgDS.addDataRow(row2);
							}
						} else {
							//StringUtil.printMsg("실패메시지",cstmt.getString(18),this);								
							conn.rollback();
							GauceDataRow row2 = msgDS.newDataRow();								
							row2.addColumnValue(cstmt.getString(18));
							msgDS.addDataRow(row2);
							fail=true;
							break;						
						} 
						
						if(cstmt!=null) cstmt.close();	
						break;
					case GauceDataRow.TB_JOB_DELETE:
						//StringUtil.printMsg("call","SALES.PR_RV520i_02-DELETE",this);
						cstmt = conn.prepareCall("{call SALES.PR_RV520i_02(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?) }");
						
						cstmt.setString(1, rows[i].getString(colNm_ReqNo));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);						
						cstmt.setInt(2, rows[i].getInt(colNm_ClientSid));
						cstmt.setString(3, rows[i].getString(colNm_AcceptDate));
						cstmt.setString(4, rows[i].getString(colNm_StatusCd));
						cstmt.setString(5, rows[i].getString(colNm_ClientDam_nm));
						cstmt.setString(6, rows[i].getString(colNm_MobileNo));
						cstmt.setString(7, rows[i].getString(colNm_DepartDate));
						cstmt.setInt(8, rows[i].getInt(colNm_AcceptSid));
						cstmt.setInt(9, rows[i].getInt(colNm_RsvSid));
						cstmt.setString(10, rows[i].getString(colNm_AdJobSel));
						cstmt.setString(11, rows[i].getString(colNm_Reason));
						cstmt.setString(12, rows[i].getString(colNm_Desc));
						cstmt.setString(13, iParamEmpno);
						cstmt.setString(14, iParamIp);
						cstmt.setString(15, "2");						
						cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);						
						cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
						cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);

						
						cstmt.executeUpdate();
						
						//메시지처리
						if (cstmt.getString(16).equals("Y") ) {
							if ( !cstmt.getString(17).equals("0000") ) {
								StringUtil.printMsg("성공메시지",cstmt.getString(18),this);
								GauceDataRow row2 = msgDS.newDataRow();									
								row2.addColumnValue(cstmt.getString(18));
								msgDS.addDataRow(row2);
							}
						} else {
							StringUtil.printMsg("실패메시지",cstmt.getString(18),this);								
							conn.rollback();
							GauceDataRow row2 = msgDS.newDataRow();
							row2.addColumnValue(cstmt.getString(18));
							msgDS.addDataRow(row2);
							fail=true;
							break;						
						} 
						
						if(cstmt!=null) cstmt.close();	
						break;						
					}
				}
				
				//StringUtil.printMsg("img길이",imgRow.length,this);
				for(int i=0; i<imgRow.length; i++){
					switch(imgRow[i].getJobType()){
						case GauceDataRow.TB_JOB_INSERT:
							//사진 정보 등록
							int data_name = imgDs.indexOfColumn("PICTURE_INFO");
							int data_url  = imgDs.indexOfColumn("PICTURE_URL");
							String d_name = imgRow[i].getString(data_name);
							
							if(!imgRow[i].getString(1).trim().equals("") && d_name!=null && !d_name.equals("")){
								String o_name = imgRow[i].getString(0).trim() + ".JPG";
								InputStream is = (InputStream)imgRow[i].getInputStream(data_url);
								FileOutputStream os = new FileOutputStream(SAVE_FILE + o_name);
								copy(is, os, 1024*1024*10 );
								is.close();
								os.close();
							}
							break;
					}
				}	
				
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
