package sales.menu.help;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Rv290I_03 extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
			
			arr_sql[1].append (" {call SALES.RV290I_03 (?, ?)}");
			
	}
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement 	cstmt 	= null;
		PreparedStatement 	stmt 	= null;
		ResultSet 			rs 		= null;
		GauceDataSet 		ds1 	= null;
		try{
			String 	v_fr_date	 	= HDUtil.nullCheckStr(req.getParameter("v_fr_date"));		//출발일자
		//	String 	v_manage_no		= HDUtil.nullCheckStr(req.getParameter("v_manage_no"));		//주민등록번호
			String 	v_cust_nm		= HDUtil.nullCheckStr(req.getParameter("v_cust_nm"));		//성명
		
			//StringUtil.printMsg("v_fr_date==", v_fr_date, this);
			//StringUtil.printMsg("v_manage_no==", v_manage_no, this);
			//StringUtil.printMsg("v_cust_nm==", v_cust_nm, this);
			
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				//StringUtil.printMsg("어떤 데이터셋?", gauceName, this);
				ds1 = req.getGauceDataSet(gauceName);
								if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("MASTER")){
												
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setString (1, v_fr_date);
					//	cstmt.setString	(2, v_manage_no);
						cstmt.setString	(2, v_cust_nm);
						rs = cstmt.executeQuery();
						getDataSet(rs, ds1).flush();
						if(rs!=null) rs.close();
						if(cstmt!=null) cstmt.close();
					} 
				  
				}
			}
		}
		
		 catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(cstmt!=null) cstmt.close();
		}
	}
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
	throws ServletException, Exception {
		// TODO Auto-generated method stub
		
	}
	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
}



