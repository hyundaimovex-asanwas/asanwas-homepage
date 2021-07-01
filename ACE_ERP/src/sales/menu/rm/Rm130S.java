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
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rm130S extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}

		arr_sql[0].append("{CALL SALES.PR_RM130S_01(?, ?, ?)}");
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
		int     v_client_sid	= HDUtil.nullCheckNum(req.getParameter("v_client_sid"));
		String	v_std_date	 	= HDUtil.nullCheckStr(req.getParameter("v_std_date"));		

//StringUtil.printMsg("v_saup_sid", v_saup_sid, this);
//StringUtil.printMsg("v_client_sid", v_client_sid, this);
//StringUtil.printMsg("v_std_date", v_std_date, this);
		
		try {
			ds1 = req.getGauceDataSet("MASTER");
			if(ds1!=null){
				res.enableFirstRow(ds1);
			
				cstmt = conn.prepareCall(arr_sql[0].toString());
				cstmt.setInt	(1, v_saup_sid);
				cstmt.setInt	(2, v_client_sid);
				cstmt.setString	(3, v_std_date);
				
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
