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
public class p040006_s1 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//�����,1- �Ի���,2
				str[1]	= req.getParameter("v_str2");		//�������ں���
				str[2]	= req.getParameter("v_str3");		//�������ڱ���
				str[3]	= req.getParameter("v_str4");		//�μ��ڵ�
				str[4]	= req.getParameter("v_str5");		//���

				for (int s=0;s<5;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"EMPNO",	   /* ��� */
				"EMPNMK",       /*�ѱ۸�*/
				"APPDT",	       /* ��� */
				"DEPTCD",	/*  �μ��ڵ�*/
				"DEPTNM",	/*  �μ���*/
				"PAYGRDNM",	/* �����ڵ�*/
				"GRDDIVNM",	/*����*/
				"PAYSEQNM",	/* ȣ���ڵ� */
				"PAYBNKNM",	/*  �����ڵ�*/
				"PAYNUM",	/*  ���¹�ȣ*/
				"PAYDT",     /*  �����޿���*/
				"RETDT",	/*  ������������*/
				"AVGAMT",	/* ��ձ޿� */
				"AVGETC",	/* ������� */
				"AVGYER",	/*  �������*/
				"AVGBOS",	/*  ����� */
				"JUSRET",	/*  ������*/
				"RETJUH",	/*  ������ȯ�� */
				"T23000",	/*  �����ҵ漼*/
				"T24000",	/*  �����ֹμ�*/
				"STRTDT",	/*  �Ի���*/
				"ENDDT",	/*  �����*/
				"S94000",	/*  �������޾�*/
				"S93000"
				};

				int[] intArrCN = new int[]{  
					7, 	    /* ��� */      
					20,	     /*�ѱ۸�*/     
					6,	        /* ��� */  
					4,	 /*  �μ��ڵ�*/     
					50,	 /*  �μ���*/       
					30,	 /* �����ڵ�*/      
					30,	 /*����*/           
					30,	 /* ȣ���ڵ� */     
					30,	 /*  �����ڵ�*/     
					25,	 /*  ���¹�ȣ*/     
					8,	  /*  �����޿���*/  
					8,	 /*  ������������*/ 
					9,	 /* ��ձ޿� */     
					9,	 /* ������� */     
					9,	 /*  �������*/     
					9,	 /*  ����� */    
					9,	 /*  ������*/       
					9,	 /*  ������ȯ�� */  
					9,	 /*  �����ҵ漼*/   
					9,	 /*  �����ֹμ�*/   
					8,	 /*  �Ի���*/   
					8,	 /*  �����*/   
					9,	 /*  �������޾�*/   
					9
         }; 

				int[] intArrCN2 = new int[]{
					-1,       /* ��� */         
					-1,	       /*�ѱ۸�*/        
					-1,           /* ��� */     
					-1,	   /*  �μ��ڵ�*/        
					-1,    /*  �μ���*/    
						
					-1,	   /* �����ڵ�*/         
					-1,    /*����*/              
					-1,	   /* ȣ���ڵ� */        
					-1,	   /*  �����ڵ�*/        
					-1,    /*  ���¹�ȣ*/ 
						
					-1,	    /*  �����޿���*/     
					-1,	   /*  ������������*/    
					0,	   /* ��ձ޿� */        
					0,	   /* ������� */        
					0,	   /*  �������*/ 
						
					0,	   /*  ����� */       
					0,	   /*  ������*/          
					0,	   /*  ������ȯ�� */     
					0,	   /*  �����ҵ漼*/      
					0,	   /*  �����ֹμ�*/   
					-1,	   /*  �Ի���*/      
					-1,	   /*  �����*/   
						
					0,	   /*  �������޾�*/      
					0

          }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT																																							\n");
					sql.append( "  I.EMPNO,										/*	��� */       																			\n");	
					sql.append( "  A.EMPNMK,									/*	�ѱ۸�*/      																			\n");	
					sql.append( "  I.APPDT,										/*	��� */       																			\n");	
					sql.append( "  A.DEPTCD,									/*  �μ��ڵ�*/    																			\n");	
					sql.append( "  C.DEPTNM AS DEPTNM,				/*  �μ���*/      																			\n");	
					sql.append( "  E.MINORNM AS PAYGRDNM,			/*	�����ڵ�*/    																			\n");	
					sql.append( "  F.MINORNM AS GRDDIVNM,			/*	����*/        																			\n");	
					sql.append( "  G.MINORNM AS PAYSEQNM,			/*	ȣ���ڵ� */   																			\n");	
					sql.append( "  H.MINORNM AS PAYBNKNM,			/*  �����ڵ�*/    																			\n");	
					sql.append( "  I.BNKNO AS PAYNUM,					/*  ���¹�ȣ*/    																			\n");	
					sql.append( "  I.PAYDT,										/*  �����޿���*/  																			\n");	
					sql.append( "  I.RETDT,										/*  ������������*/																			\n");	
					sql.append( "  I.AVGAMT,									/*	��ձ޿� */   																			\n");	
					sql.append( "  I.AVGETC,									/*	������� */   																			\n");	
					sql.append( "  I.AVGYER,									/*  �������*/    																			\n");	
					sql.append( "  I.AVGBOS,									/*  ����� */   																			\n");	
					sql.append( "  I.JUSRET,									/*  ������*/      																			\n");	
					sql.append( "  I.RETJUH,									/*  ������ȯ�� */ 																			\n");	
					sql.append( "  I.T23000,									/*  �����ҵ漼*/  																			\n");	
					sql.append( "  I.T24000,									/*  �����ֹμ�*/  																			\n");	
					sql.append( "  I.STRTDT,									/*  �Ի���*/      																			\n");	
					sql.append( "  I.ENDDT,										/*  �����*/      																			\n");	
					sql.append( "  I.S94000,									/*  �������޾�*/  																			\n");
					sql.append( "  I.S93000										/*  �����հ�*/     																			\n");
					sql.append( " FROM PAYROLL.PRPAY I			  																												\n"); 
					sql.append( " LEFT OUTER JOIN PAYROLL.HIPERSON A ON A.EMPNO   = I.EMPNO														\n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT   C ON A.DEPTCD  = C.DEPTCD													\n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE  D ON A.JOBGRPH = D.MINORCD AND D.MAJORCD = '2000'  \n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE  E ON A.PAYGRD  = E.MINORCD AND E.MAJORCD = '2002'  \n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE  F ON A.GRDDIV  = F.MINORCD AND F.MAJORCD = '2001'  \n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE  G ON A.PAYSEQ  = G.MINORCD AND G.MAJORCD = '1184'  \n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE  H ON I.BNKCD   = H.MINORCD AND H.MAJORCD = '1411'  \n");
					sql.append( " WHERE RTRIM(I.EMPNO) <> ''																													\n");
					sql.append( " AND I.PAYDIV='3'																																		\n");
																																																						
					if ( (!str[1].equals("")&&!str[1].equals("0")) && (!str[2].equals("")&&!str[2].equals("0")) )	{
						if ( str[0].equals("1") )	{
							sql.append( " AND I.ENDDT BETWEEN  '"  + str[1] + "' AND  '"  + str[2] + "' ");    //�������
						}else	{
							sql.append( " AND I.RETDT BETWEEN  '"  + str[1] + "' AND  '"  + str[2] + "' ");    //������������
						}
					}

					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( "  AND A.DEPTCD ='" + str[3]+ "' ");     //�μ�
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( "  AND I.EMPNO = '" + str[4]+ "' ");     //���

/*********************************************************************************************/
                
					stmt = conn.getGauceStatement(sql.toString());
	 		    stmt.executeQuery(dSet);
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