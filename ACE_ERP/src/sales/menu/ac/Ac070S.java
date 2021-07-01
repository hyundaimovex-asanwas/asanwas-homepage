package sales.menu.ac;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
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

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;

public class Ac070S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC070S_01(?, ?, ?)");
		
		arr_sql[2].append("CALL SALES.PR_AC070S_02(?)");
	}
 
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","선조회",this);
	}

	
	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		
		GauceStatement 		stmt 		= null;
		ResultSet 			rs 			= null;
		ResultSetMetaData 	rsmd 		= null;
		String[] 			columnName 	= null;
		CallableStatement cstmt;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		
		String sSDate 		= HDUtil.nullCheckStr(req.getParameter("sSDate")); 			// 입금일자 시작
		String sEDate 		= HDUtil.nullCheckStr(req.getParameter("sEDate")); 			// 입금일자 종료 
		String sJobSel	= HDUtil.nullCheckStr(req.getParameter("sJobSel"));// 차액발생
		
		String sPayManageNo		= HDUtil.nullCheckStr(req.getParameter("sPayManageNo")); // 결재관리번호 
		
		
		try {
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DS1".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[1].toString());
						
						
						
						cstmt.setString(1, sSDate);
						cstmt.setString(2, sEDate);
						cstmt.setString(3, sJobSel);
						
						rs = cstmt.executeQuery();	
						
						getDataSet(rs, ds1).flush();
					
					} 
					
					if ("DS2".equals(gauceName)) {
						System.out.println("sPayManageNo"+sPayManageNo);
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setString(1,sPayManageNo);
						rs = cstmt.executeQuery();							
						getDataSet(rs, ds1).flush();
					} 
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
