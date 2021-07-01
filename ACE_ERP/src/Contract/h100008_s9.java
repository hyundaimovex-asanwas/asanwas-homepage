package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.//�Ⱓ�����ҵ���Ȳ
public class h100008_s9 extends HttpServlet {

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
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{

				"DEPTNM",	/*  �μ���*/
				"TREECD",	/*  �μ���*/
				"EMPNO",	/*	���	*/
				"EMPNMK", /*	�ѱ۸�*/
				
				"PAYGRDNM",		/*  ������*/
				"JOBKINDNM",	/*  ������*/
				"JOBGRPHNM",	/*  ������*/	
				"PAYSEQNM",		/*  ȣ����*/
				"GRDDIVNM",		/*  ���޸�*/

				"P10000",	/* �⺻�޿�*/
				"P11000",	/* ��å���� */
				"P12000",	/* �ð��ܼ��� */
				"P21000",	/* �ټӼ���*/
				"P22000",	/* �ڱ��ߺ�*/
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
				"P35000",	/* �Ĵ뺸����*/
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
				"CHAGDT",  /* ���������� */
				"SENUM",    /* ��������� -�ξ簡������ -> 6��16�� �ٽú��� �����-�θ�-�ڳ�-�����-��ο�� */
				"P23002",   /* �����*/ 
				"P23003",	 /* �θ�*/    
				"P23004",	 /* �ڳ�*/    
				"P23005",	 /* ���*/    
				"P23006",	 /* ���*/ 
				"PR0020",
				"PR0030",
				"PR0040",
				"BR0020",
				"BR0030",
				"BR0040",
				"SEQ",
				"TIMAMT",	 /* �ñ�*/    
                "SANGRAT"

				};

				int[] intArrCN = new int[]{  
					30,	
					8, 	
					7, 	
					20,

					30,	/*  ������*/
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
					9,	/* �Ĵ뺸����*/
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
					8,  /* ���������� -������*/
					9,    /* ��������� -�ξ簡������ -> 6��16�� �ٽú��� �����-�θ�-�ڳ�-�����-��ο��*/
					2,	/* �����*/
					2,	/* �θ�*/  
					2,	/* �ڳ�*/  
					2,	/* ���*/  
					2,  /* ���*/ 
					20,	
					20,
					20,
					20,
					20,
					20,
					9,
				  2,   /* �ñ�*/  
				  3
             

            	}; 

