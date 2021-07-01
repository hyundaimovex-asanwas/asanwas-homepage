//**�������. delete,update�Ҷ��� where�� ���Ŀ� primary key �÷��� �� �߰��ؼ� ���ش�***
package northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class KS_Em023_S2 extends HttpServlet{

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
				//	logger.dbg.println(this, "�o��?");		
/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
 				// ������������ ���ǰ��� �Ѱܹ���
	


				// ������������ ���ǰ��� �Ѱܹ���
				String  str1	= req.getParameter("v_str1");   // ����
				String  str2	= req.getParameter("v_str2");   // ����


				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{  "HOL_SUM"	}; 

				int[] intArrCN = new int[] {		2		}; 
			
				int[] intArrCN2 = new int[]{		-1		}; 


				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

							sql.append( " SELECT MAX(HOL_SUM)   AS HOL_SUM													\n")
								.append( " FROM NORTHHR.KST160																			\n")
								.append( " WHERE																										\n")
								.append( "	  HOL_GB = '1'																							\n")
								.append( "	  AND HOL_DT BETWEEN  '"+str1+"0101"+"' AND 	'"+str1+"1231"+"'		\n")
								.append( "	  AND EMPNO = '"+str2+"'																			\n");

						stmt = conn.getGauceStatement(sql.toString());  
  	 					stmt.executeQuery(dSet);
					

				


/******************************** **********************************************
 * 
 *********************************************************************************/
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