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

public class KS_Em049_t8 extends HttpServlet{

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
				/*******************************************************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				//logger.dbg.println(this,"공제처리");

				String strPaycd="";
				String strMemo="";
				String strCurYM="";
				String strCurYMD="";				


				//파라메타 받아오는것 선언
				String usrid = reqGauce.getParameter("v_str1");
			
				String[] strArrCN = new String[]{ 
					
																"PAY_YM","PAY_GB","EMPNO"   
																	
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

					 /*+++++++++++++++++++++++++++++++++++++++++++++++ 
							급여계산작업 시작 : 예외처리 계산
					  +++++++++++++++++++++++++++++++++++++++++++++++*/

						for(int k=1;k<=1;k++) { 

							 if (k==1){
								 strPaycd ="006"; 
								 strMemo="예외처리 계산중";  //기본급
							 }

							 StringBuffer InsertSql_2 = new StringBuffer();
						
							 InsertSql_2.append("  INSERT INTO ATP.KST299 (														\n" )
													.append("   APPDT,	PAYDIV,	 PAYDT,	  PBDIV,	PAYCD,						\n" )
													.append("    FRDT,	FRTM,	    TODT, 	 TOTM, 	WRKSTS,				\n" )
													.append("    MEMO,  I_EMPNO,I_DATE,	U_EMPNO,	U_DATE				\n" )
													.append("  ) VALUES (																	\n" )
													.append("  '"+rows[j].getString(idx[0])+"',											\n" )
													.append("  '"+rows[j].getString(idx[1])+"',											\n" )
													.append("  '','1',																			\n" )
													.append("  '"+strPaycd+"',																\n" )
													.append("   '','',																			\n" )													
													//.append("   REPLACE(CHAR(CURRENT DATE ,ISO),'-',''),					\n" )
													//.append("   REPLACE(REPLACE(CHAR(CURRENT TIME ,ISO),'.',''),':',''),  \n" )
													.append("   '','',																			\n" )
													.append("   '1',																			\n" ) //진행중
													.append("   '"+strMemo+"',																\n" )
													.append("  '"+rows[j].getString(idx[2])+"', sysdate,							\n" )
													.append("  '"+rows[j].getString(idx[2])+"', sysdate) 							\n" );
						
							GauceStatement gsmt_2 = conn.getGauceStatement(InsertSql_2.toString()); 
							gsmt_2.setGauceDataRow(rows[j]);
							
							gsmt_2.executeUpdate();
							gsmt_2.close();

						}


					  /*+++++++++++++++++++++++++++++++++++++++++++++++ 
					  		급여계산작업 시작 : 일반관리비 계산 
					  +++++++++++++++++++++++++++++++++++++++++++++++*/
/*
						StringBuffer UpdateSql6 = new StringBuffer();

						UpdateSql6.append("  UPDATE ATP.KST200 																				\n" )
										.append("       SET																								\n" )		
										.append("         MANAGE_PAY = ROUND(M_TOT_PAY/D_PAY, 4)									\n" )														
										.append( "	 WHERE PAY_YM=?																				\n" );
					
						GauceStatement gsmt_7 = conn.getGauceStatement(UpdateSql6.toString()); //로그남기는것
						
						gsmt_7.setGauceDataRow(rows[j]);
						gsmt_7.bindColumn(1, idx[0]);
						
						gsmt_7.executeUpdate();
						gsmt_7.close();
*/
		           /*+++++++++++++++++++++++++++++++++++++++++++++++ 
						예외처리 계산
					+++++++++++++++++++++++++++++++++++++++++++++++*/

						strCurYM = rows[j].getString(idx[0]);  //급여년월
						strCurYMD =  strCurYM+"20"; //급여년월의 1일

						StringBuffer InsertSql = new StringBuffer();

						InsertSql.append("  UPDATE ATP.KST200 SET																			\n" )
										.append("         PAY_DT = '"+strCurYMD+"',																\n" )		
										.append("         M_PAY = ROUND(( M_TOT_PAY + SABO_PAY + SUB_PAY + S_PAY ),3)	\n" )													
										.append( "	 WHERE PAY_YM=?																				\n" )
				  						.append( "    AND PAY_GB=?																					\n" );

						GauceStatement gsmt_1 = conn.getGauceStatement(InsertSql.toString()); //로그남기는것
						gsmt_1.setGauceDataRow(rows[j]);
						
						gsmt_1.bindColumn(1, idx[0]);
						gsmt_1.bindColumn(2, idx[1]);
						
						gsmt_1.executeUpdate();
						gsmt_1.close();

						/*+++++++++++++++++++++++++++++++++++++++++++++++ 
							급여계산작업 시작 : 예외처리 계산 - 화약고 - 일반
					  +++++++++++++++++++++++++++++++++++++++++++++++*/

						StringBuffer UpdateSql2 = new StringBuffer();

