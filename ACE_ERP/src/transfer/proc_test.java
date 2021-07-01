package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import com.gauce.gaucelet.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class proc_test extends HttpServlet {

	public void doGet(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		CallableStatement stmt = null;
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
				
//				String  str1	= req.getParameter("str1");
				String  str1	= "0001";
				String  str2	= "0603";
				String  str3	= "";
				String  str4	= "";
				
				GauceRes.enableFirstRow(dSet);
		
				dSet.addDataColumn(new GauceDataColumn("SEQ_NAME", GauceDataColumn.TB_STRING,4));
				dSet.addDataColumn(new GauceDataColumn("SEQ_YYMM", GauceDataColumn.TB_STRING,4));
				dSet.addDataColumn(new GauceDataColumn("SEQ_NO", GauceDataColumn.TB_STRING,5));
				dSet.addDataColumn(new GauceDataColumn("RETCOD", GauceDataColumn.TB_STRING,1));
					
				if (!GauceReq.isBuilderRequest()) {				
					String	query = "CALL TRANSFER.SP_AUTOSEQ(?,?,?,?)" ; 

					stmt = conn.prepareCall(query);

					stmt.setString(1, str1 ); 
					stmt.setString(2, str2 ); 
					stmt.setString(3, str3 ); 
					stmt.setString(4, str4 );
						
					stmt.registerOutParameter (1, Types.CHAR); 
					stmt.registerOutParameter (2, Types.CHAR); 
					stmt.registerOutParameter (3, Types.CHAR); 
					stmt.registerOutParameter (4, Types.CHAR); 
						
					stmt.execute();

					String out1 = stmt.getString(1); 
					String out2 = stmt.getString(2); 
					String out3 = stmt.getString(3); 
					String out4 = stmt.getString(4); 

					GauceDataRow row =null;
					
					row = dSet.newDataRow();

					row.addColumnValue(out1);
					row.addColumnValue(out2);
					row.addColumnValue(out3);
					row.addColumnValue(out4);
							
					dSet.addDataRow(row);

	       	}
  		  } catch(Exception e) {
		    	logger.err.println(this,e);
		  	} finally {
		  		if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close();} catch (Exception e) {}
			}

	  	dSet.flush();
	  	GauceRes.commit();
	  	GauceRes.close();
		} catch (Exception e) {
   		logger.err.println(this, e);
		} finally {
	    loader.restoreService(service);
 		}
	}
}