// * 입출국관리 : 개인별 식수내역:(메인조회)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm041i_s01 extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1"); //회사명

				if (str1==null || str1=="") str1 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
													"CLIENT_NM",	"TEAM_NM",	"CLIENT_SID",	"TEAM_CD", 
													"CUST_SID",		"CUST_NM",	"WORK_NO"
													};

				int[] intArrCN = new int[] {
												62,	32,	15,	5,
												10,	30,	20//add
												};

				int[] intArrCN2 = new int[]{
												-1,	-1,	0,	-1,
												0,		-1,	-1//add
												}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( "     SELECT															\n" );
				sql.append( "         T1.CLIENT_NM,											\n" );
				sql.append( "         SALES.FN_DETAIL_NM ( 'CM003',T2.TEAM_CD) AS TEAM_NM,	\n" );
				sql.append( "         T2.CLIENT_SID,											\n" );
				sql.append( "         T2.TEAM_CD,												\n" );

				sql.append( "         IFNULL(T2.CUST_SID,0) AS CUST_SID,		\n" );
				sql.append( "          T3.CUST_NM,											\n" );
				sql.append( "          T2.WORK_NO											\n" );
				sql.append( "     FROM SALES.TCU030 T1									\n" );
				sql.append( "         INNER JOIN SALES.TCM010 T2 ON T1.CLIENT_SID = T2.CLIENT_SID	\n" );
				sql.append( "         JOIN SALES.TCU010 T3 ON T3.CUST_SID = T2.CUST_SID					\n" );
				sql.append( "     WHERE 1=1													\n" );
						
				if (!str1.equals("")) sql.append( "  AND CLIENT_NM = '"+str1+"'	\n");

				sql.append( "  ORDER BY  T1.CLIENT_NM										");
				//logger.dbg.println("bm041i_s01", sql.toString());
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