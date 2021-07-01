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
public class p020007_s6 extends HttpServlet {

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
	���� �������� �����Ͻ� �κ�-�μ����޿�������Ȳ �󼼺���
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String [] str = new String [8];
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
					"TREECD", // ����ڵ�   
					"DEPTNM", // �Ҽ�   
					"DEPTNM2", // �μ�*/     
					"SCOUNT", // �ο� */    
					"S94000SUM", // �ݾ� */  
					"PERRATE" // �ۼ�Ʈ*/   
				};

				int[] intArrCN = new int[]{  
					4, // ����ڵ�   
					50, // �Ҽ�   
					50, // �μ�*/     
					9, // �ο� */    
					10, // �ݾ� */  
					8 // �ۼ�Ʈ*/   
      
            	}; 

				int[] intArrCN2 = new int[]{
					-1, // ����ڵ�   
					-1, // �Ҽ�   
					-1, // �μ�*/     
					0, // �ο� */    
					0, // �ݾ� */  
					6 // �ۼ�Ʈ*/   
       
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
sql.append(" SELECT                                                                                                                     \n ");
sql.append("      SUBSTR(X.TREECD,1,4) AS TREECD,                                                                                                             \n ");
sql.append("      RTRIM(Z.DEPTNM) AS DEPTNM,                                                                                                             \n ");
sql.append("       RTRIM(X.DEPTNM) AS DEPTNM2,                                                                                         ");  
sql.append("       COALESCE(COUNT(B.DEPTCD),0) AS SCOUNT,                                                                               \n ");
sql.append("       COALESCE(SUM(B.S94000),0) AS S94000SUM,                                                                              \n ");
sql.append("       COALESCE((DOUBLE(SUM(B.S94000))/ DOUBLE(D.TOTALSUM) * 100),0) AS PERRATE                                                \n ");
sql.append(" FROM                                                                                                                       \n ");
sql.append("		  (                                                                                                                     \n ");
sql.append("		   SELECT DISTINCT TREECD, DEPTCD,TRIM(DEPTNM) AS DEPTNM FROM PAYROLL.HCDEPT  ORDER BY TREECD                                           \n ");
sql.append("		   ) X                                                                                                                  \n ");
sql.append("		  LEFT JOIN (                                                                                                           \n ");
sql.append("		   SELECT DISTINCT TREECD, DEPTCD, DEPTNM FROM PAYROLL.HCDEPT WHERE SUBSTR(TREECD,5,4)='0000' ORDER BY TREECD           \n ");
sql.append("		   )Z ON SUBSTR(X.TREECD,1,4)=SUBSTR(Z.TREECD,1,4) AND SUBSTR(X.TREECD,5,4)='0000'                                      \n ");
sql.append("		   LEFT JOIN PAYROLL.PBPAY B ON X.DEPTCD= B.DEPTCD                                               \n ");
if (!str[1].equals("")&&!str[1].equals("0")) 
	sql.append("		                          AND B.APPDT = '"+ str[1] +"'                                             \n");

if (!str[2].equals("")&&!str[2].equals("0")) 
sql.append("		                          AND B.PBDIV = '"+ str[2] +"'                                               \n ");

if (!str[3].equals("")&&!str[3].equals("0")) 
sql.append("		                          AND B.DEPTCD = '"+ str[3] +"'                                               \n ");

if (!str[4].equals("")&&!str[4].equals("0")) 
sql.append("		                          AND B.JOBGRPH = '"+ str[4] +"'                                               \n ");
if (!str[5].equals("")&&!str[5].equals("0")) 
sql.append("		                          AND B.PAYGRD = '"+ str[5] +"'                                               \n ");
if (!str[6].equals("")&&!str[6].equals("0")) 
sql.append("		                          AND B.GRDDIV = '"+ str[6] +"'                                               \n ");

sql.append("		 LEFT JOIN (                                                                                                            \n ");
sql.append("		   SELECT B.APPDT,COALESCE(SUM(B.S94000),0) AS TOTALSUM, COALESCE(COUNT(B.EMPNO),0) AS TOTALCOUNT FROM PAYROLL.PBPAY B  \n ");
sql.append("		   WHERE B.APPDT <> ' ' \n ");

if (!str[1].equals("")&&!str[1].equals("0")) 
sql.append("		   AND B.APPDT = '"+ str[1] +"'                                              \n ");
sql.append("		   GROUP BY B.APPDT                                                          \n ");
sql.append("		   ) D ON B.APPDT=D.APPDT                                                                               \n ");
sql.append(" GROUP BY X.TREECD,X.DEPTNM,Z.DEPTNM,D.TOTALSUM, D.TOTALCOUNT                                                               \n ");
sql.append(" ORDER BY X.TREECD,D.TOTALSUM,D.TOTALCOUNT                                                                                  \n ");

					//logger.err.println(this,sql.toString());
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