package sales.menu.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm056i_s01 extends HttpServlet {

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
				//1:DATE, 2:두개데이터, 3:TOP
				String  str1	= GauceReq.getParameter("v_str1"); 
				String  str2	= GauceReq.getParameter("v_str2"); 
				String  str3	= GauceReq.getParameter("v_str3"); 

				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";
				if (str3==null || str3=="") str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					                                "TH_SID", "SN_GU", "TH_UNIT", "TH_DATE"
													};

				int[] intArrCN = new int[] {
					                            10,	1,		10,	12
												};
			
				int[] intArrCN2 = new int[]{
					                            0,		-1,	2,		-1
												};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT TH_SID, SN_GU, TH_UNIT, TH_DATE			\n" );
				sql.append( " FROM SALES.TCM210												\n" );
				sql.append( "	WHERE 1 = 1															\n" );
				if (!str1.equals("")) sql.append( "  AND TH_DATE >= '"+str1+"'		\n ");
				if (!str2.equals("")) sql.append( "  AND SN_GU = '" + str2 + "'			\n ");
				sql.append( " ORDER BY TH_SID DESC											\n" );

				if (!str3.equals("")) sql.append( "  FETCH FIRST 1 ROWS ONLY		\n ");
				//logger.dbg.println(this,sql.toString());
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