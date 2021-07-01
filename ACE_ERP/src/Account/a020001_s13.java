package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class a020001_s13 extends HttpServlet {
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
				String [] str = new String [4];
				str[0]	= req.getParameter("v_str1");		//FDCODE
				str[1]	= req.getParameter("v_str2");		//FSDAT
				str[2]	= req.getParameter("v_str3");		//FSNBR

				for (int s=0;s<=2;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

			  String[] strArrCN = new String[]{ "FDCODE","DAT","NBR","FSSTAT" };                              
       
				int[] intArrCN = new int[]{2, 9, 6 , 1}; 

				int[] intArrCN2 = new int[]{-1, -1, -1, -1};
																	 
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
				
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT DISTINCT A.FDCODE,A.TSDAT AS DAT , A.TSNBR AS NBR, B.FSSTAT  		\n");
					sql.append( "   FROM ACCOUNT.BANJAEREL A, ACCOUNT.FSLIPMST B                        			\n");
					sql.append( "  WHERE A.TSDAT = B.FSDAT                                              							\n");
					sql.append( "    AND A.TSNBR = B.FSNBR                                              								\n");
					sql.append( "    AND A.FDCODE = '"+str[0]+"'                                        								\n");
					sql.append( "    AND A.TSDAT = '"+str[1]+"'                                         									\n");
					sql.append( "    AND A.TSNBR ='"+str[2]+"'                                          									\n");
					sql.append( "  UNION ALL                                                            										\n");
					sql.append( "  SELECT A.FDCODE,A.BTSDAT AS DAT, A.BTSNBR AS NBR, B.FSSTAT           		\n");
					sql.append( "    FROM ACCOUNT.BANJAEREL A, ACCOUNT.FSLIPMST B                       			\n");
					sql.append( "  WHERE A.BTSDAT = B.FSDAT                                             							\n");
					sql.append( "    AND A.BTSNBR = B.FSNBR                                             								\n");
					sql.append( "    AND A.FDCODE = '"+str[0]+"'                                        								\n");
					sql.append( "    AND A.BTSDAT = '"+str[1]+"'                                        								\n");
					sql.append( "    AND A.BTSNBR ='"+str[2]+"'                                        	 								\n");

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