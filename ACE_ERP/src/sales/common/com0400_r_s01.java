// 로그인 정보
package sales.common;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class com0400_r_s01 extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
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

				String  str2	= GauceReq.getParameter("v_str2");	//이름

				if (str2==null || str2=="") str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{	"USERID",		"USERNAME"		};

				int[] intArrCN = new int[] {  10,	30	 	};

				int[] intArrCN2 = new int[]{	 -1,	-1		};

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( "   SELECT									\n" );
				sql.append( "       USERID, USERNAME				\n" );
				sql.append( "   FROM COMMON.USERFILE			\n" );
				sql.append( "   WHERE 1 = 1							\n" );
				
//				if (!str1.equals("")) sql.append( "  AND USERID = '" + str1 + "'   \n");
				if (!str2.equals("")) sql.append( "  AND USERNAME LIKE '" + str2 + "%' \n");

				sql.append( "  ORDER BY USERNAME	 ");
				//logger.dbg.println(this,sql.toString());
				stmt = conn.getGauceStatement(sql.toString());
				stmt.executeQuery(dSet);

//**********************************************

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