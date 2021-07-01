package sales.menu.cm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class cm014i_s03 extends HttpServlet {

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

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
													"VIOL_SID",			"CARNO_SID",		"WORK_NO",		"VIOL_DATE",		"VIOL_PLACE",
													"VIOL_CONTENT",	"BLACK_MARK",		"VIOL_FU"
														};
					//�Ķ���� �ǹ� : �ڸ���
					int[] intArrCN = new int[] { 10, 10, 20, 8, 30, 30, 3, 100
																				}; 
					//�Ķ���� �ǹ�( -1:string, 0 : ����, 1 : �Ҽ��� 1�ڸ�, 2: �Ҽ��� 2�ڸ�....
					int[] intArrCN2 = new int[]{ 0, 0, -1, -1, -1, -1, 0, -1
																				}; 

					for (int i=0; i<strArrCN.length; i++) { // set column column 
						switch ( intArrCN2[i] ) { 
							case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
							default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
						} 
					} 

					if (!GauceReq.isBuilderRequest()) {					
							StringBuffer sql = new StringBuffer();

							sql.append( "	SELECT		VIOL_SID, CARNO_SID, WORK_NO, VIOL_DATE, VIOL_PLACE,		\n");
							sql.append( "					VIOL_CONTENT, BLACK_MARK, VIOL_FU					\n");
							sql.append( "	FROM SALES.TCM180                             \n");
							sql.append( "	ORDER BY VIOL_SID DESC                            \n");

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