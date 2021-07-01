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
public class p050018_s1 extends HttpServlet {

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
							// 웹페이지에서 조건값을 넘겨받음

				String  str1	= req.getParameter("v_str1");		//성명
				String  str2	= req.getParameter("v_str2");		//기준년월
				String  str3	= req.getParameter("v_str3");		//사번

				if (str1==null) { str1 = ""; }
				if (str2==null) { str2 = ""; }
				if (str3==null) { str3 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DEPTNM",	"EMPNO",	"EMPNMK",	"PAYGRDNM",	
															
															"APPDT",	"APLDT", 
																
															"ENDDT", "APLAMT_SUM", "RATAMT_SUM", "APLAMT_RATAMT",
															
															"APLCNT",	"APPAMT",	"APBAMT",	"APLAMT",     "APJAMT", 

															"RATAMT",	"CALAMT",	"AMT_1",	"REPDT", "REPYN",	 "REASON","REASONK","EXE","EXENMK"
					}; 

				int[] intArrCN = new int[]{  50,  7,   20,  30,  
													
													8,	 8,  
														
													8, 9, 9, 9,
													
													3,    9,   9,  9,	9,

													9,  9,    9,	8,  1, 30, 30, 1, 10														
					}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,  -1,  
														
														-1, -1,  
															
														-1, 0, 0, 0,

														0,  0,   0,   0,	0,

