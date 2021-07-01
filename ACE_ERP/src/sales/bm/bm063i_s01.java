// * 기타관리 : 세탁 관리(조회)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm063i_s01 extends HttpServlet {

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
				// 웹페이지에서 조건값을 넘겨받음
				String  str1	= GauceReq.getParameter("v_str1");	//날짜
				String  str2	= GauceReq.getParameter("v_str2");	//날짜2
				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
															"VEND_NM",	"LAUN_SID",	"LAUN_DATE",	"COOP_SID",		"D1",
															"D2",				"D3",				"W1",				"W2",				"W3", 
															"W5",			"W7",			"R2",					"R4",					"LAUN_FEE",
															"CALC_YN",	"BIGO",			"I_EMPNO",		"I_DATE",			"U_EMPNO",
															"U_DATE"
														}; 

				int[] intArrCN = new int[] {
												62,	10,	8,		15,	2, 
												 2,		2,		2,		2,		2,
												 2,		2,		2,		2,		4,
												 1,		30,	10,	10,	10,
												10
										};

				int[] intArrCN2 = new int[]{
												-1,	0,		-1,	-1,	0,
												 0,		0,		0,		0,		0,
												 0,		0,		0,		0,		0,
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

				sql.append( " SELECT                                 \n" );
				sql.append( " 		V1.VEND_NM,                        \n" );
				sql.append( " 		T1.LAUN_SID,                       \n" );
				sql.append( " 		T1.LAUN_DATE,                      \n" );
				sql.append( " 		T1.COOP_SID,                       \n" );
				sql.append( " 		T1.D1,                             \n" );
				sql.append( " 		T1.D2,                             \n" );
				sql.append( " 		T1.D3,                             \n" );
				sql.append( " 		T1.W1,                             \n" );
				sql.append( " 		T1.W2,                             \n" );
				sql.append( " 		T1.W3,                             \n" );
				sql.append( " 		T1.W5,                             \n" );
				sql.append( " 		T1.W7,                             \n" );
				sql.append( " 		T1.R2,                             \n" );
				sql.append( " 		T1.R4,                             \n" );
				sql.append( " 		T1.LAUN_FEE,                       \n" );
				sql.append( " 		T1.CALC_YN,                        \n" );
				sql.append( " 		T1.BIGO,                           \n" );
				sql.append( " 		T1.I_EMPNO,                        \n" );
				sql.append( " 		T1.I_DATE,                         \n" );
				sql.append( " 		T1.U_EMPNO,                        \n" );
				sql.append( " 		T1.U_DATE                          \n" );
				sql.append( " FROM SALES.TCM130 T1                   \n" );
				sql.append( " 		INNER JOIN ACCOUNT.GCZM_VENDER V1  \n" );
				sql.append( " 				ON T1.COOP_SID = V1.VEND_ID    \n" );
				sql.append( " WHERE 1=1                              \n" );

				if (!str1.equals("")) sql.append( "  AND T1.LAUN_DATE >= '"+str1+"'             \n");
				if (!str2.equals("")) sql.append( "  AND T1.LAUN_DATE <= '"+str2+"'             \n");
				sql.append( " ORDER BY T1.LAUN_SID DESC  ");
		        //logger.dbg.println("bm063i_s01",sql.toString());
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