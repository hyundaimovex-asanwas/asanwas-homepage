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
public class h060014_s1 extends HttpServlet {

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
				String  str4= req.getParameter("v_str4");  //1정규직 , 2.계약직
				
				if (str1==null ) {str1 ="";}
				if (str2==null ) {str2 ="";}
				if (str3==null ) {str3 ="";}
				if (str4==null ) {str4 ="";}
				if (str4=="" ) {str4 ="1";}
                 
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ "EVAYM",     "EMPNO",	      "EMPNMK",	  "DEPTCD",  "DEPTNM", 
					                                "PAYGRD",    "PAYGRDNM",    "TOTAVG",    "EVASEQ" ,
					                                "GRPCD" ,    "GRPNM" ,      "JOBGRPH",   "SCR",    "AVGSCR" ,"ASSES"    }; 
					                                             
				int[] intArrCN = new int[]{   6,  7,  20, 4,  70, 
					                            4,  30, 5,  2,
					                            4,  30, 4,  5,  5, 10    }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,  -1, 
					                           -1, -1,  2,  0,
					                           -1, -1, -1,  2,   2, -1     }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
				
					if(str4.equals("2")){
					
							 sql.append( "  SELECT A.EVAYM, A.EMPNO,C.EMPNMK, A.DEPTCD,D.DEPTNM,                                                    \n");
							 sql.append( "         A.PAYGRD, E.MINORNM AS PAYGRDNM, A.TOTAVG, B.EVASEQ ,                                            \n"); 
                             sql.append( "         F.MINORCD AS GRPCD, F.MINORNM AS GRPNM, A.JOBREF JOBGRPH , COALESCE(X.SCR,0) SCR, '' ASSES,               \n");
							 sql.append( "    CASE WHEN B.EVASEQ = 1 THEN COALESCE(A.AVG1,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 2 THEN COALESCE(A.AVG2,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 3 THEN COALESCE(A.AVG3,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 4 THEN COALESCE(A.AVG4,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 5 THEN COALESCE(A.AVG5,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 6 THEN COALESCE(A.AVG6,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 7 THEN COALESCE(A.AVG7,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 8 THEN COALESCE(A.AVG8,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 9 THEN COALESCE(A.AVG9,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 10 THEN COALESCE(A.AVG10,0)                                                        \n"); 
                         	 sql.append( "         WHEN B.EVASEQ = 11 THEN COALESCE(A.AVG11,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 12 THEN COALESCE(A.AVG12,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 13 THEN COALESCE(A.AVG13,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 14 THEN COALESCE(A.AVG14,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 15 THEN COALESCE(A.AVG15,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 16 THEN COALESCE(A.AVG16,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 17 THEN COALESCE(A.AVG17,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 18 THEN COALESCE(A.AVG18,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 19 THEN COALESCE(A.AVG19,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 20 THEN COALESCE(A.AVG20,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 21 THEN COALESCE(A.AVG21,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 22 THEN COALESCE(A.AVG22,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 23 THEN COALESCE(A.AVG23,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 24 THEN COALESCE(A.AVG24,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 25 THEN COALESCE(A.AVG25,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 26 THEN COALESCE(A.AVG26,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 27 THEN COALESCE(A.AVG27,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 28 THEN COALESCE(A.AVG28,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 29 THEN COALESCE(A.AVG29,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 30 THEN COALESCE(A.AVG30,0)                                                        \n"); 
                        	 sql.append( "         WHEN B.EVASEQ = 31 THEN COALESCE(A.AVG31,0)                                                       \n");
							 sql.append( "         WHEN B.EVASEQ = 32 THEN COALESCE(A.AVG32,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 33 THEN COALESCE(A.AVG33,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 34 THEN COALESCE(A.AVG34,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 35 THEN COALESCE(A.AVG35,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 36 THEN COALESCE(A.AVG36,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 37 THEN COALESCE(A.AVG37,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 38 THEN COALESCE(A.AVG38,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 39 THEN COALESCE(A.AVG39,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 40 THEN COALESCE(A.AVG40,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 41 THEN COALESCE(A.AVG41,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 42 THEN COALESCE(A.AVG42,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 43 THEN COALESCE(A.AVG43,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 44 THEN COALESCE(A.AVG44,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 45 THEN COALESCE(A.AVG45,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 46 THEN COALESCE(A.AVG46,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 47 THEN COALESCE(A.AVG47,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 48 THEN COALESCE(A.AVG48,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 49 THEN COALESCE(A.AVG49,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 50 THEN COALESCE(A.AVG50,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 51 THEN COALESCE(A.AVG51,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 52 THEN COALESCE(A.AVG52,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 53 THEN COALESCE(A.AVG53,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 54 THEN COALESCE(A.AVG54,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 55 THEN COALESCE(A.AVG55,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 56 THEN COALESCE(A.AVG56,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 57 THEN COALESCE(A.AVG57,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 58 THEN COALESCE(A.AVG58,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 59 THEN COALESCE(A.AVG59,0)                                                        \n"); 
                  			 sql.append( "         WHEN B.EVASEQ = 60 THEN COALESCE(A.AVG60,0)    END AVGSCR,                                       \n");
	    
			  	 	         sql.append( "        E.SEQ SEQ, C.PAYSEQ PAYSEQ , C.GRSTRTDT GRSTRTDT                                                \n");
				  
							 sql.append( "    FROM PAYROLL.HVEMPS A, PAYROLL.HVHEMPS B                                                                \n");
							 sql.append( "    LEFT JOIN PAYROLL.T_HIPERSON C ON A.EMPNO = C.EMPNO                                                   \n");
							 sql.append( "    LEFT JOIN PAYROLL.HCDEPT D   ON A.DEPTCD = D.DEPTCD                                                   \n");
							 sql.append( "    LEFT JOIN PAYROLL.HCLCODE E  ON A.PAYGRD = E.MINORCD AND E.MAJORCD='2002'                             \n"); 
                             sql.append( "    LEFT JOIN PAYROLL.HCLCODE F  ON E.MEMO = F.MEMO AND F.MAJORCD='2014'                                  \n");
							 sql.append( "    LEFT JOIN (SELECT G.EVAYM,G.EMPNOH, G.EMPNO,G.EVASEQ,G.GRPCD, SUM(G.SCR) SCR                          \n");
							 sql.append( "                       FROM PAYROLL.HVSCORES G                                                             \n");
							 sql.append( "                      WHERE G.EVAYM ='" + str1 +"'                                                        \n"); 
                             sql.append( "                        AND G.EMPNOH = '" + str2 +"'                                                      \n");
							 sql.append( "                      GROUP BY G.EVAYM,G.EMPNOH, G.EMPNO,G.EVASEQ, G.GRPCD) X                             \n");
							 sql.append( "                           ON A.EVAYM = X.EVAYM                                                           \n");
							 sql.append( "                         AND A.EMPNO = X.EMPNO                                                            \n"); 
                             sql.append( "                         AND X.EMPNOH = '" + str2 +"'                                                     \n");
							 sql.append( "                         AND X.EVASEQ = B.EVASEQ                                                          \n");
						//	 sql.append( "                         AND X.GRPCD = F.MINORCD                                                          \n");
							 sql.append( "  WHERE A.EVAYM = B.EVAYM                                                                                 \n"); 
                             sql.append( "      AND A.EMPNO = B.EMPNO                                                                               \n");
						     sql.append( "      AND A.DEPREF ='1'                                                                                   \n");
							 sql.append( "      AND A.EVAYM = '" + str1 +"'                                                                         \n");
							 sql.append( "      AND B.EMPNOH= '" + str2 +"'                                                                         \n"); 
                    if (!str4.equals("")) sql.append( " AND  A.GRSREF = '"+ str4 + "' \n");
							 sql.append( "      AND A.EMPNO NOT IN ('6050004','6050005','6050006','6050007','606000')                                        \n");
							 sql.append( "  ORDER BY E.SEQ, C.PAYSEQ DESC, C.GRSTRTDT                                                               \n");

					}else{

                            sql.append( "  SELECT A.EVAYM, A.EMPNO,C.EMPNMK, A.DEPTCD,D.DEPTNM,                                                         \n");
 							sql.append( "           A.PAYGRD, E.MINORNM AS PAYGRDNM, A.TOTAVG, B.EVASEQ ,                                               \n");
							sql.append( "           F.MINORCD AS GRPCD, F.MINORNM AS GRPNM, A.JOBREF JOBGRPH , COALESCE(X.SCR,0) SCR, '' ASSES,                  \n");
									 sql.append( "    CASE WHEN B.EVASEQ = 1 THEN COALESCE(A.AVG1,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 2 THEN COALESCE(A.AVG2,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 3 THEN COALESCE(A.AVG3,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 4 THEN COALESCE(A.AVG4,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 5 THEN COALESCE(A.AVG5,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 6 THEN COALESCE(A.AVG6,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 7 THEN COALESCE(A.AVG7,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 8 THEN COALESCE(A.AVG8,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 9 THEN COALESCE(A.AVG9,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 10 THEN COALESCE(A.AVG10,0)                                                        \n"); 
                         	 sql.append( "         WHEN B.EVASEQ = 11 THEN COALESCE(A.AVG11,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 12 THEN COALESCE(A.AVG12,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 13 THEN COALESCE(A.AVG13,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 14 THEN COALESCE(A.AVG14,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 15 THEN COALESCE(A.AVG15,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 16 THEN COALESCE(A.AVG16,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 17 THEN COALESCE(A.AVG17,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 18 THEN COALESCE(A.AVG18,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 19 THEN COALESCE(A.AVG19,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 20 THEN COALESCE(A.AVG20,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 21 THEN COALESCE(A.AVG21,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 22 THEN COALESCE(A.AVG22,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 23 THEN COALESCE(A.AVG23,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 24 THEN COALESCE(A.AVG24,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 25 THEN COALESCE(A.AVG25,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 26 THEN COALESCE(A.AVG26,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 27 THEN COALESCE(A.AVG27,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 28 THEN COALESCE(A.AVG28,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 29 THEN COALESCE(A.AVG29,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 30 THEN COALESCE(A.AVG30,0)                                                          \n"); 
                            sql.append( "         WHEN B.EVASEQ = 31 THEN COALESCE(A.AVG31,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 32 THEN COALESCE(A.AVG32,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 33 THEN COALESCE(A.AVG33,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 34 THEN COALESCE(A.AVG34,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 35 THEN COALESCE(A.AVG35,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 36 THEN COALESCE(A.AVG36,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 37 THEN COALESCE(A.AVG37,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 38 THEN COALESCE(A.AVG38,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 39 THEN COALESCE(A.AVG39,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 40 THEN COALESCE(A.AVG40,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 41 THEN COALESCE(A.AVG41,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 42 THEN COALESCE(A.AVG42,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 43 THEN COALESCE(A.AVG43,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 44 THEN COALESCE(A.AVG44,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 45 THEN COALESCE(A.AVG45,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 46 THEN COALESCE(A.AVG46,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 47 THEN COALESCE(A.AVG47,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 48 THEN COALESCE(A.AVG48,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 49 THEN COALESCE(A.AVG49,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 50 THEN COALESCE(A.AVG50,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 51 THEN COALESCE(A.AVG51,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 52 THEN COALESCE(A.AVG52,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 53 THEN COALESCE(A.AVG53,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 54 THEN COALESCE(A.AVG54,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 55 THEN COALESCE(A.AVG55,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 56 THEN COALESCE(A.AVG56,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 57 THEN COALESCE(A.AVG57,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 58 THEN COALESCE(A.AVG58,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 59 THEN COALESCE(A.AVG59,0)                                                        \n"); 
                  			 sql.append( "         WHEN B.EVASEQ = 60 THEN COALESCE(A.AVG60,0)    END AVGSCR ,                                       \n");
		    			 	sql.append( "             E.SEQ SEQ, C.PAYSEQ PAYSEQ , C.GRSTRTDT GRSTRTDT                                                \n");
							sql.append( "      FROM PAYROLL.HVEMPS A, PAYROLL.HVHEMPS B                                                                   \n");
							sql.append( "      LEFT JOIN PAYROLL.HIPERSON C ON A.EMPNO = C.EMPNO                                                        \n");
							sql.append( "      LEFT JOIN PAYROLL.HCDEPT D   ON A.DEPTCD = D.DEPTCD                                                      \n");
							sql.append( "      LEFT JOIN PAYROLL.HCLCODE E  ON A.PAYGRD = E.MINORCD AND E.MAJORCD='2002'                                \n");
							sql.append( "      LEFT JOIN PAYROLL.HCLCODE F  ON E.MEMO = F.MEMO AND F.MAJORCD='2014'                                     \n");
							sql.append( "      LEFT JOIN (SELECT G.EVAYM,G.EMPNOH, G.EMPNO,G.EVASEQ,G.GRPCD, SUM(G.SCR) SCR                             \n");
							sql.append( "                         FROM PAYROLL.HVSCORES G                                                                \n");
							sql.append( "                        WHERE G.EVAYM ='" + str1 +"'                                                           \n");
							sql.append( "                          AND G.EMPNOH = '" + str2 +"'                                                         \n");
							sql.append( "                        GROUP BY G.EVAYM,G.EMPNOH, G.EMPNO,G.EVASEQ, G.GRPCD) X                                \n");
							sql.append( "                             ON A.EVAYM = X.EVAYM                                                              \n");
							sql.append( "                           AND A.EMPNO = X.EMPNO                                                               \n");
							sql.append( "                           AND X.EMPNOH = '" + str2 +"'                                                        \n");
							sql.append( "                           AND X.EVASEQ = B.EVASEQ                                                             \n");
						//	sql.append( "                           AND X.GRPCD = F.MINORCD                                                             \n");
							sql.append( "    WHERE A.EVAYM = B.EVAYM                                                                                    \n");
							sql.append( "        AND A.EMPNO = B.EMPNO                                                                                  \n");
						 	sql.append( "        AND A.DEPREF ='1'                                                                                      \n");
							sql.append( "        AND A.EVAYM = '" + str1 +"'                                                                            \n");
							sql.append( "        AND B.EMPNOH= '" + str2 +"'                                                                            \n");
							 if (!str4.equals("")) sql.append( " AND  A.GRSREF = '"+ str4 + "' \n");
						
							sql.append( "    UNION ALL                                                                                                  \n");
							sql.append( "    SELECT A.EVAYM, A.EMPNO,C.EMPNMK, A.DEPTCD,D.DEPTNM,                                                       \n");
							sql.append( "           A.PAYGRD, E.MINORNM AS PAYGRDNM, A.TOTAVG, B.EVASEQ ,                                               \n");
							sql.append( "           F.MINORCD AS GRPCD, F.MINORNM AS GRPNM, A.JOBREF JOBGRPH , COALESCE(X.SCR,0) SCR, '' ASSES,                  \n");
							 sql.append( "    CASE WHEN B.EVASEQ = 1 THEN COALESCE(A.AVG1,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 2 THEN COALESCE(A.AVG2,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 3 THEN COALESCE(A.AVG3,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 4 THEN COALESCE(A.AVG4,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 5 THEN COALESCE(A.AVG5,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 6 THEN COALESCE(A.AVG6,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 7 THEN COALESCE(A.AVG7,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 8 THEN COALESCE(A.AVG8,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 9 THEN COALESCE(A.AVG9,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 10 THEN COALESCE(A.AVG10,0)                                                        \n"); 
                         	 sql.append( "         WHEN B.EVASEQ = 11 THEN COALESCE(A.AVG11,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 12 THEN COALESCE(A.AVG12,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 13 THEN COALESCE(A.AVG13,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 14 THEN COALESCE(A.AVG14,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 15 THEN COALESCE(A.AVG15,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 16 THEN COALESCE(A.AVG16,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 17 THEN COALESCE(A.AVG17,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 18 THEN COALESCE(A.AVG18,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 19 THEN COALESCE(A.AVG19,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 20 THEN COALESCE(A.AVG20,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 21 THEN COALESCE(A.AVG21,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 22 THEN COALESCE(A.AVG22,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 23 THEN COALESCE(A.AVG23,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 24 THEN COALESCE(A.AVG24,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 25 THEN COALESCE(A.AVG25,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 26 THEN COALESCE(A.AVG26,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 27 THEN COALESCE(A.AVG27,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 28 THEN COALESCE(A.AVG28,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 29 THEN COALESCE(A.AVG29,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 30 THEN COALESCE(A.AVG30,0)                                                          \n"); 
                          	 sql.append( "         WHEN B.EVASEQ = 31 THEN COALESCE(A.AVG31,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 32 THEN COALESCE(A.AVG32,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 33 THEN COALESCE(A.AVG33,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 34 THEN COALESCE(A.AVG34,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 35 THEN COALESCE(A.AVG35,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 36 THEN COALESCE(A.AVG36,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 37 THEN COALESCE(A.AVG37,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 38 THEN COALESCE(A.AVG38,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 39 THEN COALESCE(A.AVG39,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 40 THEN COALESCE(A.AVG40,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 41 THEN COALESCE(A.AVG41,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 42 THEN COALESCE(A.AVG42,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 43 THEN COALESCE(A.AVG43,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 44 THEN COALESCE(A.AVG44,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 45 THEN COALESCE(A.AVG45,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 46 THEN COALESCE(A.AVG46,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 47 THEN COALESCE(A.AVG47,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 48 THEN COALESCE(A.AVG48,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 49 THEN COALESCE(A.AVG49,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 50 THEN COALESCE(A.AVG50,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 51 THEN COALESCE(A.AVG51,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 52 THEN COALESCE(A.AVG52,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 53 THEN COALESCE(A.AVG53,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 54 THEN COALESCE(A.AVG54,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 55 THEN COALESCE(A.AVG55,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 56 THEN COALESCE(A.AVG56,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 57 THEN COALESCE(A.AVG57,0)                                                        \n"); 
                             sql.append( "         WHEN B.EVASEQ = 58 THEN COALESCE(A.AVG58,0)                                                        \n");
							 sql.append( "         WHEN B.EVASEQ = 59 THEN COALESCE(A.AVG59,0)                                                        \n"); 
                  			 sql.append( "         WHEN B.EVASEQ = 60 THEN COALESCE(A.AVG60,0)     END AVGSCR,  						            	 \n");
						   	sql.append( "             E.SEQ SEQ, C.PAYSEQ PAYSEQ , C.GRSTRTDT GRSTRTDT                                                \n");
							sql.append( "      FROM PAYROLL.HVEMPS A, PAYROLL.HVHEMPS B                                                                   \n");
							sql.append( "      LEFT JOIN PAYROLL.T_HIPERSON C ON A.EMPNO = C.EMPNO                                                      \n");
							sql.append( "      LEFT JOIN PAYROLL.HCDEPT D   ON A.DEPTCD = D.DEPTCD                                                      \n");
							sql.append( "      LEFT JOIN PAYROLL.HCLCODE E  ON A.PAYGRD = E.MINORCD AND E.MAJORCD='2002'                                \n");
							sql.append( "      LEFT JOIN PAYROLL.HCLCODE F  ON E.MEMO = F.MEMO AND F.MAJORCD='2014'                                     \n");
							sql.append( "      LEFT JOIN (SELECT G.EVAYM,G.EMPNOH, G.EMPNO,G.EVASEQ,G.GRPCD, SUM(G.SCR) SCR                             \n");
							sql.append( "                         FROM PAYROLL.HVSCORES G                                                                \n");
							sql.append( "                        WHERE G.EVAYM ='" + str1 +"'                                                           \n");
							sql.append( "                          AND G.EMPNOH = '" + str2 +"'                                                         \n");
							sql.append( "                        GROUP BY G.EVAYM,G.EMPNOH, G.EMPNO,G.EVASEQ, G.GRPCD) X                                \n");
							sql.append( "                             ON A.EVAYM = X.EVAYM                                                              \n");
							sql.append( "                           AND A.EMPNO = X.EMPNO                                                               \n");
							sql.append( "                           AND X.EMPNOH = '" + str2 +"'                                                        \n");
							sql.append( "                           AND X.EVASEQ = B.EVASEQ                                                             \n");
						//	sql.append( "                           AND X.GRPCD = F.MINORCD                                                             \n");
							sql.append( "    WHERE A.EVAYM = B.EVAYM                                                                                    \n");
							sql.append( "        AND A.EMPNO = B.EMPNO                                                                                  \n");
						 	sql.append( "        AND A.DEPREF ='1'                                                                                      \n");
							sql.append( "        AND A.EVAYM = '" + str1 +"'                                                                            \n");
							sql.append( "        AND B.EMPNOH= '" + str2 +"'                                                                            \n");
                            sql.append( "        AND A.EMPNO IN ('6050004','6050005','6050006','6050007','6060001')                                               \n");
							sql.append( "    ORDER BY SEQ, PAYSEQ DESC, GRSTRTDT                                                                        \n");
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