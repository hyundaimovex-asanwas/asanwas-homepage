package THMS;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class thms_204_s extends HttpServlet {

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
				//String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; }				//등록년도
				//String  str2	= req.getParameter("v_str2"); if (str2 == null) { str2 = ""; }				//업체코드

				//logger.dbg.println(this,"뭥미?");
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "COOP_CD",	"COOP_NM",		
					
																	"COOP_CERT",		"COOP_DIRECT",		
																		
																	"ADDRESS",		"COOP_STYLE",		"CREAT_DT",		//

																	"LICENSE1",		"CON_CAPA1",		"LICENSE2",		"CON_CAPA2",		"LICENSE3",		"CON_CAPA3",	//

																	"DEBT_2008", 		"DEBT_2009",		"DEBT_2010",		"DEBT_2011",		

																	"CASH_2008", 		"CASH_2009",		"CASH_2010",		"CASH_2011",		

																	"CREDIT_2008", 	"CREDIT_2009",	"CREDIT_2010",	"CREDIT_2011",							//
	
																	"DEFAULT", 			"PATENT",															
																		
																	"VD_TELNO",		"VD_FAXNO",	"REMARK",																//

																	"I_EMPNO",		"I_DATE",		"U_EMPNO",		"U_DATE"
             									                                 
																}; 

				int[] intArrCN = new int[] {   10, 30, 
					
															15, 20, 
															
															15, 20, 10, 							
																
															10, 15, 10, 15, 10, 15,			

															10, 10, 10, 10,

															10, 10, 10, 10,

															10, 10, 10, 10,						

															50, 50,
					                            
					                            			15, 15,  100,																	  
					                            
					                            			10, 10, 10, 10
					                           
																			}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, 
					
															-1,-1,

                                     						-1,-1, -1,						

															-1, 0, -1, 0, -1, 0,		

															-1,-1,-1, -1,

															-1,-1,-1, -1,
																
															-1,-1,-1, -1,					

															-1,-1,

															-1,-1, -1,						
					                         				
					                         				-1,-1,-1, -1
					                           
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	SELECT  COOP_CD,			COOP_NM,   															\n");
						sql.append( "				 COOP_CERT, 		COOP_DIRECT,       												\n");
						sql.append( "				 ADDRESS, 			COOP_STYLE,	 CREAT_DT,     								\n");
						sql.append( "				 LICENSE1, 			CON_CAPA1,      													\n");
						sql.append( "				 LICENSE2, 			CON_CAPA2,       													\n");
						sql.append( "				 LICENSE3, 			CON_CAPA3,       													\n");
						sql.append( "				 DEBT_2008, 		DEBT_2009,		DEBT_2010,		DEBT_2011,			\n");
						sql.append( "				 CASH_2008, 		CASH_2009,		CASH_2010,		CASH_2011,			\n");
						sql.append( "				 CREDIT_2008, 	CREDIT_2009,	CREDIT_2010,	CREDIT_2011,		\n");
						sql.append( "				 DEFAULT, 			PATENT,																\n");
						sql.append( "				 VD_TELNO,			VD_FAXNO,      		REMARK,									\n");
            			sql.append( "				 I_EMPNO, I_DATE, U_EMPNO, U_DATE 												\n");
						sql.append( "				FROM THMS.THMS020																		\n");
						sql.append( "				WHERE 1=1																						\n");
	//					if(!str1.equals(""))sql.append( "	  AND COOP_YYMM =		'"+str1+"'    								\n");
	//					if(!str2.equals(""))sql.append( "	  AND COOP_CD =		'"+str2+"'    									\n");
			
						logger.dbg.println(this,sql.toString());
						
						stmt = conn.getGauceStatement(sql.toString());
  	 					stmt.executeQuery(dSet);
  	 					
					}
				 
/*********************************************************************************************/

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