						UpdateSql2.append("  UPDATE ATP.KST200 																				\n" )
										.append("       SET																								\n" )		
										.append("         M_PAY = '150',																				\n" )		
										.append("         D_PAY = '0',																					\n" )													
										.append("         T_PAY = '0',																					\n" )	
										.append("         B_PAY = '130.44',																			\n" )													
										.append("         X_PAY = '0',																					\n" )	
										.append("         M_TOT_PAY = '130.44',																	\n" )													
										.append("         SABO_PAY = '19.56'																		\n" )	
										.append( "	 WHERE PAY_YM=?																				\n" )
				  						.append( "    AND VEND_CD = '61'																			\n" );


						GauceStatement gsmt_3 = conn.getGauceStatement(UpdateSql2.toString()); //로그남기는것
						
						gsmt_3.setGauceDataRow(rows[j]);
						gsmt_3.bindColumn(1, idx[0]);
						
						gsmt_3.executeUpdate();
						gsmt_3.close();

						/*+++++++++++++++++++++++++++++++++++++++++++++++ 
							급여계산작업 시작 : 예외처리 계산 - 화약고 - 조장
					  +++++++++++++++++++++++++++++++++++++++++++++++*/

						StringBuffer UpdateSql3 = new StringBuffer();

						UpdateSql3.append("  UPDATE ATP.KST200 																				\n" )
										.append("       SET																								\n" )		
										.append("         M_PAY = '200',																				\n" )		
										.append("         D_PAY = '0',																					\n" )													
										.append("         T_PAY = '0',																					\n" )	
										.append("         B_PAY = '173.91',																			\n" )													
										.append("         X_PAY = '0',																					\n" )	
										.append("         M_TOT_PAY = '173.91',																	\n" )													
										.append("         SABO_PAY = '26.09'																		\n" )	
										.append( "	 WHERE PAY_YM=?																				\n" )
				  						.append( "    AND VEND_CD = '61'																			\n" )
				  						.append( "    AND JOB_CD = '55'																			\n" );


						GauceStatement gsmt_4 = conn.getGauceStatement(UpdateSql3.toString()); //로그남기는것
						
						gsmt_4.setGauceDataRow(rows[j]);
						gsmt_4.bindColumn(1, idx[0]);
						
						gsmt_4.executeUpdate();
						gsmt_4.close();


						/*+++++++++++++++++++++++++++++++++++++++++++++++ 
							급여계산작업 시작 : 예외처리 계산 - 화약고 - 조장
					  +++++++++++++++++++++++++++++++++++++++++++++++*/

						StringBuffer UpdateSql4 = new StringBuffer();

						UpdateSql4.append("  UPDATE ATP.KST200 																				\n" )
										.append("       SET																								\n" )		
										.append("         M_PAY = '200',																				\n" )		
										.append("         D_PAY = '0',																					\n" )													
										.append("         T_PAY = '0',																					\n" )	
										.append("         B_PAY = '173.91',																			\n" )													
										.append("         X_PAY = '0',																					\n" )	
										.append("         M_TOT_PAY = '173.91',																	\n" )													
										.append("         SABO_PAY = '26.09'																		\n" )	
										.append( "	 WHERE PAY_YM=?																				\n" )
				  						.append( "    AND VEND_CD = '61'																			\n" )
				  						.append( "    AND JOB_CD = '55'																			\n" );

						GauceStatement gsmt_5 = conn.getGauceStatement(UpdateSql4.toString()); //로그남기는것
						
						gsmt_5.setGauceDataRow(rows[j]);
						gsmt_5.bindColumn(1, idx[0]);
						
						gsmt_5.executeUpdate();
						gsmt_5.close();


					  /*+++++++++++++++++++++++++++++++++++++++++++++++ 
					  		급여계산작업 시작 : 예외처리 계산 - 화약고 - 경비
					  +++++++++++++++++++++++++++++++++++++++++++++++*/

						StringBuffer UpdateSql5 = new StringBuffer();

						UpdateSql5.append("  UPDATE ATP.KST200 																				\n" )
										.append("       SET																								\n" )		
										.append("         B_PAY = ROUND((WK_DAY*T_PAY*8),4),											\n" )													
										.append("         X_PAY = '0',																					\n" )	
										.append("         HOL_PAY = '0',																				\n" )	
										.append("         M_TOT_PAY = ROUND((WK_DAY*T_PAY*8),4),									\n" )													
										.append("         SABO_PAY = ROUND((WK_DAY*T_PAY*1.2),4),									\n" )	
										.append("         M_PAY = ROUND((WK_DAY*T_PAY*9.2),4)											\n" )		
										.append( "	 WHERE PAY_YM=?																				\n" )
				  						.append( "    AND VEND_CD = '05'																			\n" );

						GauceStatement gsmt_6 = conn.getGauceStatement(UpdateSql5.toString()); //로그남기는것
						
