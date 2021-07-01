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
public class KS_Em042_S2 extends HttpServlet {

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

				String[] strArrCN = new String[]{  "PAY_YM",	 "PAY_GB", "EMPNO",
					
																	"EMPNMK", "PAY_DT",		//5
																			
																		"DEPT_CD", "DEPT_NM",

																		"VEND_CD", "VEND_NM",																		
																		
																		"JOB_CD", "JOB_NM",
																																					
																		"C_VEND_CD",												//12
																		
																		"M_PAY","D_PAY","T_PAY","WK_DAY",			//16
																		
																		"B_H", "O_H", "N1_H", "N2_H",	"H_TIME", "E_H",			//22
																																																																		
																		"HOL_1","HOL_2","HOL_3","HOL_4","HOL_5",	//27

																		
																		"B_PAY","X_PAY","S_PAY",							//30
																		
																		"TOT_PAY","HOL_PAY","M_TOT_PAY",			//33
																		
																		"SABO_PAY","SUB_PAY",								//35

																		"GITA","GITA2","COMMENT2",							//38
																		
																		"I_EMPNO","I_DATE","U_EMPNO","U_DATE"	//42
																		
             				
					                                 
																			}; 

				int[] intArrCN = new int[] {6, 1, 10,  30, 8,
					
															5, 20, 5, 20, 5, 20, 5,		//12
															
															10, 10, 10, 2, 			//16
										                            
										                    4, 4, 4, 4, 4, 4, 		//22        
										                            
										                    3, 3, 3, 3, 3, 		//27       
										                            
					                            			10, 10, 10, 10, 10, 10, //33
					                            
															10, 10, 10, 10, 50, 10, 10, 10, 10  //42
					                            
					                           
																			}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,				//5
					
														  -1,-1, -1, -1, -1, -1,-1,		//12
					                         				
															3, 3, 3, 0,						//16

																
															0, 0, 0, 0, 0, 0,					//22
																
															0, 0, 0, 0, 0,				//27

					                         				
															3, 3, 3, 3, 3, 3, 3, 3, 		//35
					                         				
					                         				3,  3, -1, -1,-1,-1,-1						//42
					                           
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	SELECT DISTINCT B.PAY_YM,	B.PAY_GB,	A.EMPNO,	A.EMPNMK,	B.PAY_DT,				\n");						
						sql.append( "				 A.DEPT_CD,	 RTRIM(J.DETAIL_NM)	DEPT_NM, 	   										\n");		
						sql.append( "				 A.VEND_CD,    RTRIM(K.DETAIL_NM)	VEND_NM,   										\n");	
						sql.append( "				 A.JOB_CD,    RTRIM(I.DETAIL_NM)	JOB_NM,   												\n");							
						sql.append( "				 A.WORK_CD, A.C_VEND_CD,	A.CLASS_CD,    											\n");		
						sql.append( "				 A.C_VEND_CD,   																					\n");								
						sql.append( "				 nvl(B.M_PAY,0) AS	 M_PAY,  nvl(B.D_PAY,0) AS	D_PAY,								\n");		
						sql.append( "				 nvl(B.T_PAY,0) AS	T_PAY,  nvl(B.WK_DAY,0) AS	WK_DAY,							\n");							
						sql.append( "				 nvl(B.B_H,0)   AS	 B_H,																			\n");	
						sql.append( "				 nvl(B.O_H,0)   AS	 O_H,  nvl(B.N1_H,0) AS	N1_H,									\n");		
						sql.append( "				 nvl(B.N2_H,0) AS	N2_H,  nvl(B.H_TIME,0) AS	H_TIME,								\n");		
						sql.append( "				 nvl(B.E_H,0)   AS	 E_H,																			\n");	
						sql.append( "				 nvl(B.HOL_1,0)   AS	 HOL_1,  nvl(B.HOL_2,0) AS	HOL_2,							\n");		
						sql.append( "				 nvl(B.HOL_3,0)   AS	 HOL_3,  nvl(B.HOL_4,0) AS	HOL_4,							\n");	
						sql.append( "				 nvl(B.HOL_5,0)   AS	 HOL_5,																	\n");	
						sql.append( "				 nvl(B.B_PAY,0) AS	B_PAY,  nvl(B.X_PAY,0) AS	X_PAY,								\n");	
						sql.append( "				 nvl(B.S_PAY,0) AS	 S_PAY,  nvl(B.TOT_PAY,0) AS	TOT_PAY,						\n");		
						sql.append( "				 nvl(B.HOL_PAY,0) AS	HOL_PAY,  nvl(B.M_TOT_PAY,0) AS	M_TOT_PAY,		\n");	
						sql.append( "				 nvl(B.SABO_PAY,0) AS	 SABO_PAY,  nvl(B.SUB_PAY,0) AS	SUB_PAY,		\n");	
						sql.append( "				 nvl(B.GITA,0) AS GITA, nvl(B.GITA2,0) AS GITA2, B.COMMENT2,					\n");							
            			sql.append( "				 A.I_EMPNO, A.I_DATE, A.U_EMPNO, A.U_DATE 											\n");
						sql.append( "	 FROM ATP.KST010 A																							\n");		
						sql.append( "	   LEFT JOIN ATP.KST200 B ON A.EMPNO = B.EMPNO												\n");						
						sql.append( "	   LEFT JOIN ATP.KST210 C ON B.PAY_YM = C.ATT_YM             									\n");						
						sql.append( "	   LEFT JOIN ATP.TSY010 J ON RTRIM(J.DETAIL) = RTRIM(A.DEPT_CD)    		AND J.HEAD='KS006'   AND RTRIM(J.DETAIL) IS NOT NULL    	\n");
						sql.append( "	   LEFT JOIN ATP.TSY010 K ON RTRIM(K.DETAIL) = RTRIM(A.VEND_CD)    	AND K.HEAD='KS007'   AND RTRIM(K.DETAIL) IS NOT NULL    \n");
						sql.append( "	   LEFT JOIN ATP.TSY010 I ON RTRIM(I.DETAIL) = RTRIM(A.JOB_CD)    		AND I.HEAD='KS002'   AND RTRIM(I.DETAIL) IS NOT NULL    	\n");						
						sql.append( "			WHERE 1=1															\n");						
						if(!str1.equals(""))sql.append( "	  AND C.ATT_YM = '"+str1+"'      					\n");
						if(!str2.equals(""))sql.append( "	  AND A.DEPT_CD = '"+str2+"'      				\n");
						if(!str3.equals(""))sql.append( "	  AND A.VEND_CD = '"+str3+"'      				\n");												
						sql.append( " ORDER BY A.DEPT_CD, 	A.C_VEND_CD, A.VEND_CD, D_PAY DESC, A.JOB_CD				\n");
						
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