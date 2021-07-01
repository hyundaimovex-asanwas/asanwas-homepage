//**참고사항. delete,update할떼는 where절 이후에 primary key 컬럼을 꼭 추가해서 써준다***
package North.northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
//import java.util.*;

public class KS_Em049_t1 extends HttpServlet{ 
	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;
			try {
				conn = service.getDBConnection();
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				conn.setAutoCommit(false);

				//파라메타 받아오는것 선언

				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String strPaycd="";
				String strMemo="";
				String strCurYM="";
				String strCurYMD="";
				String strYYmm="";   //급여년월 -1 월 ( 실제 급여 지급 월분)
				String strYYmm2="";  //급여년월 -2 월 ( 

				//파라메타 받아오는것 선언
				String usrid = reqGauce.getParameter("v_str1");
			
				String[] strArrCN = new String[]{ "PAY_YM","PAY_GB","EMPNO"  
					
																			  };

				int[] idx = new int[3]; //컬럼갯수를 넣어준다.

				for (int i=0; i<strArrCN.length; i++) {
								idx[i] = userSet.indexOfColumn(strArrCN[i]);
						}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				
/******************************** **********************************************
* INSERT 처리
*********************************************************************************/

			if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

            //////////////////////////////////////////////////////
            //급여 작업 테이블 처리 시작  
            ////////////////////////////////////////////////////// 

            //기존데이타 DELETE 

					/*+++++++++++++++++++++++++++++++++++++++++++++++ 
							급여 계산 기초 데이타
					+++++++++++++++++++++++++++++++++++++++++++++++*/

						// 그달의 가동일수 구하기========================================================
						StringBuffer sql9 = new StringBuffer();
						Statement stmt9= null;
						ResultSet rs9 = null;

						String WK_DAY_GA="";

						sql9.append( " SELECT WK_DAY														\n" )
							  .append( "   FROM ATP.KST140												\n" )
							  .append( "   WHERE ATT_YM = '"+rows[j].getString(idx[0])+"'		\n" );

						stmt9 = conn.createStatement();
						rs9 = stmt9.executeQuery(sql9.toString());

						while (rs9.next())	{

								WK_DAY_GA=rs9.getString(1);

						}
						//System.out.println("sql9 \n" + sql9.toString());	
						rs9.close();
						stmt9.close();


						 //급여지급년월 - 1 개월===========================================================

						StringBuffer sql0 = new StringBuffer();
						Statement stmt0= null;
						ResultSet rs0 = null;

						strCurYM = rows[j].getString(idx[0]);  //급여년월
						strCurYMD =  strCurYM.substring(0,6)+"20"; //급여년월의 1일

						//System.out.println("strCurYM \n" + strCurYM.toString());	
						//System.out.println("strCurYMD \n" + strCurYMD.toString());							
						
						//sql0.append( " SELECT SUBSTR(REPLACE(CHAR((CAST('"+strCurYMD+"' AS DATE) - 0 MONTH ) ,ISO),'-',''),1,8),   		\n" )
						//	  .append( "        SUBSTR(REPLACE(CHAR((CAST('"+strCurYMD+"' AS DATE) - 1 MONTH + 1 DAY ) ,ISO),'-',''),1,8)   \n" )
						//	  .append( "   FROM DUAL    																															\n" );
						//TO_CHAR(ADD_MONTHS('"+strCurYMD+"',1),'YYYYMMDD')
						
						
						sql0.append( " SELECT TO_CHAR(ADD_MONTHS('"+strCurYMD+"',1),'YYYYMMDD'),   		\n" )
							  .append( "        		TO_CHAR(TO_NUMBER('"+strCurYMD+"'+1))   							\n" )
							  .append( "   FROM DUAL    																				\n" );						
						
						stmt0 = conn.createStatement();
						rs0 = stmt0.executeQuery(sql0.toString());

						while (rs0.next())	{
								strYYmm=rs0.getString(1);
								strYYmm2 = rs0.getString(2);
						}
						
						//System.out.println("sql0 \n" + sql0.toString());	
						
						rs0.close();
						stmt0.close();

						//================================================================================
						//기존데이타 DELETE 

						StringBuffer DeleteSql = new StringBuffer();

						DeleteSql.append( " DELETE FROM ATP.KST200							\n")
									  .append( "	 WHERE PAY_YM=?										\n")
				  					  .append( "    AND PAY_GB=?										\n");

					
						
						GauceStatement gsmt_0 = conn.getGauceStatement(DeleteSql.toString());

						gsmt_0.setGauceDataRow(rows[j]);

						gsmt_0.bindColumn(1, idx[0]);
						gsmt_0.bindColumn(2, idx[1]);

						//System.out.println("DeleteSql \n" + DeleteSql.toString());								
						//System.out.println("나한테 그러지마1 \n");						
						
						//System.out.println("ows[j].getString(idx[0])::"+rows[j].getString(idx[0]));        						
						
						gsmt_0.executeUpdate();
						gsmt_0.close();
						
						//System.out.println("나한테 그러지마2 \n");	
						
						//logger.dbg.println(this,"PAY_YM,    		rows[j].getString(idx[0])::"+rows[j].getString(idx[0]));    
						//logger.dbg.println(this,"PAY_GB,    		rows[j].getString(idx[1])::"+rows[j].getString(idx[1]));    						
						//logger.dbg.println(this,"step3");


						//급여대상자 생성 --년차도 자동으로 가져옴 =======================================================================================================================================

						StringBuffer InsertSql = new StringBuffer();

						InsertSql.append(" INSERT INTO ATP.KST200 (																		\n" )
						 			 .append("                             PAY_YM, PAY_GB, EMPNO,										\n" )
						 			 .append("                             PAY_DT, VEND_CD, DEPT_CD,									\n" )
						 			 .append("                             JOB_CD, WORK_CD, C_VEND_CD, CLASS_CD,				\n" )
						 			 .append("                             M_PAY, D_PAY, T_PAY, WK_DAY,								\n" )
						 			 .append("                             B_H, O_H, N1_H, N2_H, H_D, H_TIME,  E_H,					\n" )
						 			 .append("                             HOL_1, HOL_2, HOL_3, HOL_4, HOL_5,						\n" )
						 			 .append("                             B_PAY, X_PAY, S_PAY, TOT_PAY,								\n" )
						 			 .append("                             HOL_PAY, M_TOT_PAY,												\n" )
						 			 .append("                             SABO_PAY, SUB_PAY,												\n" )
						 			 .append("                             I_EMPNO, I_DATE, U_EMPNO,U_DATE							\n" )
							         .append("                             )																			\n" )
				
										 .append("   SELECT  '"+rows[j].getString(idx[0])+"','"+rows[j].getString(idx[1])+"', X.EMPNO, '',																	\n" )
										 .append("   			 nvl(MAX(Y.VEND_CD),' ')VEND_CD, nvl(MAX(Y.DEPT_CD),' ')DEPT_CD, nvl(MAX(Y.JOB_CD),' ')JOB_CD,							\n" )	 
										 .append("   			 nvl(MAX(Y.WORK_CD),' ')WORK_CD, nvl(MAX(Y.C_VEND_CD),' ')C_VEND_CD, nvl(MAX(Y.CLASS_CD),' ')CLASS_CD,		\n" )
										 .append("   			 nvl(MAX(X.M_PAY),0)M_PAY, nvl(MAX(X.D_PAY),0)D_PAY, 																						\n" )
										 .append("   			 nvl(MAX(X.T_PAY),0)T_PAY, 																																\n" )
										 .append("   			 nvl(MAX(X.WK_DAY),0)WK_DAY,																															\n" )
										 
//										 .append("				 CASE WHEN ((nvl(MAX(X.WK_DAY),0))+nvl(MAX(X.H_D),0)) < '25' THEN ((nvl(MAX(X.WK_DAY),0))+nvl(MAX(X.H_D),0))   	\n" )																														
//										 .append("				 WHEN ((nvl(MAX(X.WK_DAY),0))+nvl(MAX(X.H_D),0)) >= '25' THEN nvl(MAX(X.WK_DAY),0) END AS WK_DAY,					\n" )	

										 .append("				 nvl(MAX(X.B_H),0) - nvl(MAX(X.H_TIME2),0) AS B_H,																								\n" )										 

//										 .append("				 CASE WHEN ((nvl(MAX(X.WK_DAY),0))) < '"+WK_DAY_GA+"' THEN (nvl(MAX(X.B_H),0))   							\n" )	
//										 .append("				 WHEN ((nvl(MAX(X.WK_DAY),0))) = '"+WK_DAY_GA+"' THEN (nvl(MAX(X.B_H),0))										\n" )											 
//										 .append("				 WHEN ((nvl(MAX(X.WK_DAY),0))) > '"+WK_DAY_GA+"' THEN (nvl(MAX(X.B_H),0)) END AS B_H,					\n" )	

										 .append("				 nvl(MAX(X.O_H),0) O_H,																														\n" )																																							
										 .append("				 nvl(MAX(X.N1_H),0) N1_H,																													\n" )	
										 .append("				 nvl(MAX(X.N2_H),0) N2_H,																													\n" )											 
										 .append("				 nvl(MAX(X.H_D),0) H_D,																														\n" )	

										 
//										 .append("				 CASE WHEN ((nvl(MAX(X.WK_DAY),0))+nvl(MAX(X.H_D),0)) >= '25' THEN (nvl(MAX(X.H_D),0))   				\n" )																											
//										 .append("						  WHEN ((nvl(MAX(X.WK_DAY),0))+nvl(MAX(X.H_D),0)) < '25' THEN '0' END AS H_D,								\n" )	

										 .append("				 nvl(MAX(X.H_TIME),0) H_TIME,																												\n" )	
										 
										 .append("				 nvl(MAX(X.E_H),0) E_H,																														\n" )														 
										 .append("   			 nvl(MAX(X.HOL_1),0)HOL_1, nvl(MAX(X.HOL_2),0)HOL_2, nvl(MAX(X.HOL_3),0)HOL_3,								\n" )
										 .append("   			 nvl(MAX(X.HOL_4),0)HOL_4, nvl(MAX(X.HOL_5),0)HOL_5,																		\n" )
										 .append("				 0,0,0,0,																																				\n" )
										 .append("				 0,0,0,0,																																				\n" )             
										 .append("				 '"+rows[j].getString(idx[2])+"',sysdate,'"+rows[j].getString(idx[2])+"',sysdate        										\n" )					
										 .append("			   FROM (																																				\n" )
										 .append("			          SELECT A.EMPNO,																														\n" )
										 .append("			                  nvl(MAX(A.M_PAY),0) M_PAY, nvl(MAX(L.D_PAY),0) D_PAY, nvl(MAX(L.T_PAY),0)T_PAY,           		\n" )     
										 .append("			                  SUM(A.M_H) + SUM(A.A_H) AS B_H,																						\n" )     
										 .append("			                  SUM(CASE WHEN C.DAY_GB ='1' THEN (A.O_H) END)  O_H,														\n" )     
										 .append("			                  SUM(CASE WHEN C.DAY_GB ='1' THEN (A.N1_H) END) N1_H,														\n" )     
										 .append("			                  SUM(CASE WHEN C.DAY_GB ='1' THEN (A.N2_H) END) N2_H,														\n" )     
										 .append("			                  (COUNT(CASE WHEN (C.DAY_GB IN ('2', '3') AND A.SAYU_GB IN ('0')) THEN A.EMPNO END )) -(COUNT(CASE WHEN (C.DAY_GB IN ('2', '3') AND B.VEND_CD NOT IN( '05','61') AND A.SAYU_GB IN ('0')) THEN A.EMPNO END )) H_D,	\n" )     

										 .append("			                  SUM(CASE WHEN (C.DAY_GB IN ('2', '3') AND A.SAYU_GB IN ('0')) THEN (M_H+A_H+O_H+N2_H) END ) H_TIME,		\n" )     
										 .append("			                  SUM(CASE WHEN (C.DAY_GB IN ('2', '3') AND A.SAYU_GB IN ('0')) THEN (M_H+A_H) END ) H_TIME2,					\n" ) 

										 .append("			                  SUM(A.E_H)  AS E_H,																																\n" )     										 										 
										 .append("			                       COUNT(CASE WHEN A.SAYU_GB IN ('0') THEN A.EMPNO END ) - COUNT(CASE WHEN (C.DAY_GB IN ('2', '3') AND B.VEND_CD NOT IN ('05', '61') AND A.SAYU_GB IN ('0')) THEN A.EMPNO END ) WK_DAY,         						\n" )		       
										 .append("			                       COUNT(CASE WHEN A.SAYU_GB IN ('2') THEN A.EMPNO END ) HOL_1,									\n" )                                                               
										 .append("			                       COUNT(CASE WHEN A.SAYU_GB IN ('3') THEN A.EMPNO END ) HOL_2,                					\n" )		       
										 .append("			                       COUNT(CASE WHEN A.SAYU_GB IN ('4') THEN A.EMPNO END ) HOL_3,             						\n" )	                             		
										 .append("			                       COUNT(CASE WHEN A.SAYU_GB IN ('5') THEN A.EMPNO END ) HOL_4,           							\n" )	       
										 .append("			                       COUNT(CASE WHEN A.SAYU_GB IN ('6') THEN A.EMPNO END ) HOL_5            							\n" )	         
										 .append("			            FROM ATP.KST100 A          																									\n" )
										 .append("			            LEFT JOIN ATP.KST010 B ON A.EMPNO = B.EMPNO																	\n" )
										 .append("			            LEFT JOIN ATP.KST130 C ON C.ATT_DT = A.ATT_DT																	\n" )
										 .append("			            LEFT JOIN ATP.KST210 L ON L.P_GB = B.P_GB AND L.ATT_YM = '"+rows[j].getString(idx[0])+"'		\n" )	                                                       
										 .append("			           WHERE  A.ATT_DT BETWEEN '"+strYYmm2+"' AND   '"+strYYmm+"'									\n" )
										 .append("				           GROUP BY A.EMPNO				      																	\n" )
										 .append("					) X																														\n" )                     
										 .append("					LEFT JOIN ATP.KST010 Y ON X.EMPNO = Y.EMPNO														\n" )
										 .append("			           GROUP BY X.EMPNO																							\n" )
										 .append("			           ORDER BY X.EMPNO																							\n" );
						    
							//System.out.println("InsertSql \n" + InsertSql.toString());							
							//logger.dbg.println(this, InsertSql.toString());
							
							GauceStatement gsmt_1 = conn.getGauceStatement(InsertSql.toString()); //로그남기는것
							gsmt_1.setGauceDataRow(rows[j]);
							
							gsmt_1.executeUpdate();
							gsmt_1.close();

					}
				
			}


			}catch(Exception e){
				conn.rollback();
				
				logger.err.println(this,e.getMessage());	
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();


		}
		catch (Exception e) {
			logger.err.println(this,e.getMessage());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}


