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
public class KS_Em023_S1 extends HttpServlet {

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
				String [] str = new String[9];
        		str[0] =  req.getParameter("v_str1"); 		//직장구분 
				str[1] =  req.getParameter("v_str2"); 		//출근일자   
				str[2] =  req.getParameter("v_str3"); 		//직번
				str[3] =  req.getParameter("v_str4");		//이름 
				str[4] =  req.getParameter("v_str5");		// 요번달 
				str[5] =  req.getParameter("v_str6");		// 소속 
				str[6] =  req.getParameter("v_str7");		// 직영 
				str[7] =  req.getParameter("v_str8");		// 직종
				str[8] =  req.getParameter("v_str9");		// 올해		


        for(int i=0;i<=8;i++){
        	
					if(str[i]==null) str[i]="";
					
				} 
				
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{  
                                                                      
					"ATT_DT",
					"EMPNO", 	"EMPNMK",				//3
					"DEPT_CD", 	"DEPT_NM",
					"VEND_CD", 	"VEND_NM",
					"JOB_CD", 	 "JOB_NM",
					"C_VEND_CD", 	"C_VEND_NM",
					
					"WEEK_GB",
					"WORK_GB",
					"SAYU_GB",
					"MODI_YN",							//15
					
					"M_PAY",
					"D_PAY",
					"T_PAY",								//18
				
					"A_TM",
					"L_TM",
					"E_TM",
					"G_TM",
					"R_TM",								//23
										
					"FINI_GB",
					"C_A_TM",
					"C_L_TM",
					"C_E_TM",						//27
											
					"M_H",
					"A_H",
					"O_H",
					"N1_H",
					"N2_H",
					"E_H",
					"T_H",
					"G_H",										//35
					
					"TIME_PAY",
					"CHK",										
					"HOL_SUM",								//38
					
					"I_EMPNO",
					"I_DATE",
					"U_EMPNO",
					"U_DATE"									//42

																			}; 

				int[] intArrCN = new int[] { 10, 10, 10,
					
												5, 10, 
												5, 10, 
												5, 10, 
												5, 10, 									//11
											
												1, 1, 1, 1,								//15
												
												8, 8, 8,									//18
													
												5, 5, 5, 5, 5,							//23
												
												1, 5, 5, 5,								//27
												
												5, 5, 5, 5, 5, 5, 5, 5,				//35
												
												10, 1, 2, 10, 50, 10, 50		//42
				                            
																			}; 
			
				int[] intArrCN2 = new int[]{ -1,-1, -1,		//3
					
												-1,-1,-1,-1,-1,-1, 		//9

												-1,-1,-1,-1,-1,-1, 		//15
					                           												
												2, 2, 2,						//18  소수점 -_-;;;
													
												-1,-1,-1,-1,-1,			//23
												
												-1,-1,-1,-1,				//27
												
												 2, 2, 2, 2, 2, 2, 2, 2,		//35
														
												-1, -1, 0, -1,-1, -1, -1		//42		
				                           
																			}; 


				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
	
