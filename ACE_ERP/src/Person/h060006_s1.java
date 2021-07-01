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
public class h060006_s1 extends HttpServlet {

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
				
				String[] strArrCN = new String[]{
					
					"CHK",   "EVAYM",	   "EMPNO",	"EMPNMK",   "DEPTCD","DEPTNM",  "PAYGRD","PAYGRDNM", "GRSTRTDT", "STRTDT", 					
					"SEQ1",  "EMPNMK1",  "SEQ2",  "EMPNMK2",  "SEQ3",  "EMPNMK3", "SEQ4",  "EMPNMK4",  "SEQ5",  "EMPNMK5",  
					"SEQ6",  "EMPNMK6",  "SEQ7",  "EMPNMK7",  "SEQ8",  "EMPNMK8", "SEQ9",  "EMPNMK9",  "SEQ10", "EMPNMK10", 
					"SEQ11", "EMPNMK11", "SEQ12", "EMPNMK12", "SEQ13", "EMPNMK13","SEQ14", "EMPNMK14", "SEQ15", "EMPNMK15", 
			    "TREECD",  "SEQ",  "PAYSEQ" 
				}; 


				int[] intArrCN = new int[]{   
					 1,  6,  7, 20,  4, 50,  4,  30,  8,   8,  
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20,        
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20,                 
					 7,  20, 7, 20,  7, 20,  7,  20,  7,  20, 
					 8 ,  4, 4 
				}; 
	 		
