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
public class p020007_s3 extends HttpServlet {

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
	���� �������� �����Ͻ� �κ�-�μ����޿�������Ȳ��ȸ
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String [] str = new String [7];
				str[0]	= req.getParameter("v_str1");		//���޳��
				str[1]	= req.getParameter("v_str2");		//���޳������
				str[2]	= req.getParameter("v_str3");		//���ޱ���
				str[3]	= req.getParameter("v_str4");		//�μ�
				str[4]	= req.getParameter("v_str5");		//����
				str[5]	= req.getParameter("v_str6");		//����
				str[6]	= req.getParameter("v_str7");		//����

				for (int s=0;s<7;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"PAYDIVNM",	/* ���ޱ���*/
				"DEPTCD",	/*  �μ��ڵ�*/
				"DEPTNM",	/*  �μ���*/
				"PAYDT",  /*  ������*/

				"P10000",	/*  �⺻�޿�*/
				"P11000",	/* ��å���� */
				"P12000",	/* �ð��ܼ���*/
				"B11000",	/*  �ǰ������*/
				"B12000",	/*  ���ο���*/

				"B13000",	/*  ��뺸��*/
				"T11000",	/*  �ҵ漼 OR ���ټ�*/
				"T12000",	/*  �ֹμ�*/
				"S93000",	/*  �����հ�*/	
				"S94000"	/*  �����ݾ�*/	
				};

				int[] intArrCN = new int[]{  
					30,	
					4,	
					50,	
					8,

					9,
					9,
					9,
					9,
					9,

					9,
					9,
					9,
					9,
					9
          }; 

				int[] intArrCN2 = new int[]{
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
					sql.append( "  D.MINORNM AS PAYDIVNM, ");   /*���ޱ���*/
					sql.append( "  B.DEPTCD, ");								/* �μ��ڵ� */
					sql.append( "  C.DEPTNM AS DEPTNM, ");		  /* �μ���*/
					sql.append( "  SUBSTR(B.PAYDT,1,6) AS PAYDT, ");/*  ������*/
					sql.append( "  SUM(B.P10000) AS P10000, ");	/*  �⺻�޿�*/
					sql.append( "  SUM(B.P11000) AS P11000, ");	/*  ��å����*/
					sql.append( "  SUM(B.P12000) AS P12000, ");	/*  �ð��ܼ���*/
					//sql.append( "  ( SUM(COALESCE(B.P24000,0))+ SUM(COALESCE(B.P26000,0))) AS PBISUM , ");	/*  ���������� + �������� �����*/
					sql.append( "  SUM(B.B11000) AS B11000, ");	/*  �ǰ������*/
					sql.append( "  SUM(B.B12000) AS B12000, ");	/*  ���ο���*/
					sql.append( "  SUM(B.B13000) AS B13000, ");	/*  ��뺸��*/
					sql.append( "  SUM(B.T11000) AS T11000, ");	/*  �ҵ漼 OR ���ټ�*/
					sql.append( "  SUM(B.T12000) AS T12000, ");	/*  �ֹμ�*/
					sql.append( "  SUM(B.S93000) AS S93000,  ");	/*  ������*/	
					sql.append( "  SUM(B.S94000) AS S94000  ");	/*  ������*/	
					sql.append( " FROM PAYROLL.HIPERSON A, PAYROLL.PBPAY B,PAYROLL.HCDEPT C,PAYROLL.HCLCODE D  ");
					sql.append( " WHERE A.EMPNO=B.EMPNO ");
					sql.append( " AND B.DEPTCD=C.DEPTCD ");
					sql.append( " AND B.PAYDIV = D.MINORCD ");
					sql.append( " AND D.MAJORCD = '1120' "); /*���ޱ���*/
					
					if (!str[0].equals("")&&!str[0].equals("0") && (!str[1].equals("")&&!str[1].equals("0")) )
						sql.append( " AND SUBSTR(B.PAYDT,1,6) BETWEEN '"  + str[0] + "' AND '"  + str[1] + "' ");    //�������ں��ͱ���
				
          if (str[2].equals("1")) 
					sql.append( " AND B.PAYDIV IN ( '1','3','4') ");   //���ޱ���
					if (str[2].equals("5")) 
					sql.append( " AND B.PAYDIV IN ( '5') ");   //���ޱ���

					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3]+ "' ");    //�μ��ڵ�
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '"  + str[4] + "' ");  //����
												  													   
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[5] + "' "); //����
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV = '" + str[6]+ "' "); // ����
					sql.append( "  GROUP BY SUBSTR(B.PAYDT,1,6),B.DEPTCD, D.MINORNM,C.DEPTNM "); /*�׷����*/
					sql.append( "  ORDER BY B.DEPTCD,SUBSTR(B.PAYDT,1,6) "); /*����*/
					
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