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
public class dsCalendar2 extends HttpServlet {
 
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
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				String str3 = GauceReq.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }
				String str4 = GauceReq.getParameter("gstr4");   
					if (str4==null || str4.trim().length()==0 ) {   str4=null; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{	"LINE_PART","CAL_DT","WEEK_DAY","HOLY_DIV","APP_DT1",
																					"APP_DT2","APP_DT3","HOLY_TYPE","CAL_REM","CHOUR"
																				}; 

				int[] intArrCN = new int[] {	4, 10,  1,  1,  8,
																			8,  8,  1, 30,  2
																		}; 
			
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1, -1,
																			-1, -1, -1, -1, -1
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT LINE_PART, CHAR(DATE(SUBSTR(APP_DT1,1,4)||'-'||SUBSTR(APP_DT1,5,2)||'-'||SUBSTR(APP_DT1,7,2))- 1 DAYS) CAL_DT, WEEK_DAY, HOLY_DIV, APP_DT1, \n")
						 .append( "				 APP_DT2, APP_DT3, HOLY_TYPE, CAL_REM, HOUR(CURRENT TIMESTAMP) CHOUR \n")
						 .append( "		FROM TRANSFER.LTCALENDAR \n")
						 .append( "	 WHERE CAL_DT IS NOT NULL \n");

					if( str1 != null) sql.append( " AND LINE_PART = '" + str1 + "'" ) ;
					if( str2 != null) sql.append( " AND CAL_DT LIKE '" + str2 + "%'" ) ;
					if( str3 != null) sql.append( " AND CAL_DT = '" + str3 + "'" ) ;
					if( str4 != null) sql.append( " AND APP_DT1 = '" + str4 + "'" ) ;

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