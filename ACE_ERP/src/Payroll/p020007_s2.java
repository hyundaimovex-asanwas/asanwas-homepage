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
public class p020007_s2 extends HttpServlet {

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
	���� �������� �����Ͻ� �κ� - �޿�������Ȳ ��ȸ
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String [] str = new String [9];
				str[0]	= req.getParameter("v_str1");		//���޳��
				str[1]	= req.getParameter("v_str2");		//���޳������
				str[2]	= req.getParameter("v_str3");		//���ޱ���
				str[3]	= req.getParameter("v_str4");		//�μ�
				str[4]	= req.getParameter("v_str5");		//����
				str[5]	= req.getParameter("v_str6");		//����
				str[6]	= req.getParameter("v_str7");		//����
				str[7]	= req.getParameter("v_str8");		//level
				str[8]	= req.getParameter("v_str9");		//treecd

				for (int s=0;s<9;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"EMPNO",	   /* ��� */
				"EMPNMK",       /*�ѱ۸�*/
				"PAYDIVNM",	/* ���ޱ���*/
				"DEPTCD",	/*  �μ��ڵ�*/
				"DEPTNM",	/*  �μ���*/
				"PAYDT",  /*  ������*/
                "MINORNM",	/*����*/
				"TMINORNM",  /*�ٹ���*/
				

				"P10000",	/*  �⺻�޿�*/
				"P11000",	/* ��å���� */
				"P12000",	/* �ð��ܼ���*/
				"B11000",	/*  �ǰ������*/
				"B12000",	/*  ���ο���*/

				"B13000",	/*  ��뺸��*/
				"T11000",	/*  �ҵ漼 OR ���ټ�*/
				"T12000",	/*  �ֹμ�*/
				"S93000",	/*  �����հ�*/	
				"S94000",	/*  �����ݾ�*/	
				"MINORCD"       /*�����ڵ�*/
				};

				int[] intArrCN = new int[]{  
					7, 	
					20,
					30,	
					4,	
					50,	
					8,/*������*/	

                    30,
                    30,
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
					4
          }; 

				int[] intArrCN2 = new int[]{
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
					sql.append( "  A.EMPNO, ");								/* ��� */
					sql.append( "  A.EMPNMK, ");							/*�ѱ۸�*/
					sql.append( "  D.MINORNM AS PAYDIVNM, "); /*���ޱ���*/
					sql.append( "  B.DEPTCD, ");							/* �μ��ڵ� */
					sql.append( "  C.DEPTNM AS DEPTNM, ");		/* �μ���*/
					sql.append( "  E.MINORNM AS MINORNM, ");		/* ������*/
					sql.append( "  F.MINORNM AS TMINORNM, ");		/* �ٹ���*/
					sql.append( "  B.PAYDT, ");		/*  ������*/
					sql.append( "  B.P10000, ");	/*  �⺻�޿�*/
					sql.append( "  B.P11000, ");	/*  ��å����*/
					sql.append( "  B.P12000, ");	/*  �ð��ܼ���*/
					sql.append( "  B.B11000, ");	/*  �ǰ������*/
					sql.append( "  B.B12000, ");	/*  ���ο���*/
					sql.append( "  B.B13000, ");	/*  ��뺸��*/
					sql.append( "  B.T11000, ");	/*  �ҵ漼 OR ���ټ�*/
					sql.append( "  B.T12000, ");	/*  �ֹμ�*/
					sql.append( "  B.S93000,  ");	/*  �����հ�*/	
					sql.append( "  B.S94000,  ");	/*  �����޾�*/	
					sql.append( "  D.MINORCD ");       /*�����ڵ�*/
					sql.append( " from PAYROLL.HIPERSON A, PAYROLL.PBPAY B  ");
                    sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON  B.DEPTCD=C.DEPTCD ");
				    sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON  B.PAYDIV=D.MINORCD AND D.MAJORCD='1120' "); /*���ޱ���*/
					sql.append( " LEFT JOIN PAYROLL.HCLCODE E ON  B.PAYGRD=E.MINORCD AND E.MAJORCD='2002' "); /*����*/
                    sql.append( " LEFT JOIN PAYROLL.HCLCODE F ON  C.DEPTGB=F.MINORCD AND F.MAJORCD='2050' "); /*�ٹ���*/
					sql.append( " WHERE A.EMPNO=B.EMPNO ");
					//sql.append( " AND B.DEPTCD=C.DEPTCD ");
					//sql.append( " AND B.PAYDIV = D.MINORCD ");
					//sql.append( " AND D.MAJORCD = '1120' "); 
					
					if (!str[0].equals("")&&!str[0].equals("0") && (!str[1].equals("")&&!str[1].equals("0")) )
						sql.append( " AND SUBSTR(B.PAYDT,1,6) BETWEEN '"  + str[0] + "' AND '"  + str[1] + "' ");    //�������ں��ͱ���
					if (str[2].equals("1")) 
						sql.append( " AND B.PAYDIV IN('1','3','4') ");   //���ޱ���
					if (str[2].equals("5")) 
						sql.append( " AND B.PAYDIV IN('5') ");   //���ޱ���
                    if (str[2].equals("6")) 
						sql.append( " AND B.PAYDIV IN('6') ");   //���ޱ���

					//if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3]+ "' ");    //�μ��ڵ�
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '"  + str[4] + "' ");  //����
												  													   
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[5] + "' "); //����
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV = '" + str[6]+ "' "); // ����
/*
          if (str[7].equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[8] +"'");
					if (str[7].equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[8] + "'");
					if (str[7].equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6)= '" + str[8] +"'");
					if (str[7].equals("4")) sql.append( " AND RTRIM(C.TREECD)= '" + str[8] + "'");
*/
					if (str[7].equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,2)= '" + str[8] +"'  \n");
					if (str[7].equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,2)= '" + str[8] +"'  \n");
					if (str[7].equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[8] + "' \n");
					if (str[7].equals("4")) sql.append( " AND SUBSTR(C.TREECD,1,6)= '" + str[8] +"'  \n");
					if (str[7].equals("5")) sql.append( " AND RTRIM(C.TREECD)= '" + str[8] + "'      \n");


          sql.append( "  ORDER BY C.TREECD, E.SEQ "); /*���ޱ���*/
				//	sql.append( "  ORDER BY B.DEPTCD,SUBSTR(B.PAYDT,1,6),B.EMPNO, D.MINORCD "); /*���ޱ���*/
					
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