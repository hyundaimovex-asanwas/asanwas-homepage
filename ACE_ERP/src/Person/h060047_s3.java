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
public class h060047_s3 extends HttpServlet {

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

			String [] str = new String [2];

				str[0]	= req.getParameter("v_str1");		//고과년월
				str[1]	= req.getParameter("v_str2");		//피고과자사번

				for (int s=0;s<=1;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EVAYM",	  "EMPNO",    "EMPNMK", "GRPCD", "DIVCD", "DIVNM",
					                                "JOBGRPH",	"JOBGRPNM", "PRTSEQ", "ASKITEM", "SCR", "GRADE"
																				 }; 

				int[] intArrCN = new int[] {  6,   7,  30,  4,  4,  30,
					                            4,  30,   2,  70, 4,  4
				                           }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,
					                           -1, -1,  0, -1,  2, -1
				                           }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					

					StringBuffer sql = new StringBuffer();


          sql.append( " SELECT X.EVAYM, X.EMPNO, F.EMPNMK, X.GRPCD, X.DIVCD, E.MINORNM AS DIVNM,                       \n ");
					sql.append( "        X.JOBGRPH, C.MINORNM AS JOBGRPNM, X.PRTSEQ, D.ASKITEM,                                  \n ");
					sql.append( "        ROUND(CAST((X.SCR-Z.XSCR-Z.NSCR) AS DECIMAL(10,4))/B.CNT,2) SCR,                        \n ");
					sql.append( "        CASE WHEN (ROUND(CAST((X.SCR-Z.XSCR-Z.NSCR) AS DECIMAL(10,4))/B.CNT,2))>=8.5 THEN 'S'   \n ");
					sql.append( "             WHEN (ROUND(CAST((X.SCR-Z.XSCR-Z.NSCR) AS DECIMAL(10,4))/B.CNT,2))>=7.5 THEN 'A'   \n ");
					sql.append( "             WHEN (ROUND(CAST((X.SCR-Z.XSCR-Z.NSCR) AS DECIMAL(10,4))/B.CNT,2))>=6.5 THEN 'B'   \n ");
					sql.append( "             WHEN (ROUND(CAST((X.SCR-Z.XSCR-Z.NSCR) AS DECIMAL(10,4))/B.CNT,2))>=5.5 THEN 'C'   \n ");
					sql.append( "             ELSE 'D' END GRADE                                                                 \n ");
					sql.append( "   FROM(                                                                                        \n ");
					sql.append( "         SELECT A.EVAYM, A.EMPNO, A.GRPCD, A.DIVCD, A.JOBGRPH, A.PRTSEQ, SUM(A.SCR) SCR         \n ");
					sql.append( "           FROM PAYROLL.HVSCORES A                                                              \n ");
					sql.append( "           LEFT JOIN ( SELECT EVAYM, EMPNO, PRTSEQ, MAX(SCR)XSCR,  MIN(SCR)NSCR                 \n ");
					sql.append( "                         FROM PAYROLL.HVSCORES                                                  \n ");
					if(!str[0].equals(""))sql.append( "  WHERE EVAYM ='"+str[0]+"'                                               \n ");
					if(!str[1].equals(""))sql.append( "    AND EMPNO ='"+str[1]+"'                                               \n ");
					sql.append( "                        GROUP BY EVAYM, EMPNO, PRTSEQ                                           \n ");
					sql.append( "                        ORDER BY EMPNO, PRTSEQ                                                  \n ");
					sql.append( "                     ) Z ON Z.EVAYM =A.EVAYM AND Z.EMPNO = A.EMPNO AND A.PRTSEQ = Z.PRTSEQ      \n ");
					if(!str[0].equals(""))sql.append( "  WHERE A.EVAYM ='"+str[0]+"'                                             \n ");
					if(!str[1].equals(""))sql.append( "    AND A.EMPNO ='"+str[1]+"'                                             \n ");
					sql.append( "          GROUP BY A.EVAYM, A.EMPNO, A.GRPCD, A.DIVCD, A.JOBGRPH, A.PRTSEQ                      \n ");
					sql.append( "       )X                                                                                       \n ");
					sql.append( "   LEFT JOIN ( SELECT EVAYM, EMPNO, PRTSEQ, MAX(SCR)XSCR,  MIN(SCR)NSCR                         \n ");
					sql.append( "                 FROM PAYROLL.HVSCORES                                                          \n ");
					if(!str[0].equals(""))sql.append( "  WHERE EVAYM='"+str[0]+"'                                                \n ");
					if(!str[1].equals(""))sql.append( "    AND EMPNO ='"+str[1]+"'                                               \n ");
					sql.append( "                GROUP BY EVAYM, EMPNO, PRTSEQ                                                   \n ");
					sql.append( "                ORDER BY EMPNO, PRTSEQ                                                          \n ");
					sql.append( "               ) Z ON Z.EVAYM =X.EVAYM AND Z.EMPNO = X.EMPNO AND X.PRTSEQ = Z.PRTSEQ            \n ");
					sql.append( "   LEFT JOIN ( SELECT X.EMPNO, COALESCE(COUNT(X.EMPNO),0)-2 AS  CNT                             \n "); //최고, 최저 제외함.
					sql.append( "                 FROM ( SELECT EMPNO, COUNT(EVASEQ)                                             \n ");
					sql.append( "                          FROM PAYROLL.HVSCORES                                                 \n ");
					if(!str[0].equals(""))sql.append( "   WHERE EVAYM ='"+str[0]+"'                                              \n ");
					if(!str[1].equals(""))sql.append( "     AND EMPNO ='"+str[1]+"'                                              \n ");
					sql.append( "                         GROUP BY EMPNO, EVASEQ                                                 \n ");
					sql.append( "                      )X                                                                        \n ");
					sql.append( "                GROUP BY EMPNO                                                                  \n ");
					sql.append( "              ) B ON B.EMPNO = X.EMPNO                                                          \n ");
					sql.append( "                                                                                                \n ");
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE E ON X.DIVCD = E.MINORCD    AND E.MAJORCD='2015'                   \n ");
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE C ON X.JOBGRPH = C.MINORCD  AND C.MAJORCD='2016'                   \n ");
					sql.append( "   LEFT JOIN PAYROLL.HVSHEET D ON X.EVAYM= D.EVAYM                                              \n ");
					sql.append( "                              AND X.GRPCD= D.GRPCD                                              \n ");
					sql.append( "                              AND X.DIVCD= D.DIVCD                                              \n ");
					sql.append( "                              AND X.JOBGRPH = D.JOBGRPH                                         \n ");
					sql.append( "                              AND X.PRTSEQ = D.PRTSEQ                                           \n ");
					sql.append( "   LEFT JOIN PAYROLL.YIPERSON F ON X.EMPNO = F.EMPNO                                            \n ");
					sql.append( " ORDER BY X.EMPNO, X.PRTSEQ                                                                     \n ");





          /*

					sql.append( " SELECT A.EVAYM,   A.EMPNO,  F.EMPNMK,    A.GRPCD,  A.DIVCD, E.MINORNM AS DIVNM,          \n ");
					sql.append( "        A.JOBGRPH, C.MINORNM AS JOBGRPNM, A.PRTSEQ, D.ASKITEM,                            \n ");
					sql.append( "        ROUND(CAST(SUM(A.SCR) AS DECIMAL(10,4))/B.CNT,2) AS SCR,                          \n ");
          sql.append( "        CASE WHEN ROUND(CAST(SUM(A.SCR) AS DECIMAL(10,4))/B.CNT,2)>=8.5 THEN 'S' \n ");
					sql.append( "             WHEN ROUND(CAST(SUM(A.SCR) AS DECIMAL(10,4))/B.CNT,2)>=7.5 THEN 'A' \n ");
					sql.append( "             WHEN ROUND(CAST(SUM(A.SCR) AS DECIMAL(10,4))/B.CNT,2)>=6.5 THEN 'B' \n ");
					sql.append( "             WHEN ROUND(CAST(SUM(A.SCR) AS DECIMAL(10,4))/B.CNT,2)>=5.5 THEN 'C' \n ");
					sql.append( "             ELSE 'D' END GRADE \n ");
					sql.append( "   FROM PAYROLL.HVSCORES A                                                                \n ");
					sql.append( "   LEFT JOIN ( SELECT X.EMPNO, COALESCE(COUNT(X.EMPNO),0) AS  CNT                         \n ");
					sql.append( "                 FROM ( SELECT EMPNO, COUNT(EVASEQ)                                       \n ");
					sql.append( "                          FROM PAYROLL.HVSCORES                                           \n ");
					if(!str[0].equals(""))sql.append( "   WHERE EVAYM ='"+str[0]+"'                                        \n ");
					if(!str[1].equals(""))sql.append( "     AND EMPNO ='"+str[1]+"'                                        \n ");
					sql.append( "                         GROUP BY EMPNO, EVASEQ                                           \n ");
					sql.append( "                      )X                                                                  \n ");
					sql.append( "                GROUP BY EMPNO                                                            \n ");
					sql.append( "             ) B ON B.EMPNO = A.EMPNO                                                     \n ");
					sql.append( "    LEFT JOIN PAYROLL.HCLCODE E ON A.DIVCD = E.MINORCD    AND E.MAJORCD='2015'            \n ");
					sql.append( "    LEFT JOIN PAYROLL.HCLCODE C ON A.JOBGRPH = C.MINORCD    AND C.MAJORCD='2016'          \n ");
					sql.append( "    LEFT JOIN PAYROLL.HVSHEET D ON A.EVAYM= D.EVAYM                                       \n ");
					sql.append( "                               AND A.GRPCD= D.GRPCD                                       \n ");
					sql.append( "                               AND A.DIVCD= D.DIVCD                                       \n ");
					sql.append( "                               AND A.JOBGRPH = D.JOBGRPH                                  \n ");
					sql.append( "                               AND A.PRTSEQ = D.PRTSEQ                                    \n ");
					sql.append( "    LEFT JOIN PAYROLL.YIPERSON F ON A.EMPNO = F.EMPNO                                     \n ");
					if(!str[0].equals(""))sql.append( "  WHERE A.EVAYM ='"+str[0]+"'                                       \n ");
					if(!str[1].equals(""))sql.append( "    AND A.EMPNO ='"+str[1]+"'                                       \n ");
					sql.append( "  GROUP BY A.EVAYM, A.EMPNO, F.EMPNMK, A.GRPCD, A.DIVCD, A.JOBGRPH, A.PRTSEQ, B.CNT, E.MINORNM, C.MINORNM,  D.ASKITEM \n ");
					sql.append( "  ORDER BY A.PRTSEQ \n ");

					*/
					
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