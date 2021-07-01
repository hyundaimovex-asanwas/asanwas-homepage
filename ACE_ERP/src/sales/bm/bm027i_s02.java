//개인정보관리 : 휴가신청서 작성 (엑셀조회)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm027i_s02 extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

				String  str1	= GauceReq.getParameter("v_str1"); //성명

				if (str1==null || str1=="") str1 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
													"T1CUST_SID",		"POSITIONS",		"CUST_NM",		"ORDER_DATE",		"DEPRT_SID",     
													"CUST_SID",			"REASON",			"REASON_NM",	"NS_PLAN",			"SN_PLAN",
													"VACA_DAYS",		"BIGO",				"NUMBERS",		"I_EMPNO",			"I_DATE",
													"U_EMPNO",			"U_DATE",			"CUST_SIDYN"
																};

				int[] intArrCN = new int[] {
													10,	30,	30,	8,		10,												
													10,	1,		5,		8,		8, 
													8,		30,	3,		10,	10,
													10,	10,	5
													};

				int[] intArrCN2 = new int[]{
					                               0,	-1,	-1,	-1,	0,
					                               0,	-1,	-1,	-1,	-1,
												  -1,	-1,	-1,	-1,	-1,
												  -1,	-1,	-1
													}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();

				sql.append( "     SELECT																\n" );
				sql.append( "         IFNULL(T1.CUST_SID,0) AS T1CUST_SID,		\n" );
				sql.append( "         T2.POSITIONS,												\n" );
				sql.append( "         T2.CUST_NM,												\n" );
				sql.append( "         T1.ORDER_DATE,											\n" );
				sql.append( "         IFNULL(T3.DEPRT_SID,0) AS DEPRT_SID,			\n" );
				sql.append( "         IFNULL(T3.CUST_SID,0) AS CUST_SID,			\n" );
				sql.append( "         T3.REASON,													\n" );
				sql.append( "         CASE WHEN T3.REASON = '1' THEN '정기' ELSE '비정기' END REASON_NM,	\n" );
				sql.append( "         T3.NS_PLAN,													\n" );
				sql.append( "         T3.SN_PLAN,													\n" );
				sql.append( "         T3.VACA_DAYS,												\n" );
				sql.append( "         T3.BIGO,														\n" );
				sql.append( "         T3.NUMBERS,													\n" );
				sql.append( "         T3.I_EMPNO,													\n" );
				sql.append( "         T3.I_DATE,													\n" );
				sql.append( "         T3.U_EMPNO,													\n" );
				sql.append( "         T3.U_DATE,													\n" );
				sql.append( "         CASE WHEN IFNULL(T3.CUST_SID,0) IS NULL THEN 'F' ELSE 'T' END CUST_SIDYN	\n" );//추가
				sql.append( "     FROM SALES.TCM010 T1									\n" );
				sql.append( "         INNER JOIN SALES.TCU010 T2							\n" );
				sql.append( "             ON T1.CUST_SID = T2.CUST_SID				\n" );
				sql.append( "         LEFT JOIN SALES.TCM060 T3							\n" );
				sql.append( "             ON T1.CUST_SID = T3.CUST_SID				\n" );
				sql.append( "     WHERE T3.NS_PLAN = '"+str1+"'							\n" );
				sql.append( "     ORDER BY  T3.NS_PLAN DESC									" );

				//logger.dbg.println("bm027i_s02",sql.toString());

				stmt = conn.getGauceStatement(sql.toString());
				stmt.executeQuery(dSet);

/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		} finally {
			loader.restoreService(service);
  	}
	}
}