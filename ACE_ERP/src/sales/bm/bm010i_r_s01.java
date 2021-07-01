// * 개인정보관리 : 개인정보관리팝업(조회)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm010i_r_s01 extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1"); //국적구분
				String  str2	= GauceReq.getParameter("v_str2"); //고객명
				String  str3	= GauceReq.getParameter("v_str3"); //주민여권번호

				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";
				if (str3==null || str3=="") str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
												"CUST_SID",					"COUNTRY_GU",		"WORK_NO",		"CUST_NM",			"MANAGE_NO",
												"BIRTHDAY",					"SEX",					"CUST_GU",		"SAUP_GU",			"CUST_TYPE",
												"LAST_NM",					"FIRST_NM",			"ZIP_CD",			"ZIP_NAME",			"ADDRESS1",
												"ADDRESS2",					"TEL_NO",				"MOBILE_NO",	"COMPANY_NM",	"POSITIONS",
												"COUNTRY_GU_NAME",	"NATION_CD",		"REGI_YN",			"CASE"
												};

				int[] intArrCN = new int[] {
											10,	2,		20,	30,	20,
											8,		1,		1,		2,		3,
											30,	30,	6,		6,		80,
											60,	20,	20,	20,	30,
											50,	3,		15,	15
											};

				int[] intArrCN2 = new int[]{
												0,		-1,	-1,	-1,	-1,
												-1,	-1,	-1,	-1,	-1,
												-1,	-1,	-1,	-1,	-1,
												-1,	-1,	-1,	-1,	-1,
												-1,	-1,	-1,	-1
												};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( "   SELECT																						\n" );
				sql.append( "       T1.CUST_SID,																			\n" );
				sql.append( "       T1.COUNTRY_GU,																		\n" );
				sql.append( "       T1.WORK_NO,																			\n" );
				sql.append( "       T1.CUST_NM,																			\n" );
				sql.append( "       T1.MANAGE_NO,																		\n" );
				sql.append( "       T1.BIRTHDAY,																			\n" );
				sql.append( "       T1.SEX,																					\n" );
				sql.append( "       T1.CUST_GU,																			\n" );
				sql.append( "       T1.SAUP_GU,																			\n" );
				sql.append( "       T1.CUST_TYPE,																		\n" );
				sql.append( "       T1.LAST_NM,																			\n" );
				sql.append( "       T1.FIRST_NM,																			\n" );
				sql.append( "       T1.ZIP_CD,																				\n" );
				sql.append( "       SALES.FN_DETAIL_NM ( 'CU020',T1.ZIP_CD) AS ZIP_NAME,			\n" );
				sql.append( "       T1.ADDRESS1,																			\n" );
				sql.append( "       T1.ADDRESS2,																			\n" );
				sql.append( "       T1.TEL_NO,																				\n" );
				sql.append( "       T1.MOBILE_NO,																		\n" );
				sql.append( "       T1.COMPANY_NM,																	\n" );
				sql.append( "       T1.POSITIONS,																		\n" );
				sql.append( "       SALES.FN_DETAIL_NM ( 'CU009',T1.COUNTRY_GU) AS COUNTRY_GU_NAME,	 \n" );
				sql.append( "       T1.NATION_CD,																		\n" );
				sql.append( "       COALESCE(T2.CLIENT_SID, 0) AS REGI_YN,								\n" );
				sql.append( "       CASE																						\n" );
				sql.append( "           WHEN T2.CLIENT_SID IS NULL THEN '미등록'						\n" );
				sql.append( "	           WHEN T2.CLIENT_SID = 0 THEN '미등록'								\n");
				sql.append( "           ELSE '등록'																			\n" );
				sql.append( "       END CASE																				\n" );
				sql.append( "   FROM SALES.TCU010 T1																\n" );
				sql.append( "       LEFT JOIN SALES.TCM010 T2 ON T1.CUST_SID = T2.CUST_SID	\n" );
				sql.append( "   WHERE T1.CUST_GU = '2'																\n" );
				
				if (!str1.equals("")) sql.append( "  AND T1.COUNTRY_GU = '" + str1 + "'					\n");
				if (!str2.equals("")) sql.append( "  AND T1.CUST_NM LIKE '" + str2 + "%'					\n");
				if (!str3.equals("")) sql.append( "  AND T1.REGI_NO = '" + str3 + "'							\n");

				sql.append( "  ORDER BY T1.CUST_NM																		");
				logger.dbg.println("bm010i_r_s01",sql.toString());
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