package sales.menu.ac;

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

public class Ac430S extends SuperServlet {

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

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	  //StringUtil.printMsg("# Command","선조회",this);

		CallableStatement cstmt = null;
		ResultSet rs = null;
		String[] columnName = null;
	  ResultSetMetaData rsmd = null;
	

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
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	  /*****************************************************************************
	   * Gauce Object 설정
	   *****************************************************************************/
	  //StringUtil.printMsg("# Command","조회",this);

		CallableStatement cstmt = null;		
		//GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
	  try {
		 // 검색시 조건
		 int       sSalDamSid    = HDUtil.nullCheckNum(greq.getParameter("sSalDamSid"));
		 int       sClientSid    = HDUtil.nullCheckNum(greq.getParameter("sClientSid"));
		 String    sStatusCd     = HDUtil.nullCheckStr(greq.getParameter("sStatusCd"));
		 String    sBgnDate      = HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
		 String    sEndDate      = HDUtil.nullCheckStr(greq.getParameter("sEndDate"));
		 String    sAcceptNo     = HDUtil.nullCheckStr(greq.getParameter("sAcceptNo"));
		 String    sCustNm       = HDUtil.nullCheckStr(greq.getParameter("sCustNm"));
		 String    sJobType      = HDUtil.nullCheckStr(greq.getParameter("sJobType"));
		 String    sDpBgnDate    = HDUtil.nullCheckStr(greq.getParameter("sDpBgnDate"));
		 String    sDpEndDate    = HDUtil.nullCheckStr(greq.getParameter("sDpEndDate"));
		 int       sSaup_sid     = HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));
		 int       sGoods_sid    = HDUtil.nullCheckNum(greq.getParameter("sGoods_sid"));
		 String    sRfBgnDate    = HDUtil.nullCheckStr(greq.getParameter("sRfBgnDate"));
		 String    sRfEndDate    = HDUtil.nullCheckStr(greq.getParameter("sRfEndDate"));

         
		 int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));
			GauceInputStream gis = greq.getGauceInputStream();
			GauceOutputStream gos = gres.getGauceOutputStream();
			//Component 로부터 전송된 입력스트림의 Output GauceDataSet의 배열을 반환
			GauceDataSet[] dSets = gis.readAllOutput();
			
			GauceDataSet ds1 = gis.read("DS1");
			GauceDataSet imgDs = gis.read("IMAGE");
 
			if(ds1!=null){
				 //res.enableFirstRow(ds1);

				 cstmt = conn.prepareCall("{call SALES.PR_AC430S_01(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?) }");
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
				 StringUtil.printMsg("sSaup_sid",sSaup_sid,this);
				 StringUtil.printMsg("sGoods_sid",sGoods_sid,this);
				 StringUtil.printMsg("sRfBgnDate",sRfBgnDate,this);
				 StringUtil.printMsg("sRfEndDate",sRfEndDate,this);
				 */
				 cstmt.setInt(1, sSalDamSid);
				 cstmt.setInt(2, sClientSid);
				 cstmt.setString(3, sStatusCd);
				 cstmt.setString(4, sBgnDate);
				 cstmt.setString(5, sEndDate);
				 cstmt.setString(6, sAcceptNo);
				 cstmt.setString(7, sCustNm);
				 cstmt.setString(8, sJobType);
				 cstmt.setString(9, sDpBgnDate);
				 cstmt.setString(10, sDpEndDate);
				 cstmt.setInt(11, sSaup_sid);
				 cstmt.setInt(12, sGoods_sid);
				 cstmt.setString(13, sRfBgnDate);
				 cstmt.setString(14, sRfEndDate);
				 cstmt.registerOutParameter(15, OracleTypes.CURSOR);	//결과를 받을 커서
				cstmt.executeQuery();
				rs = (ResultSet)cstmt.getObject(15);	//커서 OUT param. 			
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

   /**
	* 기능 :
	* @param req
	* @param res
	* @param dsNum = 1
	*
	*/
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
   }
}