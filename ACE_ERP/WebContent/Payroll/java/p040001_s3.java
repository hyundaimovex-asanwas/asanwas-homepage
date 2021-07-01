/* ������ ��ȸ */
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
public class p040001_s3 extends HttpServlet {

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

				String [] str = new String [4];
				str[0]	= req.getParameter("v_str1"); ///���           
				str[1]	= req.getParameter("v_str2"); ///����������  -12 
				str[2]	= req.getParameter("v_str3"); ///����������  -15 
				str[3]	= req.getParameter("v_str4"); ///����������  -1 


											/* + "v_str1=" + str1 //���
											 + "v_str2=" + str2_12 //����������-12
											 + "v_str3=" + str2_15 //����������-15
											 + "v_str4=" + str2_1; //����������-1*/




				for (int s=0;s<4;s++) {
					if (str[s]==null) str[s] = "";
				}

			//	if (str1==null){str1="";}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"SANG_SUM",  "P34000"
					}; 

				int[] intArrCN = new int[]{ 9,  9
					                      }; 
			
				int[] intArrCN2 = new int[]{ 0, 0 }; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
				
sql.append(" SELECT COALESCE(A.SANG_SUM,0) AS SANG_SUM, COALESCE(B.P34000,0) AS P34000 FROM                                                                      \n");		
sql.append(" (                                                                                                    \n");		
sql.append("    SELECT EMPNO,SUM(P10000) AS SANG_SUM FROM PAYROLL.PBPAY WHERE APPDT <> ' '                        \n");  
if ( (!str[1].equals("")&&!str[1].equals("0")) && (!str[3].equals("")&&!str[3].equals("0")) )
	    sql.append("    AND APPDT BETWEEN '" + str[1] + "' AND '" + str[3] + "'                                   \n");

if ( !str[0].equals("")&&!str[0].equals("0") ) sql.append("    AND EMPNO='" + str[0] + "'                         \n");
sql.append("    GROUP BY EMPNO  --�󿩱� �հ�                                                                     \n");		
sql.append(" ) A                                                                                                  \n");		
sql.append(" LEFT OUTER JOIN(                                                                                     \n");		
sql.append("     SELECT EMPNO,P34000  FROM PAYROLL.PBPAY WHERE APPDT <> ' '                                       \n");
if ( (!str[2].equals("")&&!str[2].equals("0")) && (!str[3].equals("")&&!str[3].equals("0")) )
	sql.append("      AND APPDT BETWEEN '" + str[2] + "' AND '" + str[3] + "'                                     \n");	

if ( !str[0].equals("")&&!str[0].equals("0") ) sql.append("      AND EMPNO='" + str[0] + "'                        \n");     
sql.append("      AND P34000 <> 0 ORDER BY APPDT DESC --�ֱ� ����                                                 \n");		
sql.append(" ) B ON  A.EMPNO=B.EMPNO                                                                              \n");		



					
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