//입출국관리 : 사업자출국신청:(세부 조회)

package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm026i_s02 extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1"); //세부

				if (str1==null || str1=="") str1 = "";


				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
														"T1_RSV_SID",		"DEPART_DATE",	"NS_PLAN",		"SN_PLAN",	"CAR_YN",
														"BIGO",					"I_EMPNO",			"I_DATE",			"U_EMPNO",	"U_DATE",
														"ARRIVE_DATE",		"T1_U_EMPNO",		"T1_U_DATE",	"RSV_SID"
															};

				int[] intArrCN = new int[] {
													10,	8,		8,		8,		1,
													30,	10,	10,	10,	10,
													8,		10,	10,	10
													};

				int[] intArrCN2 = new int[]{
													0,		-1,	-1,	-1,	-1,
													-1,	-1,	-1,	-1,	-1,
													-1,	-1,	-1,	0
													};

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();
				
				sql.append( "     SELECT																						\n" );
				sql.append( "         COALESCE(T1.RSV_SID,0) AS T1_RSV_SID,								\n" );
				sql.append( "         COALESCE(T1.DEPART_DATE,'') AS DEPART_DATE,					\n" );
				sql.append( "         COALESCE(T2.NS_PLAN,'') AS NS_PLAN,									\n" );
				sql.append( "         COALESCE(T2.SN_PLAN,'') AS SN_PLAN,									\n" );
				sql.append( "         COALESCE(T2.CAR_YN,'') AS CAR_YN,										\n" );

				sql.append( "         COALESCE(T2.BIGO,'') AS BIGO,												\n" );
				sql.append( "         COALESCE(T2.I_EMPNO,'') AS I_EMPNO,									\n" );
				sql.append( "         COALESCE(T2.I_DATE, CURRENT TIMESTAMP) AS I_DATE,		\n" );
				sql.append( "         COALESCE(T2.U_EMPNO,'') AS U_EMPNO,								\n" );
				sql.append( "         COALESCE(T2.U_DATE, CURRENT TIMESTAMP) AS U_DATE,		\n" );

				sql.append( "         T1.ARRIVE_DATE,																	\n" );
				sql.append( "         T1.U_EMPNO AS T1_U_EMPNO,												\n" );
				sql.append( "         T1.U_DATE AS T1_U_DATE,													\n" );
				sql.append( "         COALESCE(T2.RSV_SID,0) AS RSV_SID									\n" );

				sql.append( "     FROM SALES.TRV020 T1																\n" );
				sql.append( "         LEFT JOIN SALES.TCM050 T2 ON T1.RSV_SID = T2.RSV_SID		\n" );
				sql.append( "     WHERE T1.CUST_SID = '"+str1+"'												\n" );
				sql.append( "     ORDER BY    T1.RSV_SID DESC													\n" );
				sql.append( "     FETCH FIRST 1 ROWS ONLY															" );
				//logger.dbg.println("bm026i_s02",sql.toString());
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