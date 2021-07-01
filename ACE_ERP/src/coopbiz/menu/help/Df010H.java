package coopbiz.menu.help;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

public class Df010H extends SuperServlet {
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		arr_sql[0].append(" SELECT ITEM_SID, CATE1,CATE2,BRAND, ITEM_NO, AMT_EMP \n")
				  .append(", 1142 AS CURRENCY_NOW, INTEGER(AMT_EMP*1142) AS EXCH_AMT \n") 									
				  .append("   FROM COOPBIZ.ITEM_TEMP \n")
				  .append("  WHERE CATE2= ? \n")
				  .append("	 ORDER BY ITEM_SID \n");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)  throws ServletException, Exception {
		/* DataBase */
	}	

	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		GauceStatement stmt = null;
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		
		String sCate2 = HDUtil.nullCheckStr(req.getParameter("sCate2"));		
		
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				GauceDataSet ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
				
					//조회쿼리
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, sCate2);  
					
					rs = cstmt.executeQuery();
					getDataSet(rs, ds1).flush();

				}
			}
		} catch (SQLException sqle){
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

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
	
}
