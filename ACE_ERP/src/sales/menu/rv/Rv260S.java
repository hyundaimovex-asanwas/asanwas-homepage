package sales.menu.rv;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.SuperServlet;

public class Rv260S extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

		//Default 조회
		arr_sql[0].append ("{call SALES.PR_RV260S_01(?, ?, ?, ?, ?, ?, ?, ?)}");
		
		//Option Master 조회
		arr_sql[1].append ("{call SALES.PR_RV260S_02(?)}");

	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceDataSet ds1 = null;
		
		int v_saup_sid 		= HDUtil.nullCheckNum(req.getParameter("v_saup_sid"));
		int v_goods_sid 	= HDUtil.nullCheckNum(req.getParameter("v_goods_sid"));
		int v_client_sid 	= HDUtil.nullCheckNum(req.getParameter("v_client_sid"));
		String v_accept_no 	= HDUtil.nullCheckStr(req.getParameter("v_accept_no"));
		String v_fr_depart_date = HDUtil.nullCheckStr(req.getParameter("v_fr_depart_date"));
		String v_to_depart_date = HDUtil.nullCheckStr(req.getParameter("v_to_depart_date"));
		String v_manage_no 	= HDUtil.nullCheckStr(req.getParameter("v_manage_no"));
		String v_cust_nm 	= HDUtil.nullCheckStr(req.getParameter("v_cust_nm"));
		
		int v_rsv_sid 		= HDUtil.nullCheckNum(req.getParameter("v_rsv_sid"));
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DEFAULT")){
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setInt(1, v_saup_sid);
						cstmt.setInt(2, v_goods_sid);
						cstmt.setInt(3, v_client_sid);
						cstmt.setString(4, v_accept_no);
						cstmt.setString(5, v_fr_depart_date);
						cstmt.setString(6, v_to_depart_date);
						cstmt.setString(7, v_manage_no);
						cstmt.setString(8, v_cust_nm);
					} else if(gauceName.equals("MASTER")){
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1, v_rsv_sid);
					} else{
						throw new Exception ("알수 없는 DataSet Name입니다.");
					}
					
					rs = cstmt.executeQuery();
					getDataSet(rs, ds1).flush();
				}//if(ds1!=null)the end...
			}//while(it.hasNext()) The end...
		} catch (SQLException sqle){
		    throw sqle;
		} catch (Exception e) {
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
