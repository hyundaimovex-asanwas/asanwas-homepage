// * 瞒樊 包府 : 瞒樊 包府(技何 炼雀) 
package sales.cm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class cm010i_s02 extends HttpServlet {

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

				String  str1	= GauceReq.getParameter("v_str1"); //CAR_SID

				if (str1==null || str1=="") str1 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
													"T1_CAR_SID",				"CAR_NO",		"CAR_TYPE",			"CAR_NM",					"CAR_FORM",
													"CAR_YEAR",					"CAR_CC",		"CAR_PERSONS",	"MAX_KG",					"CAR_TYPE_CD",
													"CAR_TYPE_CD_NAME",	"CAR_DNO",	"NORTH_YN",			"NORTH_YN_NAME",	"NORTH_DATE",
													"CLIENT_NM",				"TEAM_NM",	"CAR_SID",			"CLIENT_SID",			"TEAM_CD",
													"I_EMPNO",					"I_DATE",		"U_EMPNO",			"U_DATE"
												};

				int[] intArrCN = new int[] {	
					                              10,	30,	20,	32,	20,
					                               4,	5,		3,		5,		1,
					                              40,	20,	1,		40,	8,
					                              40,	40,	10,	15,	5,
					                              10,	10,	10,	10
												};

				int[] intArrCN2 = new int[]{
					                              0,	-1,	-1,	-1,	-1,
					                             -1,	0,		0,		0,		-1,
					                             -1,	-1,	-1,	-1,	-1,
					                             -1,	-1,	0,		-1,	-1,
					                             -1,	-1,	-1,	-1
												};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();

				sql.append( "     SELECT																			\n" );
				sql.append( "         (T1.CAR_SID) AS T1_CAR_SID									\n" );
				sql.append( "         , T1.CAR_NO																\n" );
				sql.append( "         , T1.CAR_TYPE															\n" );
				sql.append( "         , T1.CAR_NM																\n" );
				sql.append( "         , T1.CAR_FORM															\n" );
				sql.append( "         , T1.CAR_YEAR															\n" );
				sql.append( "         , IFNULL(T1.CAR_CC,0) AS CAR_CC								\n" );
				sql.append( "         , IFNULL(T1.CAR_PERSONS,0) AS CAR_PERSONS			\n" );
				sql.append( "         , IFNULL(T1.MAX_KG,0) AS MAX_KG								\n" );
				sql.append( "         , T1.CAR_TYPE_CD														\n" );
				sql.append( "         , SALES.FN_DETAIL_NM ( 'CU017',CAR_TYPE_CD) AS CAR_TYPE_CD_NAME	\n" );
				sql.append( "         , T1.CAR_DNO															\n" );
				sql.append( "         , T1.NORTH_YN															\n" );
				sql.append( "         , SALES.FN_DETAIL_NM ( 'CU018',NORTH_YN)    AS NORTH_YN_NAME			\n" );
				sql.append( "         , T1.NORTH_DATE														\n" );
				sql.append( "         , V1.CLIENT_NM															\n" );
				sql.append( "         , SALES.FN_DETAIL_NM ( 'CM003',T2.TEAM_CD) AS TEAM_NM						\n" );
				sql.append( "         , IFNULL(T2.CAR_SID,0) AS CAR_SID							\n" );
				sql.append( "         , T2.CLIENT_SID															\n" );
				sql.append( "         , T2.TEAM_CD															\n" );
				sql.append( "         , T2.I_EMPNO																\n" );
				sql.append( "         , T2.I_DATE																\n" );
				sql.append( "         , T2.U_EMPNO															\n" );
				sql.append( "         , T2.U_DATE																\n" );
				sql.append( "     FROM SALES.TCU050 T1													\n" );
				sql.append( "         LEFT JOIN SALES.TCM140 T2 ON T1.CAR_SID = T2.CAR_SID							\n" );
				sql.append( "         LEFT JOIN SALES.TCU030 V1 ON T2.CLIENT_SID = V1.CLIENT_SID					\n" );
				sql.append( "     WHERE T1.CAR_SID = "+str1+"																		\n" );

				//logger.dbg.println("cm010i_s02",sql.toString());
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