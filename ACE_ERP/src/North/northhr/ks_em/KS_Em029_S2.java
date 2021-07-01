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
public class KS_Em029_S2 extends HttpServlet {

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
				
				String str1 =  req.getParameter("v_str1"); 	// 부서 
				String str2 =  req.getParameter("v_str2"); 	// 근무했던 휴일 
				String str3 =  req.getParameter("v_str3"); 	// 대체일 				
				
				
								
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "ATT_DT", "EMPNO",   "EMPNMK",  
					
                                           			 "DAY_CD", "DAY_NM",  "DAY_CD2", "DAY_NM2", "DEPT_CD", "DEPT_NM",                                   			

					                                 "I_EMPNO", "I_DATE",  "U_EMPNO","U_DATE"                           
																		  	}; 

				int[] intArrCN = new int[] { 8, 10, 30,  
					
					                           1,5, 1,5, 5, 50, 

					                           10, 10, 10, 10
																			}; 
			
				int[] intArrCN2 = new int[]{ -1,-1, -1,
					
					                           -1,-1,-1,-1, -1,-1,
					                           
					                           -1,-1,-1,-1
					                           
					                          }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();


						sql.append( "	 SELECT A.ATT_DT, A.EMPNO,   C.EMPNMK,                                                                                \n");             
						sql.append( "	 B.DAY_CD,  E.DETAIL_NM AS DAY_NM,      						                                       						\n");            
						sql.append( "	 F.DAY_CD AS DAY_CD2,  G.DETAIL_NM AS DAY_NM2,                                                                  \n");            
						sql.append( "	 A.DEPT_CD,  D.DETAIL_NM AS DEPT_NM,      			  		                                                			\n");           
						sql.append( "	 A.I_EMPNO, A.I_DATE,  A.U_EMPNO, A.U_DATE 		                                                                	\n");           
						sql.append( "	 FROM NORTHHR.KST100 A                                                                                                                    \n");           
						sql.append( "	 LEFT JOIN NORTHHR.KST130 B ON B.ATT_DT = A.ATT_DT                                                                      \n");          
						sql.append( "	 LEFT JOIN NORTHHR.KST010 C ON C.EMPNO = A.EMPNO                                                                        \n");          
						sql.append( "	 LEFT JOIN NORTHHR.TSY010 D ON D.DETAIL = A.DEPT_CD AND D.HEAD = 'KS006' AND TRIM(D.DETAIL)<>''  \n");   
						sql.append( "	 LEFT JOIN NORTHHR.TSY010 E ON E.DETAIL = B.DAY_CD AND E.HEAD = 'KS020' AND TRIM(E.DETAIL)<>''     \n");   
						sql.append( "	 LEFT JOIN NORTHHR.KST130 F ON F.ATT_DT = '"+str3+"'                                                                         \n");   
						sql.append( "	 LEFT JOIN NORTHHR.TSY010 G ON G.DETAIL = F.DAY_CD AND G.HEAD = 'KS020' AND TRIM(G.DETAIL)<>''   \n");   
						sql.append( "	 WHERE 1=1                                                                                                                                    \n");   
						if(!str1.equals(""))sql.append( "	  AND A.EMPNO = '"+str1+"' \n");
						if(!str2.equals(""))sql.append( "	  AND A.ATT_DT = '"+str2+"' \n");
						
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




