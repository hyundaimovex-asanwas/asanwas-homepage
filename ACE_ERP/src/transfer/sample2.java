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
public class sample2 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("image/jpeg");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection gconn = null;
		Connection conn = null;
		Statement stmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
      GauceResponse GauceRes = service.getGauceResponse();

			try {

				Class.forName("com.ibm.as400.access.AS400JDBCDriver");
				conn = DriverManager.getConnection("jdbc:as400://210.113.17.132/GROUPWARE;user=qpilot;password=pilot");

				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String  str1	= req.getParameter("v_str1");

				if (str1==null) str1 = "";

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT SIGN_IMG ");
					sql.append( "		FROM GROUPWARE.GECOB50T ");
					sql.append( " WHERE EMPNO = '" + str1 + "' ");

logger.dbg.println(this,sql.toString());

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
				if (conn != null) try {conn.close();} catch (Exception e) {}
			}

//		  dSet.flush();
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