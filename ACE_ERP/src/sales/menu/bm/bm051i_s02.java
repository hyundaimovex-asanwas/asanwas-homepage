// * 통신관리 : 통신관리>전화번호 관리 (세부 조회)
package sales.menu.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm051i_s02 extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1"); //전화번호 || 수신처 

				if (str1==null || str1=="") str1 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
														"TEL_SID",		"TEL_NUM",	"CUST_SID",		"REC_PLAC",	"SN",
														"OP",				"BIGO",			"REGI_DATE",		"I_EMPNO",	"I_DATE",    
														"U_EMPNO",	"U_DATE"
																};

				int[] intArrCN = new int[] {	
					                              10,	15,	10,	20,	1,
					                               1,	40,	8,		10,	10,
					                              10,	10
													}; 
			
				int[] intArrCN2 = new int[]{
					                              0,	-1,	0,		-1,	-1,
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

				sql.append( " SELECT									\n" );
				sql.append( "       TEL_SID,							\n" );
				sql.append( "       TEL_NUM,						\n" );
				sql.append( "       CUST_SID,						\n" );
				sql.append( "       REC_PLAC,						\n" );
				sql.append( "       SN,									\n" );
				sql.append( "       OP,									\n" );
				sql.append( "       BIGO,								\n" );
				sql.append( "       REGI_DATE,						\n" );
				sql.append( "       I_EMPNO,						\n" );
				sql.append( "       I_DATE,							\n" );
				sql.append( "       U_EMPNO,						\n" );
				sql.append( "       U_DATE							\n" );
				sql.append( " FROM SALES.TCM070				\n" );
				sql.append( " WHERE TEL_SID = '"+str1+"'	\n" );
				//if (!str1.equals("")) sql.append( " AND T1.CUST_NM = '"+str1+"'              \n" );
				//logger.dbg.println("bm051i_s02",sql.toString());

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