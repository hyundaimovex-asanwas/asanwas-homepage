package purch;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;


// class 이름은 화일명과 항상 동일해야 함.
public class np00200_s0 extends HttpServlet {



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
				String  str1	= req.getParameter("v_str1");   //정산년도

				if (str1==null) str1=""; 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
																	"PH_NO","PH_COM","PH_BIZ","PH_DEPT",				//4

																	"PH_Mcom","PH_D_RC","PH_D_DL","PH_DLCN",

																	"PH_STOR","PH_PACN","PH_PROM","PH_NOTE",		//12

																	"PH_INSC","PH_INSF","PH_TAX","PH_D_PUR",

																	"PH_D_ORD","PH_PSN","PH_TEL","PH_EST",			//20

																	"PH_AMT","PH_COM1","PH_EST1",

																	"PH_AMT1","PH_COM2","PH_EST2",						//26

																	"PH_AMT2","PH_D_EST","PH_D_INP","PH_D_TAX",	//30

																	"PH_STEP","PH_BIGO","PH_Spno","PH_Spbos",

																	"PH_Spadr","PH_USER","PH_UDT","PH_Rqno",

																	"PH_PMR","PH_PMP","PH_PCD","PH_DDCT_CHK",		//42

																	"PH_COM3","PH_EST3","PH_AMT3",

																	"PH_COM4","PH_EST4","PH_AMT4"						//48			*/

																					
																			}; 	


				int[] intArrCN = new int[] { 
																				10, 50, 5, 5,																			
																				50, 50, 50, 50,  			
																				20, 50, 500, 500,
																				10, 10, 20, 50,																			
																				50, 20, 20, 15,  					//20
																				15, 50, 15,
																				15, 50, 15,							//26																			
																				15, 5, 15, 15,  					//30

																				5, 300, 20, 20,						
																				100, 20, 50, 20,																			
																				50, 50, 50, 5,  					//42

																				50, 15, 15, 																					
																				50, 15, 15							//48	
																																								 	

																			};  
			
				int[] intArrCN2 = new int[]{
																				-1,-1,-1,-1,
																				-1,-1,-1,-1,  	
																				-1,-1,-1,-1,
																				-1,-1,-1,-1,  
																				-1,-1,-1,-1,  		//20
																				-1,-1,-1,
																				-1,-1,-1,			//26
																				-1,-1,-1,-1,  		//30
																				-1,-1,-1,-1,
																				-1,-1,-1,-1,  
																				-1,-1,-1,-1,  		//42
																				-1,-1,-1,
																				-1,-1,-1				//48

																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();


						sql.append( "	SELECT  																															\n");						
						sql.append( "			A.PH_NO,A.PH_COM,A.PH_BIZ,A.PH_DEPT,																		\n");
						sql.append( "			A.PH_Mcom,A.PH_D_RC,A.PH_D_DL,A.PH_DLCN,																	\n");
						sql.append( "			A.PH_STOR,A.PH_PACN,A.PH_PROM,A.PH_NOTE,																\n");
						sql.append( "			A.PH_INSC,A.PH_INSF,A.PH_TAX,A.PH_D_PUR,																	\n");
						sql.append( "			A.PH_D_ORD,A.PH_PSN,A.PH_TEL,A.PH_EST,																		\n");
						sql.append( "			A.PH_AMT,A.PH_COM1,A.PH_EST1,																					\n");
						sql.append( "			A.PH_AMT1,A.PH_COM2,A.PH_EST2,																				\n");
						sql.append( "			A.PH_AMT2,A.PH_D_EST,A.PH_D_INP,A.PH_D_TAX,																\n");
						sql.append( "			A.PH_STEP,A.PH_BIGO,A.PH_Spno,A.PH_Spbos,																	\n");
						sql.append( "			A.PH_Spadr,A.PH_USER,A.PH_UDT,A.PH_Rqno,																	\n");
						sql.append( "			A.PH_PMR,A.PH_PMP,A.PH_PCD,A.PH_DDCT_CHK,																\n");
						sql.append( "			A.PH_COM3,A.PH_EST3,A.PH_AMT3,																				\n");
						sql.append( "			A.PH_COM4,A.PH_EST4,A.PH_AMT4																					\n");					

						sql.append( "		FROM PURCH.PURH A																											\n");
						sql.append( "	WHERE 1=1																															\n");
				if(!str1.equals(""))sql.append( "		AND SUBSTR(A.PH_NO,1,4) = '"+str1+"'																	\n");			


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

