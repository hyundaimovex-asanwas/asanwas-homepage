// 개인정보관리 : 협력업체관리 (조회)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm065i_s01 extends HttpServlet {

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

		        String  str1	= GauceReq.getParameter("v_str1");  //거래처코드
		        String  str2	= GauceReq.getParameter("v_str2");  //거래처명

				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					                                "CLIENT_SID",		"VEND_CD",			"VEND_ID",		"CLIENT_NM",		"CLIENT_DAM_NM",
					                                "TEL_NO",				"FAX_NO",				"ZIP_CD",			"ADDRESS",            "LOCAL_MGR",
													"LOCAL_STAFF",	"LOCAL_TEL",	 	"LOCAL_FAX"
														};

				int[] intArrCN = new int[] {
					                              10,		13,	15,	30,	20,
					                              20,		20,	6,		120,	15,
												  15,		15,	15
                                   				};

				int[] intArrCN2 = new int[]{
					                              0,	-1,	-1,	-1,	-1,
					                             -1,	-1,	-1,	-1,	-1,
					                             -1,	-1,	-1
												};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT														\n" );
				sql.append( " 		CLIENT_SID										\n" );
				sql.append( " 		, VEND_CD											\n" );
				sql.append( " 		, VEND_ID 											\n" );
				sql.append( " 		, CLIENT_NM										\n" );
				sql.append( " 		, CLIENT_DAM_NM								\n" );
				sql.append( " 		, TEL_NO											\n" );
				sql.append( " 		, FAX_NO											\n" );
				sql.append( " 		, ZIP_CD											\n" );
				sql.append( " 		, ADDRESS1 || ADDRESS2 ADDRESS	\n" );
				sql.append( " 		, LOCAL_MGR										\n" );
				sql.append( " 		, LOCAL_STAFF									\n" );
				sql.append( " 		, LOCAL_TEL										\n" );
				sql.append( " 		, LOCAL_FAX										\n" );
				sql.append( "		FROM SALES.TCU030								\n" );
				sql.append( " WHERE USE_YN = 'Y'									\n" );

				if (!str1.equals("")) sql.append( "  AND VEND_CD = '"+str1+"'       \n");
				if (!str2.equals("")) sql.append( "  AND CLIENT_NM LIKE  '"+str2+"%'  \n");

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