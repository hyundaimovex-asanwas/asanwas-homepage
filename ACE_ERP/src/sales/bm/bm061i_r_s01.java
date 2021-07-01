// 기타관리 : 진료일지 관리 팝업(인원조회)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class bm061i_r_s01 extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
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
				String  str1	= GauceReq.getParameter("v_str1"); //사업자/관광객
				String  str2	= GauceReq.getParameter("v_str2"); //실무번호
				String  str3	= GauceReq.getParameter("v_str3"); //성명

				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";
				if (str3==null || str3=="") str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{	"CUST_SID",		"CLIENT_NM",		"TEAM_NM",		"WORK_NO",		"CUST_NM"	};

				int[] intArrCN = new int[] {	10,	62,	62,	20,	40	 	};

				int[] intArrCN2 = new int[]{	 	0,		-1,	-1,	-1,	-1		};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				StringBuffer sql = new StringBuffer();
//logger.dbg.println("str1:",str1);
				sql.append( "     SELECT																							\n" );
				sql.append( "         T1.CUST_SID, V1.CLIENT_NM,														\n" );
				sql.append( "         SALES.FN_DETAIL_NM ( 'CM003',T2.TEAM_CD) AS TEAM_NM,		\n" );
				if(str1.equals("1")){
					sql.append( "         T1.MANAGE_NO AS WORK_NO,												\n" );
					sql.append( "         T1.CUST_NM																			\n" );
					sql.append( "     FROM SALES.TCU010 T1  LEFT													\n" );
				}
				else
				{
					sql.append( "         T2.WORK_NO,																		\n" );
					sql.append( "         T1.CUST_NM																			\n" );
					sql.append( "     FROM SALES.TCU010 T1  INNER													\n" );
				}
				sql.append( "          JOIN SALES.TCM010 T2																\n" );
				sql.append( "             LEFT JOIN SALES.TCU030 V1													\n" );
				sql.append( "                 ON T2.CLIENT_SID = V1.CLIENT_SID									\n" );
				sql.append( "         ON T1.CUST_SID = T2.CUST_SID												\n" );
				sql.append( "         AND T1.CUST_GU = '"+str1+"'														\n" );
				sql.append( "     WHERE 1=1																					\n" );

				if (!str2.equals("")) sql.append( "  AND T2.WORK_NO = '"+str2+"'								\n");
				if (!str3.equals("")) sql.append( "  AND T1.CUST_NM = '"+str3+"'								\n");

				sql.append( "  ORDER BY T1.CUST_NM																			");
				//logger.dbg.println("bm061i_r_s01",sql.toString());
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