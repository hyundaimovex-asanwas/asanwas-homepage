package sales.menu.help;
/**********************************************************************************
 * 고객정보 팝업 
 **********************************************************************************/

import java.io.File;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sales.common.StringUtil;
import sales.common.SuperServlet;
import sales.common.HDConstant;
import sales.common.HDUtil;

import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;

public class Rv003H extends SuperServlet {
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		arr_sql[0].append("SELECT 														\n")
				  .append("    T1.DRIVE_SID||'' DRIVE_SID,                           \n")
				  .append("    T2.CUST_NM,                                      	 \n")
				  .append("    T2.MANAGE_NO,                                         \n")
				  .append("    T1.DRIVE_NO,                                        \n")
				  .append("    T1.CUST_SID,	                     \n")
				  .append("	 T2.CUST_TYPE,					\n")
				  .append("	 T2.WORK_NO,					\n")
				  .append("	 (SELECT MAX(T5.N_CARD_NO) FROM SALES.TCU060 T5					\n")
				  .append("	  WHERE T5.CUST_SID    = T2.CUST_SID) AS N_CARD_NO					\n")
				  .append("FROM                                                    \n")
				  .append("	SALES.TCU040 T1, SALES.TCU010 T2   \n")
				  .append("WHERE 1=1                           \n")
				  .append("	AND T1.CUST_SID = T2.CUST_SID      \n");
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
		System.out.println("# Command : 조회");
		GauceStatement stmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		/**********************************************************************************
		 * Command 
		 **********************************************************************************
		 * Parameter 설정
		 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
		 **********************************************************************************/
  
		// 검색시 조건
		String sClientSid		= HDUtil.nullCheckStr(req.getParameter("sClientSid"));
		String sKeyWord			= HDUtil.nullCheckStr(req.getParameter("sKeyWord"));
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		StringUtil.printMsg("DSTYPE", dsType+"", this);
		try{
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					ds1 = new GauceDataSet("DS1");
					
					if(ds1!=null){
						res.enableFirstRow(ds1);
		 
						if (!"".equals(sClientSid)) {
							  arr_sql[0].append("	AND T2.CLIENT_SID = ?                    \n");
						}
						
						if (!"".equals(sKeyWord)) {
							 arr_sql[0].append(" AND T2.CUST_NM LIKE ? OR T1.DRIVE_NO LIKE ? \n");
						}

						//쿼리 실행
						stmt = conn.getGauceStatement(arr_sql[0].toString()); 
		
						if (!"".equals(sClientSid)) {
							stmt.setString(sCnt1++,sClientSid);
						}			
						
						if (!"".equals(sKeyWord)) {
							stmt.setString(sCnt1++, sKeyWord + "%");
							stmt.setString(sCnt1++, sKeyWord + "%");
						}
						
						
						StringUtil.printMsg("DSTYPE", arr_sql[0].toString(), this);
						
						rs = stmt.executeQuery(); // DataSet set
						getDataSet(rs, ds1).flush();
					}
					break;
	
			}
		} catch (SQLException sqle){
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
