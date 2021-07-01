package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.//�Ⱓ�����ҵ���Ȳ
public class h100008_s1 extends HttpServlet {

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
				//	logger.dbg.println(this,"1234");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{

				"DEPTNM",	/*  �μ���*/
				"EMPNO",	   /* ��� */
				"EMPNMK",       /*�ѱ۸�*/
				"PAYGRDNM",	/* ������*/
				"JOBKINDNM",	/* ������*/
				"S91000",	/*  �����հ�*/
				"S93000",	/*  �����հ�*/	
				"S94000"	/*  �����ݾ�(����)*/	

				};

				int[] intArrCN = new int[]{  
					30,	
					7, 	
					20,
					30,	
					30,	
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
					sql.append("\n").append( "  RTRIM(C.DEPTNM) AS DEPTNM,			");	/* �μ���*/
					sql.append("\n").append( "  A.EMPNO,												");	/* ���  */
					sql.append("\n").append( "  A.EMPNMK,												"); /* �ѱ۸�*/
					sql.append("\n").append( "  RTRIM(D.MINORNM) AS PAYGRDNM,		");	/* ������*/
					sql.append("\n").append( "  RTRIM(E.MINORNM) AS JOBKINDNM,	");	/* ������*/
					sql.append("\n").append( "  B.S91000,												");	/*  �����հ�*/
					sql.append("\n").append( "  B.S93000,												");	/*  �����հ�*/	
					sql.append("\n").append( "  B.S94000												");	/*  �����޾�*/	
					sql.append("\n").append( " from PAYROLL.T_HIPERSON A  ");
					sql.append("\n").append( " LEFT JOIN PAYROLL.PBPAY B ON A.EMPNO=B.EMPNO ");
					sql.append("\n").append( " LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD=C.DEPTCD ");
			    sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE D ON B.PAYGRD  = D.MINORCD AND D.MAJORCD = '2002' ");/*����*/
			    sql.append("\n").append( " LEFT JOIN PAYROLL.HCLCODE E ON A.JOBKIND = E.MINORCD AND E.MAJORCD = '2037' ");/*����*/

					 sql.append("\n").append( " WHERE A.EMPNO <> '' ");
					
					if (!str[0].equals("")&&!str[0].equals("0") )
						sql.append("\n").append( " AND B.PAYDT = '"  + str[0] + "' ");    //�������ں��ͱ���
						//sql.append("\n").append( " AND B.PAYDT IN ('T') ");    //�������ں��ͱ���
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append("\n").append( " AND B.APPDT= '"  + str[1] + "' ");   //������
					//if (!str[2].equals("")&&!str[2].equals("0")) sql.append("\n").append( " AND B.PAYDIV = 'T' ");   //���ޱ���
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append("\n").append( " AND B.PAYDIV = '" + str[2]+ "' ");   //���ޱ���
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append("\n").append( " AND B.DEPTCD = '" + str[3]+ "' ");   //�μ�
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append("\n").append( " AND B.JOBGRPH= '"  + str[3] + "' "); //����
					if (!str[5].equals("")&&!str[5].equals("0") && (!str[6].equals("")&&!str[6].equals("0")) )
						sql.append("\n").append( " AND B.EMPNO BETWEEN '"  + str[5] + "' AND '"  + str[6] + "' ");              //�����ȣ���� ����
												  													   
					if (!str[7].equals("")&&!str[7].equals("0")) sql.append("\n").append( " AND A.EMPNMK LIKE '"  + str[7] + "%' "); //����
					if (!str[8].equals("")&&!str[8].equals("0")) sql.append("\n").append( " AND B.PAYGRD = '" + str[8]+ "' ");  // ����
					if (!str[9].equals("")&&!str[9].equals("0")) sql.append("\n").append( " AND B.GRDDIV = '" + str[9]+ "' ");  // ����
					//sql.append("\n").append( "  ORDER BY C.TREECD,SUBSTR(B.PAYDT,1,6),A.EMPNMK "); /*���ޱ���*/
					sql.append("\n").append( "   ORDER BY C.TREECD,SUBSTR(B.PAYDT,1,6), A.EMPNMK "); /*���ޱ���*/
			//		logger.dbg.println(this, sql.toString());
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