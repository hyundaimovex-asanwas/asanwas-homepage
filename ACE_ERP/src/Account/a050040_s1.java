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
public class a050040_s1 extends HttpServlet {
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
				String  str2    = req.getParameter("v_str2"); //년도1
				String  str3    = req.getParameter("v_str3"); //년도2

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "PRTNAM", "XLTTOT", "XRTTOT", "YLTTOT", "YRTTOT"
				}; 

				int[] intArrCN = new int[]{  66, 15, 15, 15, 15
				}; 
			
				int[] intArrCN2 = new int[]{  -1, 0, 0, 0, 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}
				
				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT X.PRTNAM AS PRTNAM, nvl(X.LTTOT,0) AS XLTTOT, nvl(X.RTTOT,0) AS XRTTOT, nvl(Y.LTTOT,0) AS YLTTOT, nvl(Y.RTTOT,0) AS YRTTOT " );
					sql.append( " FROM " );
					sql.append( " ( " );
					sql.append( "     SELECT F.ATCODE,F.PRTNAM,F.PRTSEQ, " );
					sql.append( "            CASE WHEN F.LRDIV = 'L' " );
					sql.append( "            THEN CASE WHEN E.ATDECR = '1' " );
					sql.append( "            THEN E.ATDETOT - E.ATCRTOT ELSE E.ATCRTOT - E.ATDETOT END END AS LTTOT, " );
					sql.append( "            CASE WHEN F.LRDIV = 'R' THEN CASE WHEN E.ATDECR = '1' " );
					sql.append( "            THEN E.ATDETOT - E.ATCRTOT ELSE E.ATCRTOT - E.ATDETOT END END AS RTTOT " );
					sql.append( "     FROM ACCOUNT.RPTPRTACT F LEFT JOIN " );
					sql.append( "     ( " );
					sql.append( "         SELECT C.ATCODE AS ATCODE, " );
					sql.append( "                CASE WHEN C.ATCODE = '0100' OR C.ATCODE = '0101' OR C.ATCODE = '0102' OR " );
					sql.append( "                C.ATCODE = '0104' OR C.ATCODE = '0200' OR C.ATCODE = '0201' OR " );
					sql.append( "                C.ATCODE = '0300' OR C.ATCODE = '0301' OR C.ATCODE = '0400' OR " );
					sql.append( "                C.ATCODE = '0500' OR C.ATCODE = '0600' THEN '1' " );
					sql.append( "                ELSE CASE WHEN C.ATCODE = '0103' OR C.ATCODE = '0202' OR C.ATCODE = '0302' THEN '2' " );
					sql.append( "                ELSE D.ATDECR END END AS ATDECR, " );
					sql.append( "                C.ATDETOT    AS ATDETOT, C.ATCRTOT    AS ATCRTOT " );
					sql.append( "         FROM " );
					sql.append( "         ( " );
					sql.append( "             SELECT A.ATCODE     AS ATCODE, " );
					sql.append( "                    SUM(A.ATDETOT)    AS ATDETOT, SUM(A.ATCRTOT)    AS ATCRTOT " );
					sql.append( "             FROM ACCOUNT.CASHFLOW A " );
					sql.append( "             WHERE A.ACTYYMM BETWEEN '"+str2+"' AND '"+str3+"' " );
					if(!str1.equals(""))
					sql.append( "           AND A.FDCODE = '"+str1+"' " );
					sql.append( "             GROUP BY A.ATCODE " );
					sql.append( "         ) C LEFT JOIN ACCOUNT.ACTCODE D " );
					sql.append( "         ON C.ATCODE = D.ATCODE " );
					sql.append( "     ) E " );
					sql.append( "     ON E.ATCODE = F.ATCODE " );
					sql.append( "     WHERE F.PRTCODE = '01' " );
					sql.append( "     ORDER BY F.PRTSEQ " );
					sql.append( " ) X, " );
					sql.append( " ( " );
					sql.append( "     SELECT F.ATCODE,F.PRTNAM,F.PRTSEQ, " );
					sql.append( "            CASE WHEN F.LRDIV = 'L' " );
					sql.append( "            THEN CASE WHEN E.ATDECR = '1' " );
					sql.append( "            THEN E.ATDETOT - E.ATCRTOT ELSE E.ATCRTOT - E.ATDETOT END END AS LTTOT, " );
					sql.append( "            CASE WHEN F.LRDIV = 'R' THEN CASE WHEN E.ATDECR = '1' " );
					sql.append( "            THEN E.ATDETOT - E.ATCRTOT ELSE E.ATCRTOT - E.ATDETOT END END AS RTTOT " );
					sql.append( "     FROM ACCOUNT.RPTPRTACT F LEFT JOIN " );
					sql.append( "     ( " );
					sql.append( "         SELECT C.ATCODE AS ATCODE, " );
					sql.append( "                CASE WHEN C.ATCODE = '0100' OR C.ATCODE = '0101' OR C.ATCODE = '0102' OR " );
					sql.append( "                C.ATCODE = '0104' OR C.ATCODE = '0200' OR C.ATCODE = '0201' OR " );
					sql.append( "                C.ATCODE = '0300' OR C.ATCODE = '0301' OR C.ATCODE = '0400' OR " );
					sql.append( "                C.ATCODE = '0500' OR C.ATCODE = '0600' THEN '1' " );
					sql.append( "                ELSE CASE WHEN C.ATCODE = '0103' OR C.ATCODE = '0202' OR C.ATCODE = '0302' THEN '2' " );
					sql.append( "                ELSE D.ATDECR END END AS ATDECR, " );
					sql.append( "                C.ATDETOT    AS ATDETOT, C.ATCRTOT    AS ATCRTOT " );
					sql.append( "         FROM " );
					sql.append( "         ( " );
					sql.append( "             SELECT A.ATCODE     AS ATCODE, " );
					sql.append( "                    SUM(A.ATDETOT)    AS ATDETOT, SUM(A.ATCRTOT)    AS ATCRTOT " );
					sql.append( "             FROM ACCOUNT.CASHFLOW A " );
					sql.append( "             WHERE A.ACTYYMM BETWEEN '"+str2+"' AND '"+str3+"' " );
					if(!str1.equals(""))
					sql.append( "           AND A.FDCODE = '"+str1+"' " );
					sql.append( "             GROUP BY A.ATCODE " );
					sql.append( "         ) C LEFT JOIN ACCOUNT.ACTCODE D " );
					sql.append( "         ON C.ATCODE = D.ATCODE " );
					sql.append( "     ) E " );
					sql.append( "     ON E.ATCODE = F.ATCODE " );
					sql.append( "     WHERE F.PRTCODE = '01' " );
					sql.append( "     ORDER BY F.PRTSEQ " );
					sql.append( " ) Y " );
					sql.append( " WHERE X.ATCODE = Y.ATCODE " );
					sql.append( " ORDER BY X.PRTSEQ " );

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