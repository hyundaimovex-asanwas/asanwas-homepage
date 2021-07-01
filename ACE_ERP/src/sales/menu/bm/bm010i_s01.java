// * 개인정보관리 : 개인정보관리 (조회)
package sales.menu.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import sales.common.StringUtil;

public class bm010i_s01 extends HttpServlet {

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

				logger.dbg.println(this,"1");
				
				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";
				if (str3==null || str3=="") str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
														"TEAM_CD",		"DETAIL_NM",				"CUST_SID",				"CUST_NM",			"MANAGE_NO",
														"SEX",				"SEX_NAME",					"LAST_NM",				"FIRST_NM",			"WORK_NO",
														"BIRTHDAY",		"CUST_GU",					"SAUP_GU_NAME",		"REGI_NO",			"COUNTRY_GU",
														"SAUP_GU",		"CUST_TYPE",				"CUST_TYPE_NAME",	"ZIP_CD",				"ZIP_NAME"  ,
														"ADDRESS1",		"ADDRESS2",					"TEL_NO",					"MOBILE_NO",		"COMPANY_NM",
														"POSITIONS",		"COUNTRY_GU_NAME",	"NATION_CD",			"NATION_NAME",	"CLIENT_SID",
														"VEND_NM",		"REAL_CLIENT",				"VEND_NM2",				"ORDER_DATE",		"WORK_PLACE",
														"I_EMPNO",		"U_EMPNO"
														};

				int[] intArrCN = new int[] {
											5,		50,	10,	30,	20,
											1,		50,	30,	20,	20,
											8,		10,	50,	13,	2,
											2,		3,		50,	6,		10,
											80,	60,	20,	20,	20,
											30,	50,	3,		50,	15,
											60,	10,	60,	15,	20,
											10,	10
											};

				int[] intArrCN2 = new int[]{
										-1,	-1,	-1,	-1,	-1,
										-1,	-1,	-1,	-1,	-1,
										-1,	-1,	-1,	-1,	-1,
										-1,	-1,	-1,	-1,	-1,
										-1,	-1,	-1,	-1,	-1,
										-1,	-1,	-1,	-1,	-1,
										-1,	-1,	-1,	-1,	-1,
										-1,	-1
										};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();
				//StringUtil.printMsg("1", "1",this);
				sql.append( "																	\n" );
				sql.append( " SELECT														\n" );
				sql.append( "     IFNULL(T1.TEAM_CD,'') TEAM_CD,			\n" );
				sql.append( "     IFNULL(T5.DETAIL_NM,'') DETAIL_NM,	\n" );
				sql.append( "     T1.CUST_SID,										\n" );
				sql.append( "     T2.CUST_NM,										\n" );
				sql.append( "     T2.MANAGE_NO,									\n" );
				sql.append( "     T2.SEX,													\n" );
				sql.append( "     SALES.FN_DETAIL_NM ( 'SY009',T2.SEX) AS SEX_NAME,							\n" );
				sql.append( "     T2.LAST_NM,											\n" );
				sql.append( "     T2.FIRST_NM,										\n" );
				sql.append( "     T2.WORK_NO,										\n" );
				sql.append( "     T2.BIRTHDAY,										\n" );
				sql.append( "     T2.CUST_GU,											\n" );
				sql.append( "     SALES.FN_DETAIL_NM ( 'CU004',T2.SAUP_GU) AS SAUP_GU_NAME,			\n" );
				sql.append( "     T2.REGI_NO,											\n" );
				sql.append( "     T2.COUNTRY_GU,									\n" );
				sql.append( "     T2.SAUP_GU,											\n" );
				sql.append( "     T2.CUST_TYPE,										\n" );
				sql.append( "     SALES.FN_DETAIL_NM ( 'RV003',T2.CUST_TYPE) AS CUST_TYPE_NAME,	\n" );
				sql.append( "     T2.ZIP_CD,											\n" );
				sql.append( "     IFNULL(SALES.FN_DETAIL_NM ( 'CU020',T2.ZIP_CD),'') ZIP_NAME,						\n" );
				sql.append( "     T2.ADDRESS1,										\n" );
				sql.append( "     T2.ADDRESS2,										\n" );
				sql.append( "     T2.TEL_NO,											\n" );
				sql.append( "     T2.MOBILE_NO,										\n" );
				sql.append( "     T2.COMPANY_NM,									\n" );
				sql.append( "     T2.POSITIONS,										\n" );
				sql.append( "     SALES.FN_DETAIL_NM ( 'CU009',T2.COUNTRY_GU) AS COUNTRY_GU_NAME,	\n" );
				sql.append( "     T2.NATION_CD,										\n" );
				sql.append( "     SALES.FN_DETAIL_NM ( 'SY005',T2.NATION_CD) AS NATION_NAME,			\n" );
				sql.append( "     T4.CLIENT_SID,										\n" );
				sql.append( "     T3.CLIENT_NM VEND_NM,						\n" );
				sql.append( "     T4.CLIENT_SID REAL_CLIENT,					\n" );
				sql.append( "     T4.CLIENT_NM VEND_NM2,						\n" );
				sql.append( "     IFNULL(T1.ORDER_DATE,'') ORDER_DATE,  \n" );
				sql.append( "     IFNULL(T1.WORK_PLACE,'') WORK_PLACE, \n" );
				sql.append( "     T1.I_EMPNO,											\n" );
				sql.append( "     T1.U_EMPNO											\n" );
				
				
				sql.append( " FROM SALES.TCM010 T1							\n" );
				sql.append( "     JOIN SALES.TCU010 T2			ON T1.CUST_SID = T2.CUST_SID  AND T2.CUST_GU = '2'   \n" );
				sql.append( "     LEFT JOIN SALES.TCU030 T3 ON T1.CLIENT_SID  = T3.CLIENT_SID                          \n" );
//				sql.append( "                                     AND (T3.VEND_SID IS NOT NULL OR T3.VEND_SID <> '')      \n" );
				sql.append( "     LEFT JOIN SALES.TCU030 T4 ON T1.REAL_CLIENT = T4.CLIENT_SID                         \n" );
//				sql.append( "                                     AND T4.VEND_SID IS NOT NULL AND T4.VEND_SID <> ''       \n" );
				sql.append( "     LEFT JOIN SALES.TSY010 T5             ON T1.TEAM_CD = T5.DETAIL                            \n" );
				sql.append( "                                     AND T5.HEAD    = 'CM003' AND T5.ITEM1 = 'Y'           \n" );
				sql.append( " WHERE 1 = 1                                                                                 \n" );

				if (!str1.equals("")) sql.append( "  AND T2.COUNTRY_GU = '" + str1 + "'   \n");
				if (!str2.equals("")) sql.append( "  AND T2.CUST_NM LIKE '%" + str2 + "%' \n");
				if (!str3.equals("")) sql.append( "  AND T2.MANAGE_NO = '" + str3 + "'    \n");
				//if (!str4.equals("")) sql.append( "  AND T2.CUST_SID  = '" + str4 + "'    \n");

				sql.append( "  ORDER BY T1.CUST_SID ");
				//StringUtil.printMsg("bm010i_s01", sql.toString(),this);
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