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
public class KS_Em010_S1 extends HttpServlet {

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
				String  str4	= req.getParameter("v_str4");   //
				String  str5	= req.getParameter("v_str5");   //				
				
				if (str1==null) str1=""; 
				if (str2==null) str2=""; 
				if (str3==null) str3=""; 
				if (str4==null) str4=""; 				
				if (str5==null) str5=""; 					
				

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
																			
																				"USESTS",	
																				"EMPNMK",
																				"EMPNO",																							
																				"SEX",		//4
																				
																				"BIRTHDAY",	
																				"RECOMMEND",																				
																				"START_DT",																				
																				"END_DT",		//8

																				"VEND_CD", 
																				"VEND_NM",																					
																				"DEPT_CD", 																			
																				"DEPT_NM",				
																				"JOB_CD",		
																				"JOB_NM",		//14

																				"WORK_CD",
																				"WORK_NM",
																				"C_VEND_CD", 					
																				"C_VEND_NM", 
																				"SKILL_CD", 
																				"SKILL_NM", 		//20
																				
																				"CLASS_CD",																				
																				"CLASS_NM",
																				"CON_YEAR", 		//23

																				"I_DATE",																				
																				"U_DATE",
																				"I_EMPNO",
																				"U_EMPNO",			//27

																				"ADDRESS",
																				"HEIGHT",
																				"WEIGHT",			//30
																				
																				"BLOOD",  
																				"ATT_CD",	 			 

																				"SCH_NM",  																					
																				"FAMILY",   			
																				"MARRIED" ,
																				"P_GB",			//36
																				"PICTURE"

																			}; 	
																					
				int[] intArrCN = new int[] { 
																				1, 30, 10, 1,		//4
																				
																				8, 1, 8, 8, 				//8
																				
																				10, 20, 10, 20, 10, 20, 		//14
																				
																				10, 20, 10, 20, 10, 20, 		//20
																				
																				10, 20, 2,				//23		
																																																												
																				20, 20, 10, 10,		//27
																																																										
																				50, 4, 4,				//30
																				  
																				2, 2, 					//32
																				
                                       											30, 2, 1, 1, 30				//37개																			 	

																			};  
			
				int[] intArrCN2 = new int[]{
																				-1,-1, -1, -1,
																				
																				-1,-1, -1,-1,		//8
																				
																				-1,-1, -1, -1, -1, -1,
																				
																				-1,-1, -1, -1, -1, -1,   //20
																				
																				-1, -1, 0, 
																																							
																				-1, -1,-1, -1,			//27
																																		 
																				-1, 0, 0, 
																																			
																				-1, -1,
										                                         
										                                        -1, 0, -1, -1, -1					//37	

																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	SELECT  A.USESTS,           																							\n");
						sql.append( "			RTRIM(A.EMPNMK) AS EMPNMK,  A.EMPNO AS  EMPNO, 											\n");
						sql.append( "	        A.SEX , TRIM(A.BIRTHDAY) AS BIRTHDAY,          														\n");
						sql.append( "			A.RECOMMEND, A.START_DT, NVL(A.END_DT,'')END_DT,   										\n");
						sql.append( "	        A.VEND_CD,	 	P.DETAIL_NM AS VEND_NM,                               							\n");
						sql.append( "	        A.DEPT_CD, 		K.DETAIL_NM AS DEPT_NM,  							             					\n");
						sql.append( "			A.JOB_CD, 		RTRIM(I.DETAIL_NM)	JOB_NM,														\n");	
						sql.append( "			A.WORK_CD, 	RTRIM(N.DETAIL_NM)	WORK_NM,														\n");						
						sql.append( "	       NVL(A.C_VEND_CD,0) C_VEND_CD,  Q.DETAIL_NM AS C_VEND_NM,								\n");										
						sql.append( "			A.SKILL_CD,  S.DETAIL_NM AS SKILL_NM, 																\n");
						sql.append( "	        A.CLASS_CD, 	M.DETAIL_NM AS CLASS_NM,                                          					\n");
						sql.append( "	        A.CON_YEAR, A.I_DATE, A.U_DATE,  A.I_EMPNO , A.U_EMPNO,              					\n");
						sql.append( "			A.ADDRESS, 	A.HEIGHT, A.WEIGHT , 																		\n");
						sql.append( "	       TRIM(A.BLOOD)   AS  BLOOD, NVL(A.ATT_CD,'')	ATT_CD,											\n");
						sql.append( "			NVL(A.SCH_NM,'')	SCH_NM, A.FAMILY,   A.MARRIED, L.P_GB,									\n");
						sql.append( "			A.PICTURE 																											\n");
						sql.append( "		FROM ATP. KST010 A                                                                                       		\n");
						sql.append( "		LEFT JOIN ATP.TSY010 N ON RTRIM(N.DETAIL) = RTRIM(A.WORK_CD)   	AND N.HEAD='KS001'  AND RTRIM(N.DETAIL) IS NOT NULL    \n");
						sql.append( "		LEFT JOIN ATP.TSY010 I ON RTRIM(I.DETAIL) = RTRIM(A.JOB_CD)    		AND I.HEAD='KS002'   AND RTRIM(I.DETAIL) IS NOT NULL    \n");
						sql.append( "		LEFT JOIN ATP.TSY010 G ON RTRIM(G.DETAIL) = RTRIM(A.ATT_CD)    	AND G.HEAD='KS003'  AND RTRIM(G.DETAIL) IS NOT NULL    \n");
						sql.append( "		LEFT JOIN ATP.TSY010 K ON RTRIM(K.DETAIL) = RTRIM(A.DEPT_CD)   	AND K.HEAD='KS006'  AND RTRIM(K.DETAIL) IS NOT NULL    \n");
						sql.append( "		LEFT JOIN ATP.TSY010 P ON RTRIM(P.DETAIL) = RTRIM(A.VEND_CD)    	AND P.HEAD='KS007'  AND RTRIM(P.DETAIL) IS NOT NULL    \n");
						sql.append( "		LEFT JOIN ATP.TSY010 Q ON RTRIM(Q.DETAIL) = RTRIM(A.C_VEND_CD)  AND Q.HEAD='KS008'  AND RTRIM(Q.DETAIL) IS NOT NULL    \n");
						sql.append( "		LEFT JOIN ATP.TSY010 S ON RTRIM(S.DETAIL) = RTRIM(A.SKILL_CD)    	 AND S.HEAD='KS009'  AND RTRIM(S.DETAIL) IS NOT NULL    \n");
						sql.append( "		LEFT JOIN ATP.TSY010 M ON RTRIM(M.DETAIL) = RTRIM(A.CLASS_CD)    AND M.HEAD='KS014'  AND RTRIM(M.DETAIL) IS NOT NULL    \n");
						if(!str4.equals(""))sql.append( "	  LEFT  JOIN ATP.KST210 L ON L.P_GB = A.P_GB AND L.ATT_YM =  '"+str4+"'			  												\n");	
						sql.append( "	WHERE 1=1                           									\n");
						if(!str1.equals(""))sql.append( "	  AND A.USESTS = '"+str1+"'         		\n");
						if(!str2.equals(""))sql.append( "	  AND A.VEND_CD =  '"+str2+"'  			\n");
						if(!str5.equals(""))sql.append( "	  AND A.DEPT_CD =  '"+str5+"'  			\n");
						if(!str3.equals(""))sql.append( "	  AND A.EMPNMK LIKE '%"+str3+"%'     \n");
						sql.append( "	ORDER BY A.EMPNO, A.EMPNMK                    			\n");

						//System.out.println("KS_Em010_S1 \n" + sql.toString());			
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