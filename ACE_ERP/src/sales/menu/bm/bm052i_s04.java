package sales.menu.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm052i_s04 extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1");	//년월일
				String  str2	= GauceReq.getParameter("v_str2");	//시작시간
				String  str3	= GauceReq.getParameter("v_str3");	//종료시간
				//logger.dbg.println("년월일:",str1);				logger.dbg.println("시작시간",str2);				logger.dbg.println("종료시간",str3);
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 	"MINUTE_DIFF"	}; 

				int[] intArrCN = new int[] {	3	}; 

				int[] intArrCN2 = new int[]{ -1	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();
				//SELECT TIMESTAMP( DATE(’1988-12-25’), TIME(’17.12.30’) )
				//FROM SYSIBM.SYSDUMMY1
				//SELECT TIMESTAMPDIFF(4, CAST(CURRENT_TIMESTAMP - CAST(BIRTHDATE AS TIMESTAMP) AS CHAR(22)))
				//AS AGE_IN_MONTH
				//FROM SYSIBM.SYSDUMMY1
				sql.append( " SELECT TIMESTAMPDIFF(4, CAST(TIMESTAMP(DATE('"+str1+"'), TIME('"+str3+"')) - TIMESTAMP(DATE('"+str1+"'), TIME('"+str2+"')) AS CHAR(100)))	\n");
				sql.append( " AS MINUTE_DIFF	\n");
				sql.append( " FROM SYSIBM.SYSDUMMY1		\n");

				//logger.dbg.println("",sql.toString());
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