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
public class dsCalendar_JS extends HttpServlet {
 
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
				String str2 = GauceReq.getParameter("gstr2");   

				if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				if (str2==null || str2.trim().length()==0 ) {   str2=null; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{	"LINE_PART","CAL_DT", "WEEK_DAY", "HOLY_DIV","APP_DT1",
													"APP_DT2",  "APP_DT3","HOLY_TYPE","CAL_REM", "CHOUR",  "USE_YN"
																				}; 

				int[] intArrCN = new int[] {	4,  8,  1,  1,  8,
												8,  8,  1, 30,  2, 1
																		}; 
			
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1, -1,
												-1, -1, -1, -1, -1, -1
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();
					  sql.append( " SELECT     \n")
					     .append( " LINE_PART, \n")
						 .append( " CAL_DT,    \n")
						 .append( "	WEEK_DAY,  \n")
						 .append( "	HOLY_DIV,  \n")
						 .append( "	APP_DT1,   \n")
						 .append( "	APP_DT2,   \n") 
					     .append( "	APP_DT3,   \n") 
						 .append( "	HOLY_TYPE, \n") 
						 .append( "	CAL_REM,   \n") 
						 .append( "	HOUR(CURRENT TIMESTAMP) CHOUR,   \n")
						 .append( "	CASE WHEN DAY(DATE(SUBSTRING(CAL_DT,1,4)||'-'||SUBSTRING(CAL_DT,5,2)         \n")
						 .append( "	 ||'-'||SUBSTRING(CAL_DT,7,2)) - CURDATE()) > 4 AND IFNULL(APP_DT1,'') <> '' \n")
						 .append( "	THEN 'Y' ELSE 'N' END AS USE_YN  \n")
						 .append( "	FROM TRANSFER.LTCALENDAR \n")
						 .append( "	WHERE CAL_DT IS NOT NULL \n");

					if( str1 != null) sql.append( " AND LINE_PART = '" + str1 + "'" ) ;
					if( str2 != null) sql.append( " AND SUBSTRING(CAL_DT,1,6) = '" + str2 + "%'" ) ;

					sql.append( " ORDER BY CAL_DT " ) ;

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