						gsmt_6.setGauceDataRow(rows[j]);
						gsmt_6.bindColumn(1, idx[0]);
						
						gsmt_6.executeUpdate();
						gsmt_6.close();


					  /*+++++++++++++++++++++++++++++++++++++++++++++++ 
					  		급여계산작업 시작 : 퇴직보조 충당금 계산 
					  +++++++++++++++++++++++++++++++++++++++++++++++*/

						StringBuffer UpdateSql7 = new StringBuffer();

						UpdateSql7.append("  UPDATE ATP.KST200 																								\n" )
										.append("       SET																												\n" )		
										.append("         OUT_PAY = ROUND(((WK_DAY+HOL_1+HOL_2+HOL_3+HOL_4)*D_PAY*0.1), 4)		\n" )														
										.append( "	 WHERE PAY_YM=?																								\n" );


						GauceStatement gsmt_8 = conn.getGauceStatement(UpdateSql7.toString()); //로그남기는것
						
						gsmt_8.setGauceDataRow(rows[j]);
						gsmt_8.bindColumn(1, idx[0]);
						
						gsmt_8.executeUpdate();
						gsmt_8.close();


					  /*+++++++++++++++++++++++++++++++++++++++++++++++ 
					  		급여계산작업 시작 : 총청구액 계산 
					  +++++++++++++++++++++++++++++++++++++++++++++++*/

						StringBuffer UpdateSql8 = new StringBuffer();

						UpdateSql8.append("  UPDATE ATP.KST200 																			\n" )
										.append("       SET																							\n" )		
										.append("         ALL_TOTAL_PAY = ROUND((M_PAY+MANAGE_PAY+OUT_PAY),4)		\n" )														
										.append( "	 WHERE PAY_YM=?																			\n" );

						GauceStatement gsmt_9 = conn.getGauceStatement(UpdateSql8.toString()); //로그남기는것
						
						gsmt_9.setGauceDataRow(rows[j]);
						gsmt_9.bindColumn(1, idx[0]);
						
						gsmt_9.executeUpdate();
						gsmt_9.close();

					  /*+++++++++++++++++++++++++++++++++++++++++++++++ 
					  		급여계산작업 시작 : 예외처리 계산 - 버스기사들
					  +++++++++++++++++++++++++++++++++++++++++++++++*/
/*
						StringBuffer UpdateSql6 = new StringBuffer();

						UpdateSql6.append("  UPDATE NORTHHR.KST200 																							\n" )
						.append("       SET																																	\n" )												
						.append("         X_PAY =																															\n" )
						.append("  ROUND( (D_PAY*O_H*1.5)/12 + (D_PAY*N1_H*0.5)/8 + (D_PAY*N2_H*2)/12 + (D_PAY*H_TIME*2)/8, 4)		\n" )

						
						.append( "	 WHERE PAY_YM=?																													\n" )						
						.append( "    AND JOB_CD = '29'																												\n" );


						GauceStatement gsmt_7 = conn.getGauceStatement(UpdateSql6.toString()); //로그남기는것
						gsmt_7.setGauceDataRow(rows[j]);

						gsmt_7.bindColumn(1, idx[0]);

						gsmt_7.executeUpdate();
						gsmt_7.close();

*/

				    /*+++++++++++++++++++++++++++++++++++++++++++++++ 
						급여계산작업 종료 : 						공제처리 계산
					+++++++++++++++++++++++++++++++++++++++++++++++*/

						for(int m=1;m<=1;m++) { 

							 strPaycd="";

							 if (m==1){ 
								 strPaycd ="006"; 
								 strMemo="예외처리 계산완료";  //기본급
							 }

							StringBuffer UpdateSql = new StringBuffer();			

							UpdateSql.append( " UPDATE ATP.KST299															\n")
												.append( " SET                  															\n")
												.append("  WRKSTS='2', 																\n" )												
												//.append( " TODT=REPLACE(CHAR(CURRENT DATE ,ISO),'-',''), 			\n")
												//.append( " TOTM=REPLACE(REPLACE(CHAR(CURRENT TIME ,ISO),'.',''),':',''),  WRKSTS='2',   \n")
												.append("  MEMO = '"+strMemo+"', 													\n" )
												.append( " U_DATE= sysdate 															\n")
												.append( " WHERE APPDT='"+rows[j].getString(idx[0])+"'					\n")
												.append( "   AND PAYDIV='"+rows[j].getString(idx[1])+"' 						\n")
												.append( "   AND PAYCD='"+strPaycd+"'       									\n");

							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							
							gsmt.setGauceDataRow(rows[j]);
								
							gsmt.executeUpdate();					
							gsmt.close();									

					  }
				
					}


						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/
            
						if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						}
					
						/******************************** **********************************************
						 * DELETE 처리
						 *********************************************************************************/
         
						if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
            
						}
						
						
				}
			}
			catch(Exception e){
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
