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

public class KS_Em049_t6 extends HttpServlet{

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

				String strPaycd="";
				String strMemo="";


				//�Ķ��Ÿ �޾ƿ��°� ����
				String usrid = reqGauce.getParameter("v_str1");
			
				String[] strArrCN = new String[]{ "PAY_YM","PAY_GB","EMPNO"                         
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
							�޿�����۾� ���� : ������ ���
					  +++++++++++++++++++++++++++++++++++++++++++++++*/


						for(int k=1;k<=1;k++) { 

							 if (k==1){
								 strPaycd ="005"; 
								 strMemo="������ �����";  //�⺻��
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
													//.append("   REPLACE(REPLACE(CHAR(CURRENT TIME ,ISO),'.',''),':',''),  \n" )
													.append("   '','',																		\n" )
													.append("   '1',																		\n" ) //������
													.append("   '"+strMemo+"',															\n" )
													.append("  '"+rows[j].getString(idx[2])+"', sysdate,						\n" )
													.append("  '"+rows[j].getString(idx[2])+"', sysdate) 						\n" );		
							
							GauceStatement gsmt_2 = conn.getGauceStatement(InsertSql_2.toString()); 
							gsmt_2.setGauceDataRow(rows[j]);

							gsmt_2.executeUpdate();
							gsmt_2.close();

						}


		           /*+++++++++++++++++++++++++++++++++++++++++++++++ 
						������ ��� : �����ް� * �Ϸ��� * 0.6
					+++++++++++++++++++++++++++++++++++++++++++++++*/

						StringBuffer InsertSql = new StringBuffer();

						InsertSql.append("  UPDATE ATP.KST200 SET																\n" )
						 				.append("         SUB_PAY  = ROUND((HOL_2*D_PAY*0.6),4)	 						\n" )		
										.append( "	 WHERE PAY_YM=?																	\n" )
				  						.append( "    AND PAY_GB=?																		\n" );

						GauceStatement gsmt_1 = conn.getGauceStatement(InsertSql.toString()); //�α׳���°�
						gsmt_1.setGauceDataRow(rows[j]);

						gsmt_1.bindColumn(1, idx[0]);
						gsmt_1.bindColumn(2, idx[1]);

						gsmt_1.executeUpdate();
						gsmt_1.close();
						

				    /*+++++++++++++++++++++++++++++++++++++++++++++++ 
						�޿�����۾� ���� : 						������ ���
					+++++++++++++++++++++++++++++++++++++++++++++++*/

						for(int m=1;m<=1;m++) { 

							 strPaycd="";

							 if (m==1){ 
								 strPaycd ="005"; 
								 strMemo="������ ���Ϸ�";  //�⺻��
							 }

							StringBuffer UpdateSql = new StringBuffer();			

							UpdateSql.append( " UPDATE ATP.KST299														\n")
												.append( " SET																		\n")
												.append("  WRKSTS='2',															\n")												
												//.append( " TODT=REPLACE(CHAR(CURRENT DATE ,ISO),'-',''), \n")
												//.append( " TOTM=REPLACE(REPLACE(CHAR(CURRENT TIME ,ISO),'.',''),':',''),  WRKSTS='2',   \n")
												.append("  MEMO = '"+strMemo+"', 												\n")
												.append( " U_DATE=sysdate 														\n")
												.append( " WHERE APPDT='"+rows[j].getString(idx[0])+"'				\n")
												.append( "   AND PAYDIV='"+rows[j].getString(idx[1])+"' 					\n")
												.append( "   AND PAYCD='"+strPaycd+"'       								\n");

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
