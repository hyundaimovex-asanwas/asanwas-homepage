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
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv840S extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}

		arr_sql[0].append("{CALL SALES.PR_RV840S_01(?, ?, ?, ?, ?, ?)}");

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
				cstmt.setInt	(1, v_saup_sid);
				cstmt.setInt	(2, v_goods);
				cstmt.setString	(3, v_bgn_date);
				cstmt.setString	(4, v_end_date);
				cstmt.setString (5, v_depart_bgn_date);
				cstmt.setString (6, v_depart_end_date);
				
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
