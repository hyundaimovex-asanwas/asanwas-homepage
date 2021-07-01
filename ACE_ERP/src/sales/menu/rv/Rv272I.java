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

public class Rv272I extends SuperServlet {

	String SAVE_FILE = HDConstant.FILE_UPLOAD_PATH_REQ;
	
	public void makeSql(){
		//StringUtil.printMsg("# Command","sql 생성",this);    	
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		//조회(master)
		arr_sql[0].append("{CALL SALES.PR_RV272I_01(?,?,?,?,?,    ?,?,?,?,?)}");
		//조회(detail)
			  arr_sql[1].append("{CALL SALES.PR_RV272I_02(?,?,?,?,?,    ?,?,?,?,?,    ?,?)}");
   }
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
//		StringUtil.printMsg("# Command","선조회",this);

	}	

	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req,
				GauceResponse res) throws ServletException, Exception {
			// TODO Auto-generated method stub
		
			GauceStatement 		stmt 		= null;
			ResultSet 			rs 			= null;
			ResultSetMetaData 	rsmd 		= null;
			String[] 			columnName 	= null;
			CallableStatement cstmt;
		
			//int v_rowcnt = 0;

			/* DataSet */
			GauceDataSet ds1 = null; // 대리점 정보 
		
			/*
			 * 검색시 필요한 조건
			 */
		
			int 		v_saup_sid		= HDUtil.nullCheckNum(req.getParameter("v_saup_sid"));
			int	    sClientSid    		= HDUtil.nullCheckNum(req.getParameter("sClientSid"));
			int		v_upjang_sid 	= HDUtil.nullCheckNum(req.getParameter("v_upjang_sid"));
			int		v_menu_sid 		= HDUtil.nullCheckNum(req.getParameter("v_menu_sid"));
			String	v_use_seq		= HDUtil.nullCheckStr(req.getParameter("v_use_seq"));
			String	v_fr_accept_date	 		= HDUtil.nullCheckStr(req.getParameter("v_fr_accept_date"));		
			String	v_to_accept_date	 		= HDUtil.nullCheckStr(req.getParameter("v_to_accept_date"));		
			String	v_fr_date	 		= HDUtil.nullCheckStr(req.getParameter("v_fr_date"));		
			String	v_to_date	 		= HDUtil.nullCheckStr(req.getParameter("v_to_date"));		
			String	v_fr_use_date	= HDUtil.nullCheckStr(req.getParameter("v_fr_use_date"));		
			String	v_to_use_date	= HDUtil.nullCheckStr(req.getParameter("v_to_use_date"));
			String	v_cust_nm	 	= HDUtil.nullCheckStr(req.getParameter("v_cust_nm"));		
			/*
					 StringUtil.printMsg("v_saup_sid",v_saup_sid,this);
					 StringUtil.printMsg("sClientSid",sClientSid,this);
					 StringUtil.printMsg("v_upjang_sid",v_upjang_sid,this);
					 StringUtil.printMsg("v_fr_accept_date",v_fr_accept_date,this);
					 StringUtil.printMsg("v_menu_sid",v_menu_sid,this);
					 StringUtil.printMsg("v_use_seq",v_use_seq,this);
					 StringUtil.printMsg("v_to_accept_date",v_to_accept_date,this);
					 StringUtil.printMsg("v_fr_date",v_fr_date,this);
					 StringUtil.printMsg("v_to_date",v_to_date,this);
					 StringUtil.printMsg("v_fr_use_date",v_fr_use_date,this);
					 StringUtil.printMsg("v_to_use_date",v_to_use_date,this);
					 StringUtil.printMsg("v_cust_nm",v_cust_nm,this);
		*/
					try {
					int sCnt1 = 1;
					Iterator it = req.getGauceDataSetKeys();
			
							while (it.hasNext()) {
								String gauceName = (String)it.next();
								StringUtil.printMsg("gauceName++=", gauceName, this);
								ds1 = req.getGauceDataSet(gauceName);
						
								if(ds1!=null){
									res.enableFirstRow(ds1);
									if ("MASTER".equals(gauceName)) {
										cstmt = conn.prepareCall(arr_sql[0].toString());
										cstmt.setInt(1, v_saup_sid);
										cstmt.setInt(2, sClientSid);
										cstmt.setInt(3, v_upjang_sid);
										cstmt.setString	(4, v_fr_accept_date);
										cstmt.setString	(5, v_to_accept_date);
										cstmt.setString	(6, v_fr_date);
										cstmt.setString	(7, v_to_date);
										cstmt.setString	(8, v_fr_use_date);
										cstmt.setString	(9, v_to_use_date);
										cstmt.setString	(10, v_cust_nm);
										
										rs = cstmt.executeQuery(); // DataSet set
									}
									if ("DETAIL".equals(gauceName)) {
										cstmt = conn.prepareCall(arr_sql[1].toString());
										cstmt.setInt(1, v_saup_sid);
										cstmt.setInt(2, sClientSid);
										cstmt.setInt(3, v_upjang_sid);
										cstmt.setString	(4, v_fr_accept_date);
										cstmt.setString	(5, v_to_accept_date);
										cstmt.setString	(6, v_fr_date);
										cstmt.setString	(7, v_to_date);
										cstmt.setString	(8, v_fr_use_date);
										cstmt.setString	(9, v_to_use_date);
										cstmt.setString	(10, v_cust_nm);
										cstmt.setInt(11, v_menu_sid);
										cstmt.setString	(12, v_use_seq);
										rs = cstmt.executeQuery(); // DataSet set
									}
									getDataSet(rs, ds1).flush();
							}
						}
					}catch (SQLException sqle){
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
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
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
		try{
		Iterator it = req.getGauceDataSetKeys();
		while(it.hasNext()){
			String gauceName = (String)it.next();
			ds1 = req.getGauceDataSet(gauceName);
					
			if(ds1!=null){
				res.enableFirstRow(ds1);
				if(gauceName.equals("DETAIL")){
		
				  int colNm_ReqNo                  = ds1.indexOfColumn("REQ_NO");
				  int colNm_StatusCd              = ds1.indexOfColumn("STATUS_CD");
				  int colNm_Reason                    = ds1.indexOfColumn("REASON");    
				  int colNm_Desc                  = ds1.indexOfColumn("DESC");
				  int colNm_Remarks               = ds1.indexOfColumn("REMARKS");
				  int colNm_SaleQty                = ds1.indexOfColumn("SALE_QTY");
				  int colNm_RsvSid                 = ds1.indexOfColumn("RSV_SID");
					/*
					StringUtil.printMsg("1",colNm_ReqNo, this);
					StringUtil.printMsg("2",colNm_StatusCd, this);
					StringUtil.printMsg("3", colNm_Desc, this);
					StringUtil.printMsg("4", colNm_Desc2, this);
					StringUtil.printMsg("5",colNm_Remarks, this);
					StringUtil.printMsg("6",colNm_SaleQty, this);
					StringUtil.printMsg("7",colNm_RsvSid, this);
					*/
					GauceDataRow[] 		rows = ds1.getDataRows();
					GauceDataColumn[] 	cols = ds1.getDataColumns();
					
					for(int i=0; i<rows.length; i++){
						int j=1;
						switch(rows[i].getJobType()){
							case GauceDataRow.TB_JOB_UPDATE:
								cstmt = conn.prepareCall("{call SALES.PR_RV272i_03(?,?,?,?,?   ,?,?,?,?) }");
								cstmt.setString    (1, rows[i].getString(colNm_ReqNo));		 
								//StringUtil.printMsg("1", rows[i].getString(colNm_ReqNo), this);
								cstmt.setString     (2, rows[i].getString(colNm_StatusCd));
								//StringUtil.printMsg("2",rows[i].getString(colNm_StatusCd) , this);
								cstmt.setString     (3, rows[i].getString(colNm_Reason));
								//StringUtil.printMsg("3",rows[i].getString(colNm_Desc) , this);
								cstmt.setString     (4, rows[i].getString(colNm_Desc));
								//StringUtil.printMsg("4",rows[i].getString(colNm_Desc2) , this);
								cstmt.setString     (5, rows[i].getString(colNm_Remarks));
								//StringUtil.printMsg("5",rows[i].getString(colNm_Remarks) , this);
								cstmt.setInt     	(6, rows[i].getInt(colNm_SaleQty));		
								//StringUtil.printMsg("6",rows[i].getInt(colNm_SaleQty) , this);
								cstmt.setInt        (7, rows[i].getInt(colNm_RsvSid));		 
								//StringUtil.printMsg("7", rows[i].getInt(colNm_RsvSid), this);
								cstmt.setString     (8, fParamEmpno);						//수정사번
								cstmt.setString     (9, fParamIp);								//수정ip
								cstmt.executeUpdate();
					
								if(cstmt!=null) cstmt.close();	
								break;
							} 
						}
					}
				}
			}
		} catch (SQLException sqle){
			throw sqle;
		} catch (Exception e) {
			throw e;
		} finally {
			//msgDS.flush();
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();			
			if(cstmt!=null) cstmt.close();
		}
	}
}