package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a050002_s2_1 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
				String  str1	= req.getParameter("v_str1");//사업소
				String  str2    = req.getParameter("v_str2");//기수
				String  str3    = req.getParameter("v_str3");//기간 from
				String  str4    = req.getParameter("v_str4");//기간 to

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CCCODE1", "CCCODE2", "TAXSUM1", "TAXVATAMT1"
				}; 

				int[] intArrCN = new int[]{  15, 15, 15, 15
				}; 
			
				int[] intArrCN2 = new int[]{ 0, 0,	0, 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT nvl(COUNT(DISTINCT A.CCCODE),0) CCCODE1, nvl(COUNT(A.CCCODE),0) CCCODE2, nvl(SUM(A.TAXSUM),0) TAXSUM1, nvl(SUM(A.TAXVATAMT),0) TAXVATAMT1 " );
					sql.append( "        FROM ACCOUNT.ATTAXMST A      " );
					sql.append( "        WHERE A.TAXIODIV ='2'                               ");
					sql.append( "        AND A.TAXKND = '2'                                ");
					if(!str1.equals("")) sql.append( "	AND A.COCODE = '"+str1+"' " );
					if(!str2.equals("")) sql.append( "	AND A.TAXKIDIV = '"+str2+"' " );
					if (!str3.equals("") && !str4.equals("")) sql.append( " AND A.TAXDAT BETWEEN '" + str3 + "' AND '" + str4 + "'" );

					//logger.dbg.println(this,sql.toString());
/*********************************************************************************************/

		      stmt = conn.getGauceStatement(sql.toString());
	 		  stmt.executeQuery(dSet);
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
	}
}