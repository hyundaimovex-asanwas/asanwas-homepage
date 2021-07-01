package sales.menu.help;

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

public class Rm311H extends SuperServlet {

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_RM311S_03(?,?,?)");
		
		
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		
	}
	
	public void apply(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		
	}
	
	// 조회 method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object 설정
		 *****************************************************************************/
		
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
		int sUpjang_sid 		= HDUtil.nullCheckNum(req.getParameter("sUpjang_sid"));			// 영업장SID 
		String sUseDate 		= HDUtil.nullCheckStr(req.getParameter("sUseDate")); 	// 출경일자
		
		StringUtil.printMsg("sSaup_sid 		= ", sSaup_sid 			,this);
		StringUtil.printMsg("sUpjang_sid 	= ", sUpjang_sid 	    ,this); 
		StringUtil.printMsg("sUseDate 	= ", sUseDate 	    ,this);
		try {
			int sCnt1 = 1;
			Iterator it = req.getGauceDataSetKeys();
			
			while (it.hasNext()) {
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
			
				StringUtil.printMsg("DS Name= "+ gauceName,this);
				
				if(ds1!=null){
					res.enableFirstRow(ds1);
					if ("DS020".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sUpjang_sid);
						cstmt.setString(3, sUseDate);
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
}
