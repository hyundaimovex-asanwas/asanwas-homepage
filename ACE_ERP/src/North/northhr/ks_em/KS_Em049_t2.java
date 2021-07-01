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

public class KS_Em049_t2 extends HttpServlet{

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

				String strPaycd="";
				String strMemo="";

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
							급여계산작업 시작 : 기존 자료 삭제
					  +++++++++++++++++++++++++++++++++++++++++++++++*/

						StringBuffer DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM ATP.KST299										\n")
										.append( "	 WHERE APPDT=?												\n" );
	
						GauceStatement gsmt_0 = conn.getGauceStatement(DeleteSql.toString());
						gsmt_0.setGauceDataRow(rows[j]);

						gsmt_0.bindColumn(1, idx[0]);

						gsmt_0.executeUpdate();
						gsmt_0.close();

						//System.out.println("InsertSql \n" + DeleteSql.toString());	

						// 그달의 가동일수 구하기========================================================
						StringBuffer sql0 = new StringBuffer();
						Statement stmt0= null;
						ResultSet rs0 = null;

						String WK_DAY_GA="";

						sql0.append( " SELECT WK_DAY															\n" )
							  .append( "   FROM ATP.KST140													\n" )
							  .append( "   WHERE ATT_YM = '"+rows[j].getString(idx[0])+"'			\n" );

						stmt0 = conn.createStatement();
						rs0 = stmt0.executeQuery(sql0.toString());

						while (rs0.next())	{

								WK_DAY_GA=rs0.getString(1);

						}

						rs0.close();
						stmt0.close();
						//logger.dbg.println(this,WK_DAY_GA);
						
						
						//System.out.println("InsertSql \n" + sql0.toString());	
					 /*+++++++++++++++++++++++++++++++++++++++++++++++ 
							급여계산작업 시작 : 기본급, 가급금 계산
					  +++++++++++++++++++++++++++++++++++++++++++++++*/
						 //System.out.println("나한테 그러지마 \n");	

						for(int k=1;k<=2;k++) { 

							 if (k==1){

								 strPaycd ="001"; 
								 strMemo="기본급 계산중";  //기본급

							 }else if(k==2){

								 strPaycd ="002";  
								 strMemo="가급금 계산중"; //OT

							 }


							 StringBuffer InsertSql_2 = new StringBuffer();
						
							 InsertSql_2.append("  INSERT INTO ATP.KST299 (													\n" )
													.append("   APPDT,	PAYDIV,	 PAYDT,	  PBDIV,	PAYCD,					\n" )
													.append("    FRDT,	FRTM,	    TODT, 	 TOTM, 	WRKSTS,			\n" )
													.append("    MEMO,  I_EMPNO,I_DATE,	U_EMPNO,	U_DATE			\n" )
													.append("  ) VALUES (																\n" )
													.append("  '"+rows[j].getString(idx[0])+"',										\n" )
													.append("  '"+rows[j].getString(idx[1])+"',										\n" )
													.append("  '','1',																		\n" )
													.append("  '"+strPaycd+"',															\n" )
													.append("   '','',																		\n" )													
													//.append("   REPLACE(CHAR(CURRENT DATE ,ISO),'-',''),				\n" )
													//.append("   REPLACE(REPLACE(CHAR(CURRENT TIME ,ISO),'.',''),':',''),  	\n" )
													.append("   '','',																		\n" )
													.append("   '1',																		\n" ) //진행중
													.append("   '"+strMemo+"',															\n" )
													.append("  '"+rows[j].getString(idx[2])+"', sysdate,						\n" )
													.append("  '"+rows[j].getString(idx[2])+"', sysdate) 						\n" );

							//System.out.println("InsertSql_2 \n" + InsertSql_2.toString());	
							//logger.dbg.println(this,InsertSql_2.toString());			
							
							GauceStatement gsmt_2 = conn.getGauceStatement(InsertSql_2.toString()); 
							gsmt_2.setGauceDataRow(rows[j]);

							gsmt_2.executeUpdate();
							gsmt_2.close();

						}

						
					/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
				  		급여계산작업 시작 : 예외처리 계산 - 경비 휴근 시간 빼버리기
				   ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

					StringBuffer UpdateSql2 = new StringBuffer();

					UpdateSql2.append("  UPDATE ATP.KST200 												\n" )
					.append("       SET																				\n" )		
					.append("         B_H =	(WK_DAY * 8),														\n" )							
					.append("         H_D =	0,																		\n" )			
					.append("         H_TIME =	0																	\n" )										
					.append( "	 WHERE PAY_YM = ?															\n" )						
					.append( "    AND VEND_CD IN ('05', '61')												\n" );

					GauceStatement gsmt_2 = conn.getGauceStatement(UpdateSql2.toString()); //로그남기는것
					gsmt_2.setGauceDataRow(rows[j]);
					
