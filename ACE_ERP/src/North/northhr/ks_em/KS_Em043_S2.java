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
public class KS_Em043_S2 extends HttpServlet {

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
				String  str2	= req.getParameter("v_str2"); if (str2 == null) { str2 = ""; } //직장구분
				String  str3	= req.getParameter("v_str3"); if (str3 == null) { str3 = ""; } //소속구분
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "PAY_YM",	 "PAY_GB",  "PAY_DT",						//3
					
																		"DEPT_CD","DEPT_NM","VEND_CD", "VEND_NM", 
																			
																		"C_VEND_CD", "C_VEND_NM", "PEOPLE",		//10
																		
																		"B_PAY","X_PAY","S_PAY",							//13
																		
																		"TOT_PAY","HOL_PAY","M_TOT_PAY",			//16
																		
																		"SABO_PAY","SUB_PAY","M_PAY",					//19
																		
																		"I_EMPNO","I_DATE","U_EMPNO","U_DATE"	//23
					                                 
																			}; 


				int[] intArrCN = new int[] {    6, 1,  30, 5, 10, 5, 20,	 5, 10,	10,			//10
										                            
					                            			10, 10, 10, 10, 10, 10, 10, 10, 10,			//19
					                            															
															10, 10, 10, 10											//23
					                           
																			}; 

			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,-1, -1, -1, 2,				//10
					                         				
															3, 3, 3, 3, 3, 3, 3, 3, 3, 						//19
					                         				
					                         				-1,-1,-1,-1											//23
					                           
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();


						sql.append( "	SELECT		DISTINCT 																				\n");								
						sql.append( "			C.PAY_YM, C.PAY_GB, C.PAY_DT,													\n");				
						sql.append( "			C.DEPT_CD,		RTRIM(I.DETAIL_NM) AS DEPT_NM,						\n");			
						sql.append( "			X.VEND_CD,		RTRIM(J.DETAIL_NM) AS VEND_NM,						\n");						
						sql.append( "			X.C_VEND_CD,  RTRIM(K.DETAIL_NM) AS C_VEND_NM, X.PEOPLE,	\n");								
						sql.append( "			X.B_PAY,    X.X_PAY,   X.S_PAY,														\n");					
						sql.append( "			X.TOT_PAY,    X.HOL_PAY,    X.M_TOT_PAY,								   \n");			
						sql.append( "			X.SABO_PAY,   X.SUB_PAY,     X.M_PAY,									   \n");			
						sql.append( "		    C.I_EMPNO, C.I_DATE,  C.U_EMPNO, C.U_DATE                            \n");
						sql.append( "		FROM																								\n");										
						sql.append( "		(	SELECT  	 																					\n");		                             
						sql.append( "			A.VEND_CD AS VEND_CD, 	A.DEPT_CD AS DEPT_CD,					\n");                     
						sql.append( "			MAX(A.C_VEND_CD) AS C_VEND_CD,						                     \n");     
						sql.append( "			COUNT(B.EMPNO) AS PEOPLE, 									                  \n");           
						sql.append( "		        SUM(A.B_PAY) AS B_PAY,														\n");				 
						sql.append( "		        SUM(A.X_PAY)  AS X_PAY,														\n");				 
						sql.append( "		        SUM(A.S_PAY)  AS S_PAY,														\n");					 
						sql.append( "		        SUM(A.TOT_PAY)  AS TOT_PAY,												\n");				 
						sql.append( "		        SUM(A.HOL_PAY) AS HOL_PAY,												\n");				 
						sql.append( "		        SUM(A.M_TOT_PAY)  AS M_TOT_PAY,									 \n");			 
						sql.append( "		        SUM(A.SABO_PAY)  AS SABO_PAY,										 \n");			 
						sql.append( "		        SUM(A.SUB_PAY)  AS SUB_PAY,										 \n");				 
						sql.append( "		        SUM(A.M_PAY)  AS M_PAY											 \n");				
						sql.append( "			 FROM NORTHHR.KST200 A											 \n");					
						sql.append( "			   LEFT JOIN NORTHHR.KST010 B ON A.VEND_CD = B.VEND_CD AND A.DEPT_CD = B.DEPT_CD  AND A.EMPNO = B.EMPNO    \n");  
						sql.append( "			WHERE 1=1														  \n");				                      
if(!str1.equals(""))sql.append( "	  AND A.PAY_YM = '"+str1+"'																  \n");
if(!str2.equals(""))sql.append( "	  AND A.DEPT_CD = '"+str2+"'																  \n");
if(!str3.equals(""))sql.append( "	  AND A.VEND_CD = '"+str3+"'																  \n");																		  
						sql.append( "				GROUP BY A.VEND_CD,A.DEPT_CD										 \n");							  
						sql.append( "			)X																 \n");											  
						sql.append( "		LEFT JOIN NORTHHR.KST200 C ON C.VEND_CD = X.VEND_CD 	AND C.DEPT_CD = X.DEPT_CD AND C.PAY_YM =  '"+str1+"'	 \n");												     
						sql.append( "		LEFT JOIN NORTHHR.TSY010 I ON RTRIM(I.DETAIL) = RTRIM(C.DEPT_CD)   AND I.HEAD='KS006'   AND RTRIM(I.DETAIL)<>''       \n");
						sql.append( "		LEFT JOIN NORTHHR.TSY010 J ON RTRIM(J.DETAIL) = RTRIM(X.VEND_CD)   AND J.HEAD='KS007'   AND RTRIM(J.DETAIL)<>''     \n");   
						sql.append( "		LEFT JOIN NORTHHR.TSY010 K ON RTRIM(K.DETAIL) = RTRIM(X.C_VEND_CD)   AND K.HEAD='KS008'   AND RTRIM(K.DETAIL)<>''     \n");   
						sql.append( "		ORDER BY DEPT_CD, 	X.C_VEND_CD ASC,	VEND_CD								 \n");

						
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