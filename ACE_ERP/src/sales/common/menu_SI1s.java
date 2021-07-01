// 메뉴
package sales.common;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class menu_SI1s extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1");
				String  str2	= GauceReq.getParameter("v_str2");
				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";
				//logger.dbg.println("str1",str1);
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{	"PGM_IDX",	"PARENT_IDX",	"PGMNM",	"RPGMID",	"CHK",	"BTN_AUTH"	};

				int[] intArrCN = new int[] {		4,	4,	40,	10,	1,		1		};

				int[] intArrCN2 = new int[]{  0,	 0,	 -1,	-1	,	-1,	-1	};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( "  SELECT A.PGM_IDX, A.PARENT_IDX, A.PGMNM, A.RPGMID,					\n" );
				sql.append( "				CASE WHEN B.BTN_AUTH = 'S' THEN 'F' ELSE 'T' END CHK,		\n");
				sql.append( "				B.BTN_AUTH																			\n");
				sql.append( "  FROM COMMON.MENU_AUTH B												\n" );
				sql.append( "		INNER JOIN COMMON.MENU_DETAIL A									\n" );
				sql.append( "		ON B.PGM_IDX = A.PGM_IDX												\n" );
				sql.append( "		AND A.PARENT_IDX = "+str2+"											\n" );		//idx
				sql.append( "  WHERE 1 = 1																		\n" );
				sql.append( "		AND B.USERID = '"+str1+"'													\n" );		//userid
				sql.append( "  ORDER BY B.PGM_IDX																	");

				//logger.dbg.println("menu_d1s",sql.toString());
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