					gsmt_2.bindColumn(1, idx[0]);
					
					gsmt_2.executeUpdate();
					gsmt_2.close();						
						
					//System.out.println("UpdateSql2 \n" + UpdateSql2.toString());							
					//System.out.println("나한테 그러지마 \n");	
					
		           /*+++++++++++++++++++++++++++++++++++++++++++++++ 
						기본급 및 시간외 계산
					+++++++++++++++++++++++++++++++++++++++++++++++*/

						StringBuffer InsertSql = new StringBuffer();
/*
						InsertSql.append("  UPDATE NORTHHR.KST200 SET                                          \n" )
						 				.append("         BASIC_TOT  = ROUND((B_PAY1*W_DAY1/M_DAYS+B_PAY2*W_DAY2/M_DAYS),2), \n" )
										.append("         RO_TIME = ROUND((T_PAY1*O_TIME1*1.5 + T_PAY2*O_TIME2*1.5),2),   \n" )
										.append("         HO_TIME = ROUND((CASE WHEN W_DAY1>W_DAY2 THEN T_PAY1*HO_DAY*10*1.5 ELSE T_PAY2*HO_DAY*10*1.5 END),2), \n" )
										.append("         O_TIME_TOT = ROUND((T_PAY1*O_TIME1*1.5),2) + ROUND((T_PAY2*O_TIME2*1.5),2) +ROUND((CASE WHEN W_DAY1>W_DAY2 THEN T_PAY1*HO_DAY*10*1.5 ELSE T_PAY2*HO_DAY*10*1.5 END),2) \n" )										
										.append( "	 WHERE PAY_YM=?		\n")
				  						.append( "    AND PAY_GB=?	\n");
*/
/*						
						InsertSql.append("  UPDATE ATP.KST200 SET														\n" )
//						 				.append("         B_PAY  = ROUND((CASE WHEN (WK_DAY)>'"+WK_DAY_GA+"' THEN (B_H - ((WK_DAY -'"+WK_DAY_GA+"')*8) ) *T_PAY  ELSE T_PAY*B_H END),2),										\n" )

//						 				.append("         B_PAY  = ROUND((CASE WHEN (WK_DAY)>'"+WK_DAY_GA+"' THEN T_PAY*B_H															\n" )
//						 				.append("												  WHEN (WK_DAY)='"+WK_DAY_GA+"' THEN T_PAY*B_H 															\n" )
//										.append("												  WHEN (WK_DAY)<'"+WK_DAY_GA+"' THEN   T_PAY*B_H  ELSE T_PAY*B_H END),4),				\n" )

						 				.append("         B_PAY  = ROUND(( T_PAY*B_H ),4),										\n" )


//										.append("         X_PAY  = ROUND((CASE WHEN (WK_DAY)>'"+WK_DAY_GA+"' THEN   T_PAY*O_H*1.5 + T_PAY*N1_H*0.5 + T_PAY*N2_H*2 + H_D*D_PAY*2   \n" )
//										.append("												 WHEN (WK_DAY)<='"+WK_DAY_GA+"' THEN   T_PAY*O_H*1.5 + T_PAY*N1_H*0.5 + T_PAY*N2_H*2  ELSE  T_PAY*O_H*1.5 + T_PAY*N1_H*0.5 + T_PAY*N2_H*2 END),2), \n" )


//										.append("         X_PAY  = ROUND((CASE WHEN (WK_DAY + HOL_1 + HOL_2)>='"+WK_DAY_GA+"' THEN   T_PAY*O_H*1.5 + T_PAY*N1_H*0.5 + T_PAY*N2_H*2 +    ((WK_DAY + HOL_1 + HOL_2) - '"+WK_DAY_GA+"')*D_PAY   \n" )
//										.append("												 WHEN (WK_DAY + HOL_1 + HOL_2)<'"+WK_DAY_GA+"' THEN   T_PAY*O_H*1.5 + T_PAY*N1_H*0.5 + T_PAY*N2_H*2  ELSE  T_PAY*O_H*1.5 + T_PAY*N1_H*0.5 + T_PAY*N2_H*2 + H_D*D_PAY END),4), \n" )

										.append("         X_PAY  = ROUND(( T_PAY*O_H*1 + T_PAY*N2_H*1 + H_TIME*T_PAY*1 ),4), \n" )

										.append("         S_PAY  = ROUND(( T_PAY*O_H*0.5 + T_PAY*N1_H*0.5 + T_PAY*N2_H*1 + H_TIME*T_PAY*1 ),4), \n" )
						
						//				.append("         X_PAY  = ROUND((CASE WHEN (WK_DAY + H_D)>'"+WK_DAY_GA+"' THEN   T_PAY*O_H*1.5 + T_PAY*N1_H*0.5 + T_PAY*N2_H*2 + H_D*D_PAY*2  ELSE  T_PAY*O_H*1.5 + T_PAY*N1_H*0.5 + T_PAY*N2_H*2 END),2), \n" )
						//				.append("         X_PAY = ROUND((T_PAY*O_H*1.5 + T_PAY*N1_H*0.5 + T_PAY*N2_H*2 + H_D*D_PAY*1 ),2),		\n" )			
										.append("         HOL_PAY = ROUND((HOL_1*D_PAY),4) + 	ROUND((HOL_4*D_PAY),4)								\n" )		
											

										.append( "	 WHERE PAY_YM=?																		\n" );
				  		//				.append( "    AND PAY_GB=?																			\n" );
*/
						
