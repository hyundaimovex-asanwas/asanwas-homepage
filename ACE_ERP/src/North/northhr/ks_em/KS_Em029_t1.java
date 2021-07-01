//**�������. delete,update�Ҷ��� where�� ���Ŀ� primary key �÷��� �� �߰��ؼ� ���ش�***
package northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class KS_Em029_t1 extends HttpServlet{

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
				String str1 = reqGauce.getParameter("v_str1");						//�ް��� ����
				String str2 = reqGauce.getParameter("v_str2");						//�ٹ��� ����
				String str3 = reqGauce.getParameter("v_str3");						//��ü�ް��� == ����

				if(str1==null) str1="";
				if(str2==null) str2="";
				if(str3==null) str3="";

				/******************************** **********************************************
				 * Insert ó��
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
         
				String[] strArrCN = new String[]{ "HOL_DT", "EMPNO",  "DAY_CD",  	  //3
					
			   		                                  				"DEPT_CD", "HOL_GB",                                      //5
			                                          
													  				"I_EMPNO","I_DATE","U_EMPNO","U_DATE"        // 9
																					
																			  };
																			  
			

				int[] idx = new int[9]; //�÷������� �־��ش�.

       			for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				
				/******************************** **********************************************
				* INSERT ó��
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						StringBuffer UpdateSql = new StringBuffer();

						UpdateSql.append( " UPDATE NORTHHR.KST100    									\n");				  						   			
			   			UpdateSql.append( " SET                      												\n");
						UpdateSql.append( " WEEK_GB= '1'										            \n");
						UpdateSql.append( " WHERE EMPNO='"+ str1 +"'  								\n");
						UpdateSql.append( " AND ATT_DT='"+ str2 +"'  									\n");
						
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						
			//			logger.dbg.println(this,UpdateSql.toString());//�α׳���°�

						gsmt.executeUpdate();					
						gsmt.close();		

						StringBuffer InsertSql = new StringBuffer();

						InsertSql.append( " 		 INSERT INTO NORTHHR.KST100(													\n" )                                       										
									.append( "		ATT_DT,  EMPNO,     VEND_CD,  DEPT_CD,                        		\n" )       									
									.append( "		JOB_CD,   WORK_CD,  C_VEND_CD,  CLASS_CD,              		\n" )              					
									.append( "		WEEK_GB                )																\n" )
									.append( "		SELECT  '"+str3+"' AS ATT_DT, '"+str1+"' AS EMPNO,				\n" )
									.append( "		A.VEND_CD,  A.DEPT_CD,														\n" )
									.append( "		A.JOB_CD,   A.WORK_CD,  A.C_VEND_CD,  A.CLASS_CD,			\n" )
									.append( "		'5' AS WEEK_GB																		\n" )
									.append( "		FROM NORTHHR.KST010 A															\n" )
									.append( "		WHERE A.EMPNO =   '"+str1+"'													\n" );

						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql.toString()); //�α׳���°�
			//			logger.dbg.println(this,InsertSql.toString());//�α׳���°�
						gsmt2.executeUpdate();					
						gsmt2.close();	

			//			logger.dbg.println(this,"����?");	
			
						
					}
					

					/******************************** **********************************************
					 * DELETE ó��
					 *********************************************************************************/
         
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						
						//������ �ް� ����� ORIGINAL�� �����ұ�??? �� �켱 �ΰ�....���߿� �ʿ��ϸ� �ݿ�����... 
						            
						StringBuffer DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM NORTHHR.TCM355		\n")
										       .append( " WHERE EMPNO=?							        \n")
							             .append( "	   AND YYYY=?							            \n")
				  					       .append( "      AND SEQ=?							              \n");
            	
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);

						gsmt.executeUpdate();
						gsmt.close();

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
