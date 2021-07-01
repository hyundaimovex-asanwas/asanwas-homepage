// 기타관리 : 이발관리(조회)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm062i_s01 extends HttpServlet {

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
				// 웹페이지에서 조건값을 넘겨받음
				String  str1	= GauceReq.getParameter("v_str1");	//날짜
				String  str2	= GauceReq.getParameter("v_str2");	//날짜2
				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
													"CLIENT_NM",	"TEAM_NM",		"WORK_NO",		"CUST_NM",		"HAIR_SID",
													"HAIR_DATE",	"CUST_SID",		"CALC_YN",		"HAIR_FEE",		"I_EMPNO",
													"I_DATE",			"U_EMPNO",		"U_DATE"
														};

				int[] intArrCN = new int[] {
					                              62,	62,	20,	40,	10,
					                               8,	10,	1,		3,		10,
					                              10,	10,	10
													};

				int[] intArrCN2 = new int[]{
					                            -1,	-1,	-1,	-1,	0,
												-1,	0,		-1,	1,		-1,
												-1,	-1,	-1
												};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT																									\n" );
				sql.append( " 		V1.CLIENT_NM,																				\n" );
				sql.append( " 		SALES.FN_DETAIL_NM ( 'CM003',T2.TEAM_CD) AS TEAM_NM,			\n" );
				sql.append( " 		T2.WORK_NO,																				\n" );
				sql.append( " 		T1.CUST_NM,																				\n" );
				sql.append( " 		T3.HAIR_SID,																					\n" );
				sql.append( " 		T3.HAIR_DATE,																				\n" );
				sql.append( " 		T3.CUST_SID,																				\n" );
				sql.append( " 		T3.CALC_YN,																					\n" );
				sql.append( " 		T3.HAIR_FEE,																					\n" );
				sql.append( " 		T3.I_EMPNO,																					\n" );
				sql.append( " 		T3.I_DATE,																					\n" );
				sql.append( " 		T3.U_EMPNO,																					\n" );
				sql.append( " 		T3.U_DATE																					\n" );
				sql.append( "		FROM SALES.TCM120 T3																	\n" );
				sql.append( " 		INNER JOIN SALES.TCM010 T2														\n" );
				sql.append( " 				LEFT JOIN SALES.TCU030 V1													\n" );
				sql.append( "						ON T2.CLIENT_SID = V1.CLIENT_SID									\n" );
				sql.append( " 		ON T3.CUST_SID = T2.CUST_SID													\n" );
				sql.append( " 		INNER JOIN SALES.TCU010 T1															\n" );
				sql.append( "			ON T3.CUST_SID = T1.CUST_SID AND T1.CUST_GU = '2'					\n" );
				sql.append( "		WHERE 1=1																						\n" );

				if (!str1.equals("")) sql.append( "  AND T3.HAIR_DATE >= '"+str1+"'								\n");
				if (!str2.equals("")) sql.append( "  AND T3.HAIR_DATE <= '"+str2+"'								\n");
				sql.append( " ORDER BY T1.CUST_NM																				");
				//logger.dbg.println("bm062i_s01",sql.toString());
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