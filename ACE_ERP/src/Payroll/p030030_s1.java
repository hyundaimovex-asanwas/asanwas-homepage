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
public class p030030_s1 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "APPYY", "EMPNO", "C010", "C056", "C054D047",
					                                "C123",  "C124",  "D049", "D050", "C127", 
					                                "C128",  "C131",  "C132"
				                                };  
					                              
				int[] intArrCN = new int[]{  4,  7,  20,  11,	 11,  
					                          11, 11,	 11,  11,	 11,  
					                          11,	11,  11  
				                          }; 
			                      
				int[] intArrCN2 = new int[]{-1, -1, -1, 0,  0,
					                           0,  0,  0, 0,  0,
				                             0,  0,  0
				                          }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

          sql.append(" SELECT A.APPYY, A.EMPNO, A.C010, A.C056, A.C054+COALESCE(X.D047,0) C054D047,                            \n");
					sql.append("         A.C123, A.C124,  COALESCE(X.D049,0)D049, COALESCE(X.D050,0)D050, A.C127, A.C128,                \n");
					sql.append("        CASE WHEN A.C131_1=0 THEN A.C131 ELSE A.C131*-1 END C131,                                        \n");
					sql.append("        CASE WHEN A.C132_1=0 THEN A.C132 ELSE A.C132*-1 END C132                                         \n");
					sql.append("   FROM PAYROLL.YCW_C10 A                                                                                \n");
					sql.append("   LEFT JOIN ( SELECT B.APPYY, B.EMPNO, COALESCE(SUM(B.D047),0)D047, SUM(B.D049)D049, SUM(B.D050)D050    \n");
					sql.append("                 FROM PAYROLL.YCW_D10 B                                                                  \n");
					sql.append("                WHERE B.APPYY='" + str[0] + "'                                                           \n");
					sql.append("                GROUP BY B.APPYY, B.EMPNO                                                                \n");
					sql.append("              ) X ON A.APPYY = X.APPYY AND A.EMPNO = X.EMPNO                                             \n");
					sql.append("  WHERE A.APPYY='" + str[0] + "'                                                                         \n");


          logger.dbg.println(this,"sql::"+sql.toString());              
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