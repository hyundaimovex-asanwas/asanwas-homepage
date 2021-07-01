// * 입출국관리 : 체류등록(조회)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm022i_s01 extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1"); //회사코드
				String  str2	= GauceReq.getParameter("v_str2"); //방북일
				String  str3	= GauceReq.getParameter("v_str3"); //성명

				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";
				if (str3==null || str3=="") str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
														"CHK",				"T1_RSV_SID",	"CLIENT_NM",			"TEAM_NM",			"WORK_NO",   
														"CUST_NM",		"MANAGE_NO",	"DEPART_DATE",	"DEPART_TIME",	"ARRIVE_DATE",   
														"ARRIVE_TIME", "RSV_SID",		"LSTAY_REGI",		"U_EMPNO",			"U_DATE"
														};

				int[] intArrCN = new int[] {	
													1,		10,	60,	20,	8, 
													30,	20,	8,		4,		8,
													4,		10,	8,		10,	10
												};
			
				int[] intArrCN2 = new int[]{
													-1,	0,		-1,	-1,	-1,
													-1,	-1,	-1,	-1,	-1,
													-1,	0,		-1,	-1,	-1
												};

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}

				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT																								\n" );
				sql.append( "				CASE WHEN IFNULL(T4.LSTAY_REGI, '') = '' THEN 'F' ELSE 'T' END  CHK,		\n" );
//				sql.append( " 			'F' AS CHK,																			\n" );
//				sql.append( "				IFNULL(T4.LSTAY_REGI, 'F') AS CHK											\n" );
				sql.append( " 			(T1.RSV_SID) T1_RSV_SID,													\n" );
				sql.append( " 			V1.CLIENT_NM,																		\n" );
				sql.append( " 			SALES.FN_DETAIL_NM('CM003',T2.TEAM_CD) AS TEAM_NM,		\n" );
				sql.append( " 			T2.WORK_NO,																		\n" );
				sql.append( " 			T3.CUST_NM,																		\n" );
				sql.append( " 			T3.MANAGE_NO,																	\n" );
				sql.append( " 			T1.DEPART_DATE,																	\n" );
				sql.append( " 			T1.DEPART_TIME,																	\n" );
				sql.append( " 			T1.ARRIVE_DATE,																	\n" );
				sql.append( " 			T1.ARRIVE_TIME,																	\n" );
				sql.append( " 			T4.RSV_SID,																			\n" );
				sql.append( " 			T4.LSTAY_REGI,																		\n" );
				sql.append( " 			T4.U_EMPNO,																			\n" );
				sql.append( " 			T4.U_DATE																			\n" );
				sql.append( " FROM SALES.TRV020 T1																		\n" );
				sql.append( " 			INNER JOIN SALES.TCM010 T2												\n" );
				sql.append( " 				 LEFT JOIN SALES.TCU030 V1 ON T2.CLIENT_SID = V1.CLIENT_SID				\n" );
				sql.append( " 			ON T1.CUST_SID = T2.CUST_SID																	\n" );
				sql.append( " 			INNER JOIN SALES.TCU010 T3 ON T1.CUST_SID = T3.CUST_SID						\n" );
				sql.append( " 																AND T3.CUST_GU = '2'								\n" );
				sql.append( " 			LEFT  JOIN SALES.TCM040 T4 ON T1.RSV_SID = T4.RSV_SID							\n" );
				sql.append( " 																AND T4.SN_YN = 'T'									\n" );
				sql.append( " 																AND T4.NS_YN = 'F'									\n" );
				sql.append( " WHERE T1.ARRIVE_DATE																							\n" );
				sql.append( " 			>=																												\n" );
//				sql.append( " /* 복귀일자가 조회일보다  3일 이상인 사업자 */													\n" );
				sql.append( " 			CAST(CAST((SUBSTR(T1.DEPART_DATE,1,4)||'-'||SUBSTR(T1.DEPART_DATE,5,2)||'-'||SUBSTR(T1.DEPART_DATE,7,2)) as date) + 3 day AS VARCHAR(100))  \n" );

		        if (!str1.equals("")) sql.append( "  AND T2.CLIENT_SID     = '"+str1+"'			\n");
				if (!str2.equals("")) sql.append( "  AND T1.DEPART_DATE = '"+str2+"'			\n");
				if (!str3.equals("")) sql.append( "  AND T3.CUST_NM LIKE '"+str3+"%'			\n");

//				sql.append( "   AND  T4.LSTAY_DEL = ''													\n ");
				sql.append( "  ORDER BY V1.CLIENT_NM, T3.CUST_NM									");
				//logger.dbg.println("bm022i_s01",sql.toString());
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