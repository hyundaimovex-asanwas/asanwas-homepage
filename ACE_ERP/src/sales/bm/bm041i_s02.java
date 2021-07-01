// * 식수관리 : 개인별 식수내역:(세부 조회)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm041i_s02 extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1"); //날짜
				String  str2	= GauceReq.getParameter("v_str2"); //CLIENT_SID
				String  str3	= GauceReq.getParameter("v_str3"); //TEAM_CD

				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";
				if (str3==null || str3=="") str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
														"T1_CUST_SID",		"WORK_NO",		"CUST_NM",	"CUST_SID",		"EATING_DATE", 
														"I_EMPNO",			"I_DATE",			"U_EMPNO",	"U_DATE",			"EATING_BRE" ,
														"BRE_CHK",			"EATING_LUN",	"LUN_CHK",	"EATING_DIN",	"DIN_CHK",	
														"EATING_SID"
														};

				int[] intArrCN = new int[] {
													10,	20,	30,	10,	8,
													10,	10,	10,	10,	2,
													1,		2,		1,		2,		1,
													10
												}; 

				int[] intArrCN2 = new int[]{
													0,		-1,	-1,	0,		-1,
													-1,	-1,	-1,	-1,	-1,
													-1,	-1,	-1,	-1,	-1,
													0
												};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT																		\n" );
				sql.append( "             IFNULL(T1.CUST_SID,0) AS T1_CUST_SID,		\n" );
				sql.append( "             T1.WORK_NO,												\n" );
				sql.append( "             T2.CUST_NM,												\n" );
				sql.append( "             IFNULL(T3.CUST_SID,0) CUST_SID,					\n" );
				sql.append( "             T3.EATING_DATE,											\n" );
				sql.append( "             T3.I_EMPNO,													\n" );
				sql.append( "             T3.I_DATE,													\n" );
				sql.append( "             T3.U_EMPNO,													\n" );
				sql.append( "             T3.U_DATE,													\n" );
				sql.append( "             CASE WHEN COALESCE(T3.EATING_BRE, '') = '' THEN T1.EATING_BRE ELSE T3.EATING_BRE END EATING_BRE,		\n" );
				sql.append( "             CASE WHEN COALESCE(T3.EATING_BRE, '') <> '' THEN 'T' ELSE 'F' END BRE_CHK,												\n" );
				sql.append( "             CASE WHEN COALESCE(T3.EATING_LUN, '') = '' THEN T1.EATING_LUN ELSE T3.EATING_LUN END EATING_LUN,		\n" );
				sql.append( "             CASE WHEN COALESCE(T3.EATING_LUN, '') <> '' THEN 'T' ELSE 'F' END LUN_CHK,												\n" );
				sql.append( "              CASE WHEN COALESCE(T3.EATING_DIN, '') = '' THEN T1.EATING_DIN ELSE T3.EATING_DIN END EATING_DIN,		\n" );
				sql.append( "             CASE WHEN COALESCE(T3.EATING_DIN, '') <> '' THEN 'T' ELSE 'F' END DIN_CHK													\n" );
				sql.append( "				, COALESCE(T3.EATING_SID, 0) AS EATING_SID								\n");
				sql.append( " FROM SALES.TCM010 T1																			\n" );
				sql.append( "             INNER JOIN SALES.TCU010 T2 ON T1.CUST_SID = T2.CUST_SID		\n" );
				sql.append( "															AND T2.CUST_GU = '2'						\n" );
				sql.append( "             LEFT JOIN SALES.TCM020 T3 ON T1.CUST_SID = T3.CUST_SID			\n" );
				sql.append( "															AND T3.EATING_DATE = '"+str1+"'		\n" );
				sql.append( " WHERE T1.CLIENT_SID = '"+str2+"'																\n" );
				sql.append( " AND T1.TEAM_CD = '"+str3+"'																		\n" );				
				//if (!str1.equals("")) sql.append( "  AND T3.EATING_DATE = '"+str1+"'                 \n");
				//logger.dbg.println("bm041i_s02",sql.toString());
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