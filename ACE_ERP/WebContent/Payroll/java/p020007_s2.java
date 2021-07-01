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
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"EMPNO",	   /* ��� */
				"EMPNMK",       /*�ѱ۸�*/
				"PAYDIVNM",	/* ���ޱ���*/
				"DEPTCD",	/*  �μ��ڵ�*/
				"DEPTNM",	/*  �μ���*/
				"PAYDT",  /*  ������*/

				"P10000",	/*  �⺻�޿�*/
				"P11000",	/* ��å���� */
				"P12000",	/* �ð��ܼ���*/
				"B11000",	/*  �ǰ������*/
				"B12000",	/*  ���ο���*/

				"B13000",	/*  ���뺸��*/
				"T11000",	/*  �ҵ漼 OR ���ټ�*/
				"T12000",	/*  �ֹμ�*/
				"S93000",	/*  �����հ�*/	
				"S94000"	/*  �����ݾ�*/	

				};

				int[] intArrCN = new int[]{  
					7, 	
					20,
					30,	
					4,	
					50,	
					8,/*������*/	

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
					sql.append( "  A.EMPNO, ");	   /* ��� */
					sql.append( "  A.EMPNMK, ");       /*�ѱ۸�*/
					sql.append( "  D.MINORNM AS PAYDIVNM, ");       /*���ޱ���*/
					sql.append( "  B.DEPTCD, ");	       /* �μ��ڵ� */
					sql.append( "  C.DEPTNM AS DEPTNM, ");	/* �μ���*/
					sql.append( "  B.PAYDT, ");	/*  ������*/
					sql.append( "  B.P10000, ");	/*  �⺻�޿�*/
					sql.append( "  B.P11000, ");	/*  ��å����*/
					sql.append( "  B.P12000, ");	/*  �ð��ܼ���*/

					sql.append( "  B.B11000, ");	/*  �ǰ������*/
					sql.append( "  B.B12000, ");	/*  ���ο���*/
					sql.append( "  B.B13000, ");	/*  ���뺸��*/
					sql.append( "  B.T11000, ");	/*  �ҵ漼 OR ���ټ�*/
					sql.append( "  B.T12000, ");	/*  �ֹμ�*/
					sql.append( "  B.S93000,  ");	/*  �����հ�*/	
					sql.append( "  B.S94000  ");	/*  �����޾�*/	
					sql.append( " from PAYROLL.HIPERSON A, PAYROLL.PBPAY B,PAYROLL.HCDEPT C,PAYROLL.HCLCODE D  ");
					 sql.append( " WHERE A.EMPNO=B.EMPNO ");
					 sql.append( " AND B.DEPTCD=C.DEPTCD ");


					sql.append( "        AND B.PAYDIV = D.MINORCD ");
					sql.append( "        AND D.MAJORCD = '1120' "); /*���ޱ���*/
					
					if (!str[0].equals("")&&!str[0].equals("0") && (!str[1].equals("")&&!str[1].equals("0")) )
						sql.append( " AND SUBSTR(B.PAYDT,1,6) BETWEEN '"  + str[0] + "' AND '"  + str[1] + "' ");    //�������ں��ͱ���
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND B.PAYDIV= '"  + str[2] + "' ");   //���ޱ���
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND B.DEPTCD = '" + str[3]+ "' ");    //�μ��ڵ�
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '"  + str[4] + "' ");  //����
												  													   
					if (!str[5].equals("")&&!str[5].equals("0")) sql.append( " AND B.PAYGRD= '"  + str[5] + "' "); //����
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.GRDDIV = '" + str[6]+ "' "); // ����
					sql.append( "  ORDER BY B.DEPTCD,SUBSTR(B.PAYDT,1,6),B.EMPNO "); /*���ޱ���*/
					//logger.err.println(this,sql.toString());
/*********************************************************************************************/

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