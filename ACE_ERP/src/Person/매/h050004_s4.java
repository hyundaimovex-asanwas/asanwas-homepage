package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h050004_s4 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2");

				if (str1==null) str1 = "";
				if (str2==null) str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "TREECD","DEPTNM", "ACNT", "LCNT", "HCNT", "TCNT",
																					"TEMP1","LVL1","LVL2","BCNT"
																				};

				int[] intArrCN = new int[]{ 8,20,  5,  7,  7,  7,
																		 5,  3,  3,  7
																	}; 

				int[] intArrCN2 = new int[]{ -1,-1,  0,  0,  0,  0,
																			2,  0,  0,  0
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT T.TREECD,T.DEPTNM, SUM(S.ACNT) AS ACNT, SUM(S.LCNT) AS LCNT, SUM(S.HCNT) AS HCNT, SUM(S.TCNT) AS TCNT,        ");
					sql.append( "				0 AS TEMP1, 0 AS LVL1, 0 AS LVL2, SUM(S.BCNT) AS BCNT																									");
					sql.append( "   FROM ( SELECT DEPTCD, COUNT(DEPTCD) AS ACNT, 0 AS LCNT, 0 AS HCNT, 0 AS TCNT,  0 AS BCNT                  ");
					sql.append( "            FROM PAYROLL.HIPERSON                                                                            ");
					sql.append( "           WHERE USESTS = '1'                                                                                ");
					sql.append( "           GROUP BY DEPTCD                                                                                   ");
					sql.append( "          UNION ALL                                                                                          ");
					sql.append( "          SELECT A1.DEPTCD, 0 AS ACNT, SUM(A1.AMT) AS LCNT, 0 AS HCNT, 0 AS TCNT, 0 AS BCNT                  ");
					sql.append( "            FROM PAYROLL.HLDUTY A1                                                                          ");
					sql.append( "           WHERE  SUBSTR(A1.FRDT,1,6) = '" + str1 + "'                                              ");
					sql.append( "              AND (SUBSTR(A1.LAZCD,1,1)='S' AND A1.LAZCD<>'S05')                           ");
          sql.append( "              AND RTRIM(A1.AGRDT) <> '' ");
					sql.append( "              AND RTRIM(A1.AGRDT) <> '99999999' ");
					sql.append( "           GROUP BY A1.DEPTCD                                                                                ");
					sql.append( "          UNION ALL                                                                                          ");
					sql.append( "          SELECT A1.DEPTCD, 0 AS ACNT, 0 AS LCNT, SUM(A1.AMT) AS HCNT, 0 AS TCNT, 0 AS BCNT                  ");
					sql.append( "            FROM PAYROLL.HLDUTY A1                                                                          ");
					sql.append( "           WHERE  SUBSTR(A1.FRDT,1,6) = '" + str1 + "'                                                                     ");
					sql.append( "              AND A1.LAZCD = 'S05'                                                                       ");
					sql.append( "              AND RTRIM(A1.AGRDT) <> '' ");
					sql.append( "              AND RTRIM(A1.AGRDT) <> '99999999' ");
					sql.append( "           GROUP BY A1.DEPTCD                                                                                ");
					sql.append( "          UNION ALL                                                                                          ");
					sql.append( "          SELECT A1.DEPTCD, 0 AS ACNT, 0 AS LCNT, 0 AS HCNT, SUM(A1.AMT) AS TCNT, 0 AS BCNT                  ");
					sql.append( "            FROM PAYROLL.HLDUTY A1                                                                          ");
					sql.append( "           WHERE   SUBSTR(A1.FRDT,1,6) = '" + str1 + "'                                                                     ");
					sql.append( "              AND SUBSTR(A1.LAZCD,1,1) ='S'                                                               ");
					sql.append( "              AND RTRIM(A1.AGRDT) <> '' ");
					sql.append( "              AND RTRIM(A1.AGRDT) <> '99999999' ");
					sql.append( "           GROUP BY A1.DEPTCD                                                                                ");
					sql.append( "          UNION ALL                                                                                          ");
					sql.append( "          SELECT A1.DEPTCD, 0 AS ACNT, 0 AS LCNT, 0 AS HCNT, 0 AS TCNT, SUM(A1.AMT) AS BCNT                  ");
					sql.append( "            FROM PAYROLL.HLDUTY A1                                                                       ");
					sql.append( "           WHERE SUBSTR(A1.FRDT,1,6) = '" + str2 + "'                                                                          ");
					sql.append( "              AND RTRIM(A1.AGRDT) <> '' ");
					sql.append( "              AND RTRIM(A1.AGRDT) <> '99999999' ");
					sql.append( "              AND SUBSTR(A1.LAZCD,1,1) ='S'                                                         ");
		  		sql.append( "           GROUP BY A1.DEPTCD                                                                                ");
					sql.append( "         ) S,                                                                                                ");
					sql.append( "         PAYROLL.HCDEPT T                                                                                    ");
					sql.append( "  WHERE S.DEPTCD = T.DEPTCD                                                                                  ");
					sql.append( "  GROUP BY T.TREECD ,T.DEPTNM                                                                                       ");
					sql.append( "  ORDER BY T.TREECD                                                                                       ");

         //	logger.dbg.println(this,sql.toString());
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