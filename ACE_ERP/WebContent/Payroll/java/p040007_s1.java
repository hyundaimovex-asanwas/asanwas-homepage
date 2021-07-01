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
public class p040007_s1 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//���س��
				str[1]	= req.getParameter("v_str2");		//�μ�
				str[2]	= req.getParameter("v_str3");		//����
				str[3]	= req.getParameter("v_str3");		//����


				for (int s=0;s<4;s++) {
					if (str[s]==null) str[s] = "";
				}
				//	logger.err.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"EMPNO",	   /* ��� */
				"EMPNMK",       /*�ѱ۸�*/
				"DEPTNM",	       /* �μ� */
				"STRTDT",	/* �Ի���*/
				"PAYGRD",	/*  ����*/

				"DUTPER",	/*  �ٹ����*/
				"MONPAY",	/* ��ձ޿�*/
				"MONBUS",	/*��ջ�*/
				"MONHOL",	/* �������� */
				"YEAHOL",	/*  ��������*/

				"RETPAY"	/*  �����޿�*/

				};

				int[] intArrCN = new int[]{  
					7, 	
					20,
					30, 
					8,	
					30,
						
					4,	
					10,	
					10,
						
					10,	
					10,	

					10

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

					sql.append( "  C.DEPTNM AS DEPTNM, ");	/*  �μ���*/
					sql.append( "  A.STRTDT, ");       /*�Ի���*/
					sql.append( "  E.MINORNM AS PAYGRD, ");	/* �����ڵ�*/
					sql.append( "  B.DUTPER, ");  /*  �ٹ����*/
					sql.append( "  B.MONPAY, ");	/*  ��ձ޿�*/
					sql.append( "  B.MONBUS, ");	/* ��ջ� */
					sql.append( "  B.MONHOL, ");	/* �������� */
					sql.append( "  B.YEAHOL, ");	/*  ��������*/

					sql.append( "  B.RETPAY ");	/*  �����޿� */ 


					sql.append( " from  PAYROLL.HIPERSON A"); 
					sql.append( " LEFT OUTER JOIN PAYROLL.PRDEVPAY B  ON  B.EMPNO = A.EMPNO AND B.APPDT=SUBSTR(A.ENDDT,1,6)  ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT C ON  A.DEPTCD = C.DEPTCD   ");
					sql.append( " LEFT OUTER  JOIN PAYROLL.HCLCODE E ON  A.PAYGRD = E.MINORCD  AND E.MAJORCD = '2002'   ");
					sql.append( " WHERE B.EMPNO <> ' ' and A.ENDDT <> ' ' \n ");

					if ( !str[0].equals("")&&!str[0].equals("0") )sql.append( " AND SUBSTRING(B.APPDT,1,6) = '"  + str[0] + "' ");    //���س��
						
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( "  AND A.DEPTCD ='" + str[1]+ "' ");     //�μ�
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( "  AND A.GRDDIV ='" + str[2]+ "' ");     //����
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( "  AND A.EMPNMK LIKE '" + str[3]+ "%' ");     //����
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