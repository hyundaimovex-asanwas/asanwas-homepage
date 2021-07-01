package sales.cm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class cm017i_s01 extends HttpServlet {

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
logger.dbg.println(this,"start");
//				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; }
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
													"OP_SID", "OIL_TYPE", "OP_UNIT", "OP_DATE"
													};
					//파라미터 의미 : 자리수
					int[] intArrCN = new int[] {
												10, 1, 10, 12
												};
					//파라미터 의미( -1:string, 0 : 정수, 1 : 소수점 1자리, 2: 소수점 2자리....
					int[] intArrCN2 = new int[]{
							                       0,	-1,	2,		-1
													};

					for (int i=0; i<strArrCN.length; i++) { // set column column
						switch ( intArrCN2[i] ) {
							case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
							default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
						}
					}

					if (!GauceReq.isBuilderRequest()) {					
							StringBuffer sql = new StringBuffer();

							sql.append( " SELECT OP_SID, OIL_TYPE, OP_UNIT, OP_DATE	\n" );
							sql.append( " FROM SALES.TCM220											\n" );
							//sql.append( "	WHERE 1 = 1															\n" );
							sql.append( " ORDER BY OP_SID DESC											" );
							//logger.dbg.println(this,sql.toString());
							stmt = conn.getGauceStatement(sql.toString());
							stmt.executeQuery(dSet);
					}

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