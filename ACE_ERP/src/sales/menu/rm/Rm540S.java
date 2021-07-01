package sales.menu.rm;

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

public class Rm540S extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}

		arr_sql[0].append("{CALL SALES.PR_RM540S_01(?, ?, ?, ?, ?)}");
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

		int 	v_cnt			= 1;
		int     v_goods			= HDUtil.nullCheckNum(req.getParameter("v_goods"));
		String	v_bgn_date	 	= HDUtil.nullCheckStr(req.getParameter("v_bgn_date"));		
		String	v_end_date	 	= HDUtil.nullCheckStr(req.getParameter("v_end_date"));		
		String	v_depart_bgn_date= HDUtil.nullCheckStr(req.getParameter("v_depart_bgn_date"));
		String	v_depart_end_date= HDUtil.nullCheckStr(req.getParameter("v_depart_end_date"));		

		try {
			ds1 = req.getGauceDataSet("MASTER");
			if(ds1!=null){
				res.enableFirstRow(ds1);
			
				cstmt = conn.prepareCall(arr_sql[0].toString());
				cstmt.setInt	(v_cnt++, v_goods);
				cstmt.setString	(v_cnt++, v_bgn_date);
				cstmt.setString	(v_cnt++, v_end_date);
				cstmt.setString (v_cnt++, v_depart_bgn_date);
				cstmt.setString (v_cnt++, v_depart_end_date);
				
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
