package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class dsDetailDownLoad extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement gstmt =null;
		Statement stmt = null;
		GauceDataSet dSet = null;
		ServletOutputStream stream = null;

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
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				  String str1 = GauceReq.getParameter("gstr1");   //order No
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
					String str2 = GauceReq.getParameter("gstr2");   //order No
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
					String str3 = GauceReq.getParameter("gstr3");   //order No
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }


				res.setContentType("application/x-filler; charset=KSC5601");
				res.setHeader("Content-Transfer-Encoding:", "base64");
				res.setHeader("Content-Disposition:", "attachment;filename=" + str3);

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT REGFILE \n " );
					sql.append( "   FROM TRANSFER.LTORDERDTL \n " );
					sql.append( "  WHERE ORDER_NO = '" + str1 + "' \n " );
					sql.append( "    AND ORDER_SEQ = '" + str2 + "' \n " );
					   

					logger.dbg.println(this,sql.toString());
/*********************************************************************************************/

					stmt = conn.createStatement();

					ResultSet rs = stmt.executeQuery(sql.toString());
					byte [] bdata = new byte[0];

					stream = res.getOutputStream();
					
					if(rs.next()) {
						bdata = rs.getBytes(1);
						stream.write(bdata);
						stream.flush();
		     	}

					rs.close();
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
	} //public void
} //public class