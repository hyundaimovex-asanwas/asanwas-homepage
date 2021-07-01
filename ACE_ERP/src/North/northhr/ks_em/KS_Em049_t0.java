package northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class KS_Em049_t0 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; } //지급월
				String  str2	= req.getParameter("v_str2"); if (str2 == null) { str2 = ""; } //직장
				String  str3	= req.getParameter("v_str3"); if (str3 == null) { str3 = ""; } //소속
				
								
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "PAY_YM",	 "PAY_GB", 	"VEND_CD","DEPT_CD",	//
																		
																		"D_PAY",	"TOT_PAY",	"M_TOT_PAY",				//
																		
																		"SABO_PAY","SUB_PAY",									//9
																		
																		"I_EMPNO","I_DATE","U_EMPNO","U_DATE"		//13																	           				
					                                 
																			}; 

				int[] intArrCN = new int[] {6, 1,  5,  5,				//4  
										                            
					                            			10, 10, 10, 10, 10, 	//9
					                            
															10, 10, 10, 10			//13
					                            
					                           
																			}; 
			
				int[] intArrCN2 = new int[]{ -1,-1, -1, -1, 
					                         				
															3, 3, 3, 3, 3, 			 			//9
					                         				
					                         				-1,-1,-1,-1						//13
					                           
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	SELECT A.PAY_YM,  A.PAY_GB											\n");						
						sql.append( "				 A.VEND_CD, A.DEPT_CD   										\n");										
						sql.append( "				 A.D_PAY, A.TOT_PAY, A.M_TOT_PAY,    					\n");																				
						sql.append( "				 A.SABO_PAY, A.SUB_PAY,   									\n");																							
            			sql.append( "				 A.I_EMPNO, A.I_DATE, A.U_EMPNO, A.U_DATE 			\n");
						sql.append( "	FROM NORTHHR.KST200 A                              \n");						
						sql.append( "	WHERE 1=1   \n");						
						if(!str1.equals(""))sql.append( "	  AND A.PAY_YM = '"+str1+"'      	\n");
						if(!str2.equals(""))sql.append( "	  AND A.DEPT_CD = '"+str2+"'      	\n");
						if(!str3.equals(""))sql.append( "	  AND A.VEND_CD = '"+str3+"'      	\n");

												
						//logger.dbg.println(this,sql.toString());
						
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