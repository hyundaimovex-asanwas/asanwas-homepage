// * 기타관리 : 진료일자관리(조회)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm061i_s01 extends HttpServlet {

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
														"CLIENT_NM",			"TEAM_NM",				"CUST_NM",		"MEDI_SID",		"MEDI_CT",
														"CUST_SID",				"WORK_NO",				"NAME",				"MEDI_FEE",		"DISEASE_NAME",
														"TREAT_CONTENT",	"MEDI_DATE",			"CALC_YN",		"I_EMPNO" ,		"I_DATE",
														"U_EMPNO",				"U_DATE"
																}; 

				int[] intArrCN = new int[] {	
					                            62,	62,	40,	10,	1,
												10,	20,	15,	3,		20,
												100,	8,		1,		10,	10,
												10,	10
												};

				int[] intArrCN2 = new int[]{
					                            -1,	-1,	-1,	0,		-1,
												0,		-1,	-1,	1,		-1,
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

				sql.append( " SELECT																\n" );
				sql.append( "         T3.MEDI_SID,												\n" );
				sql.append( "         V1.CLIENT_NM,											\n" );
				sql.append( "         SALES.FN_DETAIL_NM ( 'CM003',T2.TEAM_CD) AS TEAM_NM,    \n" );
//				sql.append( "         T2.WORK_NO,											\n" );
				sql.append( "         T1.CUST_NM,											\n" );
				sql.append( "         T3.MEDI_CT,												\n" );
				sql.append( "         T3.CUST_SID,											\n" );
				sql.append( "         T3.WORK_NO,											\n" );
				sql.append( "         T3.NAME,													\n" );
				sql.append( "         T3.MEDI_FEE,											\n" );
				sql.append( "         T3.DISEASE_NAME,									\n" );
				sql.append( "         T3.TREAT_CONTENT,									\n" );
				sql.append( "         T3.MEDI_DATE,											\n" );
				sql.append( "         T3.CALC_YN,												\n" );
				sql.append( "         T3.I_EMPNO,												\n" );
				sql.append( "         T3.I_DATE,												\n" );
				sql.append( "         T3.U_EMPNO,												\n" );
				sql.append( "         T3.U_DATE												\n" );
				sql.append( " FROM SALES.TCM110 T3																	\n" );
				sql.append( "         INNER JOIN SALES.TCU010 T1 ON T3.CUST_SID = T1.CUST_SID	\n" );
				sql.append( "         LEFT JOIN SALES.TCM010 T2														\n" );
				sql.append( "                 LEFT JOIN SALES.TCU030 V1												\n" );
				sql.append( "                         ON T2.CLIENT_SID = V1.CLIENT_SID							\n" );
				sql.append( "         ON T3.CUST_SID = T2.CUST_SID												\n" );
				sql.append( " WHERE 1=1																						\n" );

				if (!str1.equals("")) sql.append( "  AND T3.MEDI_DATE >= '"+str1+"'							\n");
				if (!str1.equals("")) sql.append( "  AND T3.MEDI_DATE <= '"+str2+"'								");
				sql.append( " ORDER BY T1.CUST_NM  ");
		        //logger.dbg.println("bm061i_s01",sql.toString());
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