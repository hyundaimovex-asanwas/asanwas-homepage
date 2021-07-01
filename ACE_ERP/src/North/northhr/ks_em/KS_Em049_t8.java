//**�������. delete,update�Ҷ��� where�� ���Ŀ� primary key �÷��� �� �߰��ؼ� ���ش�***
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

				//�Ķ��Ÿ �޾ƿ��°� ����
				/*******************************************************************************
				 * Insert ó��
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				//logger.dbg.println(this,"����ó��");

				String strPaycd="";
				String strMemo="";
				String strCurYM="";
				String strCurYMD="";				


				//�Ķ��Ÿ �޾ƿ��°� ����
				String usrid = reqGauce.getParameter("v_str1");
			
				String[] strArrCN = new String[]{ 
					
																"PAY_YM","PAY_GB","EMPNO"   
																	
																			  };

				int[] idx = new int[3]; //�÷������� �־��ش�.

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				
				/******************************** **********************************************
				* INSERT ó��
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					 /*+++++++++++++++++++++++++++++++++++++++++++++++ 
							�޿�����۾� ���� : ����ó�� ���
					  +++++++++++++++++++++++++++++++++++++++++++++++*/

						for(int k=1;k<=1;k++) { 

							 if (k==1){
								 strPaycd ="006"; 
								 strMemo="����ó�� �����";  //�⺻��
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
													.append("   '1',																			\n" ) //������
													.append("   '"+strMemo+"',																\n" )
													.append("  '"+rows[j].getString(idx[2])+"', sysdate,							\n" )
													.append("  '"+rows[j].getString(idx[2])+"', sysdate) 							\n" );
						
							GauceStatement gsmt_2 = conn.getGauceStatement(InsertSql_2.toString()); 
							gsmt_2.setGauceDataRow(rows[j]);
							
							gsmt_2.executeUpdate();
							gsmt_2.close();

						}


					  /*+++++++++++++++++++++++++++++++++++++++++++++++ 
					  		�޿�����۾� ���� : �Ϲݰ����� ��� 
					  +++++++++++++++++++++++++++++++++++++++++++++++*/
/*
						StringBuffer UpdateSql6 = new StringBuffer();

						UpdateSql6.append("  UPDATE ATP.KST200 																				\n" )
										.append("       SET																								\n" )		
										.append("         MANAGE_PAY = ROUND(M_TOT_PAY/D_PAY, 4)									\n" )														
										.append( "	 WHERE PAY_YM=?																				\n" );
					
						GauceStatement gsmt_7 = conn.getGauceStatement(UpdateSql6.toString()); //�α׳���°�
						
						gsmt_7.setGauceDataRow(rows[j]);
						gsmt_7.bindColumn(1, idx[0]);
						
						gsmt_7.executeUpdate();
						gsmt_7.close();
*/
		           /*+++++++++++++++++++++++++++++++++++++++++++++++ 
						����ó�� ���
					+++++++++++++++++++++++++++++++++++++++++++++++*/

						strCurYM = rows[j].getString(idx[0]);  //�޿����
						strCurYMD =  strCurYM+"20"; //�޿������ 1��

						StringBuffer InsertSql = new StringBuffer();

						InsertSql.append("  UPDATE ATP.KST200 SET																			\n" )
										.append("         PAY_DT = '"+strCurYMD+"',																\n" )		
										.append("         M_PAY = ROUND(( M_TOT_PAY + SABO_PAY + SUB_PAY + S_PAY ),3)	\n" )													
										.append( "	 WHERE PAY_YM=?																				\n" )
				  						.append( "    AND PAY_GB=?																					\n" );

						GauceStatement gsmt_1 = conn.getGauceStatement(InsertSql.toString()); //�α׳���°�
						gsmt_1.setGauceDataRow(rows[j]);
						
						gsmt_1.bindColumn(1, idx[0]);
						gsmt_1.bindColumn(2, idx[1]);
						
						gsmt_1.executeUpdate();
						gsmt_1.close();

						/*+++++++++++++++++++++++++++++++++++++++++++++++ 
							�޿�����۾� ���� : ����ó�� ��� - ȭ��� - �Ϲ�
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


						GauceStatement gsmt_3 = conn.getGauceStatement(UpdateSql2.toString()); //�α׳���°�
						
						gsmt_3.setGauceDataRow(rows[j]);
						gsmt_3.bindColumn(1, idx[0]);
						
						gsmt_3.executeUpdate();
						gsmt_3.close();

						/*+++++++++++++++++++++++++++++++++++++++++++++++ 
							�޿�����۾� ���� : ����ó�� ��� - ȭ��� - ����
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


						GauceStatement gsmt_4 = conn.getGauceStatement(UpdateSql3.toString()); //�α׳���°�
						
						gsmt_4.setGauceDataRow(rows[j]);
						gsmt_4.bindColumn(1, idx[0]);
						
						gsmt_4.executeUpdate();
						gsmt_4.close();


						/*+++++++++++++++++++++++++++++++++++++++++++++++ 
							�޿�����۾� ���� : ����ó�� ��� - ȭ��� - ����
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

						GauceStatement gsmt_5 = conn.getGauceStatement(UpdateSql4.toString()); //�α׳���°�
						
						gsmt_5.setGauceDataRow(rows[j]);
						gsmt_5.bindColumn(1, idx[0]);
						
						gsmt_5.executeUpdate();
						gsmt_5.close();


					  /*+++++++++++++++++++++++++++++++++++++++++++++++ 
					  		�޿�����۾� ���� : ����ó�� ��� - ȭ��� - ���
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

						GauceStatement gsmt_6 = conn.getGauceStatement(UpdateSql5.toString()); //�α׳���°�
						
						gsmt_6.setGauceDataRow(rows[j]);
						gsmt_6.bindColumn(1, idx[0]);
						
						gsmt_6.executeUpdate();
						gsmt_6.close();


					  /*+++++++++++++++++++++++++++++++++++++++++++++++ 
					  		�޿�����۾� ���� : �������� ���� ��� 
					  +++++++++++++++++++++++++++++++++++++++++++++++*/

						StringBuffer UpdateSql7 = new StringBuffer();

						UpdateSql7.append("  UPDATE ATP.KST200 																								\n" )
										.append("       SET																												\n" )		
										.append("         OUT_PAY = ROUND(((WK_DAY+HOL_1+HOL_2+HOL_3+HOL_4)*D_PAY*0.1), 4)		\n" )														
										.append( "	 WHERE PAY_YM=?																								\n" );


						GauceStatement gsmt_8 = conn.getGauceStatement(UpdateSql7.toString()); //�α׳���°�
						
						gsmt_8.setGauceDataRow(rows[j]);
						gsmt_8.bindColumn(1, idx[0]);
						
						gsmt_8.executeUpdate();
						gsmt_8.close();


					  /*+++++++++++++++++++++++++++++++++++++++++++++++ 
					  		�޿�����۾� ���� : ��û���� ��� 
					  +++++++++++++++++++++++++++++++++++++++++++++++*/

						StringBuffer UpdateSql8 = new StringBuffer();

						UpdateSql8.append("  UPDATE ATP.KST200 																			\n" )
										.append("       SET																							\n" )		
										.append("         ALL_TOTAL_PAY = ROUND((M_PAY+MANAGE_PAY+OUT_PAY),4)		\n" )														
										.append( "	 WHERE PAY_YM=?																			\n" );

						GauceStatement gsmt_9 = conn.getGauceStatement(UpdateSql8.toString()); //�α׳���°�
						
						gsmt_9.setGauceDataRow(rows[j]);
						gsmt_9.bindColumn(1, idx[0]);
						
						gsmt_9.executeUpdate();
						gsmt_9.close();

					  /*+++++++++++++++++++++++++++++++++++++++++++++++ 
					  		�޿�����۾� ���� : ����ó�� ��� - ��������
					  +++++++++++++++++++++++++++++++++++++++++++++++*/
/*
						StringBuffer UpdateSql6 = new StringBuffer();

						UpdateSql6.append("  UPDATE NORTHHR.KST200 																							\n" )
						.append("       SET																																	\n" )												
						.append("         X_PAY =																															\n" )
						.append("  ROUND( (D_PAY*O_H*1.5)/12 + (D_PAY*N1_H*0.5)/8 + (D_PAY*N2_H*2)/12 + (D_PAY*H_TIME*2)/8, 4)		\n" )

						
						.append( "	 WHERE PAY_YM=?																													\n" )						
						.append( "    AND JOB_CD = '29'																												\n" );


						GauceStatement gsmt_7 = conn.getGauceStatement(UpdateSql6.toString()); //�α׳���°�
						gsmt_7.setGauceDataRow(rows[j]);

						gsmt_7.bindColumn(1, idx[0]);

						gsmt_7.executeUpdate();
						gsmt_7.close();

*/

				    /*+++++++++++++++++++++++++++++++++++++++++++++++ 
						�޿�����۾� ���� : 						����ó�� ���
					+++++++++++++++++++++++++++++++++++++++++++++++*/

						for(int m=1;m<=1;m++) { 

							 strPaycd="";

							 if (m==1){ 
								 strPaycd ="006"; 
								 strMemo="����ó�� ���Ϸ�";  //�⺻��
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
						* Update ó��
						*********************************************************************************/
            
						if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						}
					
						/******************************** **********************************************
						 * DELETE ó��
						 *********************************************************************************/
         
						if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
            
						}
						
						
				}
			}
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,e.getMessage());	
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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
