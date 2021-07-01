package sales.menu.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class KS_Em013_S extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

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
				String [] str = new String [21];
				str[0]	= req.getParameter("v_str1");		//근무업체        
				str[1]	= req.getParameter("v_str2");		//직종            
				str[2]	= req.getParameter("v_str3");		//계약일 from     
				str[3]	= req.getParameter("v_str4");		//계약일 to       
				str[4]	= req.getParameter("v_str5");		//부서            
				str[5]	= req.getParameter("v_str6");		//인력대리점      
				str[6]	= req.getParameter("v_str7");		//입사일 from     
 

				for (int s=0;s<21;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ 
																				"CUST_SID",	
																				"USESTS",	
																				"EMPNMK",
																				"EMPNO",																							
																				"SEX",
																				
																				"BIRTHDAY",	
																				"RECOMMEND",																				
																				"START_DT",																				
																				"END_DT",   

																				"VEND_CD", 
																				"VEND_NM",																					
																				"DEPT_CD", 																			
																				"DEPT_NM",				
																				"JOB_CD",		
																				"JOB_NM",		

																				"WORK_CD",
																				"WORK_NM",
																				"C_VEND_CD", 					
																				"C_VEND_NM", 
																				"SKILL_CD", 
																				"SKILL_NM", 		//21
																				
																				"CLASS_CD",																				
																				"CLASS_NM",
																				"CON_YEAR"		


																	
																			}; 	
																					
				int[] intArrCN = new int[] { 
																				10, 1, 30, 10, 1,		//5
																				
																				8, 1, 8, 8, 				//9
																				
																				10, 20, 10, 20, 10, 20, 		//15
																				
																				10, 20, 10, 20, 10, 20, 		//21
																				
																				10, 20, 2				//24		
																	 	

																			};  
			
				int[] intArrCN2 = new int[]{
																				0,-1,-1, -1, -1,
																				
																				-1,-1, -1,-1,		//9
																				
																				-1,-1, -1, -1, -1, -1,
																				
																				-1,-1, -1, -1, -1, -1,   //21
																				
																				-1, -1, 0 


																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	SELECT  A.CUST_SID, A.USESTS,           																	\n");
						sql.append( "			RTRIM(A.EMPNMK) AS EMPNMK,  A.EMPNO AS  EMPNO, 								\n");
						sql.append( "	        A.SEX , TRIM(A.BIRTHDAY) AS BIRTHDAY,          												\n");
						sql.append( "			A.RECOMMEND, A.START_DT, IFNULL(A.END_DT,'')END_DT,   						\n");
						sql.append( "	        A.VEND_CD,	 	P.DETAIL_NM AS VEND_NM,                               						\n");
						sql.append( "	        A.DEPT_CD, 	K.DETAIL_NM AS DEPT_NM,  							             			\n");
						sql.append( "			A.JOB_CD, 		RTRIM(I.DETAIL_NM)	JOB_NM,												\n");	
						sql.append( "			A.WORK_CD, 	RTRIM(N.DETAIL_NM)	WORK_NM,											\n");						
						sql.append( "	       IFNULL(A.C_VEND_CD,0) C_VEND_CD,  Q.DETAIL_NM AS C_VEND_NM,             \n");										
						sql.append( "			A.SKILL_CD,  S.DETAIL_NM AS SKILL_NM, 														\n");
						sql.append( "	        A.CLASS_CD, 	M.DETAIL_NM AS CLASS_NM,                                          		\n");
						sql.append( "	        A.CON_YEAR              			\n");
						sql.append( "		FROM SALES. KST010 A                                                                                           \n");
						sql.append( "		LEFT JOIN SALES.TSY010 N ON RTRIM(N.DETAIL) = RTRIM(A.WORK_CD)   	AND N.HEAD='KS001'  AND RTRIM(N.DETAIL)<>''   \n");
						sql.append( "		LEFT JOIN SALES.TSY010 I ON RTRIM(I.DETAIL) = RTRIM(A.JOB_CD)    		AND I.HEAD='KS002'   AND RTRIM(I.DETAIL)<>''   \n");
						sql.append( "		LEFT JOIN SALES.TSY010 G ON RTRIM(G.DETAIL) = RTRIM(A.ATT_CD)    	AND G.HEAD='KS003'  AND RTRIM(G.DETAIL)<>''   \n");
						sql.append( "		LEFT JOIN SALES.TSY010 K ON RTRIM(K.DETAIL) = RTRIM(A.DEPT_CD)   	AND K.HEAD='KS006'  AND RTRIM(K.DETAIL)<>''   \n");
						sql.append( "		LEFT JOIN SALES.TSY010 P ON RTRIM(P.DETAIL) = RTRIM(A.VEND_CD)    	AND P.HEAD='KS007'  AND RTRIM(P.DETAIL)<>''   \n");
						sql.append( "		LEFT JOIN SALES.TSY010 Q ON RTRIM(Q.DETAIL) = RTRIM(A.C_VEND_CD)  AND Q.HEAD='KS008'  AND RTRIM(Q.DETAIL)<>''   \n");
						sql.append( "		LEFT JOIN SALES.TSY010 S ON RTRIM(S.DETAIL) = RTRIM(A.SKILL_CD)    	 AND S.HEAD='KS009'  AND RTRIM(S.DETAIL)<>''   \n");
						sql.append( "		LEFT JOIN SALES.TSY010 M ON RTRIM(M.DETAIL) = RTRIM(A.CLASS_CD)    AND M.HEAD='KS014'  AND RTRIM(M.DETAIL)<>''   \n");



//						sql.append( "  LEFT JOIN SALES.TCU010 B ON A.CUST_SID = B.CUST_SID                                                       \n");
//						sql.append( "  LEFT JOIN SALES.TCM345 C ON A.EMPNO = C.EMPNO                                                             \n");
//						sql.append( "                          AND C.SEQ = (SELECT MAX(SEQ) FROM SALES.TCM345                                    \n");
//						sql.append( "                                        WHERE A.EMPNO =EMPNO)                                               \n");
//						sql.append( "  LEFT JOIN SALES.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.ORD_CD) AND E.HEAD='CM012' AND RTRIM(E.DETAIL)<>''  \n");
						sql.append( " WHERE 1=1                                                  \n");


						if (!str[0].equals(""))sql.append( "AND A.VEND_CD = '"+str[0]+"'                                    \n");
						if (!str[1].equals(""))sql.append( "AND A.JOB_CD = '"+str[1]+"'                                     \n");
						if (!str[2].equals(""))sql.append( "AND C.START_DT BETWEEN '"+str[2]+"' AND '"+str[3]+"'            \n");
						if (!str[4].equals(""))sql.append( "AND A.DEPT_CD = '"+str[4]+"'                                    \n");
						if (!str[5].equals(""))sql.append( "AND A.AGENCY_CD = '"+str[5]+"'                                  \n");
						if (!str[6].equals(""))sql.append( "AND A.START_DT BETWEEN '"+str[6]+"' AND '"+str[7]+"'            \n");
						sql.append( "ORDER BY A.START_DT, A.EMPNMK 	\n");
			
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