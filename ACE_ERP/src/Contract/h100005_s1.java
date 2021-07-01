package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class h100005_s1 extends HttpServlet {

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
				String [] str = new String [12];
				str[0]	= req.getParameter("v_str1");		//��������
				str[1]	= req.getParameter("v_str2");		//������
				str[2]	= req.getParameter("v_str6");		//���ޱ���
				str[3]	= req.getParameter("v_str3");		//�μ�
				str[4]	= "";//req.getParameter("v_str5");		//����
				str[5]	= req.getParameter("v_str4");		//�������
				//str[6]	= req.getParameter("v_str7");		//�������
				str[7]	= req.getParameter("v_str5");		//����
				str[8]	= "";// req.getParameter("v_str9");		//����
				str[9]	= "";//req.getParameter("v_str10");		//����
				str[10]	= req.getParameter("v_str7");		//Level
				str[11]	= req.getParameter("v_str8");		//treecd

				for (int s=0;s<12;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]	{

					"EMPNO",		/*	��� */
					"EMPNMK",		/*	�ѱ۸�*/
					"NOTWRK",		/*	���������ϼ�*/
					"APPDT",		/*	��� */
					"PAYDIV",		/*	�޿�����*/
					
					"DEPTCD",		/*  �μ��ڵ�*/
					"DEPTNM",		/*  �μ���*/
					"PAYGRDNM",	/*	�����ڵ�*/
					"GRDDIVNM",	/*	����*/
					"PAYSEQNM",	/*	ȣ���ڵ� */
					
					"PAYBNKNM",	/*  �����ڵ�*/
					"PAYNUM",		/*  ���¹�ȣ*/
					"PAYDT",		/*  ������*/
					"DUYNOT",		/*  �������ϼ�*/
					"P10000",		/*  �⺻�޿�*/
					
					"P11000",		/*	��å���� */
					"P12000",		/*	�ð��ܼ��� */
					"P21000",		/*  �ټӼ���*/
					"P22000",		/*  �ڱ��ߺ� */
					"P23000",		/*  �ξ簡������*/
					
					"P24000",		/*  ����� */
					"P25000",		/*  �ⳳ����*/
					"P26000",		/*  ��������*/
					"P27000",		/*  �������*/
					"P28000",		/*  �ڰݼ���*/
					
					"P29000",		/*  ���ϰ�������*/
					"P30000",		/*  �������*/
					"P31000",		/*  �����ٹ�����*/
					"P32000",		/*  �����ٹ�����*/
					"P36000",		/*  �к�����*/
					
					"P37000",		/*  ���ο��ݺ�����*/
					"P38000",		/*  �����޼���*/
					"PX0010",		/*  ��Ÿ����1*/
					"PX0020",		/*  ��Ÿ����2*/
					"PX0030",		/*  ��Ÿ����3*/
					
					"PX0040",		/*  ��Ÿ����4*/
					"S91000",		/*  �����հ�*/
					"T11000",		/*  �ҵ漼 OR ���ټ�*/
					"T12000",		/*  �ֹμ�*/
					"B11000",		/*  �ǰ������*/
					
					"B12000",		/*  ���ο���*/
					"B13000",		/*  ��뺸��*/
					"B15000",		/*  ���ο���*/
					"B14000",		/*  ������ȸ��*/
					"B16000",		/*  ����ȸ��*/
					
					"BX0010",		/*  ��Ÿ����1*/		
					"BX0020",		/*  ��Ÿ����2*/		
					"BX0030",		/*  ��Ÿ����3*/		
					"BX0040",		/*  ��Ÿ����4*/
					"S93000",		/*  �����հ�*/	
					
					"S94000",		/*  �������޾�*/	
					"JOBGRPHNM",/*  ����*/	
					"P34000",		/*  ��������*/	
					"P39000",		/*  �����ұ�*/		
					"P41000",		/*  ����ǰ�*/
					
					"P42000",		/*  ������*/	
					"T21000",		/*  ���ҵ�*/	
					"T22000",		/*  �����ֹ�*/	
					"STRTDT",		/*  �Ի�����*/	
					"ENDDT",		/*  �������*/	
					
					"P35000",		/*  �Ĵ뺸��*/
					"B17000",		/* ���纸�� */
					"P43000",		/* ���꿬�� */
					"BSDAY",   /*  ����ٹ��ϼ�*/
					"HJDAY",   /*  ����ٹ��ϼ�*/
					"NSDAY",   /*  ����ٹ��ϼ�*/
					"PR0020",  /*��Ÿ��������1*/   
					"PR0030",	 /*��Ÿ��������2 */  
					"PR0040",	 /*��Ÿ��������3 */  
					"BR0020",	 /*��Ÿ��������1*/   
					"BR0030",	 /*��Ÿ��������2 */  
					"BR0040", 	 /*��Ÿ��������3*/   
          "CHAGDT",	 /*��Ÿ��������2 */  
					"TRAINYN" 	 /*��Ÿ��������3*/  
			};

				int[] intArrCN = new int[]{  
					7, 	
					20,
					2, 
					6,	
					4,	
					
					4,	
					50,	
					30,	
					30,	
					30,	
					
					30,	
					25,	
					8,	
					2,
					9,
					
					9,
					9,
					9,
					9,
					9,
					
					9,
					9,
					9,
					9,
					9,
					
					9,
					9,
					9,
					9,
					9,
					
					9,
					9,
					9,
					9,
					9,
					
					9,
					9,
					9,
					9,
					9,
					
					9,
					9,
					9,
					9,
					9,
					
					9,
					9,
					9,
					9,
					9,
					
					9,
					30,
					9,
					9,
					9,
					
					9,
					9,
					9,
					8,
					8,
					
					9,
					9,
					9,
					
					2,   /*  ����ٹ��ϼ�*/
					2,   /*  ����ٹ��ϼ�*/
					2,   /*  ����ٹ��ϼ�*/
					20,   /*��Ÿ��������1 */   
					20,		/*��Ÿ��������2 */   
					20,		/*��Ÿ��������3 */   
					20,		/*��Ÿ��������1 */   
					20,		/*��Ÿ��������2 */   
					20,		/*��Ÿ��������3*/    
          8,		/*���������� */   
					1		/*����*/
        }; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					0,
					-1,   
					-1,
					-1,   
					-1,
					-1,   
					-1,
					-1,
					-1,   
					-1,
					-1,   
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					0,
					-1,
					0,
					0,
					0,
					0,
					0,
					0,
					-1,
					-1,
					0,
					0,
					0,
					0,	 /*  ����ٹ��ϼ�*/             
					0,	 /*  ����ٹ��ϼ�*/             
					0, 	 /*  ����ٹ��ϼ�*/ 
          -1,  /*��Ÿ��������1*/    
					-1,	 /*��Ÿ��������2*/    
          -1,	 /*��Ÿ��������3*/    
					-1,	 /*��Ÿ��������1*/    
					-1,	 /*��Ÿ��������2*/    
					-1,	 /*��Ÿ��������3 */  
          -1,	 /*����������*/    
					-1  /*���� */  
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
					sql.append( "  B.EMPNO, ");		/*	��� */
					sql.append( "  A.EMPNMK, ");	/*	�ѱ۸�*/
					sql.append( "  B.NOTWRK, ");	/*	�������� OR ��������*/
					sql.append( "  B.APPDT, ");		/*	��� */
					sql.append( "  B.PAYDIV, ");	/*	�޿�����*/
					sql.append( "  B.DEPTCD, ");	/*  �μ��ڵ�*/
					sql.append( "  COALESCE(RTRIM(C.DEPTNM),' ') AS DEPTNM, ");			/*  �μ���*/
					sql.append( "  COALESCE(RTRIM(E.MINORNM),' ') AS PAYGRDNM, ");	/*	�����ڵ�*/
					sql.append( "  COALESCE(RTRIM(F.MINORNM),' ') AS GRDDIVNM, ");	/*	����*/
					sql.append( "  COALESCE(RTRIM(G.MINORNM),' ') AS PAYSEQNM, ");	/*	ȣ���ڵ� */
					sql.append( "  COALESCE(RTRIM(H.MINORNM),' ') AS PAYBNKNM, ");	/*  �����ڵ�*/
					sql.append( "  COALESCE(B.PAYNUM,' ') PAYNUM, ");	/*  ���¹�ȣ*/
					sql.append( "  COALESCE(B.PAYDT,' ') PAYDT, ");		/*  ������*/
					sql.append( "  COALESCE(B.DUYNOT,0) DUYNOT, ");		/*  �������ϼ�*/
					sql.append( "  COALESCE(B.P10000,0) P10000, ");		/*  �⺻�޿�*/
					sql.append( "  COALESCE(B.P11000,0) P11000,");		/*  ��å���� */
					sql.append( "  COALESCE(B.P12000,0) P12000,");		/*  �ð��ܼ��� */
					sql.append( "  COALESCE(B.P21000,0) P21000,");		/*  �ټӼ���*/
					sql.append( "  COALESCE(B.P22000,0) P22000,");		/*  �ڱ��ߺ� */
					sql.append( "  COALESCE(B.P23000,0) P23000,");		/*  �ξ簡������*/
					sql.append( "  COALESCE(B.P24000,0) P24000,");		/*  ����� */
					sql.append( "  COALESCE(B.P25000,0) P25000,");		/*  �ⳳ����*/
					sql.append( "  COALESCE(B.P26000,0) P26000,");		/*  ��������*/
					sql.append( "  COALESCE(B.P27000,0) P27000,");		/*  �������*/
					sql.append( "  COALESCE(B.P28000,0) P28000,");		/*  �ڰݼ���*/
					sql.append( "  COALESCE(B.P29000,0) P29000,");		/*  ���ϰ�������*/
					sql.append( "  COALESCE(B.P30000,0) P30000,");		/*  �������*/
					sql.append( "  COALESCE(B.P31000,0) P31000,");		/*  �����ٹ�����*/
					sql.append( "  COALESCE(B.P32000,0) P32000,");		/*  �����ٹ�����*/
					sql.append( "  COALESCE(B.P36000,0) P36000,");		/*  �к�����*/
					sql.append( "	 COALESCE(B.P37000,0) AS P37000, ");/*  ���ο��ݺ�����*/
					sql.append( "  COALESCE(B.P38000,0) P38000,");		/*  �����޼���*/
					sql.append( "  COALESCE(B.PX0010,0) PX0010,");		/*  ��Ÿ����1*/
					sql.append( "  COALESCE(B.PX0020,0) PX0020,");		/*  ��Ÿ����2*/
					sql.append( "  COALESCE(B.PX0030,0) PX0030,");		/*  ��Ÿ����3*/
					sql.append( "  COALESCE(B.PX0040,0) PX0040,");		/*  ��Ÿ����4*/
					sql.append( "  COALESCE(B.S91000,0) S91000,");		/*  �����հ�*/
					sql.append( "  COALESCE(B.T11000,0) T11000,");		/*  �ҵ漼 OR ���ټ�*/
					sql.append( "  COALESCE(B.T12000,0) T12000,");		/*  �ֹμ�*/
					sql.append( "  COALESCE(B.B11000,0) B11000,");		/*  �ǰ������*/
					sql.append( "  COALESCE(B.B12000,0) B12000,");		/*  ���ο���*/
					sql.append( "  COALESCE(B.B13000,0) B13000,");		/*  ��뺸��*/
					sql.append( "  COALESCE(B.B15000,0) B15000,");		/*  ���ο���*/
					sql.append( "  COALESCE(B.B14000,0) B14000,");		/*  ������ȸ��*/
					sql.append( "  COALESCE(B.B16000,0) B16000,");		/*  ����ȸ��*/
					sql.append( "  COALESCE(B.BX0010,0) BX0010,");		/*  ��Ÿ����1*/		
					sql.append( "  COALESCE(B.BX0020,0) BX0020,");		/*  ��Ÿ����2*/		
					sql.append( "  COALESCE(B.BX0030,0) BX0030,");		/*  ��Ÿ����3*/		
					sql.append( "  COALESCE(B.BX0040,0) BX0040,");		/*  ��Ÿ����4*/
					sql.append( "  COALESCE(B.S93000,0) S93000,");		/*  �����հ�*/	
					sql.append( "  COALESCE(B.S94000,0) S94000,");		/*  �����޾�,����*/	
					sql.append( "  COALESCE(D.MINORNM,' ') AS JOBGRPHNM,");	/*  ����*/	
					sql.append( "  COALESCE(B.P34000,0) P34000,");		/*  ��������*/		
					sql.append( "  COALESCE(B.P39000,0) P39000,");		/*  ��Ÿ����2*/		
					sql.append( "  COALESCE(B.P41000,0) P41000,");		/*  ��Ÿ����3*/		
					sql.append( "  COALESCE(B.P42000,0) P42000,");		/*  ��Ÿ����4*/
					sql.append( "  COALESCE(B.T21000,0) T21000,");		/*  �����հ�*/	
					sql.append( "  COALESCE(B.T22000,0) T22000,");		/*  �����޾�,����*/	
					sql.append( "  COALESCE(A.STRTDT,' ') STRTDT,");	/*  �Ի�����*/	
					sql.append( "  COALESCE(A.ENDDT,' ')  ENDDT, ");	/*  ��������*/
					sql.append( "  COALESCE(B.P35000,	0) P35000, ");	/*  �Ĵ�    */ 
					sql.append( "  COALESCE(B.B17000,	0) B17000, ");	/*  ���纸��*/ 
					sql.append( "  COALESCE(B.P43000,	0) P43000, ");	/*  ���꿬��*/ 
					sql.append( "  B.BSDAY,   ");											/*����ٹ��ϼ�*/	
					sql.append( "  B.HJDAY,   ");											/*����ٹ��ϼ�*/	
					sql.append( "  B.NSDAY,   ");											/*����ٹ��ϼ�*/
					sql.append( "  B.PR0020,  ");											/*��Ÿ��������1*/
					sql.append( "  B.PR0030,  ");											/*��Ÿ��������2*/
					sql.append( "  B.PR0040,  ");											/*��Ÿ��������3*/
					sql.append( "  B.BR0020,  ");											/*��Ÿ��������1*/
					sql.append( "  B.BR0030,  ");											/*��Ÿ��������2*/
					sql.append( "  B.BR0040,  ");											/*��Ÿ��������3*/
					sql.append( "  B.CHAGDT,  ");											/*����������*/
					sql.append( "  B.TRAINYN  ");											/*����*/
					sql.append( " FROM PAYROLL.PBPAY B "); 
					sql.append( " LEFT OUTER JOIN PAYROLL.T_HIPERSON A ON  B.EMPNO  = A.EMPNO   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT	   C ON  A.DEPTCD = C.DEPTCD   ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE   D ON  B.JOBGRPH = D.MINORCD AND D.MAJORCD = '2000'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE   E ON  B.PAYGRD = E.MINORCD  AND E.MAJORCD = '2002'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE   F ON  B.GRDDIV = F.MINORCD  AND F.MAJORCD = '2001'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE   G ON  B.PAYSEQ = G.MINORCD  AND G.MAJORCD = '1184'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE   H ON  B.PAYBNK = H.MINORCD  AND H.MAJORCD = '1411'  ");
					sql.append( " WHERE RTRIM(B.EMPNO) <> '' ");
					sql.append( " AND A.EMPDIV='3' ");	//�Ի籸�� : �ѱ��α����[3]

					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND B.PAYDT= '"  + str[0] + "' ");    //��������
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND B.APPDT = '" + str[1]+ "' ");     //������
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND B.PAYDIV= '"  + str[2] + "' ");   //�޿�����
					//if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3]+ "' ");    //�μ��ڵ�
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '"  + str[4] + "' ");  //����
												  													   
					if (!str[5].equals("")&&!str[5].equals("0") )
						sql.append( " AND B.EMPNO =  '" + str[5]+ "' ");

					if (!str[7].equals("")&&!str[7].equals("0")) sql.append( " AND A.EMPNMK LIKE '" + str[7]+ "%' ");  //����
					if (!str[8].equals("")&&!str[8].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[8] + "' "); //����
					if (!str[9].equals("")&&!str[9].equals("0")) sql.append( " AND B.GRDDIV = '" + str[9]+ "' "); // ����

          if (str[10].equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[11] +"'");
					if (str[10].equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[11] + "'");
					if (str[10].equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6)= '" + str[11] +"'");
					if (str[10].equals("4")) sql.append( " AND RTRIM(C.TREECD)= '" + str[11] + "'");
        
					sql.append( " ORDER BY C.TREECD ASC,  A.EMPNMK ASC ");

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