/* H030003_popup.html �λ��ʿ��� �� �������� �θ� */
package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.
public class hA40001_pop_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");
				
				if (str1==null){str1="";}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"EMPNO",		"EMPNMK",		"DEPTCD",		"DEPTNM",			"PAYSEQ",  
					"PAYSEQNM", "STRTDT",		"ENDDT",		"GRSTRTDT",		"PAYGRD", 
					"PAYGNM",		"RESINO",		"DUYEAR",   "PAYDIV" 
				}; 

				int[] intArrCN = new int[]{ 7, 20, 4, 50, 4,
																		30, 8, 8,  8, 4,
																		30,13,2, 1
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, 
																		 -1, -1, -1, -1, -1,
																		 -1, -1,  0, -1 
				}; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
				
					sql.append( " SELECT DISTINCT ");
					sql.append( " RTRIM(A.EMPNO) EMPNO, RTRIM(A.EMPNMK) EMPNMK, A.DEPTCD, RTRIM(C.DEPTNM) DEPTNM, A.PAYSEQ, ");
					sql.append( " RTRIM(D.MINORNM) PAYSEQNM, A.STRTDT, A.ENDDT, A.GRSTRTDT, A.PAYGRD, E.MINORNM AS PAYGNM, ");
					sql.append( " A.RESINO,A.DUYEAR, F.PAYDIV ");
					sql.append( " FROM ");
					sql.append( " PAYROLL.T_HIPERSON A ");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD = C.DEPTCD "); //�μ�
					sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON A.PAYSEQ =D.MINORCD		AND D.MAJORCD = '1184'		"); //ȣ��
					sql.append( " LEFT JOIN PAYROLL.HCLCODE E ON  A.PAYGRD = E.MINORCD  AND E.MAJORCD = '2002'		"); //����
					sql.append( " LEFT JOIN PAYROLL.PRPAY   F ON A.EMPNO  = F.EMPNO   														"); //����

					if (!str1.equals(""))	{
						sql.append( " WHERE A.EMPNMK like '%"+str1+"%' ");
					}
					sql.append( " ORDER BY EMPNO ");
					
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