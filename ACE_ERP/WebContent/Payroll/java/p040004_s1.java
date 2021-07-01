package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.
public class p040004_s1 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//������ں���
				str[1]	= req.getParameter("v_str2");		//������ڱ���
				str[2]	= req.getParameter("v_str3");		//����





				for (int s=0;s<3;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"EMPNO",	   /* ��� */
				"EMPNMK",       /*�ѱ۸�*/
				//"NOTWRK",       /*���������ϼ�*/
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
				//"DUYNOT",	/*  �������ϼ�*/
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
				"P33000",	/*  ��������*/
				"P36000",	/*  �к�����*/
				"P37000",	/*  ���ο��ݺ�����*/
				"P38000",	/*  �ӿ���å����*/
				"PX0010",	/*  ��Ÿ����1*/
				"PX0020",	/*  ��Ÿ����2*/
				"PX0030",	/*  ��Ÿ����3*/
				"PX0040",	/*  ��Ÿ����4*/
				//"S91000",	/*  �����հ�*/
				//"T11000",	/*  �ҵ漼 OR ���ټ�*/
				//"T12000",	/*  �ֹμ�*/
				//"B11000",	/*  �ǰ������*/
				//"B12000",	/*  ���ο���*/
				//"B13000",	/*  ���뺸��*/
				//"B15000",	/*  ���ο���*/
				//"B14000",	/*  ������ȸ��*/
				//"B16000",	/*  ����ȸ��*/
				//"BX0010",	/*  ��Ÿ����1*/		
				//"BX0020",	/*  ��Ÿ����2*/		
				//"BX0030",	/*  ��Ÿ����3*/		
				//"BX0040",	/*  ��Ÿ����4*/
				//"S93000",	/*  �����հ�*/	
				//"S94000",	/*  �������޾�*/	
				"STRTDT",	/*  �Ի���*/	
				"JOBGRPHNM",	/*  ����*/	
				"ENDDT",	/*  �����*/	
				"RESINO",	/*  �ֹι�ȣ*/	
				"DUYEAR",	/*  �ٹ��Ⱓ*/	
				"DUYMM",	/*  �ٹ��Ⱓ*/	
				"DUDAY",	/*  �ٹ��Ⱓ*/	
				"T21000",	/*  �Ѽҵ�*/	
				"CZIPCD",	/*  ������ȣ*/	
				"CADDR",	 /*  �ּ�*/	
				"MONAVG", /*  ��ձ޿� OR ����ӱ�*/	
				"MONBUS",/*  ��ջ󿩱�*/	
				"MONCOM",/*  ���������*/	
				"RETPAY", /*  ������*/	
				"YEAPAY" /*  ���������*/	

				};

				int[] intArrCN = new int[]{  
					7, 	
					20,
					//2, 
					6,	
					4,	
					4,	
					50,	
					30,	
					30,	
					30,	
					30,	
					25,	
					//8,	
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
                    /*
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
                    */
					8,
					30,
					8,
					13,
					2,
					2,
					2,
					9,
					6,
					140,

					10,
					10,
					10,
					10,
					10
            	}; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					//0,
					-1,   
					-1,
					-1,   
					-1,
					-1,   
					-1,
					-1,
					-1,   
					-1,
					//-1,   
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
					/*
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
					*/
					-1,
					-1,
					-1,
					-1,
					0,
					0,
					0,
					0,
				    -1,
					-1,
					0,
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
					sql.append( "  SELECT  ");
					sql.append( "  B.EMPNO, ");	   /* ��� */
					sql.append( "  A.EMPNMK, ");       /*�ѱ۸�*/
					//sql.append( "  B.NOTWRK, ");       /*�������� OR ��������*/
					sql.append( "  B.APPYM AS APPDT, ");	       /* ��� */
					sql.append( "  A.PAYDIV, ");	/* �޿�����*/
					sql.append( "  A.DEPTCD, ");	/*  �μ��ڵ�*/
					sql.append( "  C.DEPTNM AS DEPTNM, ");	/*  �μ���*/
					sql.append( "  E.MINORNM AS PAYGRDNM, ");	/* �����ڵ�*/
					sql.append( "  F.MINORNM AS GRDDIVNM, ");	/*����*/
					sql.append( "  G.MINORNM AS PAYSEQNM, ");	/* ȣ���ڵ� */
					sql.append( "  H.MINORNM AS PAYBNKNM, ");	/*  �����ڵ�*/
					sql.append( "  I.BNKNO AS PAYNUM, ");	/*  ���¹�ȣ*/
					sql.append( "  B.PAYDT, ");  /*  ������*/
					//sql.append( "  B.DUYNOT, ");	/*  �������ϼ�*/
					sql.append( "  B.P10000, ");	/*  �⺻�޿�*/
					sql.append( "  B.P11000, ");	/* ��å���� */
					sql.append( "  B.P12000, ");	/* �ð��ܼ��� */
					sql.append( "  B.P21000, ");	/*  �ټӼ���*/
					sql.append( "  B.P22000, ");	/*  �ڱ��ߺ� */
					sql.append( "  B.P23000, ");	/*  �ξ簡������*/
					sql.append( "  B.P24000, ");	/*  ���������� */
					sql.append( "  B.P25000, ");	/*  �ⳳ����*/
					sql.append( "  B.P26000, ");	/*  ��������*/
					sql.append( "  B.P27000, ");	/*  �������*/
					sql.append( "  B.P28000, ");	/*  �ڰݼ���*/
					sql.append( "  B.P29000, ");	/*  ���ϰ�������*/
					sql.append( "  B.P30000, ");	/*  ����ܼ���*/
					sql.append( "  B.P31000, ");	/*  Ư��������*/
					sql.append( "  B.P32000, ");	/*  �����ٹ�����*/
					sql.append( "  B.P33000, ");	/*  ��������*/
					sql.append( "  B.P36000, ");	/*  �к�����*/
					sql.append( "  COALESCE(B.P37000,0) AS P37000, ");	/*  ���ο��ݺ�����*/
					sql.append( "  B.P38000, ");	/*  �ӿ���å����*/
					sql.append( "  B.PX0010, ");	/*  ��Ÿ����1*/
					sql.append( "  B.PX0020, ");	/*  ��Ÿ����2*/
					sql.append( "  B.PX0030, ");	/*  ��Ÿ����3*/
					sql.append( "  B.PX0040, ");	/*  ��Ÿ����4*/
					//sql.append( "  B.S91000, ");	/*  �����հ�*/
					//sql.append( "  B.T11000, ");	/*  �ҵ漼 OR ���ټ�*/
					//sql.append( "  B.T12000, ");	/*  �ֹμ�*/
					//sql.append( "  B.B11000, ");	/*  �ǰ������*/
					//sql.append( "  B.B12000, ");	/*  ���ο���*/
					//sql.append( "  B.B13000, ");	/*  ���뺸��*/
					//sql.append( "  B.B15000, ");	/*  ���ο���*/
					//sql.append( "  B.B14000, ");	/*  ������ȸ��*/
					//sql.append( "  B.B16000, ");	/*  ����ȸ��*/
					//sql.append( "  B.BX0010, ");	/*  ��Ÿ����1*/		
					//sql.append( "  B.BX0020, ");	/*  ��Ÿ����2*/		
					//sql.append( "  B.BX0030, ");	/*  ��Ÿ����3*/		
					//sql.append( "  B.BX0040, ");	/*  ��Ÿ����4*/
					//sql.append( "  B.S93000,  ");	/*  �����հ�*/	
					//sql.append( "  B.S94000,  ");	/*  �����޾�,����*/	
					sql.append( "  RTRIM(A.STRTDT) AS STRTDT,  ");	/*  �Ի���*/	
					sql.append( "  D.MINORNM AS JOBGRPHNM,  ");	/*  ����*/	
					sql.append( "  RTRIM(A.ENDDT) AS ENDDT,  ");	/*  �����*/	
					sql.append( "  RTRIM(A.RESINO) AS RESINO,  ");	/*  �ֹι�ȣ*/	
					sql.append( "  A.DUYEAR,  ");	/*  �ٹ������*/	
					sql.append( "  A.DUYMM,  ");	/*  �ٹ������*/	
					sql.append( "  A.DUDAY,  ");	/*  �ٹ������*/	
					sql.append( "  I.RETTAX AS T21000,  ");	/*  �Ѽҵ�*/	
					sql.append( "  A.CZIPCD,  ");	/*  ������ȣ*/	
					sql.append( "  (A.CADDR01 || A.CADDR02) AS CADDR, ");	/*  �ּ�*/	
					sql.append( "  I.MONAVG, ");	/*  ��ձ޿� OR ����ӱ�*/	
					sql.append( "  I.MONBUS, ");	/*  ��ջ󿩱�*/	
					sql.append( "  I.MONCOM, ");	/*  ��ճ�������*/	
					sql.append( "  I.RETPAY, ");	    /*  ������*/	
					sql.append( "  I.YEAPAY ");	    /*  ���������*/	

					sql.append( " from  PAYROLL.HIPERSON A"); 
					sql.append( " LEFT OUTER JOIN PAYROLL.PRAVGPAY B  ON  B.EMPNO = A.EMPNO AND B.APPYM=SUBSTR(A.ENDDT,1,6)  ");
					sql.append( " LEFT OUTER JOIN PAYROLL.PRPAY I ON  B.EMPNO = I.EMPNO   ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  A.DEPTCD = C.DEPTCD   ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE D ON  A.JOBGRPH = D.MINORCD  AND D.MAJORCD = '2000'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE E ON  A.PAYGRD = E.MINORCD  AND E.MAJORCD = '2002'   ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE F ON  A.GRDDIV = F.MINORCD  AND F.MAJORCD = '2001'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE G ON  A.PAYSEQ =  G.MINORCD  AND G.MAJORCD='1184'  ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE H ON  I.BNKCD = H.MINORCD  AND H.MAJORCD = '1411'  ");
					sql.append( " WHERE B.EMPNO <> ' ' and A.ENDDT <> ' ' \n ");



					
					
					if ( (!str[0].equals("")&&!str[0].equals("0")) && (!str[1].equals("")&&!str[1].equals("0")) )
						sql.append( " AND A.ENDDT BETWEEN  '"  + str[0] + "' AND  '"  + str[1] + "' ");    //�������
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND A.EMPNMK LIKE '" + str[2]+ "%' ");     //����
					logger.dbg.println(this,sql.toString());
/*********************************************************************************************/
                     // System.out.println(sql);
						//logger.err.println(this,"1");
					stmt = conn.getGauceStatement(sql.toString());

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