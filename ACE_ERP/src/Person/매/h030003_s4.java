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
public class h030003_s4 extends HttpServlet {

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
				String str1 = req.getParameter("v_str1");		//사번

				if (str1 == null) { str1 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","EMPNMK","DEPTCD","DEPTNM","PAYGRD",
																					"PAYGRDNM","BIRDT","PREDEPT","PREDEPTNM","ORDDT"
																				};

				int[] intArrCN = new int[]{    7,  30,  4,  30, 4,          
                                      30,   8,  4,  30, 8
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "	SELECT ");
					sql.append( "	RTRIM(A.EMPNO)  AS EMPNO,  RTRIM(A.EMPNMK)  AS EMPNMK, ");
					sql.append( "	RTRIM(A.DEPTCD) AS DEPTCD, RTRIM(C.DEPTNM)  AS DEPTNM, ");
					sql.append( "	RTRIM(A.PAYGRD) AS PAYGRD, RTRIM(D.MINORNM) AS PAYGRDNM, ");
					sql.append( "	RTRIM(A.BIRDT)  AS BIRDT, ");
					sql.append( "	RTRIM(G.DEPTCD) AS PREDEPT,RTRIM(G.DEPTNM)  AS PREDEPTNM, ");
					sql.append( "	RTRIM(B.ORDDT)  AS ORDDT ");
					sql.append( "	FROM PAYROLL.HIPERSON A, ");
					sql.append( "	PAYROLL.HOORDER B, ");
					sql.append( "	PAYROLL.HCDEPT C, ");
					sql.append( "	(SELECT * FROM PAYROLL.HCLCODE D WHERE D.MAJORCD='2002') D ");
					sql.append( "	LEFT JOIN (SELECT Y.EMPNO,Y.DEPTCD,Y.ORDDT ");
					sql.append( "	FROM PAYROLL.HOORDER Y ");
					sql.append( "	WHERE Y.ORDDT = (SELECT MAX(X.ORDDT) ");
					sql.append( "	                 FROM PAYROLL.HOORDER X ");
					sql.append( "	                 WHERE X.ORDDT < (SELECT MAX(F.ORDDT) ");
					sql.append( "	                                  FROM PAYROLL.HOORDER F ");
					sql.append( "	                                  WHERE F.EMPNO='"+str1+"' ) ");
					sql.append( "	                 AND X.EMPNO='"+str1+"') ");
					sql.append( "	AND Y.EMPNO='"+str1+"')XX ON A.EMPNO = XX.EMPNO ");
					sql.append( "	LEFT JOIN PAYROLL.HCDEPT G ON XX.DEPTCD = G.DEPTCD ");
					sql.append( "	WHERE A.EMPNO = B.EMPNO ");
					sql.append( "	AND A.DEPTCD = C.DEPTCD ");
					sql.append( "	AND A.PAYGRD = D.MINORCD ");
					sql.append( "	AND B.ORDDT = (SELECT MAX(F.ORDDT) FROM PAYROLL.HOORDER F WHERE F.EMPNO='"+str1+"') ");
					sql.append( "	AND A.EMPNO = '"+str1+"' ");

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