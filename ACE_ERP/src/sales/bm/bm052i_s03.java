package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm052i_s03 extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1"); //TEL_SID
				String  str2	= GauceReq.getParameter("v_str2"); //TELHIS_SID

				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
													"TELHIS_SID",	"CUST_SID",		"CT",					"WORK_NO",		"TEL_SID",
													"TEL_NUM",		"TEL_DATE",		"TEL_STIME",		"TEL_ETIME",		"TEL_DURA",
													"TEL_FEE",			"OP",					"CAL_YN",			"I_EMPNO",		"U_EMPNO"
													};

				int[] intArrCN = new int[] {
					                              10,	10,	1,		20,	10,
					                              15,	8,		6,		6,		3,
					                              10,	1,		1,		10,	10
												};

				int[] intArrCN2 = new int[]{
					                              0,	0,		-1,	-1,	0,
					                             -1,	-1,	-1,	-1,	-1,
					                              2,	-1,	-1,	-1,	-1
												};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT																														" );
				sql.append( "			TELHIS_SID,		CUST_SID,			CT,				WORK_NO,		TEL_SID,			\n" );
				sql.append( "			TEL_NUM,			TEL_DATE,			TEL_STIME,	TEL_ETIME,		TEL_DURA,		\n" );
				sql.append( "			TEL_FEE,			OP,					CAL_YN,		I_EMPNO,			U_EMPNO			\n" );
				sql.append( "		FROM SALES.TCM080																							\n" );
				sql.append( "		WHERE 1 = 1																										\n" );
				sql.append( "		AND TEL_SID='"+str1+"'																						\n" );
				sql.append( "		AND TELHIS_SID='"+str2+"'																					\n" );
//				sql.append( "				AND WORK_NO = '" + str2 + "'	 \n");
				sql.append( "		ORDER BY TELHIS_SID DESC																					");
//				sql.append( "  FETCH FIRST 1 ROWS ONLY ");
				//logger.dbg.println("bm052i_s03",sql.toString());
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