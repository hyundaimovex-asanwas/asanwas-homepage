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

public class Ac320H extends SuperServlet {

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[1].append("CALL SALES.PR_AC320S_02(?,?,?,?,?)");
		arr_sql[2].append("CALL SALES.PR_AC320S_03(?,?,?,?,?)");
		arr_sql[3].append("CALL SALES.PR_AC320S_04(?,?,?,?,?)");
		arr_sql[4].append("CALL SALES.PR_AC320S_05(?,?,?,?,?)");
		
		
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
		int sGoods_sid 		= HDUtil.nullCheckNum(req.getParameter("sGoods_sid"));			// 상품SID 
		int sClientSid 		= HDUtil.nullCheckNum(req.getParameter("sClient_sid"));	// 매출처 
		String sSDate 		= HDUtil.nullCheckStr(req.getParameter("sSDate")); 	// 출경일자
		String sEDate 		= HDUtil.nullCheckStr(req.getParameter("sEDate")); 	// 출경일자
		
		StringUtil.printMsg("sSaup_sid 		= ", sSaup_sid 			,this);
		StringUtil.printMsg("sGoods_sid 	= ", sGoods_sid 	    ,this); 
		StringUtil.printMsg("sClientSid 	= ", sClientSid 	    ,this);
		StringUtil.printMsg("sSDate 		= ", sSDate 		    ,this);
		StringUtil.printMsg("sEDate 		= ", sEDate 		    ,this);
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
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sSDate);
						cstmt.setString(5, "020");
						rs = cstmt.executeQuery();	
					} else if ("DS030".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[1].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sSDate);
						cstmt.setString(5, "030");
						
						rs = cstmt.executeQuery();		
					} else if ("DS040".equals(gauceName)) {
						
						StringUtil.printMsg("11111",this);
						cstmt = conn.prepareCall(arr_sql[2].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sSDate);
						cstmt.setString(5, "040");
						
						rs = cstmt.executeQuery();	
					} else if ("DS060".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[3].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sSDate);
						cstmt.setString(5, "060");
						rs = cstmt.executeQuery();	
					}
					else if ("DSMI".equals(gauceName)) {
						cstmt = conn.prepareCall(arr_sql[4].toString());
						cstmt.setInt(1,sSaup_sid);
						cstmt.setInt(2, sGoods_sid);
						cstmt.setInt(3, sClientSid);
						cstmt.setString(4, sSDate);
						cstmt.setString(5, sEDate);
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
