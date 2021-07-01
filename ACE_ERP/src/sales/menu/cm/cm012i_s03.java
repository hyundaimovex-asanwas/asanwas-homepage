package sales.menu.cm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

public class cm012i_s03 extends HttpServlet {

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

				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; }	 //
				Date today = new Date();
				SimpleDateFormat date = new SimpleDateFormat("yyyyMMDD");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "OP_UNIT"		}; //
					int[] intArrCN = new int[] { 3	}; 
					int[] intArrCN2 = new int[]{ 0 }; 

					for (int i=0; i<strArrCN.length; i++) { // set column column 
						switch ( intArrCN2[i] ) { 
							case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
							default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
						} 
					} 

					if (!GauceReq.isBuilderRequest()) {					
							StringBuffer sql = new StringBuffer();

							sql.append( "	SELECT		OP_UNIT													\n");
							sql.append( "	FROM SALES.TCM220													\n");
							sql.append( "	WHERE OP_DATE < '" + date.format(today) + "'			\n");
							sql.append( "		AND OIL_TYPE = '" + str1 + "'									\n");
							sql.append( "	ORDER BY OP_SID DESC	FETCH FIRST 1 ROWS ONLY	\n");

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