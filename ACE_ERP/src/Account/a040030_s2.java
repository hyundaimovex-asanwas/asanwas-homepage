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
public class a040030_s2 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");
				String  str2    = req.getParameter("v_str2");
				String  str3	= req.getParameter("v_str3");
        
				int str4 = Integer.parseInt(str3);
				if(str4 < 10) str3 = "0"+str3 ;
				else str3=str3;

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE", "YEAR", "MOON",	"DAY", "WORKCLOSE", "SLPCLOSE",  "ACTCLOSE","BGTCLOSE"}; 

				int[] intArrCN = new int[] { 2,   4,   2,	1,   1,   1,    1, 1
				                                  }; 
			
				int[] intArrCN2 = new int[]{-1,  -1,   -1,  0,  -1,   -1,    -1,-1
				                                    };

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				

				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
 
					sql.append( "	SELECT A.FDCODE,A.YEAR,A.MOON, " );                             
					sql.append( "	TO_NUMBER(A.DAY) AS DAY,   " );
					sql.append( "	A.WORKCLOSE AS WORKCLOSE,  " );
					sql.append( "	A.SLPCLOSE AS SLPCLOSE,   " );
					sql.append( "	A.ACTCLOSE AS ACTCLOSE,   " );
					sql.append( "	A.BGTCLOSE AS BGTCLOSE   " );               
					sql.append( "	FROM ACCOUNT.SLIPCLOSE A, ACCOUNT.FIELDCODE B    " );                      
					sql.append( "	WHERE A.FDCODE = B.FDCODE     " );
					sql.append( "	AND  15 < A.DAY AND  A.DAY < 32    " );     
					sql.append( "	AND A.FDCODE = '"+str1+"'    " );                      
				    sql.append( "	AND A.YEAR = '"+str2+"'      " );                     
					sql.append( "	AND A.MOON = '"+str3+"'     " );                 
					sql.append( "	order by  DAY asc   " );

					System.out.println("a040030_s2"+sql.toString());
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