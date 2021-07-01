package North.northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class KS_Em014_S2 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; }		//직영
				String  str2	= req.getParameter("v_str2"); if (str2 == null) { str2 = ""; }		//직장
				String  str3	= req.getParameter("v_str3"); if (str3 == null) { str3 = ""; }		//소속


				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ 
																				"C_VEND_CD", 	"C_VEND_NM", 
																				"DEPT_CD", 		"DEPT_NM",	
																				"VEND_CD",		"VEND_NM",																								
																				"MAN",		"WOMAN",			
																				"TOTAL" 		
																
																			}; 	
																					
				int[] intArrCN = new int[] { 																				
																				5, 20,  					
																				5, 20,  																									
																				5, 20,  																									
																				5, 5,  							
																				5								
																	 	

																			};  
			
				int[] intArrCN2 = new int[]{
																				-1,-1, 
																				
																				-1, -1,					
																				
																				-1,-1, 

																				0,	  0, 	
																					
																				0 


																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 



					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

					 sql.append("		SELECT																																															\n");
					 sql.append("		X.C_VEND_CD, A.DETAIL_NM AS C_VEND_NM,																																\n");
					 sql.append("		X.DEPT_CD, B.DETAIL_NM AS DEPT_NM,																																		\n");	       
					 sql.append("		X.VEND_CD, C.DETAIL_NM AS VEND_NM,																																		\n");			
					 sql.append("		X.MAN AS MAN,																																												\n");		   
					 sql.append("		X.WOMAN AS WOMAN,																																									\n");			
					 sql.append("		X.TOTAL AS TOTAL																																										\n");		   
					 sql.append("		FROM																																															\n");			
					 sql.append("		(																																																	\n");            
					 sql.append("		SELECT																																															\n");	       
					 sql.append("		C_VEND_CD,DEPT_CD, VEND_CD,																																					\n");		   
					 sql.append("		COUNT(CASE WHEN (SEX = 'M') THEN SEX END ) MAN,  COUNT(CASE WHEN (SEX = 'F') THEN SEX END ) WOMAN, 						\n");		   
					 sql.append("		COUNT(EMPNO) AS TOTAL																																							\n");	       
					 sql.append("		FROM NORTHHR.KST010																																								\n");               
					 sql.append("		WHERE 1=1																																													\n");		   
					 sql.append("		AND USESTS = '1'																																													\n");		   
					 sql.append("		GROUP BY C_VEND_CD, VEND_CD, DEPT_CD																																\n");	       
					 sql.append("		) X																																																\n");	       
					 sql.append("		LEFT JOIN NORTHHR.TSY010 A ON RTRIM(A.DETAIL) = RTRIM(X.C_VEND_CD)  AND A.HEAD='KS008'  AND RTRIM(A.DETAIL)<>''    \n");
					 sql.append("		LEFT JOIN NORTHHR.TSY010 B ON RTRIM(B.DETAIL) = RTRIM(X.DEPT_CD)    AND B.HEAD='KS006'  AND RTRIM(B.DETAIL)<>''	     \n");
					 sql.append("		LEFT JOIN NORTHHR.TSY010 C ON RTRIM(C.DETAIL) = RTRIM(X.VEND_CD)   	AND C.HEAD='KS007'  AND RTRIM(C.DETAIL)<>''   \n");
					 sql.append("		WHERE																																															\n");	
					 sql.append("		1=1																																																\n");	
					 sql.append( "	  AND X.C_VEND_CD != '1'      									\n");
					if(!str2.equals(""))sql.append( "	  AND X.DEPT_CD = '"+str2+"'      	\n");
					if(!str3.equals(""))sql.append( "	  AND X.VEND_CD = '"+str3+"'      	\n");		
					 sql.append("		ORDER BY X.DEPT_CD, X.VEND_CD																														\n");	
			
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