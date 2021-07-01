//주유 이력
package sales.cm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class cm012i_s02 extends HttpServlet {

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

				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; }	 //차량SID

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
													"OILING_SID",	"CARNO_SID",	"OILING_QTY",	"OILING_PRICE",		"CALC_YN",
													"OILING_DATE",	"OIL_TYPE",		"CAR_SID",		"CAR_NO",				"CAR_DNO",
													"CAR_RNO",		"USEP",				"USEPNM"
													};
					//파라미터 의미 : 자리수
					int[] intArrCN = new int[] {
													10,	20,	10,	20,	10,
													10,	10,	10,	25,	10,
													10,	3,		50
													};
					//파라미터 의미( -1:string, 0 : 정수, 1 : 소수점 1자리, 2: 소수점 2자리....
					int[] intArrCN2 = new int[]{
													0,		-1,	-1,	-1,	-1,
													-1,	-1,	-1,	-1,	-1,
													-1,	 -1,	-1
													};

					for (int i=0; i<strArrCN.length; i++) { // set column column
						switch ( intArrCN2[i] ) {
							case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
							default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
						}
					}

					if (!GauceReq.isBuilderRequest()) {
							StringBuffer sql = new StringBuffer();

							sql.append( "	SELECT		A.OILING_SID, A.CARNO_SID, A.OILING_QTY, A.OILING_PRICE,			\n");
							sql.append( "					A.CALC_YN, A.OILING_DATE, RTRIM(A.OIL_TYPE) OIL_TYPE,				\n");
							sql.append( "					 B.CAR_SID, C.CAR_NO, B.CAR_DNO, B.CAR_RNO, A.USEP,				\n");
							sql.append( "					 SALES.FN_DETAIL_NM ( 'CM026',A.USEP) AS USEPNM						\n");
							sql.append( "	FROM SALES.TCM160 A																					\n");
							sql.append( "	INNER JOIN SALES.TCM150 B																			\n");
							sql.append( "	INNER JOIN SALES.TCU050 C																			\n");
							sql.append( "			ON B.CAR_SID = C.CAR_SID																	\n");
							sql.append( "	ON A.CARNO_SID = B.CARNO_SID																	\n");
							if(!str1.equals(""))sql.append( "	WHERE A.CARNO_SID = "+str1+"											\n");
							sql.append( "	ORDER BY A.OILING_SID DESC																			\n");

							//logger.dbg.println(this,sql.toString());
							stmt = conn.getGauceStatement(sql.toString());

						stmt.executeQuery(dSet);
					}

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