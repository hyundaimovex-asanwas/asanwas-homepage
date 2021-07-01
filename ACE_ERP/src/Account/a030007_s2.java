package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.
public class a030007_s2 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// ���������� ���� ���۹���� Post Ÿ���� ���
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

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String  str1	= req.getParameter("v_str1"); //�����ڵ�
				String  str2    = req.getParameter("v_str2"); //�����

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ACTDAT", "TOTAL", "FSNBR1", "FSNBR2" }; 

				int[] intArrCN = new int[]{   8,  15, 15, 15 }; 
			
				int[] intArrCN2 = new int[]{ -1,  0, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT SUBSTR(A.ACTDAT,1,6) ACTDAT, COUNT(*) TOTAL, MIN(SSDAT) || MIN(A.SSNBR) FSNBR1, MAX(SSDAT) || MAX(A.SSNBR) FSNBR2 " );
					sql.append( "  FROM ACCOUNT.FSLIPMST A 										" );
					sql.append( "  WHERE SUBSTR(A.ACTDAT,1,6) = '" + str2 + "' 				" );
					if(!str1.equals("")) sql.append( " AND A.FDCODE = '" + str1 + "' 				" );
					sql.append( "  AND A.FSSTAT = 'Y' 														" );
					sql.append( "  GROUP BY SUBSTR(A.ACTDAT,1,6) 								" );
					sql.append( "  ORDER BY 1 																" );
					
					//logger.dbg.println(this,sql.toString());
					
/*********************************************************************************************/

		      stmt = conn.getGauceStatement(sql.toString());
	 		  stmt.executeQuery(dSet);
				}
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