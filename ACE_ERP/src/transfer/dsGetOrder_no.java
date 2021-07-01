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
public class dsGetOrder_no extends HttpServlet {
 
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
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
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				
				boolean isNotOnlyHeader = false;
				boolean isDebug = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				if ( GauceReq.getParameter("DBG")!=null && GauceReq.getParameter("DBG").equals("Y") ) { isDebug = true; }
				 
				 
				
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				
				 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ORD_NO" }; 

				int[] intArrCN = new int[] {10 }; 
			
				int[] intArrCN2 = new int[]{-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT  '" +str1+  "' CONCAT SUBSTR(CHAR(CURRENT DATE),3,2) \n " ) ; 
					sql.append( " CONCAT SUBSTR(CHAR(CURRENT DATE),6,2) \n " ) ;
					sql.append( " CONCAT \n " ) ;
					sql.append( " CASE WHEN MAX(ORDER_NO) IS NULL  THEN   '00001' \n " ) ;
					sql.append( " WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(ORDER_NO,6,5)))+ 1)) = 1 \n " ) ;
					sql.append( " THEN '0000' CONCAT CHAR(DEC(MAX(SUBSTRING(ORDER_NO,6,5)))+ 1) \n " ) ;
					sql.append( " WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(ORDER_NO,6,5)))+ 1)) = 2 \n " ) ;
					sql.append( " THEN '000' CONCAT CHAR(DEC(MAX(SUBSTRING(ORDER_NO,6,5)))+ 1)\n " ) ;
					sql.append( " WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(ORDER_NO,6,5)))+ 1)) = 3 \n " ) ;
					sql.append( " THEN '00' CONCAT CHAR(DEC(MAX(SUBSTRING(ORDER_NO,6,5)))+ 1)\n " ) ;
					sql.append( " WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(ORDER_NO,6,5)))+ 1)) = 4 \n " ) ;
					sql.append( " THEN '0' CONCAT CHAR(DEC(MAX(SUBSTRING(ORDER_NO,6,5)))+ 1)\n " ) ;
					sql.append( " ELSE '00001' \n " ) ;
					sql.append( " END   AS ORD_NO \n " ) ;
					sql.append( " FROM TRANSFER.LTORDERMST  \n " ) ;
					sql.append( " WHERE SUBSTR(ORDER_NO,1,1) = '" +str1 + "'" ) ; 
if (isDebug) {	
 GauceRes.writeException("Sql",":",sql.toString()); }
						stmt = conn.getGauceStatement(sql.toString());
		 				stmt.executeQuery(dSet);
					}
				
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