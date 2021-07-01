
package sales.menu.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm042s01 extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1");	//ï¿
				String  str2	= GauceReq.getParameter("v_str2");	//ï¿

				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
														"CLIENT_NM",	"TEAM_NM",		"WORK_NO",		"CUST_NM",		"EATING_BRE",
														"EATING_LUN",	"EATING_DIN"
														};

				int[] intArrCN = new int[] {
													60,	30,	20,	30,	2,
													2,		2
													};

				int[] intArrCN2 = new int[]{
													-1,	-1,	-1,	-1,	-1,
													-1,	-1
												};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT																								\n" );
				sql.append( "			V3.CLIENT_NM,																			\n" );
				sql.append( "			SALES.FN_DETAIL_NM ( 'CM003',V2.TEAM_CD) AS TEAM_NM,		\n" );
				sql.append( "			V2.WORK_NO,																			\n" );
				sql.append( "			V4.CUST_NM,																			\n" );//add
				sql.append( "			CASE WHEN COALESCE(V1.EATING_BRE, '') = '' THEN '' ELSE V1.EATING_BRE END EATING_BRE,		\n" );
				sql.append( "			CASE WHEN COALESCE(V1.EATING_LUN, '') = '' THEN '' ELSE V1.EATING_LUN END EATING_LUN,		\n" );
				sql.append( "			CASE WHEN COALESCE(V1.EATING_DIN, '') = '' THEN '' ELSE V1.EATING_DIN END EATING_DIN			\n" );
				sql.append( "     FROM SALES.TCM020 V1																\n" );
				sql.append( "				INNER JOIN SALES.TCM010 V2												\n" );
				sql.append( "					INNER JOIN SALES.TCU030 V3 ON V2.CLIENT_SID = V3.CLIENT_SID  \n" );
				sql.append( "					ON V1.CUST_SID = V2.CUST_SID										\n" );
				sql.append( "				INNER JOIN SALES.TCU010	V4													\n" );
				sql.append( "					ON V1.CUST_SID = V4.CUST_SID										\n" );
				sql.append( "		WHERE V1.EATING_DATE >= '"+str1+"'											\n" );
				sql.append( "		AND V1.EATING_DATE <= '"+str2+"'												\n" );

				//logger.dbg.println("bm042_s01",sql.toString());
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