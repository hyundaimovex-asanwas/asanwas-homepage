package North.northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ��� �׻� �����ؾ� ��.
public class KS_Em019_S1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");   //gclx_code.bindcolval �ڵ屸��

				if (str1==null) str1=""; 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "HEAD",
															"DETAIL",
															"DETAIL_NM",																					
															"ITEM1"
															}; 	
																					
				int[] intArrCN = new int[] { 5, 10, 50, 10 };  
			
				int[] intArrCN2 = new int[]{ -1,-1,-1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

			if (!GauceReq.isBuilderRequest()) {					
				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT            													\n");
				sql.append( "   HEAD, DETAIL, DETAIL_NM, nvl(ITEM1,'N') ITEM1		\n");
				sql.append( "		FROM ATP.TSY010  											\n");
				sql.append( "	WHERE 1=1                           								\n");
				if(!str1.equals(""))sql.append( "	  AND HEAD = '"+str1+"'         		\n");				
				sql.append( "	AND ITEM1 !=  '��뿩��'										\n");
				sql.append( "ORDER BY DETAIL													\n");		

				//System.out.println("KS_Em019_S1 \n" + sql.toString());	
				//logger.dbg.println(this,sql.toString());
				
				stmt = conn.getGauceStatement(sql.toString());
		 		stmt.executeQuery(dSet);
					
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