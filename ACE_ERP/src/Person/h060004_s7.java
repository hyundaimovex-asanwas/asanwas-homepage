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
public class h060004_s7 extends HttpServlet {

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
				String  str1= req.getParameter("v_str1");  //고과년월
				String  str2= req.getParameter("v_str2");  //고과자사번
				String  str3= req.getParameter("v_str3");  //피고과자명
				String  str4= req.getParameter("v_str4");  //1정규직 , 2.계약직, 3부서장
				
				if (str1==null ) {str1 ="";}
				if (str2==null ) {str2 ="";}
				if (str3==null ) {str3 ="";}
				if (str4==null ) {str4 ="";}
				if (str4=="" ) {str4 ="1";}
                 
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ "EVAYM",     "EMPNO",	      "EMPNMK",	  "DEPTCD",  "DEPTNM", 
					                                "PAYGRD",    "PAYGRDNM",    "TOTAVG",    "EVASEQ" ,
					                                "GRPCD" ,    "GRPNM" ,      "JOBGRPH",   "SCR",    "AVGSCR", "ASSES"}; 
					                                             
				int[] intArrCN = new int[]{   6,  7,  20, 4,  70, 
					                            4,  30, 5,  1,
					                            4,  30, 4,  5,  5, 6}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,  -1, 
					                           -1, -1,  2,  0,
					                           -1, -1, -1,  2,   2, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn(new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
				
					if(str4.equals("3")){ //부서장

               sql.append( "  SELECT A.EVAYM, A.EMPNO, K.EMPNMK, A.DEPTCD,D.DEPTNM,                                                       \n");
							 sql.append( "         A.PAYGRD, E.MINORNM AS PAYGRDNM, IFNULL(A.TOTAVG,0)TOTAVG, B.EVASEQ ,                                \n");
							 sql.append( "         F.MINORCD AS GRPCD, F.MINORNM AS GRPNM, A.JOBREF JOBGRPH , COALESCE(X.SCR,0) SCR,                    \n");
							 sql.append( "         CASE WHEN B.EVASEQ = 1 THEN COALESCE(A.AVG1,0)                                                       \n");
							 sql.append( "              WHEN B.EVASEQ = 2 THEN COALESCE(A.AVG2,0)                                                       \n");
							 sql.append( "              WHEN B.EVASEQ = 3 THEN COALESCE(A.AVG3,0)                                                       \n");
							 sql.append( "              WHEN B.EVASEQ = 4 THEN COALESCE(A.AVG4,0)                                                       \n");
							 sql.append( "              WHEN B.EVASEQ = 5 THEN COALESCE(A.AVG5,0)                                                       \n");
							 sql.append( "              WHEN B.EVASEQ = 6 THEN COALESCE(A.AVG6,0)                                                       \n");
							 sql.append( "              WHEN B.EVASEQ = 7 THEN COALESCE(A.AVG7,0)                                                       \n");
							 sql.append( "              WHEN B.EVASEQ = 8 THEN COALESCE(A.AVG8,0)                                                       \n");
							 sql.append( "              WHEN B.EVASEQ = 9 THEN COALESCE(A.AVG9,0)                                                       \n");
							 sql.append( "              WHEN B.EVASEQ = 10 THEN COALESCE(A.AVG10,0)                                                      \n");
							 sql.append( "              WHEN B.EVASEQ = 11 THEN COALESCE(A.AVG11,0)                                                      \n");
							 sql.append( "              WHEN B.EVASEQ = 12 THEN COALESCE(A.AVG12,0)                                                      \n");
							 sql.append( "              WHEN B.EVASEQ = 13 THEN COALESCE(A.AVG13,0)                                                      \n");
							 sql.append( "              WHEN B.EVASEQ = 14 THEN COALESCE(A.AVG14,0)                                                      \n");
							 sql.append( "              WHEN B.EVASEQ = 15 THEN COALESCE(A.AVG15,0) END AVGSCR,                                          \n");
							 sql.append( "         '' ASSES --, E.SEQ SEQ, K.PAYSEQ , K.GRSTRTDT                                                        \n");
							 sql.append( "   FROM PAYROLL.HVEMP_DPT A, PAYROLL.HVHEMP_DPT B                                                             \n");
							 sql.append( "   LEFT JOIN PAYROLL.HIPERSON K ON A.EMPNO = K.EMPNO                                                          \n");
							 sql.append( "   LEFT JOIN PAYROLL.HCDEPT D   ON A.DEPTCD = D.DEPTCD  AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n");
							 sql.append( "   LEFT JOIN PAYROLL.HCLCODE E  ON A.PAYGRD = E.MINORCD AND E.MAJORCD='2002'                                  \n");
							 sql.append( "   LEFT JOIN PAYROLL.HCLCODE F  ON F.MINORCD ='4'  AND F.MAJORCD='2014'                                       \n");
							 sql.append( "   LEFT JOIN (SELECT G.EVAYM,G.EMPNOH, G.EMPNO,G.EVASEQ,G.GRPCD, SUM(G.SCR) SCR                               \n");
							 sql.append( "                FROM PAYROLL.HVSCORE_DPT G                                                                    \n");
							 sql.append( "               WHERE G.EVAYM ='" + str1 +"'                                                                   \n");
							 sql.append( "                 AND G.EMPNOH = '" + str2 +"'                                                                 \n");
							 sql.append( "               GROUP BY G.EVAYM,G.EMPNOH, G.EMPNO,G.EVASEQ, G.GRPCD                                           \n");
							 sql.append( "              ) X  ON A.EVAYM = X.EVAYM                                                                       \n");
							 sql.append( "                  AND A.EMPNO = X.EMPNO                                                                       \n");
							 sql.append( "                  AND X.EMPNOH = '" + str2 +"'                                                                \n");
							 sql.append( "                  AND X.EVASEQ = B.EVASEQ                                                                     \n");
							 sql.append( "                  AND X.GRPCD = F.MINORCD                                                                     \n");
							 sql.append( "  WHERE A.EVAYM = B.EVAYM                                                                                     \n");
							 sql.append( "    AND A.EMPNO = B.EMPNO                                                                                     \n");
							 sql.append( "    AND A.DEPREF ='2'                                                                                         \n");
							 sql.append( "    AND A.EVAYM = '" + str1 +"'                                                                               \n");
							 sql.append( "    AND B.EMPNOH= '" + str2 +"'                                                                               \n");
							 sql.append( "  ORDER BY E.SEQ, INTEGER(K.PAYSEQ), K.GRSTRTDT                                                               \n");					 
					}
        
				// logger.dbg.println(this,sql.toString());
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