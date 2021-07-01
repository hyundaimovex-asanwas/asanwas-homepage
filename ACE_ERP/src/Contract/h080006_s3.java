package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h080006_s3 extends HttpServlet {

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
				String str1 = req.getParameter("v_str1");		//부서
				String str3 = req.getParameter("v_str3");		//시작일
				String str4 = req.getParameter("v_str4");		//종료일
				String str5 = req.getParameter("v_str5");		//사번

				if (str5 == null) { str5 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","ORDDT","SEQ","DEPTCD",
																					"PAYGRD","PAYSEQ","ENDDT","APPDT","EMPNMK",
																					"REGDAT","DEPTNM","PAYGRDNM","BIRDT","DEPTPRT",
																					"JOBDTY","PREDEPT","BIRDT","PDEPT"
																				};

				int[] intArrCN = new int[]{    7,  8,  2,  4,          
                                       4,  4,  8,  8, 20,
																			 8,	50, 30,  8, 30,
																			 4, 4,  8,   4
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1,  0, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "SELECT  ");
					sql.append( "	RTRIM(A.EMPNO) AS EMPNO ,RTRIM(A.ORDDT) AS ORDDT,A.SEQ,RTRIM(A.DEPTCD) AS DEPTCD,   ");
					sql.append( " RTRIM(A.PAYGRD) AS PAYGRD,A.PAYSEQ,RTRIM(A.ENDDT) AS ENDDT,RTRIM(A.APPDT) AS APPDT, RTRIM(B.EMPNMK) EMPNMK, ");
					sql.append( "	'' AS REGDAT,RTRIM(C.DEPTNM) AS DEPTNM,RTRIM(D.MINORNM) AS PAYGRDNM, RTRIM(B.BIRDT) AS BIRDT, ");
					sql.append( "	RTRIM(E.MINORNM) AS DEPTPRT,RTRIM(B.JOBDTY) AS JOBDTY,RTRIM(G.DEPTCD) AS PREDEPT, B.BIRDT, ");
					sql.append( "	RTRIM(B.DEPTCD) AS PDEPT ");
					sql.append( " FROM PAYROLL.T_HOORDER A, ");
					sql.append( "      PAYROLL.T_HIPERSON B, ");
					sql.append( "			 PAYROLL.HCDEPT C, ");
					sql.append( "			 (SELECT * FROM PAYROLL.HCLCODE D WHERE D.MAJORCD='2002') D, ");
					sql.append( "			 (SELECT * FROM PAYROLL.HCLCODE E WHERE E.MAJORCD='1111') E ");
					sql.append( "	LEFT JOIN (SELECT Y.EMPNO,Y.DEPTCD,Y.ORDDT ");
					sql.append( "							FROM PAYROLL.HOORDER Y ");
					sql.append( "			 WHERE Y.ORDDT = (SELECT MAX(X.ORDDT) ");
					sql.append( "												FROM PAYROLL.HOORDER X ");
					sql.append( "												WHERE X.ORDDT < (SELECT MAX(F.ORDDT) ");
					sql.append( "																				 FROM PAYROLL.HOORDER F ");
					sql.append( "																				 WHERE F.EMPNO='"+str5+"' ) ");
					sql.append( "												AND X.EMPNO='"+str5+"') ");
					sql.append( "			 AND Y.EMPNO='"+str5+"')XX ON A.EMPNO = XX.EMPNO");
					sql.append( "	LEFT JOIN PAYROLL.HCDEPT G ON XX.DEPTCD = G.DEPTCD ");
					sql.append( " WHERE A.EMPNO = B.EMPNO ");
					sql.append( " AND B.DEPTCD = C.DEPTCD ");
					sql.append( " AND E.MINORCD = C.DEPTPRT ");
					sql.append( " AND D.MINORCD = B.PAYGRD ");
					sql.append( " AND A.ORDDT = (SELECT MAX(F.ORDDT) FROM PAYROLL.HOORDER F WHERE F.EMPNO='"+str5+"') ");
					sql.append( " AND A.EMPNO = '"+str5+"' ");
					//sql.append( "	AND A.ORDDT BETWEEN '" + str3 + "' AND '" + str4 + "' ");

					if (str1.equals("")){
						sql.append( " AND A.DEPTCD LIKE '%' ");
					}else {
						sql.append( " AND A.DEPTCD = '"+str1+"' ");
					}

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