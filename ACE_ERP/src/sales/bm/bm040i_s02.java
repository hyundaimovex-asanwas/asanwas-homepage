// * 입출국관리 : 식수배정:(세부 조회)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm040i_s02 extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1"); //CLIENT_SID
				String  str2	= GauceReq.getParameter("v_str2"); //TEAM_CD

				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
													"CUST_SID",		"WORK_NO",	"CUST_NM",	"EATING_BRE",	"EATING_LUN",
													"EATING_DIN",	"BRE_NM",		"LUN_NM",		"DIN_NM",			"U_EMPNO",
													"U_DATE"
													};

				int[] intArrCN = new int[] {
											10,	20,	30,	2,		2,
											2,		30,	30,	30,	10,
											10
											};

				int[] intArrCN2 = new int[]{
					                              0,	-1,	-1,	-1,	-1,
					                             -1,	-1,	-1,	-1,	-1,
												 -1
												};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( "     SELECT															\n" );
				sql.append( "         T1.CUST_SID,											\n" );
				sql.append( "         T1.WORK_NO,											\n" );
				sql.append( "         T2.CUST_NM,											\n" );
				sql.append( "         T1.EATING_BRE,											\n" );
				sql.append( "         T1.EATING_LUN,											\n" );
				sql.append( "         T1.EATING_DIN,											\n" );
				sql.append( "         SALES.FN_DETAIL_NM ( 'CM001',T1.EATING_BRE) AS BRE_NM,		\n" );
				sql.append( "         SALES.FN_DETAIL_NM ( 'CM001',T1.EATING_LUN) AS LUN_NM,		\n" );
				sql.append( "         SALES.FN_DETAIL_NM ( 'CM001',T1.EATING_DIN) AS DIN_NM,		\n" );

				sql.append( "         T1.U_EMPNO,												\n" );
				sql.append( "         T1.U_DATE												\n" );
				sql.append( "     FROM SALES.TCM010 T1								\n" );
				sql.append( "         INNER JOIN SALES.TCU010 T2						\n" );
				sql.append( "             ON T1.CUST_SID = T2.CUST_SID			\n" );
				sql.append( "     WHERE T1.CLIENT_SID = '"+str1+"'					\n" );
				sql.append( "     AND T1.TEAM_CD = '"+str2+"'							\n" );
				sql.append( "  ORDER BY  T2.CUST_NM										");
				//logger.dbg.println("bm040i_s02",sql.toString());
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