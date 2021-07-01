// * 통신관리 : 통신관리>무전기 지급관리(무전기 지급현황조회)
package sales.menu.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm055i_s03 extends HttpServlet {

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
				//Parameter
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
														"CUST_SID",		"RT_SID",		"TEAM_NM",		"WORK_NO",		"CUST_NM",
														"RT_MODEL",		"RT_SERIAL",	 "RT_DATE",		"CLIENT_NM"
															};

				int[] intArrCN = new int[] {
												10,		10,		40,		20,		30,
												20,		15,		10	,		30
												};

				int[] intArrCN2 = new int[]{
												0,		0,		-1,	-1,	-1,
												-1,	-1,	-1,	-1
												};

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( "  SELECT																							\n" );
				sql.append( "       A.CUST_SID,																				\n" );
				sql.append( "       A.RT_SID,																					\n" );
				sql.append( "       SALES.FN_DETAIL_NM ( 'CM003',T2.TEAM_CD) AS TEAM_NM,			\n" );
				sql.append( "       T2.WORK_NO,																				\n" );
				sql.append( "       T1.CUST_NM,																				\n" );
				sql.append( "       A.RT_MODEL,																				\n" );
				sql.append( "       A.RT_SERIAL,																				\n" );
				sql.append( "       A.RT_DATE,																					\n" );
				sql.append( "       V1.CLIENT_NM																				\n" );
				sql.append( "  FROM SALES.TCM100 A																		\n" );
				sql.append( "       INNER JOIN SALES.TCM010 T2														\n" );
				sql.append( "              INNER JOIN SALES.TCU030 V1												\n" );
				sql.append( "					ON T2.CLIENT_SID = V1.CLIENT_SID									\n" );
				sql.append( "       ON A.CUST_SID = T2.CUST_SID													\n" );
				sql.append( "       INNER JOIN SALES.TCU010 T1 ON A.CUST_SID = T1.CUST_SID		\n" );
				sql.append( "  WHERE A.CUST_SID <> 0 AND A.USE_YN='Y'										\n" );

				//if (!str1.equals("")) sql.append( " AND V1.CLIENT_SID = '"+str1+"'     \n" );
				//logger.dbg.println("bm055i_s03",sql.toString());
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