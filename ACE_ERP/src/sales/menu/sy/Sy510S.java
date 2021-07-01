package sales.menu.sy;

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

public class Sy510S extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_SY510S_01(?,?,?)");
		arr_sql[2].append("CALL SALES.PR_SY510S_02(?,?,?)");
		arr_sql[3].append("CALL SALES.PR_SY510S_03(?,?,?)");
		arr_sql[4].append("CALL SALES.PR_SY510S_04(?,?,?)");
		arr_sql[5].append("CALL SALES.PR_SY510S_05(?,?,?)");
		arr_sql[6].append("CALL SALES.PR_SY510S_06(?,?,?)");
		arr_sql[7].append("CALL SALES.PR_SY510S_07(?,?,?)");
		arr_sql[8].append("CALL SALES.PR_SY510S_08(?,?,?)");
	
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
		
		int sSaup_sid 		= HDUtil.nullCheckNum(req.getParameter("sSaup_sid"));	// 사업소
		String sJobDate		= HDUtil.nullCheckStr(req.getParameter("sJobDate")); // 고객구분 
		String sAll		= HDUtil.nullCheckStr(req.getParameter("sAll")); // 전체구분
		
		StringUtil.printMsg("sSaup_sid",sSaup_sid+"",this);
		StringUtil.printMsg("sJobDate",sJobDate+"",this);
		StringUtil.printMsg("sAll",sAll+"",this);
		
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DS1".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setString(2, sJobDate);
						cstmt.setString(3, sAll);
						rs = cstmt.executeQuery();	
					} else if ("DS2".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setString(2, sJobDate);
						cstmt.setString(3, sAll);
						rs = cstmt.executeQuery();	
					} else if ("DS3".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[3].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setString(2, sJobDate);
						cstmt.setString(3, sAll);
						rs = cstmt.executeQuery();	
					} else if ("DS4".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[4].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setString(2, sJobDate);
						cstmt.setString(3, sAll);
						rs = cstmt.executeQuery();	
					} else if ("DS5".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[5].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setString(2, sJobDate);
						cstmt.setString(3, sAll);
						rs = cstmt.executeQuery();	
					} else if ("DS6".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[6].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setString(2, sJobDate);
						cstmt.setString(3, sAll);
						rs = cstmt.executeQuery();	
					} else if ("DS7".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[7].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setString(2, sJobDate);
						cstmt.setString(3, sAll);
						rs = cstmt.executeQuery();	
					} else if ("DS8".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[8].toString());
						
						cstmt.setInt(1,sSaup_sid);
						cstmt.setString(2, sJobDate);
						cstmt.setString(3, sAll);
						rs = cstmt.executeQuery();	
					}
					
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