				int[] intArrCN2 = new int[]{ 
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
				  -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,                     
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
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
          
          sql.append( " SELECT X.CHK, X.EVAYM, X.EMPNO, X.EMPNMK, X.DEPTCD,                                      \n");
					sql.append( "        RTRIM(X.DEPTNM) DEPTNM , X.PAYGRD, X.PAYGRDNM,X.GRSTRTDT,X.STRTDT,                \n");
					sql.append( "         MAX(X.SEQ1)SEQ1,   MAX(X.EMPNMK1)EMPNMK1,                                        \n");
					sql.append( "         MAX(X.SEQ2)SEQ2,   MAX(X.EMPNMK2)EMPNMK2,                                        \n");
					sql.append( "         MAX(X.SEQ3)SEQ3,   MAX(X.EMPNMK3)EMPNMK3,                                        \n");
					sql.append( "         MAX(X.SEQ4)SEQ4,   MAX(X.EMPNMK4)EMPNMK4,                                        \n");
					sql.append( "         MAX(X.SEQ5)SEQ5,   MAX(X.EMPNMK5)EMPNMK5,                                        \n");
					sql.append( "         MAX(X.SEQ6)SEQ6,   MAX(X.EMPNMK6)EMPNMK6,                                        \n");
					sql.append( "         MAX(X.SEQ7)SEQ7,   MAX(X.EMPNMK7)EMPNMK7,                                        \n");
					sql.append( "         MAX(X.SEQ8)SEQ8,   MAX(X.EMPNMK8)EMPNMK8,                                        \n");
					sql.append( "         MAX(X.SEQ9)SEQ9,   MAX(X.EMPNMK9)EMPNMK9,                                        \n");
					sql.append( "         MAX(X.SEQ10)SEQ10, MAX(X.EMPNMK10)EMPNMK10,                                      \n");
					sql.append( "         MAX(X.SEQ11)SEQ11, MAX(X.EMPNMK11)EMPNMK11,                                      \n");
					sql.append( "         MAX(X.SEQ12)SEQ12, MAX(X.EMPNMK12)EMPNMK12,                                      \n");
					sql.append( "         MAX(X.SEQ13)SEQ13, MAX(X.EMPNMK13)EMPNMK13,                                      \n");
					sql.append( "         MAX(X.SEQ14)SEQ14, MAX(X.EMPNMK14)EMPNMK14,                                      \n");
					sql.append( "         MAX(X.SEQ15)SEQ15, MAX(X.EMPNMK15)EMPNMK15,                                      \n");
					sql.append( "         MAX(X.TREECD) TREECD, MAX(X.SEQ)SEQ, MAX(X.PAYSEQ) PAYSEQ                        \n");
					sql.append( "    FROM(                                                                                 \n");
					sql.append( "         SELECT 'F' CHK,    A.EVAYM,  A.EMPNO, D.EMPNMK, A.DEPTCD,                        \n");
					sql.append( "                 E.DEPTNM,  A.PAYGRD, (F.MINORNM) PAYGRDNM, D.GRSTRTDT, D.STRTDT,         \n");
					sql.append( "                 E.TREECD,  F.SEQ,    D.PAYSEQ,                                           \n");
					sql.append( "             CASE B.EVASEQ WHEN 1  THEN B.EMPNOH END AS SEQ1,                             \n");
					sql.append( "             CASE B.EVASEQ WHEN 2  THEN B.EMPNOH END AS SEQ2,                             \n");
					sql.append( "             CASE B.EVASEQ WHEN 3  THEN B.EMPNOH END AS SEQ3,                             \n");
					sql.append( "             CASE B.EVASEQ WHEN 4  THEN B.EMPNOH END AS SEQ4,                             \n");
					sql.append( "             CASE B.EVASEQ WHEN 5  THEN B.EMPNOH END AS SEQ5,                             \n");
					sql.append( "             CASE B.EVASEQ WHEN 6  THEN B.EMPNOH END AS SEQ6,                             \n");
					sql.append( "             CASE B.EVASEQ WHEN 7  THEN B.EMPNOH END AS SEQ7,                             \n");
					sql.append( "             CASE B.EVASEQ WHEN 8  THEN B.EMPNOH END AS SEQ8,                             \n");
					sql.append( "             CASE B.EVASEQ WHEN 9  THEN B.EMPNOH END AS SEQ9,                             \n");
					sql.append( "             CASE B.EVASEQ WHEN 10 THEN B.EMPNOH END AS SEQ10,                            \n");
					sql.append( "             CASE B.EVASEQ WHEN 11 THEN B.EMPNOH END AS SEQ11,                            \n");
					sql.append( "             CASE B.EVASEQ WHEN 12 THEN B.EMPNOH END AS SEQ12,                            \n");
					sql.append( "             CASE B.EVASEQ WHEN 13 THEN B.EMPNOH END AS SEQ13,                            \n");
					sql.append( "             CASE B.EVASEQ WHEN 14 THEN B.EMPNOH END AS SEQ14,                            \n");
					sql.append( "             CASE B.EVASEQ WHEN 15 THEN B.EMPNOH END AS SEQ15,                            \n");
					sql.append( "             CASE B.EVASEQ WHEN 1  THEN C.EMPNMK END AS EMPNMK1,                          \n");
					sql.append( "             CASE B.EVASEQ WHEN 2  THEN C.EMPNMK END AS EMPNMK2,                          \n");
					sql.append( "             CASE B.EVASEQ WHEN 3  THEN C.EMPNMK END AS EMPNMK3,                          \n");
					sql.append( "             CASE B.EVASEQ WHEN 4  THEN C.EMPNMK END AS EMPNMK4,                          \n");
					sql.append( "             CASE B.EVASEQ WHEN 5  THEN C.EMPNMK END AS EMPNMK5,                          \n");
					sql.append( "             CASE B.EVASEQ WHEN 6  THEN C.EMPNMK END AS EMPNMK6,                          \n");
					sql.append( "             CASE B.EVASEQ WHEN 7  THEN C.EMPNMK END AS EMPNMK7,                          \n");
					sql.append( "             CASE B.EVASEQ WHEN 8  THEN C.EMPNMK END AS EMPNMK8,                          \n");
					sql.append( "             CASE B.EVASEQ WHEN 9  THEN C.EMPNMK END AS EMPNMK9,                          \n");
					sql.append( "             CASE B.EVASEQ WHEN 10 THEN C.EMPNMK END AS EMPNMK10,                         \n");
					sql.append( "             CASE B.EVASEQ WHEN 11 THEN C.EMPNMK END AS EMPNMK11,                         \n");
					sql.append( "             CASE B.EVASEQ WHEN 12 THEN C.EMPNMK END AS EMPNMK12,                         \n");
					sql.append( "             CASE B.EVASEQ WHEN 13 THEN C.EMPNMK END AS EMPNMK13,                         \n");
					sql.append( "             CASE B.EVASEQ WHEN 14 THEN C.EMPNMK END AS EMPNMK14,                         \n");
					sql.append( "             CASE B.EVASEQ WHEN 15 THEN C.EMPNMK END AS EMPNMK15                          \n");
					sql.append( "       FROM PAYROLL.HVEMP_DPT A                                                           \n");
					sql.append( "       LEFT JOIN PAYROLL.HVHEMP_DPT  B ON A.EVAYM = B.EVAYM  AND  A.EMPNO = B.EMPNO       \n");
					sql.append( "       LEFT JOIN PAYROLL.CIPERSON C ON B.EMPNOH = C.EMPNO AND C.USESTS <>'3'  --고과자    \n");
					sql.append( "       LEFT JOIN PAYROLL.CIPERSON D ON A.EMPNO = D.EMPNO  AND D.USESTS <>'3'  --피고과자  \n");
					sql.append( "       LEFT JOIN PAYROLL.HCDEPT   E ON A.DEPTCD = E.DEPTCD                                \n");
					sql.append( "       LEFT JOIN PAYROLL.HCLCODE  F ON A.PAYGRD = F.MINORCD AND F.MAJORCD='2002'          \n");
					sql.append( "   	 WHERE A.EVAYM='" + str1 +"'                                                         \n");
					sql.append( "        AND (D.ENDDT='' OR SUBSTR(D.ENDDT,1,6)> '" + str1 +"')                            \n" ); 
					sql.append( "     )X                                                                                    \n");
					sql.append( " WHERE X.EVAYM =  '" + str1 +"'        \n");
					sql.append( "   AND X.PAYGRD LIKE '" + str3 +"%'    \n");
					  
					if(!str4.equals(""))  sql.append( " AND X.EMPNMK LIKE '" + str4 +"%'    \n");

					if (str5.equals("2")) sql.append( " AND SUBSTR(X.TREECD,1,4) LIKE '"+ str6 + "%' \n");
					if (str5.equals("3")) sql.append( " AND SUBSTR(X.TREECD,1,4) LIKE '"+ str6 + "%' \n");
					if (str5.equals("4")) sql.append( " AND SUBSTR(X.TREECD,1,6) LIKE '"+ str6 + "%' \n");
					if (str5.equals("5")) sql.append( " AND RTRIM(X.TREECD) LIKE '" + str6 + "%'     \n");
					sql.append( " GROUP BY X.CHK, X.EVAYM, X.EMPNO, X.EMPNMK, X.DEPTCD, X.DEPTNM, X.PAYGRD, X.PAYGRDNM,X.GRSTRTDT,X.STRTDT \n");
					sql.append( " ORDER BY SEQ, PAYSEQ DESC, X.GRSTRTDT \n");

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