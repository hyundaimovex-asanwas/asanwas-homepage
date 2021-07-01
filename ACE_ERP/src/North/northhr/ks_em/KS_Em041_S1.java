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
public class KS_Em041_S1 extends HttpServlet {

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
				
				
				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; } //직장
				String  str2	= req.getParameter("v_str2"); if (str2 == null) { str2 = ""; } //소속
				String  str3	= req.getParameter("v_str3"); if (str3 == null) { str3 = ""; } //직종
				String  str4	= req.getParameter("v_str4"); if (str4 == null) { str4 = ""; } //직번
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "EMPNO",	"EMPNMK",	
					
																	"DEPT_CD",  "DEPT_NM",

																	"VEND_CD",	"VEND_NM",

																	"JOB_CD", "JOB_NM", 
																					 				
																	"PAY_GB",	"ITEM_GB", "PAY_ITEM",

																	"START_DT", 	"END_DT", 	"EX_PAY",

																	"I_EMPNO","U_EMPNO", 

																	"I_DATE","U_DATE"
             				
					                                 
																			}; 

				int[] intArrCN = new int[] { 10, 10,
					
															5, 10, 5, 10,  5, 10, 
					
															1, 1, 3,
										                            
					                            			10, 10, 10, 
					                            
					                            			10, 10, 10, 10
					                            
					                           
																			}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, 
					
															-1, -1, -1, -1, -1, -1,
					
															-1, -1, -1,
					                         				
															-1, -1, 2,
					                         				
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

						sql.append( "	SELECT A.EMPNO, B.EMPNMK,  					\n");


						sql.append( "			B.DEPT_CD,		RTRIM(I.DETAIL_NM)	DEPT_NM,   												\n");		
						sql.append( "			B.VEND_CD, 		RTRIM(J.DETAIL_NM)	 VEND_NM,   											\n");		
						sql.append( "			B.JOB_CD, 		RTRIM(K.DETAIL_NM) JOB_NM,   												\n");	

						sql.append( "				 A.PAY_GB, A.ITEM_GB, A.PAY_ITEM,    							\n");

						sql.append( "				 A.START_DT, A.END_DT,   A.EX_PAY,    							\n");

            			sql.append( "				 A.I_EMPNO, A.U_EMPNO, A.I_DATE, A.U_DATE 					\n");

						sql.append( "	 		FROM NORTHHR.KST220	A										\n");			

						sql.append( "	   LEFT JOIN NORTHHR.KST010 B ON A.EMPNO = B.EMPNO				\n");					
						sql.append( "	   LEFT JOIN NORTHHR.TSY010 I ON RTRIM(I.DETAIL) = RTRIM(B.DEPT_CD)    	AND I.HEAD='KS006'   AND RTRIM(I.DETAIL)<>''   \n");
						sql.append( "	   LEFT JOIN NORTHHR.TSY010 J ON RTRIM(J.DETAIL) = RTRIM(B.VEND_CD)    	AND J.HEAD='KS007'   AND RTRIM(J.DETAIL)<>''   \n");
						sql.append( "	   LEFT JOIN NORTHHR.TSY010 K ON RTRIM(K.DETAIL) = RTRIM(B.JOB_CD)    	AND K.HEAD='KS002'   AND RTRIM(K.DETAIL)<>''   \n");						
						sql.append( "	WHERE 1=1   \n");		

						if(!str1.equals(""))sql.append( "	  AND B.DEPT_CD = '"+str1+"'      	\n");
						if(!str2.equals(""))sql.append( "	  AND B.VEND_CD = '"+str2+"'      	\n");
						if(!str3.equals(""))sql.append( "	  AND B.JOB_CD = '"+str3+"'      		\n");
						if(!str4.equals(""))sql.append( "	  AND B.EMPNO = '"+str4+"'      		\n");						

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