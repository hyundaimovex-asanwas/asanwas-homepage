package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.//�Ⱓ�����ҵ���Ȳ
public class p040005_s3 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//���
				str[1]	= req.getParameter("v_str2");		//�����

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
				"P42000",	/* ������뺸��*/
				"T21000",	/* ����ҵ漼*/
				"T22000",	/* �����ֹμ�*/
				"T23000",	/* �����Ư��*/
				"S91000",	/* �����հ�*/
				"S92000",	/* �ҵ��հ�*/
				"T11000",	/* �ҵ漼*/
				"T12000",	/* �ֹμ�*/
				"B11000",	/* �ǰ������*/
				"B12000",	/* ���ο���*/
				"B13000",	/* ���뺸��*/
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
				"PAYDTYM",  /* ���������� */
				"PAYDTYMD",  /* ���������� */
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
					9,	/* ������뺸��*/
					9,	/* ����ҵ漼*/
					9,	/* �����ֹμ�*/
					9,	/* �����Ư��*/
					9,	/* �����հ�*/
					9,	/* �ҵ��հ�*/
					9,	/* �ҵ漼*/
					9,	/* �ֹμ�*/
					9,	/* �ǰ������*/
					9,	/* ���ο���*/
					9,	/* ���뺸��*/
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
					6,  /* ���������� -������*/
					8,  /* ���������� -������*/
					9,    /* ��������� -�ξ簡������ -> 6��16�� �ٽú��� �����-�θ�-�ڳ�-�����-��ο��*/
					2,	/* �����*/
					2,	/* �θ�*/  
					2,	/* �ڳ�*/  
					2,	/* ���*/  
					2,	/* ���*/  
          2,	  /* ���*/  
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
					0,	/* ������뺸��*/
					0,	/* ����ҵ漼*/
					0,	/* �����ֹμ�*/
					0,	/* �����Ư��*/
					0,	/* �����հ�*/
					0,	/* �ҵ��հ�*/
					0,	/* �ҵ漼*/
					0,	/* �ֹμ�*/
					0,	/* �ǰ������*/
					0,	/* ���ο���*/
					0,	/* ���뺸��*/
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
					0,
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
					
					sql.append( " SELECT                            ");
          sql.append("\n").append( " RTRIM(C.DEPTNM) AS DEPTNM,        "); /* �μ���*/
					sql.append("\n").append( " C.TREECD,                         "); /* Ʈ���õ� */  
					sql.append("\n").append( " A.EMPNO,                          ");	/* ��� */      
          sql.append("\n").append( " A.EMPNMK,                         ");	/*�ѱ۸�*/      
					sql.append("\n").append( " RTRIM(D.MINORNM) AS PAYGRDNM,     "); /*  ������*/  
					sql.append("\n").append( " RTRIM(F.MINORNM) AS JOBGRPHNM,    ");	/*  ������*/	
					sql.append("\n").append( " RTRIM(G.MINORNM) AS PAYSEQNM,     ");	/*  ȣ����*/  
					sql.append("\n").append( " RTRIM(H.MINORNM) AS GRDDIVNM,     ");	/*  ���޸�*/  
					sql.append("\n").append( " X.P10000,                         "); /* �⺻�޿�*/       
					sql.append("\n").append( " X.P11000,                         ");	/* ��å���� */      
					sql.append("\n").append( " X.P12000,                         ");	/* �ð��ܼ��� */    
					sql.append("\n").append( " X.P21000,                         ");	/* �ټӼ���*/       
					sql.append("\n").append( " X.P22000,                         ");	/* �ڱ��ߺ� */    
          sql.append("\n").append( " X.P23001,                         ");	/* �ξ簡��*/       
          sql.append("\n").append( " X.P23000,                         ");	/* �ξ簡������*/   
					sql.append("\n").append( " X.P24000,                         ");	/* ���������� */    
					sql.append("\n").append( " X.P25000,                         ");	/* �ⳳ����*/       
          sql.append("\n").append( " X.P26000,                         ");	/* ��������*/       
					sql.append("\n").append( " X.P27000,                         ");	/* �������*/       
					sql.append("\n").append( " X.P28000,                         ");	/* �ڰݼ���*/       
					sql.append("\n").append( " X.P29000,                         ");	/* ���ϰ�������*/   
					sql.append("\n").append( " X.P30000,                         ");	/* ����ܼ���*/     
					sql.append("\n").append( " X.P31000,                         ");	/* Ư��������*/     
					sql.append("\n").append( " X.P32000,                         ");	/* �����ٹ�����*/   
					sql.append("\n").append( " X.P33001,                         ");	/* �����ϼ�  */     
					sql.append("\n").append( " X.P33000,                         ");	/* ��������*/       
					sql.append("\n").append( " X.P34001,                         ");	/* �����ϼ�*/       
					sql.append("\n").append( " X.P34000,                         ");	/* ��������*/       
          sql.append("\n").append( " X.P35000,                         ");	/* �Ĵ�*/           
					sql.append("\n").append( " X.P36000,                         ");	/* �к�����*/     
					sql.append("\n").append( " X.P37000,                         ");	/* ���ο��ݺ�����*/ 
          sql.append("\n").append( " X.P38000,                         ");	/* �ӿ���å����*/   
					sql.append("\n").append( " X.P39000,                         ");	/* �����ұ�*/       
					sql.append("\n").append( " X.PX0010,                         ");	/* ��Ÿ����1*/      
					sql.append("\n").append( " X.PX0020,                         ");	/* ��Ÿ����2*/      
					sql.append("\n").append( " X.PX0030,                         ");	/* ��Ÿ����3*/      
					sql.append("\n").append( " X.PX0040,                         ");	/* ��Ÿ����4*/      
					sql.append("\n").append( " X.P41000,                         ");	/* ����ǰ�����*/   
					sql.append("\n").append( " X.P42000,                         ");	/* ������뺸��*/   
					sql.append("\n").append( " X.T21000,                         ");	/* ����ҵ漼*/     
					sql.append("\n").append( " X.T22000,                         ");	/* �����ֹμ�*/     
					sql.append("\n").append( " X.T23000,                         ");	/* �����Ư��*/     
          sql.append("\n").append( " X.S91000,                         ");	/* �����հ�*/       
					sql.append("\n").append( " X.S92000,                         ");	/* �ҵ��հ�*/       
					sql.append("\n").append( " X.T11000,                         ");	/* �ҵ漼*/         
          sql.append("\n").append( " X.T12000,                         ");	/* �ֹμ�*/         
					sql.append("\n").append( " X.B11000,                         ");	/* �ǰ������*/     
					sql.append("\n").append( " X.B12000,                         ");	/* ���ο���*/       
					sql.append("\n").append( " X.B13000,                         ");	/* ���뺸��*/       
					sql.append("\n").append( " X.B14000,                         ");	/* ������ȸ��*/     
					sql.append("\n").append( " X.B15000,                         ");	/* ���ο���*/       
					sql.append("\n").append( " X.B16000,                         ");	/* ����ȸ��*/       
					sql.append("\n").append( " X.BX0010,                         ");	/* ��Ÿ����1*/      
					sql.append("\n").append( " X.BX0020,                         ");	/* ��Ÿ����2*/      
					sql.append("\n").append( " X.BX0030,                         ");	/* ��Ÿ����3*/      
					sql.append("\n").append( " X.BX0040,                         ");	/* ��Ÿ����4*/      
          sql.append("\n").append( " X.S93000,                         "); /* �����հ�*/  
					sql.append("\n").append( " X.S94000,                         ");	/* �����޾�*/  
					sql.append("\n").append( " X.STRTDT,                         "); /* �Ի��� */     
          sql.append("\n").append( " RTRIM(A.GRSTRTDT) AS GRSTRTDT,    ");	/* �׷��Ի���*/  
					sql.append("\n").append( " X.TRAINYN,                        ");  /* �������뿩�� */ 
					sql.append("\n").append( " SUBSTR(X.PAYDT,1,6) AS PAYDTYM,               ");	/* �޿����޳��*/    
					sql.append("\n").append( " X.PAYDT AS PAYDTYMD,               ");	/* �޿�������*/    
					sql.append("\n").append( " X.SENUM,                          ");	 /* ��������*/    
					sql.append("\n").append( " X.P23002,                         ");	 /* �����*/        
					sql.append("\n").append( " X.P23003,                         ");	/* �θ�*/          
					sql.append("\n").append( " X.P23004,                         ");	 /* �ڳ�*/          
					sql.append("\n").append( " X.P23005,                         ");	 /* ���*/          
					sql.append("\n").append( " X.P23006,                         ");	 /* ���*/		       
					sql.append("\n").append( " I.SEQ,                            ");	 /* ���*/
					sql.append("\n").append( " X.APLAMT,X.APLRAT,                ");
          sql.append("\n").append( " X.SANGRAT,                        ");	 /* ����*/
					sql.append("\n").append( " COALESCE((L.APLAMT+L.APLRAT),0) AMT_1 ");	/* ��ȯ�� */
					sql.append("\n").append( " FROM                              ");
          sql.append("\n").append( " (                                                                                                                     ");
					sql.append("\n").append( "    SELECT B.EMPNO, MAX(B.DEPTCD)DEPTCD, MAX(B.PAYGRD)PAYGRD, MAX(B.JOBGRPH)JOBGRPH,                                      ");
					sql.append("\n").append( "		 MAX(B.PAYSEQ)PAYSEQ,    MAX(B.GRDDIV)GRDDIV,                                                                          ");
          sql.append("\n").append( "		 SUM(B.P10000)P10000,    SUM(B.P11000)P11000,    SUM(B.P12000)P12000,    SUM(B.P21000)P21000,    SUM(B.P22000)P22000,  ");
					sql.append("\n").append( "		 SUM(B.P23001)P23001,    SUM(B.P23000)P23000,    SUM(B.P24000)P24000,    SUM(B.P25000)P25000,    SUM(B.P26000)P26000,  ");
					sql.append("\n").append( "		 SUM(B.P27000)P27000,    SUM(B.P28000)P28000,    SUM(B.P29000)P29000,    SUM(B.P30000)P30000,    SUM(B.P31000)P31000,  ");
					sql.append("\n").append( "		 SUM(B.P32000)P32000,    SUM(B.P33001)P33001,    SUM(B.P33000)P33000,    SUM(B.P34001)P34001,    SUM(B.P34000)P34000,  ");
					sql.append("\n").append( "		 SUM(B.P35000)P35000,    SUM(B.P36000)P36000,    SUM(B.P37000)P37000,    SUM(B.P38000)P38000,    SUM(B.P39000)P39000,  ");
					sql.append("\n").append( "		 SUM(B.PX0010)PX0010,    SUM(B.PX0020)PX0020,    SUM(B.PX0030)PX0030,    SUM(B.PX0040)PX0040,    SUM(B.P41000)P41000,  ");
					sql.append("\n").append( "		 SUM(B.P42000)P42000,    SUM(B.T21000)T21000,    SUM(B.T22000)T22000,    SUM(B.T23000)T23000,    SUM(B.S91000)S91000,  ");
					sql.append("\n").append( "		 SUM(B.S92000)S92000,    SUM(B.T11000)T11000,    SUM(B.T12000)T12000,    SUM(B.B11000)B11000,    SUM(B.B12000)B12000,  ");
					sql.append("\n").append( "		 SUM(B.B13000)B13000,    SUM(B.B14000)B14000,    SUM(B.B15000)B15000,    SUM(B.B16000)B16000,    SUM(B.BX0010)BX0010,  ");
					sql.append("\n").append( "		 SUM(B.BX0020)BX0020,    SUM(B.BX0030)BX0030,    SUM(B.BX0040)BX0040,    SUM(B.S93000)S93000,    SUM(B.S94000)S94000,  ");
					sql.append("\n").append( "		 MAX(B.STRTDT)STRTDT,    MAX(B.PAYDT)PAYDT,    '0'  AS SENUM,                                ");
          sql.append("\n").append( "		 SUM(B.P23002)P23002,    SUM(B.P23003)P23003,    SUM(B.P23004)P23004,    SUM(B.P23005)P23005,    SUM(B.P23006)P23006,  ");
					sql.append("\n").append( "		 SUM(B.APLAMT)APLAMT,    SUM(B.APLRAT)APLRAT,    IFNULL(MAX(B.SANGRAT),0)SANGRAT, IFNULL(MAX(B.TRAINYN),'')TRAINYN																																						 ");
					sql.append("\n").append( "		 FROM PAYROLL.PBPAY B                                                                                                  ");
					
					sql.append("\n").append( "   WHERE B.EMPNO= '"  + str[0] + "' ");
					sql.append("\n").append( "     AND SUBSTR(B.APPDT,1,4)= '"  + str[1] + "' ");     //�����=����
					sql.append("\n").append( "	    AND B.PAYDIV IN ('5')                ");					
					sql.append("\n").append( "	GROUP BY SUBSTR(B.PAYDT,1,6), B.EMPNO        ");
					sql.append("\n").append( "	    ORDER BY SUBSTR(B.PAYDT,1,6)                 ");
					sql.append("\n").append( "   ) X                                                                              ");
					sql.append("\n").append( " LEFT JOIN PAYROLL.HIPERSON A ON A.EMPNO=X.EMPNO                                                                       ");
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCDEPT C ON X.DEPTCD=C.DEPTCD                                                                       ");
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE D ON X.PAYGRD = D.MINORCD AND D.MAJORCD = '2002'                                            "); /*����*/       
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE F ON X.JOBGRPH = F.MINORCD AND F.MAJORCD = '2000'                                           ");	 /*����*/      
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE G ON X.PAYSEQ = G.MINORCD AND G.MAJORCD = '1184'                                            ");	/*ȣ��*/       
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE H ON X.GRDDIV = H.MINORCD AND H.MAJORCD = '2001'                                            ");	/*����*/       
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE I ON C.GROUPID = I.MINORCD AND I.MAJORCD = '2051'                                           ");	 /*�ٹ���*/    
					sql.append("\n").append( " LEFT OUTER JOIN PAYROLL.PWRONPAY L ON  X.EMPNO = L.EMPNO  ");
														  													   
				
					sql.append("\n").append( " ORDER BY I.SEQ, D.SEQ,PAYDTYMD ASC, PAYSEQNM DESC, A.EMPNO "); /*���ޱ���*/

					logger.dbg.println(this,sql.toString());
					
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