package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p030030_s2 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
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
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음

				String [] str= new String[1] ;
        str[0]  = req.getParameter("v_str1");   // 귀속년도

		  	for (int s=0;s<1;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "APPYY",
					                                "A001", "A002", "A003", "A004", "A005",
					                                "A006", "A007", "A008", "A009", "A010",
					                                "A011", "A012", "A013", "A014", "A015", "A016"
				                                };  
					                              
				int[] intArrCN = new int[]{  4, 
					                           1,   2,   3,   8,   1, 
					                           6,	 20,   4,	 10,  40,	
					                          30,  30,  15,   5,   3, 1067  
				                          }; 
			                      
				int[] intArrCN2 = new int[]{-1, 
					                          -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1,  -1,
				                            -1, -1, -1, -1,  -1,  -1
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
					sql.append("        A001,    A002,    A003,    A004,    A005,           \n");
					sql.append("        A006,    A007,    A008,    A009,    A010,           \n");
					sql.append("        A011,    A012,    A013,    A014,    A015,    A016   \n");
					sql.append("   FROM PAYROLL.YCW_A10                                     \n");	
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