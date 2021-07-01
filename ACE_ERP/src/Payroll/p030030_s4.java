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
public class p030030_s4 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "APPYY",	"WRKGB",	"EMPNO",	
																					"C001",	"C002",	"C003",	"C004",	"C005",	"C006",	"C007",	"C008",	"C009",	"C010",	
																					"C011",	"C012",	"C013",	"C014",	"C015",	"C016",	"C017",	"C018",	"C019",	"C020",	
																					"C021",	"C022",	"C023",	"C024",	"C025",	"C026",	"C027",	"C028",	"C042",	"C045",	
																					"C054",	"C055",	"C056",	"C057",	"C058",	"C059",	"C060",	
																					"C061",	"C062",	"C063",	"C064",	"C065",	"C066",	"C067",	"C068",	"C069",	"C070",	
																					"C071",	"C072",	"C073",	"C074",	"C075",	
																					"C081",	"C082",	"C083",	"C084",	"C085",	"C086",	"C087",	"C088",	"C089",	"C090",	
																					"C091",	"C092",	"C093",	"C094",	"C095",	"C096",	"C097",	"C098",	"C099",	"C100",	
																					"C101",	"C102",	"C103",	"C104",	"C105",	"C106",	"C107",	"C108",	"C109",	"C110",	
																					"C111",	"C112",	"C113",	"C114",	"C115",	"C116",	"C117",	"C118",	"C119",	"C120",	
																					"C121",	"C122",	"C123",	"C124",	"C125",	"C126",	"C127",	"C128",	"C129",	"C130",	
																					"C131_1","C131","C132_1","C132","C133_1","C133","C134_1","C134","C135"
				                                };  
					                              
				int[] intArrCN = new int[]{ 4,	1,	7,	
																		1,	2,	3,	 6, 10, 2,	1,	2,	1,  30,	
																		1,	13,	 2,	 1,	 1,	10,	40,	8,	8,	8,	
																		8,	11,	11,	11,	11,	11,	22, 11,	10,	10,	
																		10,	10,	11,	10,	11,	8,	8,	
																		2,	8,	2,	8,	2,	8,	8,	2,	8,	2,	
																		8,	10,	2,	8,	10,
																		10,	10,	10,	10,	10,	10,	8,	8,	8,	8,	
																		10,	20,	10,	8,	11,	8,	8,	10,	10,	10,	
																		10,	10,	10,	8,	10,	10,	10,	10,	10,	11,	
																		10,	10,	10,	10,	10,	10,	10,	10,	10,	10,	
																		10,	10,	10,	10,	10,	10,	10,	10,	10,	10,	
																		1,	10,	1,	10,	1,	10,	1,	10,	1245

				                          }; 
			                      
				int[] intArrCN2 = new int[]{-1, -1, -1,
					                          -1, -1, -1, -1, -1, -1, -1, -1, -1,  -1,
 				                            -1, -1, -1, -1, -1, -1, -1, -1, -1,  -1, 
					                          -1, -1, -1, -1, -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1, -1, -1, -1, 
					                          -1, -1, -1, -1, -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1, -1,
					                          -1, -1, -1, -1, -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1, -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1, -1, -1, -1, -1, -1,  -1,
                                    -1, -1, -1, -1, -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1, -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1, -1, -1, -1, -1, -1
				                          }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

          sql.append(" SELECT                                                                            \n");
					sql.append("     APPYY,  WRKGB,  EMPNO,                                                        \n");
					sql.append("     C001,   C002,   C003,   C004,   C005,   C006,   C007,   C008,   C009,   C010, \n");
					sql.append("     C011,   C012,   C013,   C014,   C015,   C016,   C017,   C018,   C019,   C020, \n");
					sql.append("     C021,   C022,   C023,   C024,   C025,   C026,   C027,   C028,   C042,   C045, \n");
					sql.append("     C054,   C055,   C056,   C057,   C058,   C059,   C060,                         \n");	
					sql.append("     C061,   C062,   C063,   C064,   C065,   C066,   C067,   C068,   C069,   C070, \n");
					sql.append("     C071,   C072,   C073,   C074,   C075,                                         \n");
					sql.append("     C081,   C082,   C083,   C084,   C085,   C086,   C087,   C088,   C089,   C090, \n");
					sql.append("     C091,   C092,   C093,   C094,   C095,   C096,   C097,   C098,   C099,   C100, \n");
					sql.append("     C101,   C102,   C103,   C104,   C105,   C106,   C107,   C108,   C109,   C110, \n");
					sql.append("     C111,   C112,   C113,   C114,   C115,   C116,   C117,   C118,   C119,   C120, \n");
					sql.append("     C121,   C122,   C123,   C124,   C125,   C126,   C127,   C128,   C129,   C130, \n");
					sql.append("     C131_1, C131,   C132_1, C132,   C133_1, C133,   C134_1, C134,   C135          \n");
					sql.append("   FROM PAYROLL.YCW_C10                                                            \n");
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