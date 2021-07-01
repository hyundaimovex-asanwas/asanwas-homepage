package sales.menu.rv;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv831S extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// �����, ������, ��������, ����
		arr_sql[1].append("CALL SALES.PR_RV831S_01(?, ?, ?, ?, ?)");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		CallableStatement cstmt;
		
		GauceDataSet ds1 = null; // �븮�� ���� 
		
		int sSaup_sid 		= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));	// �����
		int sUpjang_sid		= HDUtil.nullCheckNum(req.getParameter("sUpjang_sid")); // ������ SID
		String sJob_date 	= HDUtil.nullCheckStr(req.getParameter("sJob_date")); 	// �۾����
		String sCust_name	= HDUtil.nullCheckStr(req.getParameter("sCust_name"));	// ����
		int sGoods_sid		= HDUtil.nullCheckNum(req.getParameter("sGoods_sid")); // ��ǰ
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
				
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1,sSaup_sid);
					cstmt.setInt(2, sUpjang_sid);
					cstmt.setString(3, sJob_date);
					cstmt.setString(4, sCust_name);
					cstmt.setInt(5, sGoods_sid);
					rs = cstmt.executeQuery();							
					
					getDataSet(rs, ds1).flush();
				}
			}
		}catch (SQLException sqle){
			throw sqle;
		} catch (Exception e){
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

}
