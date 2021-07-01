package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class p040002_t1 extends HttpServlet{
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
				//String  str1	= req.getParameter("v_str1");

				String[] strArrCN = new String[]{
				"EMPNO",	   /* ��� */
				"EMPNMK",       /*�ѱ۸�*/
				"NOTWRK",       /*���������ϼ�*/
				"APPDT",	       /* ��� */
				"PAYDIV",	/* �޿�����*/

				"DEPTCD",	/*  �μ��ڵ�*/
				"DEPTNM",	/*  �μ���*/
				"PAYGRDNM",	/* �����ڵ�*/
				"GRDDIVNM",	/*����*/
				"PAYSEQNM",	/* ȣ���ڵ� */

				"PAYBNKNM",	/*  �����ڵ�*/
				"PAYNUM",	/*  ���¹�ȣ*/
				"PAYDT",  /*  ������*/
				"DUYNOT",	/*  �������ϼ�*/

				"P10000",	/*  �⺻�޿�*/

				"P11000",	/* ��å���� */
				"P12000",	/* �ð��ܼ��� */
				"P21000",	/*  �ټӼ���*/
				"P22000",	/*  �ڱ��ߺ� */
				"P23000",	/*  �ξ簡��*/

				"P24000",	/*  ���������� */
				"P25000",	/*  �ⳳ����*/
				"P26000",	/*  ��������*/
				"P27000",	/*  �������*/
				"P28000",	/*  �ڰݼ���*/

				"P29000",	/*  ���ϰ�������*/
				"P30000",	/*  ����ܼ���*/
				"P31000",	/*  Ư��������*/
				"P32000",	/*  �����ٹ�����*/
				"P36000",	/*  �к�����*/

				"P37000",	/*  ���ο��ݺ�����*/
				"P38000",	/*  �ӿ���å����*/
				"PX0010",	/*  ��Ÿ����1*/
				"PX0020",	/*  ��Ÿ����2*/
				"PX0030",	/*  ��Ÿ����3*/

				"PX0040",	/*  ��Ÿ����4*/
				"S91000",	/*  �����հ�*/
				"T11000",	/*  �ҵ漼 OR ���ټ�*/
				"T12000",	/*  �ֹμ�*/
				"B11000",	/*  �ǰ������*/

				"B12000",	/*  ���ο���*/
				"B13000",	/*  ��뺸��*/
				"B15000",	/*  ���ο���*/
				"B14000",	/*  ������ȸ��*/
				"B16000",	/*  ����ȸ��*/

				"BX0010",	/*  ��Ÿ����1*/		
				"BX0020",	/*  ��Ÿ����2*/		
				"BX0030",	/*  ��Ÿ����3*/		
				"BX0040",	/*  ��Ÿ����4*/
				"S93000",	/*  �����հ�*/	

				"S94000",	/*  �������޾�*/
				
				"STRTDT",	/*  �Ի���*/	
				"JOBGRPHNM",	/*  ����*/	
				"ENDDT",	/*  �����*/	
				"RESINO",	/*  �ֹι�ȣ*/	

				"DUYEAR",	/*  �ٹ��Ⱓ*/	
				"DUYMM",	/*  �ٹ��Ⱓ*/	
				"DUDAY",	/*  �ٹ��Ⱓ*/	
				"T21000",	/*  �Ѽҵ�*/	
				"CZIPCD",	/*  �����ȣ*/	

				"CADDR",	    /*  �ּ�*/	
				"T92000"	/*  ������ȯ��*/	
				};

        int indexRow=0;
				int[] idx = new int[62];
				for (int i=0; i<strArrCN.length; i++) {
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						InsertSql = new StringBuffer();
						InsertSql.append( " " );
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE PAYROLL.PBPAY " );
						UpdateSql.append( " SET " );
							for(int i=14;i<=50;i++)	{
								UpdateSql.append( strArrCN[i] + "= ?, \n");
							}

								UpdateSql.append( strArrCN[61] + "= ?   \n");
								UpdateSql.append( "  WHERE  ");
								UpdateSql.append( "  EMPNO = ?  " );
								UpdateSql.append( "  AND APPDT = ? " );
								UpdateSql.append( "  AND PAYDIV = ? " );
								UpdateSql.append( "  AND PAYDT = ? " );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						for(int i=14;i<=50;i++)	{
              gsmt.bindColumn(i-13, idx[i]);
							indexRow=i-13;
						}
							indexRow++;
							gsmt.bindColumn(indexRow, idx[61]); //������ȯ�� �߰�
							gsmt.bindColumn(++indexRow, idx[0]);
							gsmt.bindColumn(++indexRow, idx[3]);
							gsmt.bindColumn(++indexRow, idx[4]);
							gsmt.bindColumn(++indexRow, idx[12]);
							indexRow=0;
							gsmt.executeUpdate();
							gsmt.close();  
							UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "	DELETE FROM PAYROLL.PBPAY " );
						DeleteSql.append( " WHERE EMPNO = ? " );
						DeleteSql.append( " AND APPDT = ? " );
						DeleteSql.append( " AND PAYDIV = ? " );

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[3]);
						gsmt.bindColumn(3, idx[4]);

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
			logger.dbg.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}