package sales.menu.ac;

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

public class Ac230S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_AC230S_01(?,?,?)");
		arr_sql[2].append("CALL SALES.PR_AC230S_02(?,?,?)");
		arr_sql[3].append("CALL SALES.PR_AC230S_03(?,?,?)");
		
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
		CallableStatement 	cstmt		=null;
		
		int v_rowcnt = 0;

		/* DataSet */
		GauceDataSet ds1 = null; // 대리점 정보 
		
		/*
		 * 검색시 필요한 조건
		 */
		
		int 	sSaup_sid 	= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));	// 사업소
		String 	sSDate 		= HDUtil.nullCheckStr(req.getParameter("sSDate")); 	// 사용일자
		int 	sGoods_sid		= HDUtil.nullCheckNum(req.getParameter("sGoods_sid")); 	// 상품SID
		
		
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					
					if ("DS1".equals(gauceName)) {
						res.enableFirstRow(ds1);
					
						StringUtil.printMsg("1",this);
						cstmt = conn.prepareCall(arr_sql[1].toString()); // 매출분석
						cstmt.setInt(1,sSaup_sid);
						cstmt.setString(2, sSDate);
						cstmt.setInt(3, sGoods_sid);
						
					} else if ("DS2".equals(gauceName)) {
						res.enableFirstRow(ds1);
						cstmt = conn.prepareCall(arr_sql[2].toString());	// 입금내역 및 외상매출금
						cstmt.setInt(1,sSaup_sid);
						cstmt.setString(2, sSDate);
						cstmt.setInt(3, sGoods_sid);
						
						StringUtil.printMsg("2",this);
					} else if ("DS3".equals(gauceName)) {
						res.enableFirstRow(ds1);
						cstmt = conn.prepareCall(arr_sql[3].toString()); // 거래선별 외상매출 
						cstmt.setInt(1,sSaup_sid);
						cstmt.setString(2, sSDate);
						cstmt.setInt(3, sGoods_sid);
						
						StringUtil.printMsg("3",this);
					}
												
					rs = cstmt.executeQuery();
					getDataSet(rs, ds1).flush();

				}
			}
			
		}catch (SQLException sqle){
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			res.writeException("ERROR", "", e.toString());
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
