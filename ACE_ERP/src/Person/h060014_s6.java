package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.
public class h060014_s6 extends HttpServlet {

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

			String [] str = new String [2];

				str[0]	= req.getParameter("v_str1");		//������� 
				str[1]	= req.getParameter("v_str2");		//

				for (int s=0;s<=1;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EVAYM","EMPNOH","EMPNMK","SUBMITST","WRDT","WRID"
																				 }; 

				int[] intArrCN = new int[] {  6,   7,  30,   1,  10,  10
				                           }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1
				                           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					

					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.EVAYM,  A.EMPNOH,  B.EMPNMK,  A.SUBMITST,  A.WRDT,  A.WRID          \n ");
					sql.append( "   FROM PAYROLL.HVCLOSE A                                                     \n ");
					sql.append( "   LEFT JOIN PAYROLL.YIPERSON B ON A.EMPNOH = B.EMPNO                         \n ");
					if(!str[0].equals(""))sql.append( "  WHERE A.EVAYM  ='"+str[0]+"'                          \n ");
					if(!str[1].equals(""))sql.append( "    AND A.EMPNOH ='"+str[1]+"'                          \n ");
					sql.append( "  ORDER BY A.EVAYM, A.EMPNOH \n ");
					
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