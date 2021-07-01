package sales.menu.help;
/**********************************************************************************
 * 고객정보 팝업 
 **********************************************************************************/

import java.io.File;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

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

public class Rv006H extends SuperServlet {
	   
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		//	출경시간	
		arr_sql[0].append ("SELECT ''                 AS DEPART_TIME,			\n")
					.append ("		'전체'             AS DEPART_TIME_NM			\n")
					.append ("FROM SYSIBM.SYSDUMMY1			\n")
					.append ("UNION ALL			\n")
					.append ("SELECT R2.DEPART_TIME,			\n")
					.append ("		SALES.FMT_TIME(R2.DEPART_TIME) AS DEPART_TIME_NM			\n")
					.append ("FROM SALES.TRM200 R1 JOIN SALES.TRM220 R2			\n")
					.append ("	ON R2.GOODS_SID   = R1.GOODS_SID			\n")
					.append ("WHERE R1.SAUP_SID    = ?			\n")
					.append ("	AND R2.DEPART_DATE = ?			\n")
					.append ("GROUP BY R2.DEPART_TIME			\n");
		
		//상품
		arr_sql[1].append ("SELECT 0                   AS GOODS_SID,					\n")     
					.append ("		'전체'              AS GOODS_NM       					\n")
					.append ("FROM SYSIBM.SYSDUMMY1					\n")
					.append ("UNION ALL					\n")
					.append ("SELECT GOODS_SID,					\n")
					.append ("		GOODS_NM					\n")
					.append ("FROM SALES.TRM200 R1					\n")
					.append ("WHERE SAUP_SID    =  ?					\n")
					.append ("	AND USE_YN      =  'Y'					\n");

		//반현황
	   arr_sql[2].append(" SELECT R2.CLASS||' ('||SALES.FN_DETAIL_NM('RV017', R2.CLASS) ||')'   AS CLASS,   \n")
                 .append("        R2.TEAMS                                                      AS TEAMS,   \n")
                 .append("        COUNT(*)                                                      AS COUNT    \n")
                 .append("   FROM SALES.TRV010 R1 JOIN SALES.TRV020 R2 ON (R2.ACCEPT_SID  = R1.ACCEPT_SID)  \n")
                 .append("             LEFT OUTER JOIN SALES.TRM010 R3 ON (R3.UPJANG_SID  = R2.UPJANG_SID)  \n")
                 .append("  WHERE R2.STATUS_CD IN ('RA', 'RR', 'DP', 'AR')                                  \n");	
    }
	
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res) throws ServletException, Exception {
		System.out.println("# Command : 선조회");

		/* DataSet */
		GauceDataSet ds1 = null;
		GauceStatement stmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		String[] columnName = null;
		
		int v_rowcnt = 0;
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		String 	sSaupSid	= HDUtil.nullCheckStr(req.getParameter("sSaupSid"));
		String 	sDepartDate	= HDUtil.nullCheckStr(req.getParameter("sDepartDate"));

		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				
				ds1 = req.getGauceDataSet(gauceName);
			
				if(ds1!=null){
					switch(dsType){
						case 1:
							int sCnt1 = 1;
							res.enableFirstRow(ds1);
							if(gauceName.equals("DS2")){
								StringUtil.printMsg("SQL", arr_sql[0].toString()+"", this);								
								stmt = conn.getGauceStatement(arr_sql[0].toString());
								stmt.setString(1, sSaupSid);
								stmt.setString(2, sDepartDate);									
							} 
							if(gauceName.equals("DS3")){
								StringUtil.printMsg("SQL", arr_sql[1].toString()+"", this);
								stmt = conn.getGauceStatement(arr_sql[1].toString());
								stmt.setString(1, sSaupSid);
							} 							
								rs = stmt.executeQuery(); // DataSet set
								getDataSet(rs, ds1).flush();
					}
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
		}
		
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
		String sDepartDate		= HDUtil.nullCheckStr(req.getParameter("sDepartDate"));
		String sGoodsSid		= HDUtil.nullCheckStr(req.getParameter("sGoodsSid"));
		String sDepartTime		= HDUtil.nullCheckStr(req.getParameter("sDepartTime"));		
		String sSaupSid			= HDUtil.nullCheckStr(req.getParameter("sSaupSid"));
		
		
		
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
		
		StringUtil.printMsg("DSTYPE", dsType+"", this);
		try{
			switch(dsType) {
				case 1 :
					int sCnt1 = 1;
					ds1 = new GauceDataSet("DS1");
					
					if(ds1!=null){
						res.enableFirstRow(ds1);
		 
						if (!"".equals(sDepartDate)) {
							  arr_sql[2].append("	AND R1.DEPART_DATE = ?                    \n");
						}
						if (!"".equals(sGoodsSid) && !"0".equals(sGoodsSid) ) {
							 arr_sql[2].append(" AND R1.GOODS_SID = ?		 			\n");
						}
						if (!"".equals(sDepartTime)) {
							 arr_sql[2].append(" AND R2.DEPART_TIME = ?			 \n");
						}
						
						if (!"".equals(sSaupSid)) {
							 arr_sql[2].append(" AND R1.SAUP_SID = ?			 \n");
						}
						
						arr_sql[2].append(" GROUP BY R2.CLASS, R2.TEAMS					\n");
						arr_sql[2].append(" ORDER BY MAX(R3.DISPLAY_SEQ), R2.TEAMS		\n");						
						//쿼리 실행
						stmt = conn.getGauceStatement(arr_sql[2].toString()); 
		
						if (!"".equals(sDepartDate)) {
							stmt.setString(sCnt1++,sDepartDate);
						}			
						if (!"".equals(sGoodsSid) && !"0".equals(sGoodsSid) ) {
							stmt.setString(sCnt1++, sGoodsSid);
						}
						if (!"".equals(sDepartTime)) {
							stmt.setString(sCnt1++, sDepartTime);
						}						
						if (!"".equals(sSaupSid)) {
							stmt.setString(sCnt1++, sSaupSid);
						}						

						
						StringUtil.printMsg("SQL", arr_sql[2].toString(), this);
						
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
