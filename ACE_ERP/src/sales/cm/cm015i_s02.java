package sales.cm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class cm015i_s02 extends HttpServlet {

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

				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; }	 //CARNO_SID

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
													"REPAIR_SID",				"CARNO_SID",				"CUST_SID",					"CUST_NM",					"RR_DATE",
													"WH_DATE",					"OWH_DATE",				"REPAIR_FEE",				"REPAIR_CAUSE",			"REPAIR_CONTENT1",
													"REPAIR_CONTENT2",		"REPAIR_CONTENT3",		"REPAIR_CONTENT4",		"REPAIR_CONTENT5",		"CALC_YN"
													};
					//파라미터 의미 : 자리수
					int[] intArrCN = new int[] {
													10,	10,	10,	20,	8,		8,
													8,		4,		50,	100,	100,	100,
													100, 100,	1
													};
					//파라미터 의미( -1:string, 0 : 정수, 1 : 소수점 1자리, 2: 소수점 2자리....
					int[] intArrCN2 = new int[]{
													0,		0,		0,		-1,	-1,
													-1,	-1,	1,		-1,	-1,
													-1,	-1,	-1,	-1,	-1
													};

					for (int i=0; i<strArrCN.length; i++) { // set column column
						switch ( intArrCN2[i] ) {
							case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
							default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
						}
					}

					if (!GauceReq.isBuilderRequest()) {					
							StringBuffer sql = new StringBuffer();

							sql.append( "	SELECT		A.REPAIR_SID, A.CARNO_SID, A.CUST_SID, B.CUST_NM, A.RR_DATE, A.WH_DATE, A.OWH_DATE,	\n");
							sql.append( "					A.REPAIR_FEE, A.REPAIR_CAUSE, A.REPAIR_CONTENT1, A.REPAIR_CONTENT2,								\n");
							sql.append( "					A.REPAIR_CONTENT3, A.REPAIR_CONTENT4, A.REPAIR_CONTENT5, A.CALC_YN								\n");
							sql.append( "	FROM SALES.TCM190 A												\n");
							sql.append( "		INNER JOIN SALES.TCU010 B									\n");
							sql.append( "		ON A.CUST_SID = B.CUST_SID								\n");
							if(!str1.equals(""))sql.append( "	WHERE A.CARNO_SID = "+str1+"		\n");
							sql.append( "	ORDER BY A.REPAIR_SID DESC										");

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