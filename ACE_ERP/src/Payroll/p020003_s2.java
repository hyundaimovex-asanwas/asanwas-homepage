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
public class p020003_s2 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//������
				str[1]	= req.getParameter("v_str2");		//�����


				for (int s=0;s<12;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]	{
        "EMPNO","EMPNMK","PREPAYGRD","PAYGRD","ETC"     
			};	       
				int[] intArrCN = new int[]{  
					7, 20, 4, 4, 30
        }; 

				int[] intArrCN2 = new int[]{
					-1, -1, -1, -1, -1   
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

			
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT A.EMPNO, B.EMPNMK,                                       ");
					sql.append( "       D.PAYGRD AS PREPAYGRD,                                    ");	
					sql.append( "       A.PAYGRD,                                                 ");
					sql.append( "       '�ű��Ի�' AS ETC                                         ");	
					sql.append( "  FROM PAYROLL.PBPAY A                                           ");
					sql.append( "  LEFT JOIN PAYROLL.HIPERSON B ON B.EMPNO = A.EMPNO              ");	
					sql.append( "  LEFT JOIN ( SELECT C.EMPNO, C.PAYGRD                           ");
					sql.append( "                FROM PAYROLL.PBPAY C                             ");	
					sql.append( "               WHERE C.APPDT='" +str[0] +"' AND C.PAYDIV='1')D ON A.EMPNO = D.EMPNO     ");
					sql.append( " WHERE A.USESTS='1'                                              ");	
					sql.append( "   AND SUBSTR(A.APPDT,1,6) ='" +str[1] +"'                       ");
					sql.append( "   AND SUBSTR(A.STRTDT,1,6) = '" +str[1] +"'                     ");	
					sql.append( "                                                                 ");
					sql.append( "/*���*/                                                           ");	
          sql.append( " UNION ALL                                                        ");     
					sql.append( " SELECT A.EMPNO, A.EMPNMK, PAYGRD AS PREPAYGRD,'' PAYGRD,         ");	   
					sql.append( "       '���' AS ETC                                             ");     
					sql.append( "  FROM PAYROLL.HIPERSON A                                        ");	   
					sql.append( " WHERE A.USESTS='3'                                              ");     
					sql.append( "   AND SUBSTR(A.ENDDT,1,6) = '" +str[0] +"'                      ");     
					sql.append( "                                                                 ");	   
					sql.append( " UNION ALL                                                        ");     
					sql.append( "/*�μ�*/                                                           ");	   
					sql.append( " SELECT A.EMPNO, B.EMPNMK,                                        ");     
					sql.append( "       D.DEPTCD AS PREDEPTCD,                                    ");	   
					sql.append( "       A.DEPTCD,                                                 ");     
					sql.append( "       '�μ�����' AS ETC                                         ");	   
					sql.append( "  FROM PAYROLL.PBPAY A                                           ");     
					sql.append( "  LEFT JOIN PAYROLL.HIPERSON B ON B.EMPNO = A.EMPNO              ");	   
					sql.append( "  LEFT JOIN ( SELECT C.EMPNO, C.DEPTCD                           ");     
					sql.append( "                FROM PAYROLL.PBPAY C                             ");	   
					sql.append( "               WHERE C.APPDT='" +str[0] +"' AND C.PAYDIV='1')D ON A.EMPNO = D.EMPNO ");     
					sql.append( " WHERE A.USESTS='1'                                              ");	   
					sql.append( "   AND SUBSTR(A.APPDT,1,6) ='" +str[1] +"'                       ");     
					sql.append( "   AND A.DEPTCD <> D.DEPTCD                                      ");	   
					sql.append( "                                                                 ");     
					sql.append( " UNION ALL                                                        ");	   
					sql.append( "/*����*/                                                           ");     
					sql.append( " SELECT A.EMPNO, B.EMPNMK,                                        ");	 
					sql.append( "       D.PAYGRD AS PREPAYGRD,                                    ");     
					sql.append( "       A.PAYGRD,                                                 ");	  
					sql.append( "       '��������' AS ETC                                         ");  
					sql.append( "  FROM PAYROLL.PBPAY A                                           ");	
					sql.append( "  LEFT JOIN PAYROLL.HIPERSON B ON B.EMPNO = A.EMPNO              ");  
					sql.append( "  LEFT JOIN ( SELECT C.EMPNO, C.PAYGRD                           ");	
					sql.append( "                FROM PAYROLL.PBPAY C                             ");  
					sql.append( "               WHERE C.APPDT='" +str[0] +"' AND C.PAYDIV='1')D ON A.EMPNO = D.EMPNO     ");	
					sql.append( " WHERE A.USESTS='1'                                              ");  
					sql.append( "   AND SUBSTR(A.APPDT,1,6) ='" +str[1] +"'                             ");	
					sql.append( "   AND A.PAYGRD <> D.PAYGRD                                      ");  
					sql.append( "                                                                 ");	
					sql.append( "                                                                 ");	
					sql.append( " UNION ALL                                                        ");  
					sql.append( "/*ȣ��*/                                                           ");	
					sql.append( " SELECT A.EMPNO, B.EMPNMK,                                        ");  
					sql.append( "       D.PAYSEQ AS PREPAYSEQ,                                    ");	
					sql.append( "       A.PAYSEQ,                                                 ");  
					sql.append( "       'ȣ������' AS ETC                                         ");	
					sql.append( "  FROM PAYROLL.PBPAY A                                           ");  
					sql.append( "  LEFT JOIN PAYROLL.HIPERSON B ON B.EMPNO = A.EMPNO              ");	
					sql.append( "  LEFT JOIN ( SELECT C.EMPNO, C.PAYSEQ                           ");  
					sql.append( "                FROM PAYROLL.PBPAY C                             ");	
					sql.append( "               WHERE C.APPDT='" +str[0] +"' AND C.PAYDIV='1')D ON A.EMPNO = D.EMPNO     ");  
					sql.append( " WHERE A.USESTS='1'                                              ");	
					sql.append( "   AND SUBSTR(A.APPDT,1,6) ='" +str[1] +"'                             ");  
					sql.append( "   AND A.PAYSEQ <> D.PAYSEQ                                      ");	
				
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