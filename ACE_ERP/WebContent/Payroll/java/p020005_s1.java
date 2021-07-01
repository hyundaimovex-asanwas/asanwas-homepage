package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class p020005_s1 extends HttpServlet {

	// ���������� ���� ���۹���� Post Ÿ���� ���
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
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//��������
				str[1]	= req.getParameter("v_str2");		//������
				str[2]	= req.getParameter("v_str3");		//�޿�����
				str[3]	= req.getParameter("v_str4");		//�μ�
				str[4]	= req.getParameter("v_str5");		//����
				str[5]	= req.getParameter("v_str6");		//�������
				str[6]	= req.getParameter("v_str7");		//�������
				str[7]	= req.getParameter("v_str8");		//����
				str[8]	= req.getParameter("v_str9");		//����
				str[9]	= req.getParameter("v_str10");		//����






				for (int s=0;s<10;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

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
				"PAYDT",     /*  ������*/
				"DUYNOT",	/*  �������ϼ�*/
				"P10000",	/*  �⺻�޿�*/
				"P11000",	/* ��å���� */
				"P12000",	/* �ð��ܼ��� */
				"P21000",	/*  �ټӼ���*/
				"P22000",	/*  �ڱ��ߺ� */
				"P23000",	/*  �ξ簡������*/
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
				"S94000",	/*  �����޾�*/

				"P34000",	/*  ��������*/
				"P39000",	/*  �����ұ�*/
				"P41000",   /*  ����ǰ�*/
				"P42000",   /*  ������*/
				"T21000",   /*  ����ҵ�*/
				"T22000",   /*  �����ֹ�*/
				"TS9100",   /*  �����ҵ洩��*/
				"TT1100",   /*  �����ҵ��*/  
				"TT1200",   /*  �����ֹμ�*/  


				
				"STRTDT",	 /*  �Ի���*/	
				"JOBGRPHNM",	/*  ����*/	
				"ENDDT" 	 /*  �����*/	

				};

				int[] intArrCN = new int[]{  
					7, 	    /* ��� */                
					20,	     /*�ѱ۸�*/               
					2, 	     /*���������ϼ�*/         
					6,	        /* ��� */            
					30,	 /* �޿�����*/                
					4,	 /*  �μ��ڵ�*/               
					50,	 /*  �μ���*/                 
					30,	 /* �����ڵ�*/                
					30,	 /*����*/                     
					30,	 /* ȣ���ڵ� */               
					30,	 /*  �����ڵ�*/               
					25,	 /*  ���¹�ȣ*/               
					8,	  /*  ������*/                
					2,	 /*  �������ϼ�*/           
					9,	 /*  �⺻�޿�*/               
					9,	 /* ��å���� */               
					9,	 /* �ð��ܼ��� */             
					9,	 /*  �ټӼ���*/               
					9,	 /*  �ڱ��ߺ� */            
					9,	 /*  �ξ簡������*/           
					9,	 /*  ���������� */            
					9,	 /*  �ⳳ����*/               
					9,	 /*  ��������*/               
					9,	 /*  �������*/               
					9,	 /*  �ڰݼ���*/               
					9,	 /*  ���ϰ�������*/           
					9,	 /*  ����ܼ���*/             
					9,	 /*  Ư��������*/             
					9,	 /*  �����ٹ�����*/           
					9,	 /*  �к�����*/             
					9,	 /*  ���ο��ݺ�����*/         
					9,	 /*  �ӿ���å����*/           
					9,	 /*  ��Ÿ����1*/              
					9,	 /*  ��Ÿ����2*/              
					9,	 /*  ��Ÿ����3*/              
					9,	 /*  ��Ÿ����4*/              
					9,	 /*  �����հ�*/               
					9,	 /*  �ҵ漼 OR ���ټ�*/       
					9,	 /*  �ֹμ�*/                 
					9,	 /*  �ǰ������*/             
					9,	 /*  ���ο���*/               
					9,	 /*  ��뺸��*/               
					9,	 /*  ���ο���*/               
					9,	 /*  ������ȸ��*/             
					9,	 /*  ����ȸ��*/               
					9,	 /*  ��Ÿ����1*/		         
					9,	 /*  ��Ÿ����2*/		         
					9,	 /*  ��Ÿ����3*/		         
					9,	 /*  ��Ÿ����4*/              
					9,	 /*  �����հ�*/	             
					9,	 /*  �����޾�*/               
						                              
					9,	 /*  ��������*/               
					9,	 /*  �����ұ�*/               
					9,	 /*  ����ǰ�*/               
					9,	 /*  ������*/               
					9,	 /*  ����ҵ�*/               
					9,	 /*  �����ֹ�*/               
					9,   /*  �����ҵ洩��*/
					9,   /*  �����ҵ��*/  
					9,   /*  �����ֹμ�*/  



					8,		  /*  �Ի���*/                              
					30,	 	/*  ����*/ 	             
					8	  /*  �����*/              
            	}; 		
						                              
				int[] intArrCN2 = new int[]{
					-1,     /* ��� */                 
					-1,	     /*�ѱ۸�*/              
					0,	     /*���������ϼ�*/        
					-1,         /* ��� */             
					-1,	 /* �޿�����*/               
					-1,  /*  �μ��ڵ�*/                
					-1,	 /*  �μ���*/                
					-1,  /* �����ڵ�*/                 
					-1,	 /*����*/                    
					-1,	 /* ȣ���ڵ� */              
					-1,  /*  �����ڵ�*/                
					-1,	 /*  ���¹�ȣ*/              
					-1,   /*  ������*/                 
					0,	 /*  �������ϼ�*/          
					0,	 /*  �⺻�޿�*/              
					0,	 /* ��å���� */              
					0,	 /* �ð��ܼ��� */            
					0,	 /*  �ټӼ���*/              
					0,	 /*  �ڱ��ߺ� */           
					0,	 /*  �ξ簡������*/          
					0,	 /*  ���������� */           
					0,	 /*  �ⳳ����*/              
					0,	 /*  ��������*/              
					0,	 /*  �������*/              
					0,	 /*  �ڰݼ���*/              
					0,	 /*  ���ϰ�������*/          
					0,	 /*  ����ܼ���*/            
					0,	 /*  Ư��������*/            
					0,	 /*  �����ٹ�����*/          
					0,	 /*  �к�����*/            
					0,	 /*  ���ο��ݺ�����*/        
					0,	 /*  �ӿ���å����*/          
					0,	 /*  ��Ÿ����1*/             
					0,	 /*  ��Ÿ����2*/             
					0,	 /*  ��Ÿ����3*/             
					0,	 /*  ��Ÿ����4*/             
					0,	 /*  �����հ�*/              
					0,	 /*  �ҵ漼 OR ���ټ�*/      
					0,	 /*  �ֹμ�*/                
					0,	 /*  �ǰ������*/            
					0,	 /*  ���ο���*/              
					0,	 /*  ��뺸��*/              
					0,	 /*  ���ο���*/              
					0,	 /*  ������ȸ��*/            
					0,	 /*  ����ȸ��*/              
					0,	 /*  ��Ÿ����1*/		     
					0,	 /*  ��Ÿ����2*/		     
					0,	 /*  ��Ÿ����3*/		     
					0,	 /*  ��Ÿ����4*/             
					0,	 /*  �����հ�*/	             
					0,	 /*  �����޾�*/              
					0,	 /*  ��������*/                            
					0,	 /*  �����ұ�*/              
					0,	 /*  ����ǰ�*/              
					0,	 /*  ������*/              
					0,	 /*  ����ҵ�*/              
					0,	 /*  �����ֹ�*/              
					0,	 /*  �����ҵ洩��*/              
					0,	 /*  �����ҵ��*/              
					0,	 /*  �����ֹμ�*/              
						               
					-1,		  /*  �Ի���*/           
					-1,	 	/*  ����*/ 	             
					-1	  /*  �����*/               





                                           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT  ");
					sql.append( "  A.EMPNO, ");	   /* ��� */
					sql.append( "  A.EMPNMK, ");       /*�ѱ۸�*/
					sql.append( "  B.NOTWRK, ");       /*�������� OR ��������*/
					sql.append( "  B.APPDT, ");	       /* ��� */
					sql.append( "  I.MINORNM AS PAYDIV, ");	/* �޿�����*/
					sql.append( "  B.DEPTCD, ");	/*  �μ��ڵ�*/
					sql.append( "  C.DEPTNM AS DEPTNM, ");	/*  �μ���*/
					sql.append( "  E.MINORNM AS PAYGRDNM, ");	/* �����ڵ�*/
					sql.append( "  F.MINORNM AS GRDDIVNM, ");	/*����*/
					sql.append( "  G.MINORNM AS PAYSEQNM, ");	/* ȣ���ڵ� */
					sql.append( "  H.MINORNM AS PAYBNKNM, ");	/*  �����ڵ�*/
					sql.append( "  B.PAYNUM, ");	/*  ���¹�ȣ*/
					sql.append( "  B.PAYDT, ");  /*  ������*/
					sql.append( "  B.DUYNOT, ");	/*  �������ϼ�*/
					sql.append( "  B.P10000, ");	/*  �⺻�޿�*/
					sql.append( "  B.P11000, ");	/* ��å���� */
					sql.append( "  B.P12000, ");	/* �ð��ܼ��� */
					sql.append( "  B.P21000, ");	/*  �ټӼ���*/
					sql.append( "  B.P22000, ");	/*  �ڱ��ߺ� */
					sql.append( "  B.P23000, ");	/*  �ξ簡��*/
					sql.append( "  B.P24000, ");	/*  ���������� */
					sql.append( "  B.P25000, ");	/*  �ⳳ����*/
					sql.append( "  B.P26000, ");	/*  ��������*/
					sql.append( "  B.P27000, ");	/*  �������*/
					sql.append( "  B.P28000, ");	/*  �ڰݼ���*/
					sql.append( "  B.P29000, ");	/*  ���ϰ�������*/
					sql.append( "  B.P30000, ");	/*  ����ܼ���*/
					sql.append( "  B.P31000, ");	/*  Ư��������*/
					sql.append( "  B.P32000, ");	/*  �����ٹ�����*/
					sql.append( "  B.P36000, ");	/*  �к�����*/
					sql.append( "  B.P37000, ");	/*  ���ο��ݺ�����*/
					sql.append( "  B.P38000, ");	/*  �ӿ���å����*/
					sql.append( "  B.PX0010, ");	/*  ��Ÿ����1*/
					sql.append( "  B.PX0020, ");	/*  ��Ÿ����2*/
					sql.append( "  B.PX0030, ");	/*  ��Ÿ����3*/
					sql.append( "  B.PX0040, ");	/*  ��Ÿ����4*/
					sql.append( "  B.S91000, ");	/*  �����հ�*/
					sql.append( "  B.T11000, ");	/*  �ҵ漼 OR ���ټ�*/
					sql.append( "  B.T12000, ");	/*  �ֹμ�*/
					sql.append( "  B.B11000, ");	/*  �ǰ������*/
					sql.append( "  B.B12000, ");	/*  ���ο���*/
					sql.append( "  B.B13000, ");	/*  ��뺸��*/
					sql.append( "  B.B15000, ");	/*  ���ο���*/
					sql.append( "  B.B14000, ");	/*  ������ȸ��*/
					sql.append( "  B.B16000, ");	/*  ����ȸ��*/
					sql.append( "  B.BX0010, ");	/*  ��Ÿ����1*/		
					sql.append( "  B.BX0020, ");	/*  ��Ÿ����2*/		
					sql.append( "  B.BX0030, ");	/*  ��Ÿ����3*/		
					sql.append( "  B.BX0040, ");	/*  ��Ÿ����4*/
					sql.append( "  B.S93000,  ");	/*  �����հ�*/	
					sql.append( "  B.S94000,  ");	/*  �����޾�*/	

					sql.append( "  B.P34000,  ");	/*  ��������*/
					sql.append( "  B.P39000,  ");	/*  �����ұ�*/
					sql.append( "  B.P41000,  ");   /*  ����ǰ�*/
					sql.append( "  B.P42000,  ");   /*  ������*/
					sql.append( "  B.T21000,  ");   /*  ����ҵ�*/
					sql.append( "  B.T22000,  ");   /*  �����ֹ�*/

					sql.append( "  B.TS9100,  ");   /*  �����ҵ洩��*/ 
					sql.append( "  B.TT1100,  ");   /*  �����ҵ��*/   
					sql.append( "  B.TT1200,  ");   /*  �����ֹμ�*/   
					sql.append( "  RTRIM(A.STRTDT) AS STRTDT,  ");	/*  �Ի���*/	
					sql.append( "  D.MINORNM AS JOBGRPHNM,  ");	/*  ����*/	
					sql.append( "  RTRIM(A.ENDDT) AS ENDDT  ");	/*  �����*/	
					sql.append( " from  PAYROLL.PBPAY B "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON A ON  B.EMPNO = A.EMPNO   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  B.DEPTCD = C.DEPTCD   ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE D ON  B.JOBGRPH = D.MINORCD  AND D.MAJORCD = '2000'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE E ON  B.PAYGRD = E.MINORCD  AND E.MAJORCD = '2002'   ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE F ON  B.GRDDIV = F.MINORCD  AND F.MAJORCD = '2001'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE G ON  B.PAYSEQ =  G.MINORCD  AND G.MAJORCD='1184'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE H ON  B.PAYBNK = H.MINORCD  AND H.MAJORCD = '1411'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE I ON  B.PAYDIV = I.MINORCD  AND I.MAJORCD = '1120'  ");
					 sql.append( " WHERE B.EMPNO <> ' ' ");
					 sql.append( "  AND B.PAYDIV <> '3'  ");  //�����޿� ����  

					
					
					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND B.PAYDT= '"  + str[0] + "' ");    //��������
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND B.APPDT = '" + str[1]+ "' ");     //������
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND B.PAYDIV= '"  + str[2] + "' ");   //�޿�����
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3]+ "' ");    //�μ��ڵ�
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '"  + str[4] + "' ");  //����
												  													   
					if (!str[5].equals("")&&!str[5].equals("0") && (!str[6].equals("")&&!str[6].equals("0")) )
						                                        sql.append( " AND B.EMPNO BETWEEN   '" + str[5]+ "' AND '" + str[6]+ "' ");
					                                             //��� ���� ����
					if (!str[7].equals("")&&!str[7].equals("0")) sql.append( " AND A.EMPNMK LIKE '" + str[7]+ "%' ");  //����
					if (!str[8].equals("")&&!str[8].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[8] + "' "); //����
					if (!str[9].equals("")&&!str[9].equals("0")) sql.append( " AND B.GRDDIV = '" + str[9]+ "' "); // ����
					sql.append( " ORDER BY B.DEPTCD , B.PAYDIV,A.EMPNMK,B.EMPNO  ");
					//logger.dbg.println(this,sql.toString());
/*********************************************************************************************/
                     // System.out.println(sql);
					stmt = conn.getGauceStatement(sql.toString());
								//		logger.err.println(this,"1");

	 		    stmt.executeQuery(dSet);
					//logger.err.println(this,"2");

				}
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