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
public class p030030_s6 extends HttpServlet {

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

				String[] strArrCN = new String[]{   "APPYY",	"WRKGB",	"EMPNO",	
																						"E001",	"E002",	"E003",	"E004",	"E005",	"E006",	"E007",	"E008",	"E009",	"E010",	
																						"E011",	"E012",	"E013",	"E014",	"E015",	"E016",	"E017",	"E018",	"E019",	"E020",	
																						"E021",	"E022",	"E023",	"E024",	"E025",	"E026",	"E027",	"E028",	"E029",	"E030",	
																						"E031",	"E032",	"E033",	"E034",	"E035",	"E036",	"E037",	"E038",	"E039",	"E040",	
																						"E041",	"E042",	"E043",	"E044",	"E045",	"E046",	"E047",	"E048",	"E049",	"E050",	
																						"E051",	"E052",	"E053",	"E054",	"E055",	"E056",	"E057",	"E058",	"E059",	"E060",	
																						"E061",	"E062",	"E063",	"E064",	"E065",	"E066",	"E067",	"E068",	"E069",	"E070",	
																						"E071",	"E072",	"E073",	"E074",	"E075",	"E076",	"E077",	"E078",	"E079",	"E080",	
																						"E081",	"E082",	"E083",	"E084",	"E085",	"E086",	"E087",	"E088",	"E089",	"E090",	
																						"E091",	"E092",	"E093",	"E094",	"E095",	"E096",	"E097",	"E098",	"E099",	"E100",	
																						"E101",	"E102",	"E103",	"E104",	"E105",	"E106",	"E107",	"E108",	"E109",	"E110",	
																						"E111",	"E112",	"E113",	"E114",	"E115",	"E116",	"E117",	"E118",	"E119",	"E120",	
																						"E121",	"E122",	"E123"
					                               };  
					                              
				int[] intArrCN = new int[]{ 4,	1,	7,	
																		1,	2,	3,	6,	10,	13,	1,	1,	20,	13,
																		1,	1,	1,	1,	1,	1,	10,	10,	10,	10,	
																		10,	10,	10,	10,	10,	10,	10,	10,	10,	1,	
																		1,	20,	13,	1,	1,	1,	1,	1,	1,	10,	
																		10,	10,	10,	10,	10,	10,	10,	10,	10,	10,	
																		10,	10,	1,	1,	20,	13,	1,	1,	1,	1,	
																		1,	1,	10,	10,	10,	10,	10,	10,	10,	10,	
																		10,	10,	10,	10,	10,	1,	1,	20,	13,	1,	
																		1,	1,	1,	1,	1,	10,	10,	10,	10,	10,	
																		10,	10,	10,	10,	10,	10,	10,	10,	1,	1,	
																		20,	13,	1,	1,	1,	1,	1,	1,	10,	10,	
																		10,	10,	10,	10,	10,	10,	10,	10,	10,	10,	
																		10,	2,	353

				                          }; 
			                      
				int[] intArrCN2 = new int[]{-1, -1, -1,
					                          -1, -1, -1, -1,  -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1,  -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1,  -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1,  -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1,  -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1,  -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1,  -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1,  -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1,  -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1,  -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1,  -1, -1, -1, -1, -1,  -1,
					                          -1, -1, -1, -1,  -1, -1, -1, -1, -1,  -1,
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

          sql.append("SELECT                                                        \n");
					sql.append("	APPYY,	WRKGB,	EMPNO,	                                    \n");
					sql.append("	E001,	E002,	E003,	E004,	E005,	E006,	E007,	E008,	E009,	E010,	\n");
					sql.append("	E011,	E012,	E013,	E014,	E015,	E016,	E017,	E018,	E019,	E020,	\n");
					sql.append("	E021,	E022,	E023,	E024,	E025,	E026,	E027,	E028,	E029,	E030,	\n");
					sql.append("	E031,	E032,	E033,	E034,	E035,	E036,	E037,	E038,	E039,	E040,	\n");
					sql.append("	E041,	E042,	E043,	E044,	E045,	E046,	E047,	E048,	E049,	E050,	\n");
					sql.append("	E051,	E052,	E053,	E054,	E055,	E056,	E057,	E058,	E059,	E060,	\n");
					sql.append("	E061,	E062,	E063,	E064,	E065,	E066,	E067,	E068,	E069,	E070,	\n");
					sql.append("	E071,	E072,	E073,	E074,	E075,	E076,	E077,	E078,	E079,	E080,	\n");
					sql.append("	E081,	E082,	E083,	E084,	E085,	E086,	E087,	E088,	E089,	E090,	\n");
					sql.append("	E091,	E092,	E093,	E094,	E095,	E096,	E097,	E098,	E099,	E100,	\n");
					sql.append("	E101,	E102,	E103,	E104,	E105,	E106,	E107,	E108,	E109,	E110,	\n");
					sql.append("	E111,	E112,	E113,	E114,	E115,	E116,	E117,	E118,	E119,	E120,	\n");
					sql.append("	E121,	E122,	E123                                           \n");
					sql.append(" FROM PAYROLL.YCW_E10                                         \n");
					sql.append("  WHERE APPYY='" + str[0] + "'                                \n");	       
					sql.append("  ORDER BY E004,E122   \n");	        


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