package transfer;

import com.gauce.*;
import com.gauce.ServiceLoader;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.io.*;
import java.util.*;

// class 이름은 화일명과 항상 동일해야 함.
public class tr00102_s1 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		System.out.println("tr00102_s1:: 시작");
		ServiceLoader loader = new com.gauce.ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		//GauceStatement gstmt =null;
		Statement stmt = null;
		GauceDataSet dSet = null;
		ServletOutputStream stream = null;
		//System.out.println("tr00102_s1::1");
		try {
			//service = loader.newService();
			
			service= loader.newService();
			//System.out.println("tr00102_s1::11");
			context = service.getContext();
			//System.out.println("tr00102_s1::12");
			logger = context.getLogger();
			//System.out.println("tr00102_s1::13");
			GauceRequest GauceReq = service.getGauceRequest();
			//System.out.println("tr00102_s1::14");
			GauceResponse GauceRes = service.getGauceResponse();
			try {
				System.out.println("tr00102_s1::2");
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String str1 = req.getParameter("v_str1");
				String str2 = req.getParameter("v_str2");
				String filename = str1 + "." + str2;

				res.setContentType("application/x-filler; charset=KSC5601");
				res.setHeader("Content-Transfer-Encoding:", "base64");
				res.setHeader("Content-Disposition:", "attachment;filename=" + filename);

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT ATT_FILE ")
					   .append( "	FROM TRANSFER.LTORDERMST ")
					   .append( " WHERE ORDER_NO = '" + str1 + "' ");

					//ogger.dbg.println(this,sql.toString());
/*********************************************************************************************/
					System.out.println("tr00102_s1::3");
					stmt = conn.createStatement();

					ResultSet rs = stmt.executeQuery(sql.toString());
					byte [] bdata = new byte[0];

					stream = res.getOutputStream();
					System.out.println("tr00102_s1::4");
					if(rs.next()) {
						bdata = rs.getBytes(1);
						stream.write(bdata);
						stream.flush();
		     	}

					rs.close();

				}
				
				System.out.println("tr00102_s1::5");
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
			//loader.restoreService(service);
  	}
	} //public void
} //public class