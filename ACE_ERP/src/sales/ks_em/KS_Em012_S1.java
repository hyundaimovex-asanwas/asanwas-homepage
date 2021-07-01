package sales.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class KS_Em012_S1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");   //gclx_usts.bindcolval 재직구분
				String  str2	= req.getParameter("v_str2");   // gclx_cmsosok.bindcolval 소속구분이겠고
				String  str3	= req.getParameter("v_str3");   // txt_nm.value  이름이겠

				if (str1==null) str1=""; 
				if (str2==null) str2=""; 
				if (str3==null) str3=""; 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
																				"ORD_DT",
																				"ORD_CD",
																				"ORD_NM",																					

																				"EMPNMK",
																				"EMPNO",					//5																		

																				"VEND_CD", 
																				"VEND_NM",																					
																				"DEPT_CD", 																			
																				"DEPT_NM",				//9
																				
																				"WORK_CD",
																				"WORK_NM",		
																				"C_VEND_CD", 					
																				"C_VEND_NM", 		//13
																																								
																				"CLASS_CD",																				
																				"CLASS_NM",																																																								
																				"JOB_CD",		
																				"JOB_NM",				//17
													
																				"START_DT",				//18		
																				"CHK"														
  																	
																			}; 	
																					
				int[] intArrCN = new int[] { 
																				8, 3, 10, 30, 10, 		//5
																				
																				5, 10, 5, 10, 				//9
																				
																				5, 10, 5, 10, 				//13
																																			
																				5, 10, 5, 10, 				//17
																				
																				8, 1				//18																				 	

																			};  
			
				int[] intArrCN2 = new int[]{
																				-1,-1,-1, -1, -1,
																				
																				-1,-1, -1,-1,		//9
																				
																				-1,-1, -1, -1, 
																				
																				-1,-1, -1, -1,    //17
																				
																				-1, -1

																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

			if (!GauceReq.isBuilderRequest()) {					
				StringBuffer sql = new StringBuffer();

				sql.append( "	SELECT            																	 				\n");
				sql.append( "   A.ORD_DT, A.ORD_CD, '' ORD_NM,										 				\n");
				sql.append( "   B.EMPNMK, A.EMPNO, A.VEND_CD, C.DETAIL_NM AS VEND_NM,		 	\n");
				sql.append( "   A.DEPT_CD, 	D.DETAIL_NM AS DEPT_NM, 										 \n");
				sql.append( "	A.WORK_CD, 	E.DETAIL_NM AS WORK_NM,											\n");						
				sql.append( "	A.C_VEND_CD,  F.DETAIL_NM AS C_VEND_NM,             							\n");										
				sql.append( "	B.CLASS_CD, 	G.DETAIL_NM AS CLASS_NM,                                          \n");
				sql.append( "	A.JOB_CD, 		H.DETAIL_NM AS	JOB_NM,												\n");					
				sql.append( "	B.START_DT, '' CHK   																				\n");

				sql.append( "		FROM SALES. KST015 A 													\n");
				sql.append( "		LEFT JOIN SALES.KST010 B ON A.EMPNO = B.EMPNO  \n");
				sql.append( "		LEFT JOIN SALES.TSY010 C ON RTRIM(C.DETAIL) = RTRIM(A.VEND_CD)    		AND C.HEAD='KS007'   AND RTRIM(C.DETAIL)<>''   \n");
				sql.append( "		LEFT JOIN SALES.TSY010 D ON RTRIM(D.DETAIL) = RTRIM(A.DEPT_CD)    		AND D.HEAD='KS006'   AND RTRIM(D.DETAIL)<>''   \n");
				sql.append( "		LEFT JOIN SALES.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.WORK_CD)    		AND E.HEAD='KS001'   AND RTRIM(E.DETAIL)<>''   \n");
				sql.append( "		LEFT JOIN SALES.TSY010 F ON RTRIM(F.DETAIL) = RTRIM(A.C_VEND_CD)    		AND F.HEAD='KS008'   AND RTRIM(F.DETAIL)<>''   \n");
				sql.append( "		LEFT JOIN SALES.TSY010 G ON RTRIM(G.DETAIL) = RTRIM(B.CLASS_CD)    		AND G.HEAD='KS014'   AND RTRIM(G.DETAIL)<>''   \n");
				sql.append( "		LEFT JOIN SALES.TSY010 H ON RTRIM(H.DETAIL) = RTRIM(A.JOB_CD)    		AND H.HEAD='KS002'   AND RTRIM(H.DETAIL)<>''   \n");


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