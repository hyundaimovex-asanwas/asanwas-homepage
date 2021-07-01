package sales.menu.my;
 
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

public class My530R extends SuperServlet {

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		// TODO Auto-generated method stub
		arr_sql[0].append("CALL SALES.PR_MY530R_01(?,?)"); // 계좌이체 & 가상계좌
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
	
	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceDataSet ds1 = null;
		GauceStatement stmt = null; 
		ResultSet rs = null;
		CallableStatement cstmt;
		//System.out.println("11111111111111111111111");
		//상품권 리스트에 필요한 입력 파라미터 정의
		String sSendDate 		= HDUtil.nullCheckStr(req.getParameter("send_date"));
		String sOutLoginId 	= HDUtil.nullCheckStr(req.getParameter("out_login_id"));
		//String sSendDate 	= HDUtil.nullCheckStr(req.getParameter("send_date"));
		
		//StringUtil.printMsg("send_date",sSendDate,this);
		//StringUtil.printMsg("send_login_id",sSendLoginId,this);
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if(gauceName.equals("DS2")){
						//StringUtil.printMsg("가상계좌",this);
						cstmt = conn.prepareCall(arr_sql[0].toString());
						cstmt.setString(1, sSendDate);
						cstmt.setString(2, sOutLoginId);
		//				cstmt.setString(3, sSendDate);
						rs = cstmt.executeQuery();							
						getDataSet(rs, ds1).flush();
					}  
				}
			}
		} catch (SQLException sqle){
			sqle.printStackTrace();
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			e.printStackTrace();
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
	}
}
