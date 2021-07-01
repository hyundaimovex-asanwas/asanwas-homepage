	package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class a030008_s3_y extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
				String  str1	= req.getParameter("v_str1");  //�����ڵ�
				String  str2  = req.getParameter("v_str2");  //ȸ����
				String  str6  = "";

				if(str1 == null) str1 = ""; //�����ڵ�
				if(str2 == null) str2 = ""; //��꼭�Ⱓ ���
        
				str6 = str2.substring(0,4);

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{   "DEVAL", "DETOT","CRTOT","CRVAL"
				}; 

				int[] intArrCN = new int[]{ 15,	15, 15, 15
				}; 
			
				int[] intArrCN2 = new int[]{ 0, 0, 0, 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
				
					sql.append(" SELECT                                                                                   					\n");
					sql.append("        SUM(CASE WHEN B.ATDECR='1'   THEN  nvl(B.DETOT - B.CRTOT,0) ELSE 0 END) DEVAL, \n");
					sql.append("        SUM(DETOT)DETOT, SUM(CRTOT)CRTOT,  											\n");
					sql.append("        SUM(CASE WHEN B.ATDECR='2'   THEN  nvl(B.CRTOT - B.DETOT,0) ELSE 0 END) CRVAL  \n");
					sql.append("  FROM(                                                                                   					\n");
					sql.append("        SELECT A.ATCODE ATCODE, C.ATDECR,  SUM(A.DETOT) DETOT, SUM(A.CRTOT) CRTOT         \n");
					sql.append(" 				  FROM ACCOUNT.MTOTALBAL A                                                   \n");
					sql.append("          LEFT JOIN ACCOUNT.ACTCODE C ON A.ATCODE = C.ATCODE                 \n");
					sql.append("         WHERE A.FDCODE LIKE '%"+str1+"%' 													\n");
					sql.append("           AND (A.ACTYYMM >= '"+str6+"00' AND A.ACTYYMM <= '"+str2+"') 			\n");
					sql.append("           AND C.ATUSEYN= 'Y'                                                             			\n");
					sql.append("         GROUP BY A.ATCODE, C.ATDECR                                                      	\n");
					sql.append("         UNION ALL                                                                        				\n"); 
					sql.append("				SELECT A.ATCODE, C.ATDECR, SUM(A.DETOT) DETOT, SUM(A.CRTOT)CRTOT    \n");
					sql.append("				  FROM ACCOUNT.MDMTOTAL A                                           			\n");
					sql.append("				  LEFT JOIN ACCOUNT.ACTCODE C ON A.ATCODE = C.ATCODE          \n");
					sql.append("				 WHERE A.FDCODE LIKE '%"+str1+"%'                                   			\n");
					sql.append("				   AND (A.ACTYYMM >= '"+str6+"00' AND A.ACTYYMM <= '"+str2+"')      \n");
					sql.append("				   AND C.ATUSEYN= 'Y'                                               					\n");
					sql.append("				 GROUP BY A.ATCODE, C.ATDECR                                        			\n");
					sql.append("  ) B                                                                       									\n");
				
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