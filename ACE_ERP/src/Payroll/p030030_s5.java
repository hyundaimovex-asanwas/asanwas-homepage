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
public class p030030_s5 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "APPYY", "WRKGB", "EMPNO",
					                                "D001", "D002", "D003", "D004", "D005", "D006", "D007", "D008", "D009", "D010",
					                                "D011", "D012", "D013", "D014", "D015", "D016", "D017", "D018", "D019", "D020",
					                                "D021", "D035", "D036", "D038", "D047", "D048", "D049", "D050",
					                                "D051", "D052", "D053", "D054"                           
					                               };  
					                              
				int[] intArrCN = new int[]{ 4,   1,	 7,	
					                          1,	 2,  3,	 6,	10, 50,  13, 	 1, 40,	10,	
																		8,	 8,	 8,	 8,	11, 11,  11,	11,	11,	22,	
																		11,	10,	10,	10,	10,	10,	 10,	10,	
					                          10,	10,	2,	677
				                          }; 
			                      
				int[] intArrCN2 = new int[]{-1, -1, -1,
					                          -1, -1, -1, -1,  -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1,  -1, -1, -1, -1, -1,  -1,
				                            -1, -1, -1, -1,  -1, -1, -1, -1, 
					                          -1, -1, -1, -1
				                          }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

          sql.append("SELECT                                                                            \n");
					sql.append("    APPYY,  WRKGB,  EMPNO,                                                        \n");
					sql.append("    D001,   D002,   D003,   D004,   D005,   D006,   D007,   D008,   D009,   D010, \n");
					sql.append("    D011,   D012,   D013,   D014,   D015,   D016,   D017,   D018,   D019,   D020, \n");
					sql.append("    D021,   D035,   D036,   D038,   D047,   D048,   D049,   D050,                 \n");
					sql.append("    D051,   D052,   D053,   D054                                                  \n");
					sql.append("  FROM PAYROLL.YCW_D10                                                            \n");
					sql.append("  WHERE APPYY='" + str[0] + "'                                                    \n");	       
					sql.append("  ORDER BY D004   \n");	        
   
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