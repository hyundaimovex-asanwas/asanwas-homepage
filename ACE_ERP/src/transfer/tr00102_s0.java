package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.ServiceLoader;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class tr00102_s0 extends HttpServlet {

	// ���������� ���� ���۹���� Post Ÿ���� ���
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("image/jpeg");
		
		//System.out.println("tr00102_s0:;����");
		
		//ServiceLoader loader = new ServiceLoader(req, res);
		com.gauce.ServiceLoader loader = new com.gauce.ServiceLoader(req, res);
		//GauceService service = null;
		
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		Statement stmt =null;
		//GauceDataSet dSet1 = null;
		
		//System.out.println("tr00102_s0:;1"); 
		try {
			GauceService service = loader.newService();
			
			//System.out.println("tr00102_s0:;11"); 
			context = service.getContext();
			//System.out.println("tr00102_s0:;12"); 
			logger = context.getLogger();
			//System.out.println("tr00102_s0:;13"); 

			GauceRequest GauceReq = service.getGauceRequest();
			//System.out.println("tr00102_s0:;14"); 
			GauceResponse GauceRes = service.getGauceResponse();

			//System.out.println("tr00102_s0:;2"); 
			try {
				conn = service.getDBConnection();
				//dSet1 = new GauceDataSet();

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String  str1	= req.getParameter("v_str1");
				
				//System.out.println("tr00102_s0:;3"); 

				if (str1==null) str1 = "";

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT ATT_FILE ")
					   .append( "		FROM TRANSFER.LTORDERMST ")
					   .append( " WHERE ORDER_NO = '" + str1 + "' ");

					
					//System.out.println("tr00102_s0:;"+sql.toString()); 
					stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery(sql.toString());
					byte [] bdata = new byte[1];

					while (rs.next()){
						bdata = rs.getBytes(1);
						GauceRes.write(bdata);
					}

/*********************************************************************************************/

				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		    } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

//		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		} finally {
			//loader.restoreService(service);
     	}
	}
}