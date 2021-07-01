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
public class a070007_s3 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");    //�����ڵ�  
				String  str2	= req.getParameter("v_str2");	 //�ǻ�����

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "GUBN", "ACAMT1", "ACAMT2" ,"ACAMT3", "ACAMT4", "BIGO" };

				int[] intArrCN = new int[]{11, 15, 15, 15, 15, 0 };
			
				int[] intArrCN2 = new int[]{ -1, 0, 0, 0, 0, -1 };

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();            
					sql.append( " SELECT CASE CUR WHEN '1' THEN ' ��ȭ' 																\n");
					sql.append( " WHEN '3' THEN ' ��ȭ(EUR)' WHEN '4' THEN ' ��ȭ(USD)' ELSE ' ��Ÿ ' END as GUBN,    \n	");
					sql.append( " SUM(ACAMT1) as ACAMT1, SUM(ACAMT2) as ACAMT2, SUM(ACAMT3) as ACAMT3, SUM(ACAMT4) as ACAMT4,'' as BIGO FROM \n");
					sql.append( " (SELECT CASE SUBSTR(CURDIV,1,1) WHEN '2' THEN '1' ELSE SUBSTR(CURDIV,1,1) END AS CUR, ACAMT1, ACAMT2, ACAMT3, ACAMT4 \n");
					sql.append( " FROM ACCOUNT.ASURVEND WHERE FDCODE = '" + str1 + "' 	\n");
					sql.append( " AND ACDATE = '"+ str2 + "') A 												\n");
					sql.append( " GROUP BY CUR ORDER BY CUR 										\n");
				   
					//System.out.println("a070007_s3:"+sql.toString());

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