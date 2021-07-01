package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p040001_t1 extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] strArrCN = new String[]{
                               
					 "BASAMT1", //�޿�(�⺻��+��å����+�ð��ܼ���)                                  
					 "BASAMT2", //�޿�(�⺻��+��å����+�ð��ܼ���)                                  
					 "BASAMT3", //�޿�(�⺻��+��å����+�ð��ܼ���)
					 "BASAMT4", //�޿�(�⺻��+��å����+�ð��ܼ���)
					 "BASBUS1", //�� 3��                                  
					 "BASBUS2", //�� 12,1��                                  
					 "BASBUS3", //�� 9,11��
					 "BASBUS4", //�� 5,7��
					 "BAEAMT1", //��Ÿ�����                                  
					 "BAEAMT2", //��Ÿ�����                                   
					 "BAEAMT3", //��Ÿ�����                                  
					 "BAEAMT4", //��Ÿ�����    
					 "YEAQTY",  //�����ϼ�                                  
					 "YEAPAY",  //��������                                   
					 "AVGYER",  //��ճ�������  
					 "AVGAMT",  //��ձ޿�    
					 "AVGBOS",  //��ջ�    
					 "AVGETC",  //��ձ�Ÿ����    
					 "P21000",  //�ټӼ���    
					 "P22000",  //�ڱ��ߺ�    
					 "P24000",  //����������    
					 "P29000",  //���ϰ�������    
					 "P38000",  //�ӿ���å����    
					 "PX0000",  //��Ÿ����    
					 "JUSPAY",  //�޿�    
					 "JUSRET",  //������    
					 "JUSYER",  //��������    
					 "JUSBOS",  //��    
					 "S91000",  //�����հ�    
					 "S94000",  //�����޾�    
					 "T21000",  //���갩�ټ�-�ҵ漼                             
					 "T22000",  //�����ֹμ�                              
					 "T23000",  //�������ټ�-�ҵ漼                             
					 "T24000",  //�����ֹμ�                              
					 "P43000",  //���ο���                              
					 "P41000",  //�ǰ�����                              
					 "P42000",  //��뺸��                           
					 "RETJUH",  //������ȯ�� 
					 "BX0010",  //��Ÿ����1
					 "BX0020",  //��Ÿ����2                                
					 "BX0030",  //��Ÿ����3                                
					 "BX0040",  //��Ÿ����4
 					 "S93000",   //�����հ�
					 "PAYDIV",	
           "REF1"	,		//��1
					 "REF2"	,		//��2
					 "REF3"	,		//��3
					 "REF4"	,		//��4
					 "REF"			//��������
				};
                
				int idxEMPNO = userSet.indexOfColumn("EMPNO");	/*  ���*/
				int idxAPPDT = userSet.indexOfColumn("APPDT");	/*  ��� */
               
				int[] idx = new int[strArrCN.length];
				for (int i=0; i<strArrCN.length; i++) {
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( "UPDATE PAYROLL.PRPAY SET " );
						for(int i=0; i <strArrCN.length; i++)	{
							if(i==(strArrCN.length-1))
								UpdateSql.append( " "+strArrCN[i]+"=?  " );
							else
								UpdateSql.append( " "+strArrCN[i]+"=?,  " );
						}
						UpdateSql.append( " WHERE EMPNO = ? " );
						UpdateSql.append( " AND APPDT = ? " );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//logger.dbg.println(this, UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						for (int i=1; i<=strArrCN.length; i++) {
							gsmt.bindColumn(i, idx[(i-1)]);
						}

						gsmt.bindColumn((strArrCN.length+1), idxEMPNO);
						gsmt.bindColumn((strArrCN.length+2), idxAPPDT);
	
						gsmt.executeUpdate(); 
						gsmt.close(); 
						UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM PAYROLL.PRPAY WHERE EMPNO = ? AND APPDT	= ? " );

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//logger.dbg.println(this, DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxAPPDT);
						gsmt.executeUpdate();
						gsmt.close();
						DeleteSql=null;
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			}
 			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}