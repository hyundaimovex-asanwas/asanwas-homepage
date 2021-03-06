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

public class Rv511I extends SuperServlet {

   /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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

   }

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	  //StringUtil.printMsg("# Command","선조회",this);

	  /* DataSet */
	  CallableStatement cstmt = null;
	  ResultSet rs = null;
	  ResultSetMetaData rsmd = null;
	  String[] columnName = null;

	  int v_rowcnt = 0;

	  int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

	  try{
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

	  CallableStatement cstmt = null;		
	  ResultSet rs = null;
	  ResultSetMetaData rsmd = null;
	  String[] columnName = null;
	  try {
		 // 검색시 조건

		 int       sSalDamSid    = HDUtil.nullCheckNum(greq.getParameter("sSalDamSid"));
		 int	   sClientSid    = HDUtil.nullCheckNum(greq.getParameter("sClientSid"));
		 String    sStatusCd     = HDUtil.nullCheckStr(greq.getParameter("sStatusCd"));
		 String    sBgnDate      = HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
		 String    sEndDate      = HDUtil.nullCheckStr(greq.getParameter("sEndDate"));
		 String    sAcceptNo     = HDUtil.nullCheckStr(greq.getParameter("sAcceptNo"));
		 String    sCustNm       = HDUtil.nullCheckStr(greq.getParameter("sCustNm"));
		 String    sDpBgnDate    = HDUtil.nullCheckStr(greq.getParameter("sDpBgnDate"));
		 String    sDpEndDate    = HDUtil.nullCheckStr(greq.getParameter("sDpEndDate"));
		 String    sJobType      = HDUtil.nullCheckStr(greq.getParameter("sJobType"));
		 int  	   sSaupSid		 = HDUtil.nullCheckNum(greq.getParameter("sSaup_sid")); 	// 지역
		 int       sGoodsSid	 = HDUtil.nullCheckNum(greq.getParameter("sGoods_sid")); 	// 상품id
		

		 // dataset 구분 param
		 int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
		GauceDataSet[] dSets = gis.readAllOutput();
		
		GauceDataSet ds1 = gis.read("DS1");
		GauceDataSet ds2 = gis.read("DS2");
		GauceDataSet ds3 = gis.read("DS3");
		GauceDataSet ds4 = gis.read("DS4");
		
			if(ds1!=null){
					 GauceDataSet imgDs = gis.read("IMAGE");
					 
					 cstmt = conn.prepareCall("{call SALES.PR_RV511I_01N(?,?,?,?,?,   ?,?,?,?,?,  ?,?,?) }");

					 cstmt.setInt	(1, sSalDamSid);
					 cstmt.setInt	(2, sClientSid);
					 cstmt.setString(3, sStatusCd);
					 cstmt.setString(4, sBgnDate);
					 cstmt.setString(5, sEndDate);
					 cstmt.setString(6, sAcceptNo);
					 cstmt.setString(7, sCustNm);
					 cstmt.setString(8, sJobType);
					 cstmt.setString(9, sDpBgnDate);
					 cstmt.setString(10, sDpEndDate);
					 cstmt.setInt	(11,sSaupSid);
					 cstmt.setInt	(12,sGoodsSid);					 
					 cstmt.registerOutParameter(13, OracleTypes.CURSOR);	//결과를 받을 커서
					 cstmt.executeQuery();
					 rs = (ResultSet)cstmt.getObject(13);	//커서 OUT param. 			
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

			   
			}

			if(ds2!=null){	//리포트 출력용
			   //res.enableFirstRow(ds2);

			   //StringUtil.printMsg("call","SALES.PR_RV511I_03",this);
			   cstmt = conn.prepareCall("{call SALES.PR_RV511I_03(?,?,?,?,?,   ?,?,?,?,?,  ?,?,?) }");
			   /*
			   StringUtil.printMsg("sSalDamSid",sSalDamSid,this);
			   StringUtil.printMsg("sClientSid",sClientSid,this);
			   StringUtil.printMsg("sStatusCd",sStatusCd,this);
			   StringUtil.printMsg("sBgnDate",sBgnDate,this);
			   StringUtil.printMsg("sEndDate",sEndDate,this);
			   StringUtil.printMsg("sAcceptNo",sAcceptNo,this);
			   StringUtil.printMsg("sCustNm",sCustNm,this);
			   StringUtil.printMsg("sJobType",sJobType,this);
			   StringUtil.printMsg("sDpBgnDate",sDpBgnDate,this);
			   StringUtil.printMsg("sDpEndDate",sDpEndDate,this);
			   StringUtil.printMsg("sSaupSid",sSaupSid,this);
			   StringUtil.printMsg("sGoodsSid",sGoodsSid,this);
			   */
			   cstmt.setInt	(1, sSalDamSid);
			   cstmt.setInt	(2, sClientSid);
			   cstmt.setString(3, sStatusCd);
			   cstmt.setString(4, sBgnDate);
			   cstmt.setString(5, sEndDate);
			   cstmt.setString(6, sAcceptNo);
			   cstmt.setString(7, sCustNm);
			   cstmt.setString(8, sJobType);
			   cstmt.setString(9, sDpBgnDate);
			   cstmt.setString(10, sDpEndDate);
			   cstmt.setInt	(11,sSaupSid);
			   cstmt.setInt	(12,sGoodsSid);			   
			   cstmt.registerOutParameter(13, OracleTypes.CURSOR);	//결과를 받을 커서
			   cstmt.executeQuery();
			   rs = (ResultSet)cstmt.getObject(13);	//커서 OUT param. 			
			   gos.write(getDataSet(rs, ds2));
				 
			   rsmd = rs.getMetaData();

			   columnName = new String[rsmd.getColumnCount()];

			   for(int i=0; i<columnName.length; i++){
				  columnName[i] = rsmd.getColumnName(i+1);
				  if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
					 ds2.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
				  else
					 ds2.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
			   }

			   while ( rs.next()) {
				  GauceDataRow row = ds2.newDataRow();
				  for(int i=0; i<columnName.length; i++) {
					 if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
						row.addColumnValue(rs.getInt(columnName[i]));
					 else
						row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
				  }
				  ds2.addDataRow(row);
				  //StringUtil.printMsg("addDataRow","1",this);
			   }//End of while

			   if(rs!=null) rs.close();
			   if(cstmt!=null) cstmt.close();

			   //StringUtil.printMsg("# ResultSet Total Count",ds2.getDataRowCnt(),this);
			   //ds2.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.
			}

			if(ds3!=null){	//리포트 출력용
			   //res.enableFirstRow(ds3);

			   //StringUtil.printMsg("call","SALES.PR_RV511I_04",this);
			   cstmt = conn.prepareCall("{call SALES.PR_RV511I_04(?,?,?,?,?,   ?,?,?,?,?,  ?,?,?) }");
			   /*
			   StringUtil.printMsg("sSalDamSid",sSalDamSid,this);
			   StringUtil.printMsg("sClientSid",sClientSid,this);
			   StringUtil.printMsg("sStatusCd",sStatusCd,this);
			   StringUtil.printMsg("sBgnDate",sBgnDate,this);
			   StringUtil.printMsg("sEndDate",sEndDate,this);
			   StringUtil.printMsg("sAcceptNo",sAcceptNo,this);
			   StringUtil.printMsg("sCustNm",sCustNm,this);
			   StringUtil.printMsg("sJobType",sJobType,this);
			   StringUtil.printMsg("sDpBgnDate",sDpBgnDate,this);
			   StringUtil.printMsg("sDpEndDate",sDpEndDate,this);
			   StringUtil.printMsg("sSaupSid",sSaupSid,this);
			   StringUtil.printMsg("sGoodsSid",sGoodsSid,this);
			   */
			   cstmt.setInt	(1, sSalDamSid);
			   cstmt.setInt	(2, sClientSid);
			   cstmt.setString(3, sStatusCd);
			   cstmt.setString(4, sBgnDate);
			   cstmt.setString(5, sEndDate);
			   cstmt.setString(6, sAcceptNo);
			   cstmt.setString(7, sCustNm);
			   cstmt.setString(8, sJobType);
			   cstmt.setString(9, sDpBgnDate);
			   cstmt.setString(10, sDpEndDate);
			   cstmt.setInt	(11,sSaupSid);
			   cstmt.setInt	(12,sGoodsSid);		
			   cstmt.registerOutParameter(13, OracleTypes.CURSOR);	//결과를 받을 커서
			   cstmt.executeQuery();
			   rs = (ResultSet)cstmt.getObject(13);	//커서 OUT param. 			
			   gos.write(getDataSet(rs, ds3));
			   rsmd = rs.getMetaData();

			   columnName = new String[rsmd.getColumnCount()];

			   for(int i=0; i<columnName.length; i++){
				  columnName[i] = rsmd.getColumnName(i+1);
				  if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
					 ds3.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_NUMBER, rsmd.getColumnDisplaySize(i+1)));
				  else
					 ds3.addDataColumn(new GauceDataColumn(columnName[i], GauceDataColumn.TB_STRING, rsmd.getColumnDisplaySize(i+1)));
			   }

			   while ( rs.next()) {
				  GauceDataRow row = ds3.newDataRow();
				  for(int i=0; i<columnName.length; i++) {
					 if(rsmd.getColumnTypeName(i+1).equals("NUMERIC"))
						row.addColumnValue(rs.getInt(columnName[i]));
					 else
						row.addColumnValue(rs.getString(columnName[i])==null ? "" : rs.getString(columnName[i]));
				  }
				  ds3.addDataRow(row);
				  //StringUtil.printMsg("addDataRow","1",this);
			   }//End of while
//StringUtil.printMsg("ds3","ds3============================",this);
			   if(rs!=null) rs.close();
			   if(cstmt!=null) cstmt.close();

			   //StringUtil.printMsg("# ResultSet Total Count",ds3.getDataRowCnt(),this);
			   ds3.flush(); // 현재 GauceDataSet에 저장되어 있으며 아직 Component로 송신되지 않은 GauceDataRow를 Component로 전송한다.
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
		
		StringUtil.printMsg("# Command","저장",this);
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		/* DataSet */
		GauceDataSet inputDs = gis.read("DEFAULT");
		GauceDataSet msgDS = gis.read("msgDS");				
		
	    boolean fail=false;

	  /**
	   * @Todo 사번 , 컴퓨터 IP는 퀴에서 가지고 와야한다
	   **/
	  String iParamEmpno = fParamEmpno;
	  String iParamIp = fParamIp;
	  try{
		 if(inputDs!=null){

			int colNm_ReqNo                 = inputDs.indexOfColumn("REQ_NO");
			int colNm_StatusCd              = inputDs.indexOfColumn("STATUS_CD");
			int colNm_Desc                  = inputDs.indexOfColumn("DESC");
			int colNm_JobType               = inputDs.indexOfColumn("JOB_TYPE");
			int colNm_ChargeCd              = inputDs.indexOfColumn("CHARGE_CD");

			GauceDataRow[]       rows = inputDs.getDataRows();
			GauceDataColumn[]    cols = inputDs.getDataColumns();

			//메시지처리
			//res.enableFirstRow(msgDS);
			msgDS.addDataColumn(new GauceDataColumn("pMsg", GauceDataColumn.TB_STRING));

			for(int i=0; i<rows.length; i++){
			   int j=1;
			   switch(rows[i].getJobType()){
			   case GauceDataRow.TB_JOB_UPDATE:
				  //StringUtil.printMsg("call","SALES.PR_RV511i_02-UPDATE",this);
				  cstmt = conn.prepareCall("{call SALES.PR_RV511i_02(?,?,?,?,?, ?,?,?,?,?,  ?) }");

				  //StringUtil.printMsg("rows[i].getString(colNm_StatusCd)",rows[i].getString(colNm_StatusCd),this);
				  cstmt.setString(1, rows[i].getString(colNm_ReqNo));
				  cstmt.setString(2, rows[i].getString(colNm_StatusCd));
				  cstmt.setString(3, rows[i].getString(colNm_Desc));
				  cstmt.setString(4, rows[i].getString(colNm_JobType));
				  cstmt.setString(5, rows[i].getString(colNm_ChargeCd));
				  cstmt.setString(6, iParamEmpno);
				  cstmt.setString(7, iParamIp);
				  cstmt.setString(8, "3");
				  cstmt.registerOutParameter(9,  java.sql.Types.VARCHAR);
				  cstmt.registerOutParameter(10,  java.sql.Types.VARCHAR);
				  cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);

				  cstmt.executeUpdate();
				  StringUtil.printMsg("cstmt.getString(9)",cstmt.getString(9),this);
				  //메시지처리
				  if (cstmt.getString(9).equals("Y") ) {
					 if ( !cstmt.getString(10).equals("0000") ) {
						//StringUtil.printMsg("cstmt.getString(9)",cstmt.getString(9),this);
						//StringUtil.printMsg("성공메시지",cstmt.getString(10),this);
						GauceDataRow row2 = msgDS.newDataRow();
						row2.addColumnValue(cstmt.getString(11));
						msgDS.addDataRow(row2);
					 }
				  } else {
					 StringUtil.printMsg("cstmt.getString(9)",cstmt.getString(9),this);
					 StringUtil.printMsg("실패메시지",cstmt.getString(10),this);
					 conn.rollback();
					 GauceDataRow row2 = msgDS.newDataRow();
					 row2.addColumnValue(cstmt.getString(11));
					 msgDS.addDataRow(row2);
					 fail = true;
					 break;
				  }

				  if(cstmt!=null) cstmt.close();
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
			if(cstmt!=null) cstmt.close();
		//if( fail == true ) throw new Exception("");			
		}
	}
}
