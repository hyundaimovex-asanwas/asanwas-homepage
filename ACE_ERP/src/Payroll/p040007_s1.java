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
				str[3]	= req.getParameter("v_str4");		//����

				for (int s=0;s<=3;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
					"EMPNMK","APPDT","STRTDT",
					"BASAMT1","BASAMT2","BASAMT3","BASAMT","BASAVG",
					"BUSAMT","BUSAVG","BAEAMT1","BAEAMT2","BAEAMT3","BAEAMT",
					"BAEAVG","YEAPAY","YEAAVG","AVGTOT","DUYEAR",
					"DUYMM","PRGAMT","ENDJAMT","PRGJAMT","PRGADD",
					"PRGTOT","EMPNO","DEPTPRNM","DEPTNM","PAYGNM",
					"RESINO","GRSTRTDT"
				};

				int[] intArrCN = new int[]{  
					  20,  6,  8, 	
						9,  9,  9,  9,  9,
						9,  9,  9,  9,  9, 9,
						9,  9,  9,  9,  2,
						2,  9,  9,  9,  9,
						9,  7, 30, 30, 30, 
					 13,	8
        }; 

				int[] intArrCN2 = new int[]{
					-1, -1, -1,   
					 0,  0,  0,  0,  0,
					 0,  0,  0,  0,  0, 0,
					 0,  0,  0,  0,  0,
					 0,  0,  0,  0,  0,
					 0, -1, -1, -1, -1,
					-1, -1
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
					sql.append( "  A.EMPNMK,										\n");	/*�ѱ۸�*/
					sql.append( "  B.APPDT,											\n");	/*���*/
					sql.append( "  B.STRTDT,										\n");	/*�Ի���*/		
					sql.append( "  B.BASAMT1,										\n");	/*�⺻��å1*/               		
					sql.append( "  B.BASAMT2,										\n");	/*�⺻��å2*/               		
					sql.append( "  B.BASAMT3,										\n");	/*�⺻��å3*/               		
					sql.append( "  B.BASAMT,										\n");	/*�޿��հ�(�޿���)*/        		
					sql.append( "  B.BASAVG,										\n");	/*��ձ޿�*/                		
					sql.append( "  B.BUSAMT,										\n");	/*���Ѿ�*/ 
					sql.append( "  B.BUSAVG,										\n");	/*��ջ�*/
					sql.append( "  B.BAEAMT1,										\n");	/*��Ÿ����1*/               	
					sql.append( "  B.BAEAMT2,										\n");	/*��Ÿ����2*/               		
					sql.append( "  B.BAEAMT3,										\n");	/*��Ÿ����3*/               	
					sql.append( "  B.BAEAMT,										\n");	/*�����հ�(�����)*/        	
					sql.append( "  B.BAEAVG,										\n");	/*��ռ���(�����/91*30)*/  		
					sql.append( "  B.YEAPAY,										\n");	/*��������*/                		
					sql.append( "  B.YEAAVG,										\n");	/*��ճ���*/                		
					sql.append( "  B.AVGTOT,										\n");	/*����հ�*/                		
					sql.append( "  B.DUYEAR,										\n");	/*�ٹ����*/                		
					sql.append( "  B.DUYMM,											\n");	/*�ٹ�����*/                		
					sql.append( "  B.PRGAMT,										\n");	/*�����ݾ�*/                		
					sql.append( "  B.ENDJAMT,										\n");	/*���⼳��*/                		
					sql.append( "  B.PRGJAMT,										\n");	/*�����������(����(���))*/		
					sql.append( "  B.PRGADD,										\n");	/*�߰�������*/              	
					sql.append( "  B.PRGTOT,										\n");	/*���ݿ����ܾ�*/          		
					sql.append( "  B.EMPNO,											\n");	/*���*/                    	
					sql.append( "  RTRIM(E.MINORNM) DEPTPRNM,		\n");	/*�ٹ���*/                  
					sql.append( "  RTRIM(C.DEPTNM) DEPTNM,			\n");	/*�μ�(�Ҽ�)*/              
					sql.append( "  RTRIM(D.MINORNM) PAYGNM,			\n");	/*����*/                    
					sql.append( "  A.RESINO,										\n");	/*�ֹι�ȣ*/                
					sql.append( "  A.GRSTRTDT										\n");	/*�׷��Ի���*/              
					sql.append( "  FROM  PAYROLL.PRDEVPAY B			\n");	/*��������*/ 
					sql.append( "  LEFT OUTER JOIN PAYROLL.HIPERSON A ON A.EMPNO = B.EMPNO\n");
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCDEPT   C ON A.DEPTCD = C.DEPTCD \n");;
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCLCODE  D ON D.MINORCD=A.PAYGRD AND D.MAJORCD='2002' \n");	/*�����ڵ�*/
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCLCODE  E ON E.MINORCD=C.DEPTPRT AND E.MAJORCD='1111' \n");	/*�ٹ���*/
					sql.append( "  WHERE RTRIM(B.EMPNO) <> '' \n");
					sql.append( "    AND B.DEPTCD <> 'A400'   \n");  //��������
					sql.append( "    AND ( B.ENDDT='' OR B.ENDDT IS NULL OR SUBSTR(B.ENDDT,1,6) > '" + str[0] + "' )\n");  //���������
				  sql.append( "    AND B.USESTS IN ( '1','2')   \n");  //������ �� ������

					if (!str[0].equals("")&&!str[0].equals("0") )sql.append( " AND SUBSTRING(B.APPDT,1,6) = '" + str[0] + "' \n"); //���س��						
					if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND A.DEPTCD ='" + str[1]+ "' \n");				//�μ�
					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND A.PAYGRD ='" + str[2]+ "' \n");				//����
					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND A.EMPNMK LIKE '" + str[3]+ "%' \n");		//����

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