						sql.append( "	SELECT DISTINCT H.ATT_DT, A.EMPNO,   A.EMPNMK,                               	\n");
						sql.append( "	       A.DEPT_CD, B.DETAIL_NM AS DEPT_NM,											 	\n");
						sql.append( "	       A.VEND_CD, C.DETAIL_NM AS VEND_NM,                                        		\n");
						sql.append( "	       A.JOB_CD, D.DETAIL_NM AS JOB_NM,                                       			\n");
						sql.append( "	       A.C_VEND_CD, E.DETAIL_NM AS C_VEND_NM,                                  		\n");
						sql.append( "	       J.DAY_GB AS WEEK_GB ,'' WORK_GB, H.SAYU_GB,  H.MODI_YN,			\n");
						sql.append( "	       nvl(H.M_PAY,0) AS M_PAY,																\n");	
						sql.append( "		   nvl(H.D_PAY,0) AS D_PAY,                 												\n");					
						sql.append( "		   nvl(H.T_PAY,0) AS  T_PAY,  																\n");						
						sql.append( "	       H.A_TM, H.L_TM,                 																\n");								
						sql.append( "	       nvl(H.E_TM, 0) AS   E_TM,																	\n");	
						sql.append( "	       nvl(H.G_TM, 0) AS  G_TM,																	\n");	
						sql.append( "	       nvl(H.R_TM, 0) AS   R_TM,																	\n");	
						sql.append( "	       H.FINI_GB,																						\n");							
						sql.append( "	       H.C_A_TM,H.C_L_TM, H.C_E_TM,                  										\n");						
						sql.append( "	       nvl(H.M_H,0) AS M_H,  nvl(H.A_H,0) AS A_H,										\n");							
						sql.append( "	       nvl(H.O_H,0) AS O_H,  nvl(H.N1_H,0) AS N1_H,									\n");	
						sql.append( "	       nvl(H.N2_H,0) AS N2_H,																		\n");	
						sql.append( "	       nvl(H.E_H,0) AS E_H,  nvl(H.T_H,0) AS T_H,											\n");							
						sql.append( "	       nvl(H.G_H,0) AS G_H,																		\n");							
						sql.append( "	       L.T_PAY AS TIME_PAY, 																		\n");																			
						sql.append( "	       ''CHK,   0  AS HOL_SUM,																	\n");	
						sql.append( "	       A.I_EMPNO,  A.I_DATE,  A.U_EMPNO, A.U_DATE 									\n");					
						sql.append( "	  FROM ATP.KST010 A                                                           					\n");
						sql.append( "	  LEFT  JOIN ATP.KST130 J ON J.ATT_DT = '"+str[1]+"'									\n");	
						sql.append( "	  LEFT  JOIN ATP.TSY010 B ON RTRIM(B.DETAIL) = RTRIM(A.DEPT_CD) AND B.HEAD='KS006' AND RTRIM(B.DETAIL) IS NOT NULL			\n");	
						sql.append( "	  LEFT  JOIN ATP.TSY010 C ON RTRIM(C.DETAIL) = RTRIM(A.VEND_CD) AND C.HEAD='KS007' AND RTRIM(C.DETAIL) IS NOT NULL			\n");	
						sql.append( "	  LEFT  JOIN ATP.TSY010 D ON RTRIM(D.DETAIL) = RTRIM(A.JOB_CD) AND D.HEAD='KS002' AND RTRIM(D.DETAIL) IS NOT NULL				\n");	
						sql.append( "	  LEFT  JOIN ATP.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.C_VEND_CD) AND E.HEAD='KS008' AND RTRIM(E.DETAIL) IS NOT NULL			\n");	
						sql.append( "	  LEFT  JOIN ATP.KST100 H ON RTRIM(H.EMPNO) = RTRIM(A.EMPNO) AND H.ATT_DT = J.ATT_DT														\n");		
						sql.append( "	  LEFT  JOIN ATP.TSY010 I ON RTRIM(I.DETAIL) = RTRIM(H.WORK_GB) AND I.HEAD='KS016' AND RTRIM(I.DETAIL) IS NOT NULL				\n");		
						sql.append( "	  LEFT  JOIN ATP.KST210 L ON L.P_GB = A.P_GB AND L.ATT_YM =  '"+str[4]+"'			    				\n");	
						sql.append( "   WHERE 1=1																														\n");
						sql.append( "	  AND (A.USESTS = '1' OR (A.USESTS = '3' AND H.ATT_DT < A.END_DT))									\n");		
						if(!str[0].equals(""))sql.append( "	  AND A.DEPT_CD = '"+str[0]+"'																	\n");
						if(!str[2].equals(""))sql.append( "	  AND A.EMPNO = '"+str[2]+"'																	\n");
						if(!str[3].equals(""))sql.append( "	  AND A.EMPNMK LIKE '"+str[3]+"%'															\n");
						if(!str[5].equals(""))sql.append( "	  AND A.VEND_CD = '"+str[5]+"'																	\n");
						if(!str[6].equals(""))sql.append( "	  AND A.C_VEND_CD = '"+str[6]+"'																\n");
						if(!str[7].equals(""))sql.append( "	  AND A.JOB_CD = '"+str[7]+"'																	\n");		
						
						//System.out.println("KS_Em023_S1 \n" + sql.toString());
						//logger.dbg.println(this, sql.toString()); 				
								
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

