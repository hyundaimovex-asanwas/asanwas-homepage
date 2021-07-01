package sales.menu.rv;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.SuperServlet;

public class Rv270S extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}

		arr_sql[0].append("{CALL SALES.PR_RV270S_01(?, ?, ?, ?, ?, ?)}");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet 		  rs 	= null;
		GauceDataSet 	  ds1 	= null; 

		int 	v_saup_sid		= HDUtil.nullCheckNum(req.getParameter("v_saup_sid"));
		int     v_upjang_sid	= HDUtil.nullCheckNum(req.getParameter("v_upjang_sid"));
		int     v_client_sid	= HDUtil.nullCheckNum(req.getParameter("v_client_sid"));
		String	v_fr_date	 	= HDUtil.nullCheckStr(req.getParameter("v_fr_date"));		
		String	v_to_date	 	= HDUtil.nullCheckStr(req.getParameter("v_to_date"));		
		String	v_cust_nm	 	= HDUtil.nullCheckStr(req.getParameter("v_cust_nm"));		

		int v_cnt = 1;
		try {
			ds1 = req.getGauceDataSet("MASTER");
			if(ds1!=null){
				res.enableFirstRow(ds1);
				v_cnt = 1;			
				cstmt = conn.prepareCall(arr_sql[0].toString());
				cstmt.setInt	(v_cnt++, v_saup_sid);
				cstmt.setInt	(v_cnt++, v_upjang_sid);
				cstmt.setInt	(v_cnt++, v_client_sid);
				cstmt.setString	(v_cnt++, v_fr_date);
				cstmt.setString	(v_cnt++, v_to_date);
				cstmt.setString	(v_cnt++, v_cust_nm);
				
				rs = cstmt.executeQuery();
				getDataSet(rs, ds1).flush();
			}
		}catch (SQLException sqle){
			throw sqle;
		} catch (Exception e){
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

}