				int[] intArrCN2 = new int[]{
					-1,
					-1,   
					-1,   
					-1,

					-1,	/*  ������*/
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
					0,	/* �Ĵ뺸����*/
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
					-1,    /* ��������� -�ξ簡������ -> 6��16�� �ٽú��� �����-�θ�-�ڳ�-�����-��ο��*/
					0,		/* �����*/ 
					0,		/* �θ�*/    
					0,		/* �ڳ�*/    
					0,		/* ���*/    
					0,		/* ���*/ 
				 -1,
				 -1,
				 -1,
				 -1,
				 -1,
				 -1,
					0,
					0, 		/* �ñ�*/  
					-1	
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
					sql.append("\n").append( "  RTRIM(C.DEPTNM) AS DEPTNM, " );	/* �μ���*/
					sql.append("\n").append( "  C.TREECD, " );	   /* Ʈ���õ� */
					sql.append("\n").append( "  A.EMPNO, " );	   /* ���     */
					sql.append("\n").append( "  A.EMPNMK, " );    /* �ѱ۸�   */

					sql.append("\n").append( "  RTRIM(D.MINORNM) AS PAYGRDNM, " );		/*  ������*/
					sql.append("\n").append( "  RTRIM(J.MINORNM) AS JOBKINDNM, " );	/*  ������*/
					sql.append("\n").append( "  RTRIM(F.MINORNM) AS JOBGRPHNM, " );	/*  ������*/	
					sql.append("\n").append( "  RTRIM(G.MINORNM) AS PAYSEQNM,  " );	/*  ȣ����*/
					sql.append("\n").append( "  RTRIM(H.MINORNM) AS GRDDIVNM,  " );	/*  ���޸�*/
					
					sql.append("\n").append( "  B.P10000, " );	/* �⺻�޿�*/
					sql.append("\n").append( "  B.P11000, " );	/* ��å���� */
					sql.append("\n").append( "  B.P12000, " );	/* �ð��ܼ��� */
					sql.append("\n").append( "  B.P21000, " );	/* �ټӼ���*/
					sql.append("\n").append( "  B.P22000, " );	/* �ڱ��ߺ� */
					sql.append("\n").append( "  B.P23001, " );	/* �ξ簡��*/
					sql.append("\n").append( "  B.P23000, " );	/* �ξ簡������*/
					sql.append("\n").append( "  B.P24000, " );	/* ���������� */
					sql.append("\n").append( "  B.P25000, " );	/* �ⳳ����*/
					sql.append("\n").append( "  B.P26000, " );	/* ��������*/
					sql.append("\n").append( "  B.P27000, " );	/* �������*/
					sql.append("\n").append( "  B.P28000, " );	/* �ڰݼ���*/
					sql.append("\n").append( "  B.P29000, " );	/* ���ϰ�������*/
					sql.append("\n").append( "  B.P30000, " );	/* ����ܼ���*/
					sql.append("\n").append( "  B.P31000, " );	/* Ư��������*/
					sql.append("\n").append( "  B.P32000, " );	/* �����ٹ�����*/
					sql.append("\n").append( "  B.P33001, " );	/* �����ϼ�  */
					sql.append("\n").append( "  B.P33000, " );	/* ��������*/
					sql.append("\n").append( "  B.P34001, " );	/* �����ϼ�*/
					sql.append("\n").append( "  B.P34000, " );	/* ��������*/
					sql.append("\n").append( "  B.P35000, " );	/* �ĺ�����*/
					sql.append("\n").append( "  B.P36000, " );	/* �к�����*/
					sql.append("\n").append( "  B.P37000, " );	/* ���ο��ݺ�����*/
					sql.append("\n").append( "  B.P38000, " );	/* �ӿ���å����*/
					sql.append("\n").append( "  B.P39000, " );	/* �����ұ�*/
					sql.append("\n").append( "  B.PX0010, " );	/* ��Ÿ����1*/
					sql.append("\n").append( "  B.PX0020, " );	/* ��Ÿ����2*/
					sql.append("\n").append( "  B.PX0030, " );	/* ��Ÿ����3*/
					sql.append("\n").append( "  B.PX0040, " );	/* ��Ÿ����4*/
					sql.append("\n").append( "  B.P41000, " );	/* ����ǰ�����*/
					sql.append("\n").append( "  B.P42000, " );	/* ������뺸��*/
					sql.append("\n").append( "  B.T21000, " );	/* ����ҵ漼*/
					sql.append("\n").append( "  B.T22000, " );	/* �����ֹμ�*/
					sql.append("\n").append( "  B.T23000, " );	/* �����Ư��*/
					sql.append("\n").append( "  B.S91000, " );	/* �����հ�*/
					sql.append("\n").append( "  B.S92000, " );	/* �ҵ��հ�*/
					sql.append("\n").append( "  B.T11000, " );	/* �ҵ漼*/
					sql.append("\n").append( "  B.T12000, " );	/* �ֹμ�*/
					sql.append("\n").append( "  B.B11000, " );	/* �ǰ������*/
					sql.append("\n").append( "  B.B12000, " );	/* ���ο���*/
					sql.append("\n").append( "  B.B13000, " );	/* ���뺸��*/
					sql.append("\n").append( "  B.B14000, " );	/* ������ȸ��*/
					sql.append("\n").append( "  B.B15000, " );	/* ���ο���*/
					sql.append("\n").append( "  B.B16000, " );	/* ����ȸ��*/
					sql.append("\n").append( "  B.BX0010, " );	/* ��Ÿ����1*/
					sql.append("\n").append( "  B.BX0020, " );	/* ��Ÿ����2*/
					sql.append("\n").append( "  B.BX0030, " );	/* ��Ÿ����3*/
					sql.append("\n").append( "  B.BX0040, " );	/* ��Ÿ����4*/
					sql.append("\n").append( "  --B.T31000, " );	/* ��¡�ҵ漼*/
					sql.append("\n").append( "  --B.T33000, " );	/* ��¡�ֹμ�*/
					sql.append("\n").append( "  --B.T92000, \n " );	/* ������ȯ��*/
					sql.append("\n").append( "  B.S93000, " );	/* �����հ�*/
					sql.append("\n").append( "  B.S94000, " );	/* �����޾�*/
					sql.append("\n").append( "  RTRIM(B.STRTDT) AS STRTDT, " ); /* �Ի��� */
					sql.append("\n").append( "  RTRIM(A.GRSTRTDT) AS GRSTRTDT,  " );	/* �׷��Ի���*/
					sql.append("\n").append( "  A.TRAINYN, " ); /* �������뿩�� */
					sql.append("\n").append( "  B.CHAGDT AS CHAGDT,  " );	/* ����������*/
					sql.append("\n").append( "  '0'  AS SENUM, " );	/* ��������*/
					sql.append("\n").append( "  B.P23002," );	/* �����*/
					sql.append("\n").append( "  B.P23003, " );	/* �θ�*/
					sql.append("\n").append( "  B.P23004," );	/* �ڳ�*/
					sql.append("\n").append( "  B.P23005, " );	/* ���*/
					sql.append("\n").append( "  B.P23006," );	/* ���*/	
					sql.append("\n").append( "  B.PR0020, " );	/* ��Ÿ����1*/
					sql.append("\n").append( "  B.PR0030, " );	/* ��Ÿ����2*/
					sql.append("\n").append( "  B.PR0040, " );	/* ��Ÿ����3*/
					sql.append("\n").append( "  B.BR0020, " );	/* ��Ÿ����1*/
					sql.append("\n").append( "  B.BR0030, " );	/* ��Ÿ����2*/
					sql.append("\n").append( "  B.BR0040, " );	/* ��Ÿ����3*/
					//sql.append("\n").append( "  I2.SEQ,    " );	/* ��¼���*/
					// 2008.08.18 ���ñٹ��� ������ ����...
          //sql.append(" CASE WHEN A.HSKSCR=2 THEN 99 ELSE I2.SEQ END SEQ,   ");	 /* ���*/
					//sql.append(" CASE WHEN A.JTGB IN (2,3,4,5,6) THEN 99 ELSE I2.SEQ END SEQ,   ");	 /* ���*/
          
					sql.append("  CASE WHEN B.JTGB = 2 THEN 95    ");	 
					sql.append("       WHEN B.JTGB = 3 THEN 96    ");	 
					sql.append("       WHEN B.JTGB = 4 THEN 97    ");	 
					sql.append("       WHEN B.JTGB = 5 THEN 98    ");	 
					sql.append("       WHEN B.JTGB = 6 THEN 99    ");	 
					sql.append("       ELSE I2.SEQ END SEQ,        ");	          
					sql.append("\n").append( "  COALESCE(I.TIMAMT,0) TIMAMT," );	/* �ñ�*/
					sql.append("\n").append( "  B.SANGRAT " );	/* ��Ÿ����3*/
					sql.append("\n").append( " FROM PAYROLL.PBPAY B" );
					sql.append("\n").append( " LEFT JOIN PAYROLL.T_HIPERSON A ON A.EMPNO=B.EMPNO" );
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD=C.DEPTCD" );
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE D ON B.PAYGRD  = D.MINORCD AND D.MAJORCD = '2002'" );		/*����*/
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE J ON A.JOBKIND = J.MINORCD AND J.MAJORCD = '2037'" );		/*����*/
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE F ON B.JOBGRPH = F.MINORCD AND F.MAJORCD = '2000'" );		/*����*/
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE G ON B.PAYSEQ  = G.MINORCD AND G.MAJORCD = '1184'" );		/*ȣ��*/
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE H ON B.GRDDIV  = H.MINORCD AND H.MAJORCD = '2001'" );		/*����*/
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE I2 ON C.GROUPID = I2.MINORCD AND I2.MAJORCD = '2051'" );		
					sql.append("\n").append( " LEFT JOIN PAYROLL.T_PCPAYTBL I ON SUBSTR(I.STDYM,1,6)=(SELECT MAX(STDYM) STDYM FROM PAYROLL.T_PCPAYTBL)" );		/*ȣ��*/
					sql.append("\n").append( "													AND B.GRDDIV=I.PAYGRD AND B.PAYSEQ=I.PAYSEQ					");		/*ȣ��MAX��*/
					sql.append("\n").append( " WHERE B.EMPNO <> ' '" );

					if (!str[0].equals("")&&!str[0].equals("0") )
						sql.append("\n").append( " AND B.PAYDT = '"  + str[0] + "'" );    //�������ں��ͱ���
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append("\n").append( " AND B.APPDT= '"  + str[1] + "'" );   //������
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append("\n").append( " AND B.PAYDIV = '" + str[2]+ "'" );   //���ޱ���
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append("\n").append( " AND B.DEPTCD = '" + str[3]+ "'" );   //�μ�
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append("\n").append( " AND B.JOBGRPH= '"  + str[3] + "'" ); //����
					if (!str[5].equals("")&&!str[5].equals("0") && (!str[6].equals("")&&!str[6].equals("0")) )
						sql.append("\n").append( " AND B.EMPNO BETWEEN '"  + str[5] + "' AND '"  + str[6] + "'" );              //�����ȣ���� ����
												  													   
					if (!str[7].equals("")&&!str[7].equals("0")) sql.append("\n").append( " AND A.EMPNMK LIKE '"  + str[7] + "%'" ); //����
					if (!str[8].equals("")&&!str[8].equals("0")) sql.append("\n").append( " AND B.PAYGRD = '" + str[8]+ "'" );  // ����
					if (!str[9].equals("")&&!str[9].equals("0")) sql.append("\n").append( " AND B.GRDDIV = '" + str[9]+ "'" );  // ����
					//sql.append("\n").append( "  ORDER BY C.TREECD,SUBSTR(B.PAYDT,1,6),B.EMPNO" ); /*���ޱ���*/
					//sql.append("\n").append( "  ORDER BY I2.SEQ, D.SEQ,   B.GRDDIV, CAST(b.payseq AS NUMERIC) DESC  , A.EMPNO" ); /*���ޱ���*/
					sql.append("\n").append( "  ORDER BY SEQ, D.SEQ,   B.GRDDIV, CAST(b.payseq AS NUMERIC) DESC  , A.EMPNO" ); /*���ޱ���*/

					//logger.dbg.println("",sql.toString());
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