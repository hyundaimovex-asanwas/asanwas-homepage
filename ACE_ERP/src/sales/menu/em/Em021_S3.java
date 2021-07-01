package sales.menu.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.
public class Em021_S3 extends HttpServlet {

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

				String [] str = new String [3];

				str[0]	= req.getParameter("v_str1");    //����
				str[1]	= req.getParameter("v_str2");    //���� 
				str[2]	= req.getParameter("v_str3");    //���

				for (int s=0;s<=2;s++) {
					if (str[s].equals("")) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CNT" }; 

				int[] intArrCN = new int[] { 3	}; 
			
				int[] intArrCN2 = new int[]{ 0 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {			
					if(str[0].equals("1")){ //���� üũ
						StringBuffer sql = new StringBuffer();
						sql.append( "	SELECT COUNT(*) CNT FROM SALES.TCM410  \n");
						sql.append( "	 WHERE YYYYMM = '"+str[2]+"' \n");
						sql.append( "	   AND CON_YEAR='"+str[1]+"' \n");
						stmt = conn.getGauceStatement(sql.toString());
						stmt.executeQuery(dSet);
					
					}else if(str[0].equals("2")){ //��� üũ
						StringBuffer sql = new StringBuffer();
						sql.append( "	SELECT COUNT(*) CNT FROM SALES.TCM410  \n");
						sql.append( "	 WHERE YYYYMM = '"+str[2]+"' \n");
						stmt = conn.getGauceStatement(sql.toString());
						stmt.executeQuery(dSet);
					}
				}
				
/*********************************************************************************************/

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