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
public class KS_Em026_S1 extends HttpServlet {

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
				String [] str = new String[6];

        		str[0] =  req.getParameter("v_str1"); 		// 직장구분 
				str[1] =  req.getParameter("v_str2"); 		// 소속
				str[2] =  req.getParameter("v_str3"); 		// 출근일자시작
				str[3] =  req.getParameter("v_str4"); 		// 출근일자끝
				str[4] =  req.getParameter("v_str5");		// 직번 
				str[5] =  req.getParameter("v_str6");		// 이름 
				
        for(int i=0;i<=5;i++){
					if(str[i]==null) str[i]="";
				} 
				
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{  
                                                                      
					"ATT_DT",
					"EMPNO", 	"EMPNMK",		//3
					"VEND_CD", 	"VEND_NM",
					"DEPT_CD", 	"DEPT_NM",
					"JOB_CD", 	 "JOB_NM",

					"C_VEND_CD", 	"C_VEND_NM",
					"CLASS_CD", 	"CLASS_NM",	// 15
					
					"WEEK_GB",
					"WORK_GB",
					"SAYU_GB",
					"MODI_YN",							//19
					
					"M_PAY",
					"D_PAY",
					"T_PAY",								//22
					
					"A_TM",
					"L_TM",
					"E_TM",
					"G_TM",
					"R_TM",								//27
					
					
					"FINI_GB",
					"C_A_TM",
					"C_L_TM",
					"C_E_TM",						//31
					
					
					"M_H",
					"A_H",
					"O_H",
					"N1_H",
					"N2_H",
					"E_H",
					"T_H",
					"G_H",								//39
					
					"CHK",								//40
					
					"I_EMPNO",
					"I_DATE",
					"U_EMPNO",
					"U_DATE"							//44

																			}; //

				int[] intArrCN = new int[] { 10, 10, 10,
					
												5, 10, 
												5, 10, 
												5, 10, 

												5, 10, 
												5, 10, 					//
												
												1, 1, 1, 1,				//
												
												10, 10, 10,			//
												
												5, 5, 5, 5, 5,			//
												
												1, 5, 5, 5,				//
												
												5, 5, 5, 5, 5, 5, 5, 5,		//
					
											   1, 10, 50, 5, 50			//

					                            
																			}; 
			
				int[] intArrCN2 = new int[]{ -1,-1, -1,		//3
					
												-1,-1,-1,-1, 		

												-1,-1,-1,-1,-1,-1, 		//15
					                            
												-1,-1, -1, -1,
												
												0, 0, 0,
												
												-1,-1,-1,-1,-1,
												
												-1,-1, -1, -1,
												
												0, 0, 0, 0, 0, 0, 0,	0,				
													
												-1, -1,-1, -1, -1							
				                           
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
	
						sql.append( "	SELECT H.ATT_DT, A.EMPNO,   A.EMPNMK,                               				    \n");
						sql.append( "	       A.VEND_CD, B.DETAIL_NM AS VEND_NM,                                        	\n");
						sql.append( "	       A.DEPT_CD, C.DETAIL_NM AS DEPT_NM,                                         	\n");
						sql.append( "	       A.JOB_CD, D.DETAIL_NM AS JOB_NM,                                       			\n");
						sql.append( "	       A.C_VEND_CD, E.DETAIL_NM AS C_VEND_NM,                                   \n");
						sql.append( "	       A.CLASS_CD, F.DETAIL_NM AS CLASS_NM,                                        \n");
						sql.append( "	       J.DAY_GB AS WEEK_GB, H.WORK_GB, H.SAYU_GB,  H.MODI_YN,       \n");
						sql.append( "	       H.M_PAY,H.D_PAY, H.T_PAY,  H.A_TM,                  								\n");						
						sql.append( "	       H.L_TM,H.E_TM, H.G_TM,  H.R_TM,  H.FINI_GB,                 					\n");								
						sql.append( "	       H.C_A_TM,H.C_L_TM, H.C_E_TM,  H.M_H,                  						\n");						
						sql.append( "	       H.A_H,H.O_H, H.N1_H,  H.N2_H, H.E_H,  H.T_H,   H.G_H,               	\n");																	
						sql.append( "	       ''CHK,  A.I_EMPNO,  A.I_DATE,  A.U_EMPNO, A.U_DATE						\n");												
												
						sql.append( "	  FROM ATP.KST010 A                                                            \n");
						sql.append( "	  LEFT  JOIN ATP.TSY010 B ON RTRIM(B.DETAIL) = RTRIM(A.VEND_CD) AND B.HEAD='KS007' AND RTRIM(B.DETAIL) IS NOT NULL   \n");	
						sql.append( "	  LEFT  JOIN ATP.TSY010 C ON RTRIM(C.DETAIL) = RTRIM(A.DEPT_CD) AND C.HEAD='KS006' AND RTRIM(C.DETAIL) IS NOT NULL   \n");	
						sql.append( "	  LEFT  JOIN ATP.TSY010 D ON RTRIM(D.DETAIL) = RTRIM(A.JOB_CD) AND D.HEAD='KS002' AND RTRIM(D.DETAIL) IS NOT NULL   \n");	
						sql.append( "	  LEFT  JOIN ATP.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.C_VEND_CD) AND E.HEAD='KS008' AND RTRIM(E.DETAIL) IS NOT NULL   \n");	
						sql.append( "	  LEFT  JOIN ATP.TSY010 F ON RTRIM(F.DETAIL) = RTRIM(A.CLASS_CD) AND F.HEAD='KS014' AND RTRIM(F.DETAIL) IS NOT NULL   \n");	
						sql.append( "	  LEFT  JOIN ATP.KST100 H ON RTRIM(H.EMPNO) = RTRIM(A.EMPNO)				  \n");	
						sql.append( "	  LEFT  JOIN ATP.KST130 J ON J.ATT_DT = H.ATT_DT				\n");			
						sql.append( "   WHERE 1=1   \n");

						if(!str[0].equals(""))sql.append( "	  AND A.DEPT_CD = '"+str[0]+"'										\n");
						if(!str[1].equals(""))sql.append( "	  AND A.VEND_CD = '"+str[1]+"'										\n");
						if(!str[2].equals(""))sql.append( "	  AND H.ATT_DT BETWEEN '"+str[2]+"' 	AND 	'"+str[3]+"'	\n");

						if(!str[4].equals(""))sql.append( "	  AND A.EMPNO = '"+str[4]+"'											\n");
						if(!str[5].equals(""))sql.append( "	  AND A.EMPNMK LIKE '"+str[5]+"%'									\n");

						sql.append( "	  ORDER BY H.ATT_DT																						\n");								
				
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