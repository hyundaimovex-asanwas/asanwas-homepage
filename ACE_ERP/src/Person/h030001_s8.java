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
public class h030001_s8 extends HttpServlet {

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

				if (str1==null) str1 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EVAYM","EMPNO","DEPTCD","DEPTNMK","PAYGRD","GRSTRTDT",
																					"LAMDT","WRDT", "GRADE3"
																				};

				int[] intArrCN = new int[]{  6,  7,  4,  50, 4,  8, 
																		 8,  8,  1
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,
																		 -1, -1,  -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					/*
					sql.append( " SELECT                                                                                     ");
					sql.append( "    RTRIM(EVAYM) AS EVAYM,EMPNO,DEPTCD,RTRIM(PAYGRD) AS PAYGRD,RTRIM(GRSTRTDT) AS GRSTRTDT, ");
					sql.append( "    RTRIM(LAMDT) AS LAMDT,RTRIM(WRDT) AS WRDT,TOTAVG                                        ");
					sql.append( "   FROM PAYROLL.HVEMP                                                                       ");
					sql.append( "  WHERE EMPNO = '" + str1 + "'                                                              ");
					sql.append( "	 ORDER BY RTRIM(EVAYM) DESC                                                                ");
					*/
					 
					sql.append( " SELECT RTRIM(A.EVAYM) AS EVAYM, A.EMPNO,A.DEPTCD,                                           \n ");
					sql.append( "        CASE WHEN A.EVAYM <'200801' THEN RTRIM(C.DEPTNMK) ELSE RTRIM(B.DEPTNMK) END DEPTNMK , \n ");
					sql.append( "        RTRIM(A.PAYGRD) AS PAYGRD,  RTRIM(A.GRSTRTDT) AS GRSTRTDT, RTRIM(A.LAMDT) AS LAMDT,RTRIM(A.WRDT) AS WRDT,   \n ");
					/*sql.append( "        CASE WHEN A.AVG1 >=85 THEN '상'  \n ");
					sql.append( "         WHEN  A.AVG1 < 85 AND A.AVG1 >= 75 THEN '중상'  \n ");
					sql.append( "         WHEN  A.AVG1 < 75 AND A.AVG1 >= 65 THEN '중' 		\n ");
					sql.append( "         WHEN  A.AVG1 < 65 AND A.AVG1 >= 55 THEN '중하'  \n ");
					sql.append( "         WHEN  A.AVG1 < 55 AND A.AVG1 > 0 THEN '하' \n ");
					sql.append( "         WHEN  A.AVG1 = 0 THEN '' END AS AVG1, \n ");
					sql.append( "        CASE WHEN A.AVG2 >=85 THEN '상'  \n ");
					sql.append( "         WHEN  A.AVG2 < 85 AND A.AVG2 >= 75 THEN '중상'  \n ");
					sql.append( "         WHEN  A.AVG2 < 75 AND A.AVG2 >= 65 THEN '중'  \n ");
					sql.append( "         WHEN  A.AVG2 < 65 AND A.AVG2 >= 55 THEN '중하'  \n ");
					sql.append( "         WHEN  A.AVG2 < 55 AND A.AVG2 > 0 THEN '하' \n ");
					sql.append( "         WHEN  A.AVG2 = 0  THEN ''  END AS AVG2, \n ");
					sql.append( "        CASE WHEN A.AVG3 >= 85 THEN '상'  \n ");
					sql.append( "        WHEN  A.AVG3 < 85 AND A.AVG3>= 75 THEN '중상'  \n ");
					sql.append( "        WHEN  A.AVG3 < 75 AND A.AVG3 >= 65 THEN '중'  \n ");
					sql.append( "        WHEN  A.AVG3 < 65 AND A.AVG3 >= 55 THEN '중하'  \n ");
					sql.append( "        WHEN  A.AVG3 < 55 AND A.AVG3 > 0 THEN '하' \n ");
					sql.append( "        WHEN  A.AVG3 = 0  THEN ''  END AS AVG3, \n ");
					sql.append( "        CASE WHEN A.TOTAVG >= 85 THEN '상'  \n ");
					sql.append( "        WHEN  A.TOTAVG < 85 AND A.TOTAVG>= 75 THEN '중상'  \n ");
					sql.append( "        WHEN  A.TOTAVG < 75 AND A.TOTAVG >= 65 THEN '중'  \n ");
					sql.append( "        WHEN  A.TOTAVG < 65 AND A.TOTAVG >= 55 THEN '중하'  \n ");
					sql.append( "        WHEN  A.TOTAVG < 55 AND A.TOTAVG > 0 THEN '하' \n ");
					sql.append( "        WHEN  A.TOTAVG = 0 THEN ''  END AS GOGAGB \n "); */
					sql.append( "        GRADE3 \n");
					sql.append( "   FROM PAYROLL.HVEMP A                                                                     \n ");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD \n ");
					sql.append( "   LEFT JOIN PAYROLL.HCDEPT_99 C ON A.DEPTCD = C.DEPTCD \n ");
					sql.append( "  WHERE EMPNO = '" + str1 + "'                                                              \n ");
					sql.append( "  AND A.EVAYM >= '201106'                                                              \n ");
					sql.append( "	 ORDER BY RTRIM(EVAYM) DESC                                                                \n ");
					
				//	logger.dbg.println( this, sql.toString() );
         
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