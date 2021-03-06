// * 통신관리 : 통신관리>통화관리 ((하)세부조회)
package sales.menu.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm052i_s02 extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1"); //전화번호
				String  str2	= GauceReq.getParameter("v_str2"); //수신처

				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
															"TEL_SID",		"TEL_NUM",	"CUST_SID",		"REC_PLAC",	"SN",
															"OP",				"BIGO",			"REGI_DATE",		"I_EMPNO",	"I_DATE",
															"U_EMPNO",	"U_DATE",		"CLIENT_NM"
														};

				int[] intArrCN = new int[] {	
					                              10,15,10,20, 1,												
					                               1,40, 8,10,10,												
					                              10,10,30
												};

				int[] intArrCN2 = new int[]{
					                              0,-1, -1,-1,-1,
					                             -1,-1,-1,-1,-1,
					                             -1,-1,-1
												};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT									\n" );
				sql.append( "       A.TEL_SID,						\n" );
				sql.append( "       A.TEL_NUM,						\n" );
				sql.append( "       A.CUST_SID,					\n" );
				sql.append( "       A.REC_PLAC,					\n" );
				sql.append( "       A.SN,								\n" );
				sql.append( "       A.OP,								\n" );
				sql.append( "       A.BIGO,							\n" );
				sql.append( "       A.REGI_DATE,					\n" );
				sql.append( "       A.I_EMPNO,						\n" );
				sql.append( "       A.I_DATE,						\n" );
				sql.append( "       A.U_EMPNO,					\n" );
				sql.append( "       A.U_DATE,						\n" );
				sql.append( "       V1.CLIENT_NM					\n" );
				sql.append( " FROM SALES.TCM070 A			\n" );
				sql.append( "     JOIN SALES.TCU010 T1 ON A.CUST_SID = T1.CUST_SID									\n" );
				sql.append( "     INNER JOIN SALES.TCM010 T2																		\n" );
				sql.append( "                  INNER JOIN SALES.TCU030 V1 ON T2.CLIENT_SID = V1.CLIENT_SID		\n" );
				sql.append( "     ON T1.CUST_SID = T2.CUST_SID																	\n" );
				sql.append( " WHERE 1=1							\n" );
								
				if (!str1.equals("")) sql.append( " AND A.TEL_NUM  LIKE '%"+str1+"%'		\n" );
				if (!str2.equals("")) sql.append( " AND A.REC_PLAC LIKE '%"+str2+"%'		\n" );

				sql.append( "  ORDER BY A.CUST_SID																");
				//logger.dbg.println("bm052i_s02",sql.toString());
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