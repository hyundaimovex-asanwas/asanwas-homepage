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
public class KS_Em011_S1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; } //사번
				String  str2	= req.getParameter("v_str2"); if (str2 == null) { str2 = ""; } //성명
				String  str3	= req.getParameter("v_str3"); if (str3 == null) { str3 = ""; } //부서

				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "EMPNO",	"EMPNMK",	"CUST_SID", "CHK",

																	"VEND_CD", 	"VEND_NM",

																	"DEPT_CD",	"DEPT_NM",

																	"C_VEND_CD", 	"C_VEND_NM",																	

																	"WORK_CD",		"WORK_NM",
					                                 
																	"CLASS_CD",	"CLASS_NM",

                                           							"JOB_CD",	"JOB_NM", 

																	"I_EMPNO","U_EMPNO",

																	"I_DATE","U_DATE"
             				
					                                 
																			}; 

				int[] intArrCN = new int[] { 10, 30, 10, 1,
					
															5, 50,
															
															5, 50, 																		  
					                            
					                            			5, 50,  

															5, 50, 																		  
					                            
															5, 50,
					                            
					                            			5, 50, 
					                            
					                            			10, 10, 10, 10
					                            
					                           
																			}; 
			
				int[] intArrCN2 = new int[]{ -1,-1, 0, -1,
					
															-1,-1,

                                     						-1,-1,
                                     						
															-1,-1,
                                     					                           
					                         				-1,-1,
					                         				
					                         				-1, -1,
					                         				
															-1, -1,
					                         				
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

						sql.append( "	SELECT A.EMPNO, A.EMPNMK, COALESCE(A.CUST_SID,0)	CUST_SID, ''CHK,  \n");
						sql.append( "				 A.VEND_CD, 		B.DETAIL_NM AS VEND_NM,       			\n");
						sql.append( "				 A.DEPT_CD, 		C.DETAIL_NM AS DEPT_NM,       			\n");
						sql.append( "				 A.C_VEND_CD, 	D.DETAIL_NM AS C_VEND_NM,       		\n");
						sql.append( "				 A.WORK_CD,		E.DETAIL_NM AS WORK_NM,      			\n");
						sql.append( "				 A.CLASS_CD,		F.DETAIL_NM AS CLASS_NM,       		\n");
						sql.append( "				 A.JOB_CD,  		G.DETAIL_NM AS JOB_NM,        			\n");
            			sql.append( "				 A.I_EMPNO, A.I_DATE, A.U_EMPNO, A.U_DATE 				\n");

						sql.append( "	FROM SALES.KST010 A                             \n");
						sql.append( "	LEFT JOIN SALES.TSY010 B ON RTRIM(B.DETAIL) = RTRIM(A.VEND_CD) AND B.HEAD='KS007' AND RTRIM(B.DETAIL)<>''  \n");
						sql.append( "	LEFT JOIN SALES.TSY010 C ON RTRIM(C.DETAIL) = RTRIM(A.DEPT_CD) AND C.HEAD='KS006' AND RTRIM(C.DETAIL)<>''  \n");
						sql.append( "	LEFT JOIN SALES.TSY010 D ON RTRIM(D.DETAIL) = RTRIM(A.C_VEND_CD)  AND D.HEAD='KS008'  AND RTRIM(D.DETAIL)<>''   \n");
						sql.append( "	LEFT JOIN SALES.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.WORK_CD) AND E.HEAD='KS001' AND RTRIM(E.DETAIL)<>''  \n");
						sql.append( "	LEFT JOIN SALES.TSY010 F ON RTRIM(F.DETAIL) = RTRIM(A.CLASS_CD)  AND F.HEAD='KS014'  AND RTRIM(F.DETAIL)<>''   \n");
						sql.append( "	LEFT JOIN SALES.TSY010 G ON RTRIM(G.DETAIL) = RTRIM(A.JOB_CD) AND G.HEAD='KS002'   AND RTRIM(G.DETAIL)<>'' \n");            
						
						sql.append( "	WHERE 1=1   \n");

						if(!str1.equals(""))sql.append( "	  AND A.EMPNO = '"+str1+"'      	\n");
						if(!str2.equals(""))sql.append( "	  AND A.EMPNMK LIKE '"+str2+"%' \n");
						if(!str3.equals(""))sql.append( "	  AND A.DEPT_CD = '"+str3+"'    	\n");


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