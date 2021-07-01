// * 개인정보관리 : 협력업체 조회
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class Company_pop_s01 extends HttpServlet {

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

		        String  str1	= GauceReq.getParameter("v_str1"); 

				if (str1==null || str1=="") str1 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					                                "VEND_SID",		"VEND_NM"
														};

				int[] intArrCN = new int[] {
					                              10,	50
												};

				int[] intArrCN2 = new int[]{
					                             -1,		-1
												};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT																						\n" );
				sql.append( "  CLIENT_SID VEND_SID,																\n" );
				sql.append( "  CLIENT_NM VEND_NM																\n" );
//				sql.append( "  CASE WHEN A.LOCAL_GU = 'K' THEN '금강산'								\n" );
//				sql.append( "				WHEN A.LOCAL_GU = 'G' THEN '개성'								\n" );
//				sql.append( "				ELSE '' END LOCAL_GU_NM												\n" );
				sql.append( " FROM SALES.TCU030																	\n" );
				sql.append( " WHERE VEND_TYPE > 0																\n" );
				sql.append( " AND USE_YN = 'Y'																		\n" );
				if (!str1.equals("")) sql.append( "  AND CLIENT_NM LIKE '%"+str1+"%'				\n");
				sql.append( "  ORDER BY CLIENT_NM ");
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