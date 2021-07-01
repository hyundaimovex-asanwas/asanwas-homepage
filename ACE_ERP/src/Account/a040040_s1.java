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
public class a040040_s1 extends HttpServlet {
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
				String  str1	  = req.getParameter("v_str1"); //지점
				String  str2    = req.getParameter("v_str2"); //년도

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE", "ATKORNAM", "ATUSEYN", "DETOT", "CRTOT"
				}; 

				int[] intArrCN = new int[]{  7, 66, 1, 15, 15
				}; 
			
				int[] intArrCN2 = new int[]{  -1, -1, -1, 0, 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT C.ATCODE AS ATCODE, C.ATKORNAM AS ATKORNAM, C.ATUSEYN AS ATUSEYN, " );
					sql.append( "     nvl(CASE WHEN C.ATDECR = '1' THEN B.DETOT - B.CRTOT END,0) AS DETOT, " );
					sql.append( "     nvl(CASE WHEN C.ATDECR = '2' THEN B.CRTOT - B.DETOT END,0) AS CRTOT " );
					sql.append( " FROM  " );
					sql.append( " ( " );
					sql.append( "   SELECT A.ATCODE AS ATCODE, " );
					sql.append( "          SUM(A.DETOT) AS DETOT, " );
					sql.append( "          SUM(A.CRTOT) AS CRTOT " );
					sql.append( "   FROM ACCOUNT.MTOTALBAL A " );
					sql.append( "   WHERE A.ACTYYMM BETWEEN '"+str2+"01' AND '"+str2+"12' " );
					if(!str1.equals(""))sql.append( " AND A.FDCODE = '"+str1+"' " );
					sql.append( "   AND SUBSTR(A.ATCODE,1,1) < '4' " );
					sql.append( "   GROUP BY A.ATCODE " );
					sql.append( " ) B LEFT JOIN ACCOUNT.ACTCODE C " );
					sql.append( " ON B.ATCODE = C.ATCODE " );
					sql.append( " ORDER BY C.ATPRTSEQ " );

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