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
public class h060003_s1 extends HttpServlet {

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
				String  str2= req.getParameter("v_str2");  //부서
				String  str3= req.getParameter("v_str3");  //직위
				String  str4= req.getParameter("v_str4");  //성명
				String  str5= req.getParameter("v_str5");  //level
				String  str6= req.getParameter("v_str6");  //treecd

				if (str1==null ) {str1 ="";}
				if (str2==null ) {str2 ="";}
				if (str3==null ) {str3 ="";}
				if (str4==null ) {str4 ="";}
				if (str5==null ) {str5 ="";}
				if (str6==null ) {str6 ="";}
				
				if (str2.equals("A000")){str2 ="";}  //현대아산 선택시 전체부서조회됨.
				if (str3.equals("0")){str3 ="";}       //직위가 전체일경우
                 
				 
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ "CHK",     "EVAYM",	    "EMPNO",	    "EMPNMK",   "DEPTCD",  "DEPTNM", 
					                                "PAYGRD",  "PAYGRDNM",  "GRSTRTDT",   "STRTDT",   "SEQ1",     "EMPNMK1",   
					                                "SEQ2",     "EMPNMK2",  "SEQ3",       "EMPNMK3",  "SEQ4",    "EMPNMK4",
				                                  "TREECD",  "SEQ",       "PAYSEQ"
				}; 
					                                             
				int[] intArrCN = new int[]{   1,  6,  7, 20,  4,   50, 
					                            4,  30, 8, 8,   7,  20,  
					                            7,  20, 7, 20,  7,  20, 
					                            8,  4,  4
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,  -1,  -1, 
					                           -1, -1, -1, -1,  -1,  -1, 
					                           -1, -1, -1, -1,  -1, -1,
					                           -1, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT X.CHK, X.EVAYM, X.EMPNO, X.EMPNMK, X.DEPTCD, RTRIM(X.DEPTNM) DEPTNM ,X.PAYGRD, X.PAYGRDNM,X.GRSTRTDT,X.STRTDT,\n");
					sql.append( "              RTRIM(MAX(X.SEQ1)) AS SEQ1, MAX(H.EMPNMK)EMPNMK1, MAX(X.SEQ2)SEQ2, MAX(I.EMPNMK)EMPNMK2,  \n");
					sql.append( "              MAX(X.SEQ3)SEQ3, MAX(J.EMPNMK)EMPNMK3, MAX(X.SEQ4)SEQ4, MAX(K.EMPNMK)EMPNMK4, MAX(X.TREECD) TREECD,  \n");
					sql.append( "              MAX(X.SEQ)SEQ, MAX(X.PAYSEQ) PAYSEQ  \n");
					sql.append( "    FROM  \n");
					sql.append( "           ( SELECT 'F' CHK, A.EVAYM, A.EMPNO, C.EMPNMK, A.DEPTCD, D.DEPTNM,  A.PAYGRD, (E.MINORNM) PAYGRDNM,A.GRSTRTDT,A.STRTDT,\n");
					sql.append( "                         CASE B.EVASEQ WHEN 1 THEN B.EMPNOH END AS SEQ1, \n");
					sql.append( "                         CASE B.EVASEQ WHEN 2 THEN B.EMPNOH END AS SEQ2, \n");
					sql.append( "                         CASE B.EVASEQ WHEN 3 THEN B.EMPNOH END AS SEQ3, \n");
					sql.append( "                         CASE B.EVASEQ WHEN 4 THEN B.EMPNOH END AS SEQ4,  \n");
					sql.append( "                         D.TREECD, E.SEQ, C.PAYSEQ   \n");
					sql.append( "               FROM PAYROLL.HVEMP A, PAYROLL.HVHEMP B " );
					sql.append( "                        LEFT JOIN PAYROLL.HIPERSON C ON A.EMPNO  = C.EMPNO   \n");
					sql.append( "                        LEFT JOIN PAYROLL.HCDEPT   D ON A.DEPTCD = D.DEPTCD  \n");
          sql.append( "                        LEFT JOIN PAYROLL.HCLCODE  E ON A.PAYGRD = E.MINORCD AND E.MAJORCD='2002' \n");
					sql.append( "              WHERE A.EVAYM = B.EVAYM       \n");
					sql.append( "                  AND A.EMPNO = B.EMPNO     \n");
          sql.append( "                  AND (C.ENDDT='' OR SUBSTR(C.ENDDT,1,6)> '" + str1 +"') \n" );
          sql.append( "                  AND A.GRSREF='1' \n" );
          sql.append( "              UNION ALL   \n"); 
          sql.append( "               SELECT 'F' CHK, A.EVAYM, A.EMPNO, C.EMPNMK, A.DEPTCD, D.DEPTNM ,A.PAYGRD, (E.MINORNM) PAYGRDNM,A.GRSTRTDT,A.STRTDT,\n");
					sql.append( "                           ''SEQ1,''SEQ2,''SEQ3,''SEQ4, D.TREECD, E.SEQ, C.PAYSEQ \n"); 
					sql.append( "                  FROM PAYROLL.HVEMP A         \n"); 
					sql.append( "                           LEFT JOIN PAYROLL.HIPERSON C ON A.EMPNO  = C.EMPNO         \n"); 
					sql.append( "                           LEFT JOIN PAYROLL.HCDEPT   D ON A.DEPTCD = D.DEPTCD        \n"); 
					sql.append( "                           LEFT JOIN PAYROLL.HCLCODE  E ON A.PAYGRD = E.MINORCD AND E.MAJORCD='2002' \n");
          sql.append( "               WHERE (C.ENDDT='' OR SUBSTR(C.ENDDT,1,6)> '" + str1 +"')  \n");
					sql.append( "                 AND A.GRSREF='1' \n" );
					sql.append( "                    ) X    \n");
					sql.append( "           LEFT JOIN PAYROLL.HIPERSON H ON X.SEQ1  = H.EMPNO    \n");
					sql.append( "           LEFT JOIN PAYROLL.HIPERSON I ON X.SEQ2  = I.EMPNO    \n");
					sql.append( "           LEFT JOIN PAYROLL.HIPERSON J ON X.SEQ3  = J.EMPNO    \n");
					sql.append( "           LEFT JOIN PAYROLL.HIPERSON K ON X.SEQ4  = K.EMPNO    \n");
					sql.append( "  WHERE   X.EVAYM =  '" + str1 +"'    \n");
				//	sql.append( "       AND  X.DEPTCD LIKE '" + str2 +"%'" );
					sql.append( "       AND  X.PAYGRD LIKE '" + str3 +"%'    \n");
					sql.append( "       AND  X.EMPNMK LIKE '" + str4 +"%'    \n");
					 
					if (str5.equals("1")) sql.append( " AND SUBSTR(X.TREECD,1,4) = '"+ str6 + "' \n");
					if (str5.equals("2")) sql.append( " AND SUBSTR(X.TREECD,1,4) = '"+ str6 + "' \n");
					if (str5.equals("3")) sql.append( " AND SUBSTR(X.TREECD,1,6) = '"+ str6 + "' \n");
					if (str5.equals("4")) sql.append( " AND RTRIM(X.TREECD) = '" + str6 + "'     \n");
					sql.append( "  GROUP BY X.CHK, X.EVAYM, X.EMPNO, X.EMPNMK,X.DEPTCD, X.DEPTNM,X.PAYGRD, X.PAYGRDNM,X.GRSTRTDT,X.STRTDT   \n");
  

          //계약직
          sql.append( "  UNION ALL ");

					sql.append( "  SELECT X.CHK, X.EVAYM, X.EMPNO, X.EMPNMK, X.DEPTCD, RTRIM(X.DEPTNM) DEPTNM ,X.PAYGRD, X.PAYGRDNM,X.GRSTRTDT,X.STRTDT,\n");
					sql.append( "              RTRIM(MAX(X.SEQ1)) AS SEQ1, MAX(H.EMPNMK)EMPNMK1, MAX(X.SEQ2)SEQ2, MAX(I.EMPNMK)EMPNMK2,  \n");
					sql.append( "              MAX(X.SEQ3)SEQ3, MAX(J.EMPNMK)EMPNMK3, MAX(X.SEQ4)SEQ4, MAX(K.EMPNMK)EMPNMK4, MAX(X.TREECD) TREECD,  \n");
					sql.append( "              MAX(X.SEQ)SEQ, MAX(X.PAYSEQ) PAYSEQ  \n");
					sql.append( "    FROM  \n");
					sql.append( "           ( SELECT 'F' CHK, A.EVAYM, A.EMPNO, C.EMPNMK, A.DEPTCD, D.DEPTNM,  A.PAYGRD, (E.MINORNM) PAYGRDNM,A.GRSTRTDT,A.STRTDT,\n");
					sql.append( "                         CASE B.EVASEQ WHEN 1 THEN B.EMPNOH END AS SEQ1, \n");
					sql.append( "                         CASE B.EVASEQ WHEN 2 THEN B.EMPNOH END AS SEQ2, \n");
					sql.append( "                         CASE B.EVASEQ WHEN 3 THEN B.EMPNOH END AS SEQ3, \n");
					sql.append( "                         CASE B.EVASEQ WHEN 4 THEN B.EMPNOH END AS SEQ4,  \n");
					sql.append( "                         D.TREECD, E.SEQ, C.PAYSEQ   \n");
					sql.append( "               FROM PAYROLL.HVEMP A, PAYROLL.HVHE
					MP B " );
					sql.append( "                        LEFT JOIN PAYROLL.T_HIPERSON C ON A.EMPNO  = C.EMPNO   \n");
					sql.append( "                        LEFT JOIN PAYROLL.HCDEPT   D ON A.DEPTCD = D.DEPTCD  \n");
          sql.append( "                        LEFT JOIN PAYROLL.HCLCODE  E ON A.PAYGRD = E.MINORCD AND E.MAJORCD='2002' \n");
					sql.append( "              WHERE A.EVAYM = B.EVAYM       \n");
					sql.append( "                  AND A.EMPNO = B.EMPNO     \n");
          sql.append( "                  AND (C.ENDDT='' OR SUBSTR(C.ENDDT,1,6)> '" + str1 +"') \n" );
					sql.append( "                  AND A.GRSREF='2' \n" );
          sql.append( "              UNION ALL   \n"); 
          sql.append( "               SELECT 'F' CHK, A.EVAYM, A.EMPNO, C.EMPNMK, A.DEPTCD, D.DEPTNM ,A.PAYGRD, (E.MINORNM) PAYGRDNM,A.GRSTRTDT,A.STRTDT,\n");
					sql.append( "                           ''SEQ1,''SEQ2,''SEQ3,''SEQ4, D.TREECD, E.SEQ, C.PAYSEQ \n"); 
					sql.append( "                  FROM PAYROLL.HVEMP A         \n"); 
					sql.append( "                           LEFT JOIN PAYROLL.T_HIPERSON C ON A.EMPNO  = C.EMPNO         \n"); 
					sql.append( "                           LEFT JOIN PAYROLL.HCDEPT   D ON A.DEPTCD = D.DEPTCD        \n"); 
					sql.append( "                           LEFT JOIN PAYROLL.HCLCODE  E ON A.PAYGRD = E.MINORCD AND E.MAJORCD='2002' \n");
          sql.append( "              WHERE (C.ENDDT='' OR SUBSTR(C.ENDDT,1,6)> '" + str1 +"')  \n");
					sql.append( "                AND  A.GRSREF='2' \n" );
					sql.append( "                    ) X    \n");
					sql.append( "           LEFT JOIN PAYROLL.HIPERSON H ON X.SEQ1  = H.EMPNO    \n");
					sql.append( "           LEFT JOIN PAYROLL.HIPERSON I ON X.SEQ2  = I.EMPNO    \n");
					sql.append( "           LEFT JOIN PAYROLL.HIPERSON J ON X.SEQ3  = J.EMPNO    \n");
					sql.append( "           LEFT JOIN PAYROLL.HIPERSON K ON X.SEQ4  = K.EMPNO    \n");
					sql.append( "  WHERE   X.EVAYM =  '" + str1 +"'    \n");
				//	sql.append( "       AND  X.DEPTCD LIKE '" + str2 +"%'" );
					sql.append( "       AND  X.PAYGRD LIKE '" + str3 +"%'    \n");
					sql.append( "       AND  X.EMPNMK LIKE '" + str4 +"%'    \n");
					 
					if (str5.equals("1")) sql.append( " AND SUBSTR(X.TREECD,1,4) = '"+ str6 + "' \n");
					if (str5.equals("2")) sql.append( " AND SUBSTR(X.TREECD,1,4) = '"+ str6 + "' \n");
					if (str5.equals("3")) sql.append( " AND SUBSTR(X.TREECD,1,6) = '"+ str6 + "' \n");
					if (str5.equals("4")) sql.append( " AND RTRIM(X.TREECD) = '" + str6 + "'     \n");
					sql.append( "  GROUP BY X.CHK, X.EVAYM, X.EMPNO, X.EMPNMK,X.DEPTCD, X.DEPTNM,X.PAYGRD, X.PAYGRDNM,X.GRSTRTDT ,X.STRTDT  \n");
          sql.append( "  ORDER BY SEQ, PAYSEQ DESC, GRSTRTDT, STRTDT ");
          
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