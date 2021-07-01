package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.//�Ⱓ�����ҵ���Ȳ
public class p020006_s9 extends HttpServlet {

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
				str[2]	= req.getParameter("v_str3");		//���ޱ���
				str[3]	= req.getParameter("v_str4");		//�μ�
				str[4]	= req.getParameter("v_str5");		//����
				str[5]	= req.getParameter("v_str6");		//�����ȣ
				str[6]	= req.getParameter("v_str7");		//�����ȣ
				str[7]	= req.getParameter("v_str8");		//����
				str[8]	= req.getParameter("v_str9");		//����
				str[9]	= req.getParameter("v_str10");		//����

				for (int s=0;s<10;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{

				"DEPTNM",	 /*  �μ���*/
				"TREECD",	 /*  �μ���*/
				"EMPNO",	 /* ��� */
				"EMPNMK",  /*�ѱ۸�*/
				
				"PAYGRDNM",/*  ������*/
				"JOBGRPHNM",/*  ������*/	
				"PAYSEQNM",/*  ȣ����*/
				"GRDDIVNM",/*  ���޸�*/

				"P10000",	/* �⺻�޿�*/
				"P11000",	/* ��å���� */
				"P12000",	/* �ð��ܼ��� */
				"P21000",	/* �ټӼ���*/
				"P22000",	/* �ڱ��ߺ� */
				"P23001",	/* �ξ簡��*/
				"P23000",	/* �ξ簡������*/
				"P24000",	/* ���������� */
				"P25000",	/* �ⳳ����*/
				"P26000",	/* ��������*/
				"P27000",	/* �������*/
				"P28000",	/* �ڰݼ���*/
				"P29000",	/* ���ϰ�������*/
				"P30000",	/* ����ܼ���*/
				"P31000",	/* Ư��������*/
				"P32000",	/* �����ٹ�����*/
				"P33001",	/* �����ϼ�  */
				"P33000",	/* ��������*/
				"P34001",	/* �����ϼ�*/
				"P34000",	/* ��������*/
				"P35000",	/* �Ĵ�*/
				"P36000",	/* �к�����*/
				"P37000",	/* ���ο��ݺ�����*/
				"P38000",	/* �ӿ���å����*/
				"P39000",	/* �����ұ�*/
				"PX0010",	/* ��Ÿ����1*/
				"PX0020",	/* ��Ÿ����2*/
				"PX0030",	/* ��Ÿ����3*/
				"PX0040",	/* ��Ÿ����4*/
				"P41000",	/* ����ǰ�����*/
				"P42000",	/* �����뺸��*/
				"T21000",	/* ����ҵ漼*/
				"T22000",	/* �����ֹμ�*/
				"T23000",	/* �����Ư��*/
				"S91000",	/* �����հ�*/
				"S92000",	/* �ҵ��հ�*/
				"T11000",	/* �ҵ漼*/
				"T12000",	/* �ֹμ�*/
				"B11000",	/* �ǰ������*/
				"B12000",	/* ���ο���*/
				"B13000",	/* ��뺸��*/
				"B14000",	/* ������ȸ��*/
				"B15000",	/* ���ο���*/
				"B16000",	/* ����ȸ��*/
				"BX0010",	/* ��Ÿ����1*/
				"BX0020",	/* ��Ÿ����2*/
				"BX0030",	/* ��Ÿ����3*/
				"BX0040",	/* ��Ÿ����4*/
				//"T31000",	/* ��¡�ҵ漼*/
				//"T33000",	/* ��¡�ֹμ�*/
				//"T92000",	/* ������ȯ��*/
				"S93000",	/* �����հ�*/
				"S94000",	/* �����޾�*/
				"STRTDT",   /* �Ի��� */
				"GRSTRTDT",   /* �׷��Ի��� */
				"TRAINYN",  /* �������뿩��*/
				"CHAGDT",  /* ���������� */
				"SENUM",    /* ��������� -�ξ簡������ -> 6��16�� �ٽú��� �����-�θ�-�ڳ�-�����-��ο�� */
				"P23002",   /* �����*/ 
				"P23003",	 /* �θ�*/    
				"P23004",	 /* �ڳ�*/    
				"P23005",	 /* ���*/    
				"P23006",	 /* ���*/    
        "SEQ",	 /* �ٹ�����¼���*/   
				"APLAMT",
				"APLRAT",			
				"SANGRAT",  /*����*/
				"AMT_1"
				};

				int[] intArrCN = new int[]{  
					30,	
					8, 	
					7, 	
					20,

					30,	/*  ������*/
					30,	/*  ������*/
					30,	/*  ȣ����*/
					30,	/*  ���޸�*/

					9,	/* �⺻�޿�*/
					9,	/* ��å���� */
					9,	/* �ð��ܼ��� */
					9,	/* �ټӼ���*/
					9,	/* �ڱ��ߺ� */
					9,	/* �ξ簡��*/
					9,	/* �ξ簡������*/
					9,	/* ���������� */
					9,	/* �ⳳ����*/
					9,	/* ��������*/
					9,	/* �������*/
					9,	/* �ڰݼ���*/
					9,	/* ���ϰ�������*/
					9,	/* ����ܼ���*/
					9,	/* Ư��������*/
					9,	/* �����ٹ�����*/
					9,	/* �����ϼ�  */
					9,	/* ��������*/
					9,	/* �����ϼ�*/
					9,	/* ��������*/
					9,	/* �Ĵ�*/
					9,	/* �к�����*/
					9,	/* ���ο��ݺ�����*/
					9,	/* �ӿ���å����*/
					9,	/* �����ұ�*/
					9,	/* ��Ÿ����1*/
					9,	/* ��Ÿ����2*/
					9,	/* ��Ÿ����3*/
					9,	/* ��Ÿ����4*/
					9,	/* ����ǰ�����*/
					9,	/* �����뺸��*/
					9,	/* ����ҵ漼*/
					9,	/* �����ֹμ�*/
					9,	/* �����Ư��*/
					9,	/* �����հ�*/
					9,	/* �ҵ��հ�*/
					9,	/* �ҵ漼*/
					9,	/* �ֹμ�*/
					9,	/* �ǰ������*/
					9,	/* ���ο���*/
					9,	/* ��뺸��*/
					9,	/* ������ȸ��*/
					9,	/* ���ο���*/
					9,	/* ����ȸ��*/
					9,	/* ��Ÿ����1*/
					9,	/* ��Ÿ����2*/
					9,	/* ��Ÿ����3*/
					9,	/* ��Ÿ����4*/
					//9,	/* ��¡�ҵ漼*/
					//9,	/* ��¡�ֹμ�*/
					//9,	/* ������ȯ��*/
					9,	/* �����հ�*/
					9,	/* �����޾�*/
					8,   /* �Ի��� */
					8,   /* �׷��Ի��� */
					1,   /* �������뿩�� */
					8,  /* ���������� -������*/
					9,    /* ��������� -�ξ簡������ -> 6��16�� �ٽú��� �����-�θ�-�ڳ�-�����-��ο��*/
					2,	/* �����*/
					2,	/* �θ�*/  
					2,	/* �ڳ�*/  
					2,	/* ���*/  
					2,	/* ���*/  
          3,	  /* �ٹ�����¼�*/  
					9,
					9,
					3,
					9
          }; 

				int[] intArrCN2 = new int[]{
					-1,
					-1,   
					-1,   
					-1,

					-1,	/*  ������*/
					-1,	/*  ������*/
					-1,	/*  ȣ����*/
					-1,	/*  ���޸�*/

					0,	/* �⺻�޿�*/
					0,	/* ��å���� */
					0,	/* �ð��ܼ��� */
					0,	/* �ټӼ���*/
					0,	/* �ڱ��ߺ� */
					0,	/* �ξ簡��*/
					0,	/* �ξ簡������*/
					0,	/* ���������� */
					0,	/* �ⳳ����*/
					0,	/* ��������*/
					0,	/* �������*/
					0,	/* �ڰݼ���*/
					0,	/* ���ϰ�������*/
					0,	/* ����ܼ���*/
					0,	/* Ư��������*/
					0,	/* �����ٹ�����*/
					0,	/* �����ϼ�  */
					0,	/* ��������*/
					0,	/* �����ϼ�*/
					0,	/* ��������*/
					0,	/* �Ĵ�*/
					0,	/* �к�����*/
					0,	/* ���ο��ݺ�����*/
					0,	/* �ӿ���å����*/
					0,	/* �����ұ�*/
					0,	/* ��Ÿ����1*/
					0,	/* ��Ÿ����2*/
					0,	/* ��Ÿ����3*/
					0,	/* ��Ÿ����4*/
					0,	/* ����ǰ�����*/
					0,	/* �����뺸��*/
					0,	/* ����ҵ漼*/
					0,	/* �����ֹμ�*/
					0,	/* �����Ư��*/
					0,	/* �����հ�*/
					0,	/* �ҵ��հ�*/
					0,	/* �ҵ漼*/
					0,	/* �ֹμ�*/
					0,	/* �ǰ������*/
					0,	/* ���ο���*/
					0,	/* ��뺸��*/
					0,	/* ������ȸ��*/
					0,	/* ���ο���*/
					0,	/* ����ȸ��*/
					0,	/* ��Ÿ����1*/
					0,	/* ��Ÿ����2*/
					0,	/* ��Ÿ����3*/
					0,	/* ��Ÿ����4*/
					//0,	/* ��¡�ҵ漼*/
					//0,	/* ��¡�ֹμ�*/
					//0,	/* ������ȯ��*/
					0,	/* �����հ�*/
					0,	/* �����޾�*/
					-1,   /* �Ի��� */
					-1,   /* �׷��Ի��� */
					-1,   /* �������뿩�� */
					-1,  /* ���������� */
					-1,    /* ��������� -�ξ簡������ -> 6��16�� �ٽú��� �����-�θ�-�ڳ�-�����-��ο��*/
					0,		/* �����*/ 
					0,		/* �θ�*/    
					0,		/* �ڳ�*/    
					0,		/* ���*/    
					0, 		/* ���*/    
          -1,
					0,
					0,
					-1,
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
					
					sql.append( " SELECT                            \n ");
          sql.append( " RTRIM(C.DEPTNM) AS DEPTNM,        \n "); /* �μ���*/
					sql.append( " C.TREECD,                         \n "); /* Ʈ���õ� */  
					sql.append( " A.EMPNO,                          \n ");	/* ��� */      
          sql.append( " A.EMPNMK,                         \n ");	/*�ѱ۸�*/      
					sql.append( " RTRIM(D.MINORNM) AS PAYGRDNM,     \n "); /*  ������*/  
					sql.append( " RTRIM(F.MINORNM) AS JOBGRPHNM,    \n ");	/*  ������*/	
					sql.append( " RTRIM(G.MINORNM) AS PAYSEQNM,     \n ");	/*  ȣ����*/  
					sql.append( " RTRIM(H.MINORNM) AS GRDDIVNM,     \n ");	/*  ���޸�*/  
					sql.append( " X.P10000,                         \n "); /* �⺻�޿�*/       
					sql.append( " X.P11000,                         \n ");	/* ��å���� */      
					sql.append( " X.P12000,                         \n ");	/* �ð��ܼ��� */    
					sql.append( " X.P21000,                         \n ");	/* �ټӼ���*/       
					sql.append( " X.P22000,                         \n ");	/* �ڱ��ߺ� */    
          sql.append( " X.P23001,                         \n ");	/* �ξ簡��*/       
          sql.append( " X.P23000,                         \n ");	/* �ξ簡������*/   
					sql.append( " X.P24000,                         \n ");	/* ���������� */    
					sql.append( " X.P25000,                         \n ");	/* �ⳳ����*/       
          sql.append( " X.P26000,                         \n ");	/* ��������*/       
					sql.append( " X.P27000,                         \n ");	/* �������*/       
					sql.append( " X.P28000,                         \n ");	/* �ڰݼ���*/       
					sql.append( " X.P29000,                         \n ");	/* ���ϰ�������*/   
					sql.append( " X.P30000,                         \n ");	/* ����ܼ���*/     
					sql.append( " X.P31000,                         \n ");	/* Ư��������*/     
					sql.append( " X.P32000,                         \n ");	/* �����ٹ�����*/   
					sql.append( " X.P33001,                         \n ");	/* �����ϼ�  */     
					sql.append( " X.P33000,                         \n ");	/* ��������*/       
					sql.append( " X.P34001,                         \n ");	/* �����ϼ�*/       
					sql.append( " X.P34000,                         \n ");	/* ��������*/       
          sql.append( " X.P35000,                         \n ");	/* �Ĵ�*/           
					sql.append( " X.P36000,                         \n ");	/* �к�����*/     
					sql.append( " X.P37000,                         \n ");	/* ���ο��ݺ�����*/ 
          sql.append( " X.P38000,                         \n ");	/* �ӿ���å����*/   
					sql.append( " X.P39000,                         \n ");	/* �����ұ�*/       
					sql.append( " X.PX0010,                         \n ");	/* ��Ÿ����1*/      
					sql.append( " X.PX0020,                         \n ");	/* ��Ÿ����2*/      
					sql.append( " X.PX0030,                         \n ");	/* ��Ÿ����3*/      
					sql.append( " X.PX0040,                         \n ");	/* ��Ÿ����4*/      
					sql.append( " X.P41000,                         \n ");	/* ����ǰ�����*/   
					sql.append( " X.P42000,                         \n ");	/* �����뺸��*/   
					sql.append( " X.T21000,                         \n ");	/* ����ҵ漼*/     
					sql.append( " X.T22000,                         \n ");	/* �����ֹμ�*/     
					sql.append( " X.T23000,                         \n ");	/* �����Ư��*/     
          sql.append( " X.S91000,                         \n ");	/* �����հ�*/       
					sql.append( " X.S92000,                         \n ");	/* �ҵ��հ�*/       
					sql.append( " X.T11000,                         \n ");	/* �ҵ漼*/         
          sql.append( " X.T12000,                         \n ");	/* �ֹμ�*/         
					sql.append( " X.B11000,                         \n ");	/* �ǰ������*/     
					sql.append( " X.B12000,                         \n ");	/* ���ο���*/       
					sql.append( " X.B13000,                         \n ");	/* ��뺸��*/       
					sql.append( " X.B14000,                         \n ");	/* ������ȸ��*/     
					sql.append( " X.B15000,                         \n ");	/* ���ο���*/       
					sql.append( " X.B16000,                         \n ");	/* ����ȸ��*/       
					sql.append( " X.BX0010,                         \n ");	/* ��Ÿ����1*/      
					sql.append( " X.BX0020,                         \n ");	/* ��Ÿ����2*/      
					sql.append( " X.BX0030,                         \n ");	/* ��Ÿ����3*/      
					sql.append( " X.BX0040,                         \n ");	/* ��Ÿ����4*/      
          sql.append( " X.S93000,                         \n "); /* �����հ�*/  
					sql.append( " X.S94000,                         \n ");	/* �����޾�*/  
					sql.append( " X.STRTDT,                         \n "); /* �Ի��� */     
          sql.append( " RTRIM(A.GRSTRTDT) AS GRSTRTDT,    \n ");	/* �׷��Ի���*/  
					sql.append( " X.TRAINYN,                        \n ");  /* �������뿩�� */ 
					sql.append( " X.CHAGDT AS CHAGDT,               \n ");	/* ����������*/    
					sql.append( " X.SENUM,                          \n ");	 /* ��������*/    
					sql.append( " X.P23002,                         \n ");	 /* �����*/        
					sql.append( " X.P23003,                         \n ");	/* �θ�*/          
					sql.append( " X.P23004,                         \n ");	 /* �ڳ�*/          
					sql.append( " X.P23005,                         \n ");	 /* ���*/          
					sql.append( " X.P23006,                         \n ");	 /* ���*/		       
					//sql.append( " I.SEQ,                            \n ");	 /* ���*/
          // 2008.08.18 ���ñٹ��� ������ ����...
          //sql.append( " CASE WHEN A.HSKSCR=2 THEN 99 ELSE I.SEQ END SEQ,   \n ");	 /* ���*/
					// 2009.01.18 ���ñٹ��� ������ ����...
					//sql.append( " CASE WHEN A.JTGB IN (2,3,4,5,6) THEN 99 ELSE I.SEQ END SEQ,   \n ");	 /* ���*/
					// 2010.01.25. JYS ������ ����ó��
          sql.append( " CASE WHEN X.JTGB = 2 THEN 995    \n ");	 
					sql.append( " 		 WHEN X.JTGB = 3 THEN 996    \n ");	 
					sql.append( " 		 WHEN X.JTGB = 4 THEN 997    \n ");	 
					sql.append( " 		 WHEN X.JTGB = 5 THEN 998    \n ");	 
					sql.append( " 		 WHEN X.JTGB = 6 THEN 999    \n ");	 				
					sql.append( " 		 ELSE CASE WHEN X.EMPNO ='1990016' THEN '7'        \n ");	 //1990005-->1990016
					sql.append( " 		           WHEN X.EMPNO ='2000001' THEN '8'        \n ");	
					sql.append( " 		      ELSE I.SEQ END        \n ");	 
					sql.append( "  END SEQ,        \n ");	 
					sql.append( " X.APLAMT,X.APLRAT,              \n ");
          sql.append( " X.SANGRAT,                      \n ");	 /* ����*/
					sql.append( " COALESCE((L.APLAMT+L.APLRAT),0) AMT_1,  \n ");	/* ��ȯ�� */
					//2007.10.24�߰� 2009.10.16 �߰� 2010.01.18 �߰�
					//sql.append( " CASE WHEN A.EMPNO='1990005' THEN '998'             \n " );	/* ����ó�� */
          //sql.append( " CASE WHEN A.EMPNO='2030001' THEN '998'             \n " );	/* ����ó�� */
					//sql.append( "      WHEN A.EMPNO='2010008' THEN '999'   \n " );	/*  */
					//sql.append( "      WHEN A.EMPNO='2060002' THEN '40'  \n " );	/*  */
          //sql.append( "      WHEN A.EMPNO='1990013' THEN '41'  \n " );	/*  */
					//sql.append( "      WHEN A.EMPNO='2070012' THEN '42'  \n " );	/*  */
					//sql.append( "      WHEN A.EMPNO='2040056' THEN '43'  \n " );	/*  */
					//sql.append( "      WHEN A.EMPNO='2040060' THEN '50'  \n " );	/*  */
					//sql.append( "      WHEN A.EMPNO='2040056' THEN '60'  \n " );	/*  */
					//sql.append( "      WHEN A.EMPNO='2090007' THEN '70'  \n " );	/*  */
					//sql.append( "      ELSE D.SEQ END SEQ2  \n " );	/*  */					
					sql.append( " CASE WHEN A.EMPNO='1990005' THEN '548'  \n " );	/* ����ó�� */
					sql.append( "      WHEN A.EMPNO='2070031' THEN '549'  \n " );	/* ����ó�� */
					sql.append( "      ELSE D.SEQ END SEQ2  \n " );	/*  */
					sql.append( " FROM                              \n " );
          sql.append( " (                                                                                                                     \n " );
					sql.append( "    SELECT B.EMPNO, MAX(B.DEPTCD)DEPTCD, MAX(B.PAYGRD)PAYGRD, MAX(B.JOBGRPH)JOBGRPH,                                      \n " );
					sql.append( "		 MAX(B.PAYSEQ)PAYSEQ,    MAX(B.GRDDIV)GRDDIV,                                                                          \n " );
          sql.append( "		 SUM(B.P10000)P10000,    SUM(B.P11000)P11000,    SUM(B.P12000)P12000,    SUM(B.P21000)P21000,    SUM(B.P22000)P22000,  \n " );
					sql.append( "		 SUM(B.P23001)P23001,    SUM(B.P23000)P23000,    SUM(B.P24000)P24000,    SUM(B.P25000)P25000,    SUM(B.P26000)P26000,  \n " );
					sql.append( "		 SUM(B.P27000)P27000,    SUM(B.P28000)P28000,    SUM(B.P29000)P29000,    SUM(B.P30000)P30000,    SUM(B.P31000)P31000,  \n " );
					sql.append( "		 SUM(B.P32000)P32000,    SUM(B.P33001)P33001,    SUM(B.P33000)P33000,    SUM(B.P34001)P34001,    SUM(B.P34000)P34000,  \n " );
					sql.append( "		 SUM(B.P35000)P35000,    SUM(B.P36000)P36000,    SUM(B.P37000)P37000,    SUM(B.P38000)P38000,    SUM(B.P39000)P39000,  \n " );
					sql.append( "		 SUM(B.PX0010)PX0010,    SUM(B.PX0020)PX0020,    SUM(B.PX0030)PX0030,    SUM(B.PX0040)PX0040,    SUM(B.P41000)P41000,  \n " );
					sql.append( "		 SUM(B.P42000)P42000,    SUM(B.T21000)T21000,    SUM(B.T22000)T22000,    SUM(B.T23000)T23000,    SUM(B.S91000)S91000,  \n " );
					sql.append( "		 SUM(B.S92000)S92000,    SUM(B.T11000)T11000,    SUM(B.T12000)T12000,    SUM(B.B11000)B11000,    SUM(B.B12000)B12000,  \n " );
					sql.append( "		 SUM(B.B13000)B13000,    SUM(B.B14000)B14000,    SUM(B.B15000)B15000,    SUM(B.B16000)B16000,    SUM(B.BX0010)BX0010,  \n " );
					sql.append( "		 SUM(B.BX0020)BX0020,    SUM(B.BX0030)BX0030,    SUM(B.BX0040)BX0040,    SUM(B.S93000)S93000,    SUM(B.S94000)S94000,  \n " );
					sql.append( "		 MAX(B.STRTDT)STRTDT,    MAX(B.CHAGDT)CHAGDT,    '0'  AS SENUM,            \n " );
          sql.append( "		 SUM(B.P23002)P23002,    SUM(B.P23003)P23003,    SUM(B.P23004)P23004,    SUM(B.P23005)P23005,    SUM(B.P23006)P23006,  \n " );
					sql.append( "		 SUM(B.APLAMT)APLAMT,    SUM(B.APLRAT)APLRAT,    IFNULL(MAX(B.SANGRAT),0)SANGRAT, IFNULL(MAX(B.TRAINYN),'')TRAINYN,MAX(B.JTGB) JTGB	 \n " );
					sql.append( "		 FROM PAYROLL.PBPAY B                                                                                                  \n " );
					
					sql.append( "   WHERE B.EMPNO <> ' ' \n " );
					if (!str[0].equals("")&&!str[0].equals("0")) 
					sql.append( "     AND B.PAYDT = '"  + str[0] + "' \n " );    //�������ں��ͱ���
					if (!str[1].equals("")&&!str[1].equals("0")) 
					sql.append( "     AND B.APPDT= '"  + str[1] + "' \n " );     //������
					//if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND B.PAYDIV = '" + str[2]+ "' \n " );   //���ޱ���
					if (!str[3].equals("")&&!str[3].equals("0")) 
					sql.append( "     AND B.DEPTCD = '" + str[3]+ "' \n " );   //�μ�
					if (!str[4].equals("")&&!str[4].equals("0")) 
					sql.append( "     AND B.JOBGRPH= '"  + str[4] + "' \n " ); //����
					if (!str[5].equals("")&&!str[5].equals("0") && (!str[6].equals("")&&!str[6].equals("0")) )
					sql.append( "     AND B.EMPNO BETWEEN '"  + str[5] + "' AND '"  + str[6] + "' \n " );                //�����ȣ���� ����                                                                                               \n " );
          if (!str[8].equals("")&&!str[8].equals("0")) 
					sql.append( "     AND B.PAYGRD = '" + str[8]+ "' \n " );  // ����
					if (!str[9].equals("")&&!str[9].equals("0")) 
					sql.append( "     AND B.GRDDIV = '" + str[9]+ "' \n " );  // ����
					if (str[2].equals("1")) 
					sql.append( "   	AND B.PAYDIV IN ('1','3','4')                \n " );     //����+����+�ޱ�
					if (str[2].equals("5"))
					sql.append( "	    AND B.PAYDIV IN ('5')                \n " );	
					if (str[2].equals("6"))
					sql.append( "	    AND B.PAYDIV IN ('6')                \n " );	
					if (str[2].equals("7"))
					sql.append( "	    AND B.PAYDIV IN ('7')                \n " );	
					sql.append( "	GROUP BY SUBSTR(B.PAYDT,1,6), B.EMPNO) X                                                                              \n " );
					sql.append( " LEFT JOIN PAYROLL.HIPERSON A ON A.EMPNO=X.EMPNO                                                                       \n " );
					sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON X.DEPTCD=C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)                 \n " );
					sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON X.PAYGRD = D.MINORCD AND D.MAJORCD = '2002'                                            \n " ); /*����*/       
					sql.append( " LEFT JOIN PAYROLL.HCLCODE F ON X.JOBGRPH = F.MINORCD AND F.MAJORCD = '2000'                                           \n " );	 /*����*/      
					sql.append( " LEFT JOIN PAYROLL.HCLCODE G ON X.PAYSEQ = G.MINORCD AND G.MAJORCD = '1184'                                            \n " );	/*ȣ��*/       
					sql.append( " LEFT JOIN PAYROLL.HCLCODE H ON X.GRDDIV = H.MINORCD AND H.MAJORCD = '2001'                                            \n " );	/*����*/       
					sql.append( " LEFT JOIN PAYROLL.HCLCODE I ON C.GROUPID = I.MINORCD AND I.MAJORCD = '2051'                                           \n " );	 /*�ٹ���*/    
					sql.append( " LEFT OUTER JOIN PAYROLL.PWRONPAY L ON  X.EMPNO = L.EMPNO     AND L.APLDAY ='"+str[1]+"25' \n " );
														  													   
					if (!str[7].equals("")&&!str[7].equals("0")) sql.append( " WHERE A.EMPNMK= '"  + str[7] + "' \n " ); //����
				
					//sql.append( " ORDER BY I.SEQ, D.SEQ, PAYSEQNM DESC, A.EMPNO \n " ); /*���ޱ���*/
					//sql.append( " ORDER BY I.SEQ, SEQ2, INTEGER(X.PAYSEQ) DESC, PAYSEQNM DESC, A.EMPNO \n " ); /*���ޱ���*/

          sql.append( " ORDER BY SEQ, SEQ2, INTEGER(X.PAYSEQ) DESC, PAYSEQNM DESC, A.EMPNO \n " ); /*���ޱ���*/

					//logger.dbg.println(this,sql.toString());
					
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