														0,	0, 0,	 -1,  -1,  -1, -1, -1, -1
				  }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT																																		\n");
					sql.append( " C.DEPTNM, A.EMPNO,  B.EMPNMK, D.MINORNM AS PAYGRDNM,																\n");
					sql.append( " A.APPDT,																																		\n");
					sql.append( " A.APLDT,																																		\n");

					sql.append( " H.MAX_APLDT AS ENDDT,																												\n");
					sql.append( " A.APPAMT - A.APJAMT AS APLAMT_SUM,																							\n");
					sql.append( " E.RATAMT_SUM,																															\n");
					sql.append( " A.APLAMT+A.CALAMT AS APLAMT_RATAMT,																						\n");
					//2011.04.20 JYS 수정
					//sql.append( " A.APLAMT+E.RATAMT_SUM AS APLAMT_RATAMT,																				\n");
 

					sql.append( " A.APLCNT,																																	\n");
					sql.append( " A.APPAMT,																																	\n");
					sql.append( " A.APBAMT,																																	\n");
					sql.append( " A.APLAMT,																																	\n");
					sql.append( " A.APJAMT,																																	\n");
					sql.append( " A.RATAMT,																																	\n");
					sql.append( " A.CALAMT,																																	\n");
					sql.append( " (A.APLAMT + A.CALAMT) AS AMT_1,																									\n");
					sql.append( " A.REPDT,																																		\n");
					sql.append( " A.REPYN,																																		\n");
					sql.append( " IFNULL(RTRIM(A.REASON),'') REASON,																								\n");
					sql.append( " CASE WHEN REASON = '1' THEN '결혼'																								\n");
					sql.append( " WHEN REASON = '2' THEN '학자금'																										\n");
					sql.append( " WHEN REASON = '3' THEN '주택'																										\n");
					sql.append( " ELSE '기타'  END	REASONK, A.EXE,																									\n");

					sql.append( " CASE WHEN A.EXE = '0' THEN '직원'																									\n");
					sql.append( " ELSE '임원'  END	EXENMK																												\n");

					sql.append( " FROM PAYROLL.PWCOLOAN A																											\n");
					sql.append( " JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO																				\n");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD = C.DEPTCD																		\n");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON B.PAYGRD = D.MINORCD AND MAJORCD ='2002'									\n");

 					sql.append( " LEFT JOIN ( SELECT EMPNO, APPDT, IFNULL(SUM(CALAMT),0) RATAMT_SUM											\n");		
 					sql.append( "               FROM PAYROLL.PWCOLOAN    																							\n");
					sql.append( " 			  WHERE APLDT<='" + str2 +"25'	                                                           									\n");
					sql.append( "               GROUP BY EMPNO, APPDT                                                                  								\n");
					sql.append( "             )E ON A.EMPNO = E.EMPNO	 																								\n");
					sql.append( "  LEFT JOIN ( SELECT EMPNO, IFNULL(SUM(APLAMT),0)APLAMT_SUM, IFNULL(SUM(APLRAT),0) APLRAT_SUM   \n");                      			
					sql.append( "                   FROM PAYROLL.PBPAY                                                                                    				\n");
					sql.append( "                  WHERE PAYDIV IN('1','4','T')                                                                                     	    \n");                                                                                  
					sql.append( "                  GROUP BY EMPNO                                                                                         					\n");
					sql.append( "               ) G ON A.EMPNO = G.EMPNO   																							\n");
					sql.append( "  LEFT JOIN ( SELECT EMPNO, APPDT, MAX(APLDT)AS MAX_APLDT															\n");
					sql.append( "                FROM PAYROLL.PWCOLOAN																								\n");     
					sql.append( "               GROUP BY EMPNO, APPDT																									\n");
					sql.append( "             )H ON A.EMPNO = H.EMPNO																									\n");

					sql.append( " WHERE 1=1																																	\n");


					if (!str1.equals("")) sql.append( " AND RTRIM(B.EMPNMK) = '" + str1 + "'																		\n");
 					if (!str2.equals("")) sql.append( " AND SUBSTR(A.APLDT,1,6) = '" + str2 +"'																	\n");
 					if (!str3.equals("")) sql.append( " AND B.EMPNO = '" + str3 +"'																					\n");
					
					sql.append( " UNION																											\n");

					sql.append( " SELECT																																		\n");
					sql.append( " C.DEPTNM, A.EMPNO,  B.EMPNMK, D.MINORNM AS PAYGRDNM,																\n");
					sql.append( " A.APPDT,																																		\n");
					sql.append( " A.APLDT,																																		\n");

					sql.append( " H.MAX_APLDT AS ENDDT,																												\n");
					sql.append( " A.APPAMT - A.APJAMT AS APLAMT_SUM,																							\n");
					sql.append( " E.RATAMT_SUM,																															\n");
					sql.append( " A.APLAMT+A.CALAMT AS APLAMT_RATAMT,																						\n");
					//2011.04.20 JYS 수정
					//sql.append( " A.APLAMT+E.RATAMT_SUM AS APLAMT_RATAMT,																				\n");

					sql.append( " A.APLCNT,																																	\n");
					sql.append( " A.APPAMT,																																	\n");
					sql.append( " A.APBAMT,																																	\n");
					sql.append( " A.APLAMT,																																	\n");
					sql.append( " A.APJAMT,																																	\n");
					sql.append( " A.RATAMT,																																	\n");
					sql.append( " A.CALAMT,																																	\n");
					sql.append( " (A.APLAMT + A.CALAMT) AS AMT_1,																									\n");
					sql.append( " A.REPDT,																																		\n");
					sql.append( " A.REPYN,																																		\n");
					sql.append( " IFNULL(RTRIM(A.REASON),'') REASON,																								\n");
					sql.append( " CASE WHEN REASON = '1' THEN '결혼'																								\n");
					sql.append( " WHEN REASON = '2' THEN '학자금'																										\n");
					sql.append( " WHEN REASON = '3' THEN '주택'																										\n");
					sql.append( " ELSE '기타'  END	REASONK, A.EXE,																									\n");

					sql.append( " CASE WHEN A.EXE = '0' THEN '직원'																									\n");
					sql.append( " ELSE '임원'  END	EXENMK																												\n");

					sql.append( " FROM PAYROLL.PWCOLOAN A																											\n");
					sql.append( " JOIN PAYROLL.T_HIPERSON B ON A.EMPNO = B.EMPNO																			\n");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD = C.DEPTCD																		\n");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON B.PAYGRD = D.MINORCD AND MAJORCD ='2002'									\n");

 					sql.append( " LEFT JOIN ( SELECT EMPNO, APPDT, IFNULL(SUM(CALAMT),0) RATAMT_SUM											\n");		
 					sql.append( "               FROM PAYROLL.PWCOLOAN    																							\n");
					sql.append( " 			  WHERE APLDT<='" + str2 +"25'	                                                           									\n");
					sql.append( "               GROUP BY EMPNO, APPDT                                                                  								\n");
					sql.append( "             )E ON A.EMPNO = E.EMPNO	 																								\n");
					sql.append( "  LEFT JOIN ( SELECT EMPNO, IFNULL(SUM(APLAMT),0)APLAMT_SUM, IFNULL(SUM(APLRAT),0) APLRAT_SUM   \n");                      			
					sql.append( "                   FROM PAYROLL.PBPAY                                                                                    				\n");
					sql.append( "                  WHERE PAYDIV IN('1','4','T')                                                                                     	    \n");                                                                                  
					sql.append( "                  GROUP BY EMPNO                                                                                         					\n");
					sql.append( "               ) G ON A.EMPNO = G.EMPNO   																							\n");
					sql.append( "  LEFT JOIN ( SELECT EMPNO, APPDT, MAX(APLDT)AS MAX_APLDT															\n");
					sql.append( "                FROM PAYROLL.PWCOLOAN																								\n");     
					sql.append( "               GROUP BY EMPNO, APPDT																									\n");
					sql.append( "             )H ON A.EMPNO = H.EMPNO																									\n");

					sql.append( " WHERE 1=1																																	\n");


					if (!str1.equals("")) sql.append( " AND RTRIM(B.EMPNMK) = '" + str1 + "'																		\n");
 					if (!str2.equals("")) sql.append( " AND SUBSTR(A.APLDT,1,6) = '" + str2 +"'																	\n");
 					if (!str3.equals("")) sql.append( " AND B.EMPNO = '" + str3 +"'																					\n");


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