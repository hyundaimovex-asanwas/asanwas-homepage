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
public class h060002_s1 extends HttpServlet {

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
             
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ "EVAYM",	 "EMPNO",	 "EMPNMK",    "DEPTCD", "DEPTNM", 
					                                "PAYGRD",  "GRDNM",  "GRSTRTDT",  "STRTDT",	"WRDT",	
					                                "TOTAVG",  "SCR1",	 "AVG1",      "SCR2",	  "AVG2",	    
					                                "SCR3",	   "AVG3",	 "SCR4",	    "AVG4" ,
					                                "LAMDT",   "RECDIV", "RECNM",     "JOBKIND","JOBNM", "JOBREF",
					                                "SEQ",     "PAYSEQ" 	}; 

					                                             
				int[] intArrCN = new int[]{   6,  7, 20,  4,  50, 
					                            4, 30,  8,  8,   8,  
					                            5,  5,  5,  5,   5,  
					                            5,  5,  5,  5,  
					                            8,  4,  30, 4,  30, 2, 
					                            3,  4   }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,  -1,  -1,
					                           -1, -1, -1,  -1,  -1,
					                            2,  2,  2,   2,   2,  
					                            2,  2,  2,   2,
					                           -1, -1, -1,  -1,  -1, -1,
					                            0, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
          sql.append( " SELECT X.EVAYM,   X.EMPNO, X.EMPNMK  ,X.DEPTCD,       X.DEPTNM,			\n");
					sql.append( "  			 X.PAYGRD,  X.GRDNM, X.GRSTRTDT,   X.STRTDT,    X.WRDT,				\n");
					sql.append( "  			 X.TOTAVG,  X.SCR1,      X.AVG1,      X.SCR2,   X.AVG2,					\n");
          sql.append( "  			 X.SCR3,     X.AVG3,     X.SCR4,      X.AVG4,							\n");
					sql.append( "  			 X.LAMDT,   X.RECDIV,  X.RECNM,X.JOBKIND,X.JOBNM,	X.JOBREF,X.SEQ, X.PAYSEQ \n");
          sql.append( "   FROM(										\n");
					sql.append( "        SELECT A.EVAYM,    A.EMPNO,  										\n");
          sql.append( "               CASE WHEN SUBSTR(A.EMPNO,1,1) IN ('1','2') THEN B.EMPNMK ELSE T.EMPNMK END EMPNMK ,\n");
					sql.append( "               A.DEPTCD,      C.DEPTNM,	 \n");
					sql.append( "               A.PAYGRD,   D.MINORNM AS GRDNM,        RTRIM(A.GRSTRTDT)GRSTRTDT,    RTRIM(A.STRTDT)STRTDT,    A.WRDT,  \n");
					sql.append( "               A.TOTAVG,   A.SCR1,      A.AVG1,       A.SCR2,        A.AVG2,													\n");
					sql.append( "               A.SCR3,     A.AVG3,      A.SCR4,       A.AVG4,																					\n");
					sql.append( "               RTRIM(A.LAMDT)LAMDT,    A.RECDIV,  RTRIM(E.MINORNM) RECNM, A.JOBKIND, RTRIM(F.MINORNM) JOBNM,			\n");
					sql.append( "               A.JOBREF, D.SEQ, B.PAYSEQ																																					\n");
					sql.append( "        FROM PAYROLL.HVEMP A																																					\n");
          sql.append( "        LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO   = B.EMPNO																			\n");
					sql.append( "        LEFT JOIN PAYROLL.HCDEPT   C ON A.DEPTCD = C.DEPTCD																			\n");
					sql.append( "        LEFT JOIN PAYROLL.HCLCODE  D ON A.PAYGRD = D.MINORCD  AND D.MAJORCD = '2002'							\n");
					sql.append( "        LEFT JOIN PAYROLL.HCLCODE  E ON A.RECDIV = E.MINORCD  AND E.MAJORCD = '2035'							\n");
					sql.append( "        LEFT JOIN PAYROLL.HCLCODE  F ON A.JOBREF = F.MINORCD  AND F.MAJORCD = '2034'						 \n");
          sql.append( "        LEFT JOIN PAYROLL.T_HIPERSON T ON A.EMPNO   = T.EMPNO						 \n");
          sql.append( "       WHERE A.EVAYM <> ''																																						\n");
					if (!str1.equals("")) sql.append( " AND A.EVAYM   = '" + str1+"'						 \n");
					if (!str3.equals("")) sql.append( " AND A.PAYGRD  = '" + str3 +"'						 \n");
				  if (str5.equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '"+ str6 + "' \n");
					if (str5.equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '"+ str6 + "' \n");
					if (str5.equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6) = '"+ str6 + "' \n");
					if (str5.equals("4")) sql.append( " AND RTRIM(C.TREECD) = '" + str6 + "'     \n");
					sql.append( "    ) X										\n");
					sql.append( "    WHERE X.EVAYM <> ''									\n");
					if (!str4.equals("")) sql.append( " AND X.EMPNMK  LIKE '" + str4 +"%' 	 \n");
					sql.append( " ORDER BY X.SEQ, X.PAYSEQ DESC, X.GRSTRTDT ");
          //logger.dbg.println(this, sql.toString());
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