package coopbiz.menu.df;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.*;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Df311I extends SuperServlet {

	public void makeSql() {
        for(int i=0; i<arr_sql.length; i++)
            arr_sql[i] = new StringBuffer();
		 
		arr_sql[0].append("{call COOPBIZ.PR_DF310I_01(?, ?, ? ) }");

		//입금 업데이트
		arr_sql[1].append ("INSERT INTO COOPBIZ.ORDER_PAY (PAY_MANAGE_NO, PAY_AMT, ORDER_NM, ORDER_E_MAIL, \n") 
				  .append ("			ORDER_TEL_NO, BUYR_TEL2, RESP_CODE, RES_MSG, VAN_IDX_NO,           \n")
				  .append ("			CARD_CD, CARD_NAME, APP_TIME, APP_NO,                              \n")
				  .append ("			QUOTA, SUCCESS, USER_KEY, U_EMPNO, U_IP, U_DATE) \n")
				  .append ("	VALUES                                                       \n")             
				  .append ("		   (?,?,?,?,                                                 \n")         
				  .append ("			?,?,?,?,?,                                                   \n")     
				  .append ("			?,?,?,?,                                                         \n") 
				  .append ("			?,?,?,?,?,CURRENT TIMESTAMP)                               \n");
				  


	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		
		
		String sPay_manage_no 	= HDUtil.nullCheckStr(req.getParameter("sPay_manage_no"));	//결제관리번호
		String sPay_amt 		= HDUtil.nullCheckStr(req.getParameter("sPay_amt"));	//
		String sPay_cd 			= HDUtil.nullCheckStr(req.getParameter("sPay_cd"));	//
		String sOrder_nm 		= HDUtil.nullCheckStr(req.getParameter("sOrder_nm"));	//
		String sOrder_e_mail 	= HDUtil.nullCheckStr(req.getParameter("sOrder_e_mail"));	//
		String sOrder_tel_no 	= HDUtil.nullCheckStr(req.getParameter("sOrder_tel_no"));	//
		String sOrder_tel_no2 	= HDUtil.nullCheckStr(req.getParameter("sOrder_tel_no2"));	//
		String sResp_code 		= HDUtil.nullCheckStr(req.getParameter("sResp_code"));	//
		String sRes_msg 		= HDUtil.nullCheckStr(req.getParameter("sRes_msg"));	//
		String sVan_idx_no 		= HDUtil.nullCheckStr(req.getParameter("sVan_idx_no"));	//
		String sCard_cd 		= HDUtil.nullCheckStr(req.getParameter("sCard_cd"));	//
		String sCard_name 		= HDUtil.nullCheckStr(req.getParameter("sCard_name"));	//
		String sApp_time 		= HDUtil.nullCheckStr(req.getParameter("sApp_time"));	//
		String sApp_no 			= HDUtil.nullCheckStr(req.getParameter("sApp_no"));	//
		String sQuota 			= HDUtil.nullCheckStr(req.getParameter("sQuota"));	//
		String sSuccess 		= HDUtil.nullCheckStr(req.getParameter("sSuccess"));	//
		String sUser_key 		= HDUtil.nullCheckStr(req.getParameter("sUser_key"));	//

		StringUtil.printMsg("sPay_manage_no",sPay_manage_no,this);
			
		try{
			stmt = conn.getGauceStatement(arr_sql[1].toString());

			stmt.setString(1,sPay_manage_no);                                                    
			stmt.setInt(2,Integer.parseInt(sPay_amt) );                                           
			stmt.setString(3,sOrder_nm);                                   
			stmt.setString(4,sOrder_e_mail);
			stmt.setString(5,sOrder_tel_no);
			stmt.setString(6,sOrder_tel_no2);
			stmt.setString(7,sResp_code);                                      
			stmt.setString(8,sRes_msg);                                        
			stmt.setString(9,sVan_idx_no);                                     
			stmt.setString(10,sCard_cd);                                       
			stmt.setString(11,sCard_name);                                     
			stmt.setString(12,sApp_time);                                      
			stmt.setString(13,sApp_no);                                        
			stmt.setString(14,sQuota);                                         
			stmt.setString(15,sSuccess);                                       
			stmt.setString(16,sUser_key);                                      
			stmt.setString(17,fParamEmpno);                                               
			stmt.setString(18,fParamIp);  


			stmt.executeUpdate();
			if(stmt!=null) stmt.close();
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
	}}
