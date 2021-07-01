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
public class p030030_s7 extends HttpServlet {

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

				String[] strArrCN = new String[]{   "APPYY",	"WRKGB",	"EMPNO",	"SEQ",	
																						"F001",	"F002",	"F003",	"F004",	"F005",	"F006",	"F007",	"F008",	"F009",	"F010",	
																						"F011",	"F012",	"F013",	"F014",	"F015",	"F016",	"F017",	"F018",	"F019",	"F020",	
																						"F021",	"F022",	"F023",	"F024",	"F025",	"F026",	"F027",	"F028",	"F029",	"F030",	
																						"F031",	"F032",	"F033",	"F034",	"F035",	"F036",	"F037",	"F038",	"F039",	"F040",	
																						"F041",	"F042",	"F043",	"F044",	"F045",	"F046",	"F047",	"F048",	"F049",	"F050",	
																						"F051",	"F052",	"F053",	"F054",	"F055",	"F056",	"F057",	"F058",	"F059",	"F060",	
																						"F061",	"F062",	"F063",	"F064",	"F065",	"F066",	"F067",	"F068",	"F069",	"F070",	
																						"F071",	"F072",	"F073",	"F074",	"F075",	"F076",	"F077",	"F078",	"F079",	"F080",	
																						"F081",	"F082",	"F083",	"F084",	"F085",	"F086",	"F087",	"F088",	"F089",	"F090",	
																						"F091",	"F092",	"F093",	"F094",	"F095",	"F096",	"F097",	"F098",	"F099",	"F100",	
																						"F101",	"F102",	"F103",	"F104",	"F105",	"F106",	"F107",	"F108",	"F109",	"F110",	
																						"F111",	"F112"
					                               };  
					                              
				int[] intArrCN = new int[]{ 4,	1,	7,	4,	
																		1,	2,	3,	6,	10,	13,	2,	3,	30,	25,
																		2,	10,	10,	2,	3,	30,	25,	2,	10,	10,	
																		2,	3,	30,	25,	2,	10,	10,	2,	3,	30,	
																		25,	2,	10,	10,	2,	3,	30,	25,	2,	10,	
																		10,	2,	3,	30,	25,	2,	10,	10,	2,	3,	
																		30,	25,	2,	10,	10,	2,	3,	30,	25,	2,	
																		10,	10,	2,	3,	30,	25,	2,	10,	10,	2,	
																		3,	30,	25,	2,	10,	10,	2,	3,	30,	25,	
																		2,	10,	10,	2,	3,	30,	25,	2,	10,	10,	
																		2,	3,	30,	25,	2,	10,	10,	2,	3,	30,	
																		25,	2,	10,	10,	2,	3,	30,	25,	2,	10,	
																		10,	55
				                          }; 
			                      
				int[] intArrCN2 = new int[]{-1, -1, -1, -1,
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
					                          -1, -1
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
					sql.append("     APPYY,  WRKGB,  EMPNO,  SEQ,                                                  \n");
					sql.append("	    F001,   F002,   F003,   F004,   F005,   F006,   F007,   F008,   F009,   F010,\n");
					sql.append("	    F011,   F012,   F013,   F014,   F015,   F016,   F017,   F018,   F019,   F020,\n");
					sql.append("	    F021,   F022,   F023,   F024,   F025,   F026,   F027,   F028,   F029,   F030,\n");
					sql.append("	    F031,   F032,   F033,   F034,   F035,   F036,   F037,   F038,   F039,   F040,\n");
					sql.append("	    F041,   F042,   F043,   F044,   F045,   F046,   F047,   F048,   F049,   F050,\n");
					sql.append("	    F051,   F052,   F053,   F054,   F055,   F056,   F057,   F058,   F059,   F060,\n");
					sql.append("	    F061,   F062,   F063,   F064,   F065,   F066,   F067,   F068,   F069,   F070,\n");
					sql.append("	    F071,   F072,   F073,   F074,   F075,   F076,   F077,   F078,   F079,   F080,\n");
					sql.append("	    F081,   F082,   F083,   F084,   F085,   F086,   F087,   F088,   F089,   F090,\n");
					sql.append("	    F091,   F092,   F093,   F094,   F095,   F096,   F097,   F098,   F099,   F100,\n");
					sql.append("	    F101,   F102,   F103,   F104,   F105,   F106,   F107,   F108,   F109,   F110,\n");
					sql.append("	    F111,   F112                                                                 \n");
					sql.append("   FROM PAYROLL.YCW_F10                                                            \n");
					sql.append("  WHERE APPYY='" + str[0] + "'                                                     \n");	       
					sql.append("  ORDER BY F004   \n");	        


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