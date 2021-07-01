// * 통신관리 : 통신관리>무전기 지급관리(직원 조회)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm055i_s02 extends HttpServlet {

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

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
										    	"POSITIONS",		"WORK_NO",		"CUST_NM",		"CUST_SID",		"TEAM_NM"
															};

				int[] intArrCN = new int[] {	
					                              30,	20,	30,	10,	40
																		}; 
			
				int[] intArrCN2 = new int[]{
					                              -1,	-1,	-1,	0,	-1
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( "     SELECT																							\n" );
				sql.append( "         T1.POSITIONS, T2.WORK_NO, T1.CUST_NM, T1.CUST_SID,			\n" );
				sql.append( "         SALES.FN_DETAIL_NM ( 'CM003',T2.TEAM_CD) AS TEAM_NM		\n" );
				sql.append( "     FROM SALES.TCU010 T1																	\n" );
				sql.append( "         INNER JOIN SALES.TCM010 T2													\n" );
				sql.append( "             INNER JOIN SALES.TCU030 V1													\n" );
				sql.append( "                 ON T2.CLIENT_SID = V1.CLIENT_SID									\n" );
//				sql.append( " /*              AND T2.CLIENT_SID = '' 현대아산 코드 생성 후 코드를 하드코딩할 예정*/ \n" );
				sql.append( "         ON T1.CUST_SID = T2.CUST_SID												\n" );
				sql.append( "         AND T1.CUST_GU = '2'																\n" );
				sql.append( "     ORDER BY T1.CUST_NM																	\n" );

				//if (!str1.equals("")) sql.append( " AND V1.CLIENT_SID = '"+str1+"'     \n" );
				//logger.dbg.println("bm055i_s02",sql.toString());
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