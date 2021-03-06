package sales.cm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class cm012i_s01 extends HttpServlet {

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

				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; }	 //차량번호
				String  str2	= req.getParameter("v_str2"); if (str2 == null) { str2 = ""; }	 //차대번호
				String  str3	= req.getParameter("v_str3"); if (str3 == null) { str3 = ""; }	 //현지번호

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
													"CARNO_SID",	"CAR_SID",	"CAR_NO",	 "CAR_DNO",	"CAR_RNO"
													};
					//파라미터 의미 : 자리수
					int[] intArrCN = new int[] {
													10,	10,	20,	10,	20
													};
					//파라미터 의미( -1:string, 0 : 정수, 1 : 소수점 1자리, 2: 소수점 2자리....
					int[] intArrCN2 = new int[]{
													0,		0,		-1,	-1,	-1
													};

					for (int i=0; i<strArrCN.length; i++) { // set column column
						switch ( intArrCN2[i] ) {
							case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
							default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
						}
					}

					if (!GauceReq.isBuilderRequest()) {					
							StringBuffer sql = new StringBuffer();

							sql.append( "	SELECT A.CARNO_SID, A.CAR_SID,									\n");
							sql.append( "				B.CAR_NO, A.CAR_DNO, A.CAR_RNO					\n");
							sql.append( "	FROM SALES.TCM150 A													\n");
							sql.append( "	INNER JOIN SALES.TCU050 B											\n");
							sql.append( "	ON A.CAR_SID = B.CAR_SID											\n");
							//sql.append( "	AND A.CAR_SID = ( SELECT CAR_SID FROM SALES.TCM150 GROUP BY CAR_SID ORDER BY CAR_SID DESC FETCH FIRST 1 ROWS ONLY )                            \n");
							sql.append( "	WHERE 1 = 1																	\n");
							if(!str1.equals(""))sql.append( "	  AND B.CAR_NO LIKE '%"+str1+"%'		\n");
							if(!str2.equals(""))sql.append( "	  AND A.CAR_DNO LIKE '%"+str2+"%'	\n");
							if(!str3.equals(""))sql.append( "	  AND A.CAR_RNO LIKE '%"+str3+"%'	\n");
							sql.append( "	ORDER BY A.CARNO_SID DESC										\n");
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