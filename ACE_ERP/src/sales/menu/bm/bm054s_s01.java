// * 통신관리 : 통신관리>통화내역조회(조회)
package sales.menu.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm054s_s01 extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1");		//회사코드
				String  str2	= GauceReq.getParameter("v_str2");		//날짜
				String  str3	= GauceReq.getParameter("v_str3");		//날짜2
				String  str4	= GauceReq.getParameter("v_str4");		//성명

				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";
				if (str3==null || str3=="") str3 = "";
				if (str4==null || str4=="") str4 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
													"CLIENT_SID",	"CLIENT_NM",	"TEAM_NM",		"WORK_NO",		"CUST_NM",      
													"UP_SID",			"TEL_DATE",		"TEL_STIME",		"TEL_ETIME",		"UP_NUM",
													"TEL_NUM",		"TEL_DURA",		"TEL_FEE"
														};

				int[] intArrCN = new int[] {
					                              15,	62,	62,	20,	40,									
					                              10,	 8,		4,		4,		15,
					                              15,	3,		5
													};

				int[] intArrCN2 = new int[]{
					                             -1,	-1,	-1,	-1,	-1,
					                              0,	-1,	-1,	-1,	-1,
					                             -1,	-1,	1
													};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT																												\n" );
				sql.append( "    V1.CLIENT_SID,																								\n" );
				sql.append( "    V1.CLIENT_NM,																								\n" );
				sql.append( "    SALES.FN_DETAIL_NM ( 'CM003',T2.TEAM_CD) AS TEAM_NM,							\n" );
				sql.append( "    A.WORK_NO,																									\n" );
				sql.append( "    T3.CUST_NM,																									\n" );
				sql.append( "    A.UP_SID,																										\n" );
				sql.append( "    A.TEL_DATE,																									\n" );
				sql.append( "    A.TEL_STIME,																									\n" );
				sql.append( "    A.TEL_ETIME,																									\n" );
				sql.append( "    C.UP_NUM,																										\n" );
				sql.append( "    B.TEL_NUM,																									\n" );
				sql.append( "    A.TEL_DURA,																									\n" );
				sql.append( "    A.TEL_FEE	 																									\n" );
//				sql.append( "    C.TEL_FEE																										\n" );
				sql.append( " FROM SALES.TCM080 A																						\n" );
				sql.append( "      JOIN SALES.TCU010 T1 ON A.CUST_SID = T1.CUST_SID									\n" );
				sql.append( "      JOIN SALES.TCM010 T2																					\n" );
				sql.append( "                   JOIN SALES.TCU030 V1 ON T2.CLIENT_SID = V1.CLIENT_SID				\n" );
				sql.append( "      ON T1.CUST_SID = T2.CUST_SID																	\n" );
				sql.append( "      JOIN SALES.TCU010 T3 ON A.CUST_SID = T3.CUST_SID									\n" );
				sql.append( "      JOIN SALES.TCM070 B ON A.TEL_SID = B.TEL_SID											\n" );
//				sql.append( "		INNER JOIN SALES.TCM090 C ON A.TELHIS_SID = C.TELHIS_SID  \n" );
				sql.append( "      LEFT JOIN SALES.TCM090 C ON A.TELHIS_SID = C.TELHIS_SID  \n" );//inner join으로 변경
				sql.append( " WHERE 1=1																										\n" );

				if (!str1.equals("")) sql.append( " AND V1.CLIENT_SID = '"+str1+"'												\n" );
				if (!str2.equals("")) sql.append( " AND A.TEL_DATE >= '"+str2+"'												\n" );
				if (!str3.equals("")) sql.append( " AND A.TEL_DATE <= '"+str3+"'												\n" );
				if (!str4.equals("")) sql.append( " AND T3.CUST_NM LIKE '"+str4+"%'											\n" );

				sql.append( "  ORDER BY V1.CLIENT_SID ");
				//logger.dbg.println("bm054s_s01",sql.toString());
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