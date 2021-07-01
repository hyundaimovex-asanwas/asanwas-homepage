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
public class p020006_s1 extends HttpServlet {

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
				str[2]	= req.getParameter("v_str3");		//���ޱ���
				str[3]	= req.getParameter("v_str4");		//�μ�
				str[4]	= req.getParameter("v_str5");		//����
				str[5]	= req.getParameter("v_str6");		//�����ȣ
				str[6]	= req.getParameter("v_str7");		//�����ȣ
				str[7]	= req.getParameter("v_str8");		//����
				str[8]	= req.getParameter("v_str9");		//����
				str[9]	= req.getParameter("v_str10");		//����
				str[10]	= req.getParameter("v_str11");		//level
				str[11]	= req.getParameter("v_str12");		//treecd

				for (int s=0;s<12;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{

				"DEPTNM",	 /* �μ���*/
				"EMPNO",	 /* ��� */
				"EMPNMK",  /* �ѱ۸�*/
				"PAYGRDNM",/* ������*/
				"S91000",	 /* �����հ�*/
				"S93000",	 /* �����հ�*/	
				"S94000",	 /* �����ݾ�(����)*/	
        "TREECD",	 /* �����ݾ�(����)*/	
				"SEQ"	 /* �����ݾ�(����)*/	
				};

				int[] intArrCN = new int[]{  
					30,	
					7, 	
					20,
					30,	
					9,
					9,
					9,
					8,
					3
          }; 

				int[] intArrCN2 = new int[]{
					-1,
					-1,   
					-1,
					-1,
					0,
					0,
					0,
					-1,
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

					sql.append( " SELECT   \n ");
					sql.append( " X.DEPTNM,  \n "); /* �μ���*/
					sql.append( " X.EMPNO,  \n ");     /* ��� */
					sql.append( " X.EMPNMK, \n ");  /*�ѱ۸�*/
					sql.append( " X.PAYGRDNM,  \n "); /* ������*/
					sql.append( " X.S91000,  \n "); /*  �����հ�*/    
					sql.append( " X.S93000,  \n "); /*  �����հ�*/	  
					sql.append( " X.S94000,  \n "); /*  �����޾�*/	  
          sql.append( " X.TREECD,  \n "); /*  �����޾�*/	  
          sql.append( " X.SEQ  \n ");     /*  �����޾�*/	  

					sql.append( " FROM  \n ");
					sql.append( "   (SELECT  MAX(RTRIM(C.DEPTNM)) AS DEPTNM,   B.EMPNO,    MAX(A.EMPNMK) EMPNMK,  MAX(RTRIM(D.MINORNM)) AS PAYGRDNM,   \n ");
					sql.append( "            SUM(B.S91000) S91000,  SUM(B.S93000) S93000, SUM(B.S94000) S94000,  \n ");
          //sql.append( "            C.TREECD, D.SEQ  \n ");
					sql.append( "            C.TREECD,  \n ");
					sql.append( "            CASE WHEN B.EMPNO ='2060002' THEN '10'   \n ");
					sql.append( "               	WHEN B.EMPNO ='2040060' THEN '20'   \n ");
					sql.append( "            	    WHEN B.EMPNO ='1990005' THEN '40'   \n ");
					sql.append( "            	    WHEN B.EMPNO ='2070031' THEN '41'   \n ");
					sql.append( "            ELSE D.SEQ END SEQ                       \n ");

					sql.append( "      FROM PAYROLL.HIPERSON A \n ");
					sql.append( "      LEFT JOIN PAYROLL.PBPAY B ON A.EMPNO=B.EMPNO  \n ");
					sql.append( "      LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD=C.DEPTCD  \n ");
					sql.append( "      LEFT JOIN PAYROLL.HCLCODE D ON B.PAYGRD = D.MINORCD AND D.MAJORCD = '2002' \n "); /*����*/
					sql.append( "     WHERE RTRIM(A.EMPNO) <> '' \n ");
					
					if (!str[0].equals("")&&!str[0].equals("0") )
						sql.append( " AND B.PAYDT = '"  + str[0] + "'  \n ");    /* �������ں��ͱ���*/
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND B.APPDT= '"  + str[1] + "'  \n ");   /* ������*/
					if (str[2].equals("1")) 
					sql.append( "   	AND B.PAYDIV IN ('1','3','4')             \n ");     /* ����+����+�ޱ�*/
					if (str[2].equals("5"))
					sql.append( "	    AND B.PAYDIV IN ('5')                 \n ");	
                    if (str[2].equals("6"))
					sql.append( "	    AND B.PAYDIV IN ('6')                 \n ");
					
					if (!str[4].equals("")&&!str[4].equals("0")) sql.append( " AND B.JOBGRPH= '"  + str[4] + "'  \n "); /* ����*/
					if (!str[5].equals("")&&!str[5].equals("0") && (!str[6].equals("")&&!str[6].equals("0")) )
						sql.append( " AND B.EMPNO BETWEEN '"  + str[5] + "' AND '"  + str[6] + "'  \n ");              /* �����ȣ���� ����*/
												  													   
					if (!str[7].equals("")&&!str[7].equals("0")) sql.append( " AND A.EMPNMK= '"  + str[7] + "'  \n "); /* ����*/
					if (!str[8].equals("")&&!str[8].equals("0")) sql.append( " AND B.PAYGRD = '" + str[8]+ "'  \n ");  /*  ����*/
					if (!str[9].equals("")&&!str[9].equals("0")) sql.append( " AND B.GRDDIV = '" + str[9]+ "'  \n ");  /*  ����*/

					if (str[10].equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[11] +"' \n ");
					if (str[10].equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[11] + "' \n ");
					if (str[10].equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6)= '" + str[11] +"' \n ");
					if (str[10].equals("4")) sql.append( " AND RTRIM(C.TREECD)= '" + str[11] + "' \n ");
					
					sql.append( "  GROUP BY B.EMPNO, SUBSTR(B.PAYDT,1,6),C.TREECD, D.SEQ) X  \n ");
				  sql.append( "  ORDER BY X.TREECD, X.SEQ, X.EMPNMK   \n "); /*���ޱ���*/

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