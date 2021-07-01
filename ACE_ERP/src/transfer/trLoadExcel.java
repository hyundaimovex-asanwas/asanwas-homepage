package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import jxl.*; 
import java.io.*;
import java.net.*;



// class 이름은 화일명과 항상 동일해야 함.
public class trLoadExcel extends HttpServlet {
 
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
    GauceDataSet dSet = null;
		GauceDataSet userSet = null ; 
		GauceStatement gstmt = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet(); 
				userSet = new  GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				  dSet = GauceReq.getGauceDataSet("USER");
				boolean isNotOnlyHeader = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				
				
				 
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				String str3 = GauceReq.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }
				
				 

				 int idxFILENAME = dSet.indexOfColumn("FILENAME"); 
logger.err.println(this,"eee");
				String[] strArrCN = new String[]{ "FILENAME" }; 
logger.err.println(this,"eee1");
				GauceDataRow[] rows = dSet.getDataRows();
				//logger.err.println(this,idxFILENAME.toString()); //ms
				String oBlob = rows[0].getString(0);

 
logger.err.println(this,oBlob);
logger.err.println(this,"kkkeee2");
				InputStream nst_file = (InputStream) rows[0].getInputStream(idxFILENAME);
logger.err.println(this,"eee3");
				Workbook workbook = Workbook.getWorkbook(nst_file); 
				Sheet sheet = workbook.getSheet(0); 
				Cell a1 = sheet.getCell(0,0); 
				Cell b2 = sheet.getCell(0,1); 
				Cell c2 = sheet.getCell(0,2); 

				String stringa1 = a1.getContents();
				String stringb2 = b2.getContents();
				String stringc2 = c2.getContents();
				logger.err.println(this,stringa1);
				logger.err.println(this,stringb2);
				logger.err.println(this,stringc2);
		 

						 
					 
				
/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
			GauceRes.writeException("Sql",":",e.toString());
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