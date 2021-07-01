package sales.menu.my;

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

public class My520S extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}

		arr_sql[0].append("{CALL SALES.PR_MY520S_01( ?,?,?)}");
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

		//String	v_fr_date	 	= HDUtil.nullCheckStr(req.getParameter("v_fr_date"));		
		//String	v_to_date	 	= HDUtil.nullCheckStr(req.getParameter("v_to_date"));		
		String	v_subject	 	= HDUtil.nullCheckStr(req.getParameter("v_subject"));		
		String	v_send_login_id	 	= HDUtil.nullCheckStr(req.getParameter("v_send_login_id"));
		String	v_out_login_id	 	= HDUtil.nullCheckStr(req.getParameter("v_out_login_id"));
		//StringUtil.printMsg("v_subject",v_subject+"",this);
		//StringUtil.printMsg("v_send_login_id",v_send_login_id+"",this);
		int v_cnt = 1;
		try {
			ds1 = req.getGauceDataSet("MASTER");
			if(ds1!=null){
				res.enableFirstRow(ds1);
				v_cnt = 1;			
				cstmt = conn.prepareCall(arr_sql[0].toString());
				//cstmt.setString	(v_cnt++, v_fr_date);
				//cstmt.setString	(v_cnt++, v_to_date);
				cstmt.setString	(v_cnt++, v_subject);
				cstmt.setString	(v_cnt++, v_send_login_id);
				cstmt.setString	(v_cnt++, v_out_login_id);
				
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
