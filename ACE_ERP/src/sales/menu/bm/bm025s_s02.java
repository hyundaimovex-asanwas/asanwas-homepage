// * 입출국관리 : 입출국명단:북->남 (조회) 
package sales.menu.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm025s_s02 extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1"); //날짜
				String  str2	= GauceReq.getParameter("v_str2"); //복귀일자
				String  str3	= GauceReq.getParameter("v_str3"); //복귀flag
				String  str4	= GauceReq.getParameter("v_str4"); //출력flag

				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";
				if (str3==null || str3=="") str3 = "";
				if (str4==null || str4=="") str4 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
												"RSV_SID",		"CUST_SID",	"CUST_NM",			"NATION_NAME",		"SEXN",
												"BIRTHDAY",		"WORK_NO",	"DEPART_DATE",	"NORTH_PURPOSE",	"POSITIONS",
												"CLIENT_NM",	"CHK",			"NSP_YN",				"U_EMPNO",				"U_DATE"
														};

				int[] intArrCN = new int[] {
												10,	10,	30,	30,	2,
												8,		20,	8,		62,	30,
												62,	1,		1,		10,	10
													};

				int[] intArrCN2 = new int[]{
												0,		0,		-1,	-1,	-1,
												-1,	-1,	-1,	-1,	-1,
												-1,	-1,	-1,	-1,	-1
													};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( "      SELECT														\n" );
				sql.append( "          T1.RSV_SID,												\n" );
				sql.append( "          T1.CUST_SID,											\n" );
				sql.append( "          T3.CUST_NM,											\n" );
				sql.append( "          SALES.FN_DETAIL_NM ( 'CU003',T3.NATION_CD) AS NATION_NAME,		\n" );
				sql.append( "          CASE WHEN T3.SEX = 'M' THEN '남' ELSE '여' END SEXN,					\n" );
				sql.append( "          T3.BIRTHDAY,											\n" );
				sql.append( "          T2.WORK_NO,											\n" );
				sql.append( "          T1.DEPART_DATE,										\n" );
				sql.append( "          T1.NORTH_PURPOSE,								\n" );
				sql.append( "          T3.POSITIONS,											\n" );
				sql.append( "          V1.CLIENT_NM,											\n" );
				sql.append( "          'F' AS CHK,												\n" );
				sql.append( "          T4.NSP_YN,												\n" );//추가
				sql.append( "          T4.U_EMPNO,											\n" );//추가
				sql.append( "          T4.U_DATE												\n" );//추가

				sql.append( "      FROM SALES.TRV020 T1								\n" );
				sql.append( "          INNER JOIN SALES.TCM010 T2					\n" );
				sql.append( "          LEFT JOIN SALES.TCU030 V1						\n" );
				sql.append( "              ON T2.CLIENT_SID = V1.CLIENT_SID		\n" );
				sql.append( "         ON T1.CUST_SID = T2.CUST_SID				\n" );
				sql.append( "          INNER JOIN SALES.TCU010 T3					\n" );
				sql.append( "              INNER JOIN SALES.TSY110 S1				\n" );
				sql.append( "                  ON T3.ZIP_SID = S1.ZIP_SID				\n" );
				sql.append( "         ON T1.CUST_SID = T3.CUST_SID				\n" );
				sql.append( "         AND T3.CUST_GU = '2'								\n" );
				sql.append( "         LEFT JOIN SALES.TCM040 T4 ON T1.RSV_SID = T4.RSV_SID		\n" );

				sql.append( "         WHERE 1=1                                                         \n" );

				if (!str1.equals("")) sql.append( "  AND T1.ARRIVE_DATE ='" + str1 + "'		\n");
				if (!str2.equals("")) sql.append( "  AND T1.ARRIVE_TIME ='" + str2 + "'		\n");//추가
				if (!str3.equals("")) sql.append( "  AND T4.NS_YN       ='" + str3 + "'			\n");//추가
				if (!str4.equals("")) sql.append( "  AND T4.NSP_YN      ='" + str4 + "'			\n");//추가

				sql.append( "  ORDER BY T1.RSV_SID ");
				//logger.dbg.println("bm025s_s02",sql.toString());
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