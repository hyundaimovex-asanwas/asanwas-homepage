package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class p030030_s3 extends HttpServlet {

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

				String [] str= new String[1] ;
        str[0]  = req.getParameter("v_str1");   // �ͼӳ⵵

		  	for (int s=0;s<1;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "APPYY",
					                                "B001", "B002", "B003", "B004", "B005",
					                                "B006", "B007", "B008", "B009", "B010",
					                                "B011", "B012", "B013", "B014", "B015",
					                                "B016", "B017", "B018"
				                                };  
					                              
				int[] intArrCN = new int[]{  4, 
					                           1,   2,   3,   6,  10, 
					                          40,	 30,  13, 	7,   7,	
					                          14,  13,  13,  13,  13, 
					                          13,   1,  1046  
				                          }; 
			                      
				int[] intArrCN2 = new int[]{-1, 
					                          -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1,  -1,
				                            -1, -1, -1, -1,  -1, 
					                          -1, -1, -1
				                          }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

          sql.append(" SELECT APPYY,                                              \n");
					sql.append("        B001,    B002,    B003,    B004,    B005,           \n");
					sql.append("        B006,    B007,    B008,    B009,    B010,           \n");
					sql.append("        B011,    B012,    B013,    B014,    B015,           \n");
					sql.append("        B016,    B017,    B018                              \n");
					sql.append("   FROM PAYROLL.YCW_B10                                     \n");	
					sql.append("  WHERE APPYY='" + str[0] + "'                              \n");	                                          
   
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