							InsertSql.append("  UPDATE ATP.KST200 SET																											\n" )						
						 				.append("         B_PAY  = ROUND(( T_PAY*B_H ),4),																						\n" )						
										.append("         X_PAY  = ROUND(( T_PAY*O_H*1 + T_PAY*N2_H*1 + H_TIME*T_PAY*1 ),4), 								\n" )
										.append("         S_PAY  = ROUND(( T_PAY*O_H*0.5 + T_PAY*N1_H*0.5 + T_PAY*N2_H*1 + H_TIME*T_PAY*1 ),4), 	\n" )
										.append("         HOL_PAY = ROUND((HOL_1*D_PAY),4) + 	ROUND((HOL_4*D_PAY),4)										\n" )		
										.append( "	 WHERE PAY_YM=?																													\n" )									
					  					.append( "    AND PAY_GB=?																														\n" );										
						
						 //System.out.println("InsertSql \n" + InsertSql.toString());	
						// logger.dbg.println(this,"::"+InsertSql.toString());

						GauceStatement gsmt_1 = conn.getGauceStatement(InsertSql.toString()); //로그남기는것
						gsmt_1.setGauceDataRow(rows[j]);

						gsmt_1.bindColumn(1, idx[0]);
						gsmt_1.bindColumn(2, idx[1]);

						gsmt_1.executeUpdate();
						gsmt_1.close();
						


					  /*+++++++++++++++++++++++++++++++++++++++++++++++ 
					  		급여계산작업 시작 : 예외처리 계산 - 버스기사들
					  +++++++++++++++++++++++++++++++++++++++++++++++*/
/*
						StringBuffer UpdateSql2 = new StringBuffer();

						UpdateSql2.append("  UPDATE ATP.KST200 																																\n" )
						.append("       SET																																								\n" )		
						.append("         X_PAY =																																						\n" )							
						.append("  ROUND( (D_PAY*O_H*1.5)/12 + (D_PAY*N1_H*0.5)/8 + (D_PAY*N2_H*2)/12 + (D_PAY*H_TIME*2)/8, 4)								\n" )
						.append( "	 WHERE PAY_YM=?																																				\n" )						
						.append( "    AND JOB_CD = '29'																																			\n" );


						GauceStatement gsmt_2 = conn.getGauceStatement(UpdateSql2.toString()); //로그남기는것
						gsmt_2.setGauceDataRow(rows[j]);

						gsmt_2.bindColumn(1, idx[0]);

						gsmt_2.executeUpdate();
						gsmt_2.close();

*/

				    /*+++++++++++++++++++++++++++++++++++++++++++++++ 
						급여계산작업 종료 : 기본급 및 시간외(가급금) 
					+++++++++++++++++++++++++++++++++++++++++++++++*/

						for(int m=1;m<=2;m++) { 

							 strPaycd="";

							 if (m==1){ 
								 strPaycd ="001"; 
								 strMemo="기본급 계산완료";  //기본급

							 }else if(m==2){
								 strPaycd ="002";  
								 strMemo="가급금 계산완료"; //OT
							 }

							StringBuffer UpdateSql = new StringBuffer();			

							UpdateSql.append( " UPDATE ATP.KST299											\n")
												.append( " SET                  											\n")
												//.append( " TODT=REPLACE(CHAR(CURRENT DATE ,ISO),'-',''), \n")
												//.append( " TOTM=REPLACE(REPLACE(CHAR(CURRENT TIME ,ISO),'.',''),':',''),  WRKSTS='2',   \n")
												.append("  WRKSTS='2', 												\n" )												
												.append("  MEMO = '"+strMemo+"', 									\n" )
												.append( " U_DATE= sysdate				 							\n")
												.append( " WHERE APPDT='"+rows[j].getString(idx[0])+"'	\n")
												.append( "   AND PAYDIV='"+rows[j].getString(idx[1])+"' 		\n")
												.append( "   AND PAYCD='"+strPaycd+"'       					\n");


							//logger.dbg.println(this,UpdateSql.toString());

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
