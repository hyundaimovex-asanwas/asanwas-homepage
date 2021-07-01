package North.northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class hdasan_login extends HttpServlet {
			  
	public void doGet(HttpServletRequest req,HttpServletResponse res) {
		
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;
		String query = "";

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
	    	      GauceResponse GauceRes = service.getGauceResponse();
			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();   
				
				String str1	= req.getParameter("gstr1");
				String str2	= req.getParameter("gstr2");
				String str3 	= req.getRemoteAddr();

//				str1 = str1.replace('\'',' ');
//				str1 = str1.replace('-',' ');
				
        		String str4 = str1.substring(0,2);
				
				GauceRes.enableFirstRow(dSet);

				dSet.addDataColumn(new GauceDataColumn("userid", GauceDataColumn.TB_STRING, 10));
				dSet.addDataColumn(new GauceDataColumn("password", GauceDataColumn.TB_STRING, 10));
				dSet.addDataColumn(new GauceDataColumn("username", GauceDataColumn.TB_STRING, 30));
				dSet.addDataColumn(new GauceDataColumn("autlevel", GauceDataColumn.TB_STRING, 10));
				dSet.addDataColumn(new GauceDataColumn("ipaddr", GauceDataColumn.TB_STRING, 15));
				dSet.addDataColumn(new GauceDataColumn("strsys", GauceDataColumn.TB_STRING, 3));
//				dSet.addDataColumn(new GauceDataColumn("strdate", GauceDataColumn.TB_STRING, 8));
//				dSet.addDataColumn(new GauceDataColumn("enddate", GauceDataColumn.TB_STRING, 8));
//				dSet.addDataColumn(new GauceDataColumn("regman", GauceDataColumn.TB_STRING, 10));
//				dSet.addDataColumn(new GauceDataColumn("regdate", GauceDataColumn.TB_STRING, 8));

		    if (!GauceReq.isBuilderRequest()) {
		    			
					if(str4.equals("KS")){

						query = " SELECT A.USERID, A.PASSWORD, A.USERNAME, A.AUTLEVEL, A.IPADDR, A.STRSYS"
									+ " FROM NORTHHR.USERFILE A  "									
									+ " WHERE A.USERID  = '" + str1 + "'"
									+ "   AND A.PASSWORD = '" + str2 + "'";
				  }


				//logger.dbg.println(this,query);//로그남기는것				
				
			    stmt = conn.getGauceStatement(query);
			 	stmt.executeQuery(dSet);
			 				 				 	
			   	}
  		  	} catch(Exception e) {
		    	logger.err.println(this,e);
		  	} finally {
		  		if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  	dSet.flush();
		  	GauceRes.commit(query);
		  	GauceRes.close();
		} catch (Exception e) {
	   		logger.err.println(this, e);
		} finally {
		    loader.restoreService(service);
  		}
	}
}


