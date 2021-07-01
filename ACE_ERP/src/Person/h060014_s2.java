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
public class h060014_s2 extends HttpServlet {

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
				String  str2= req.getParameter("v_str2");  //피고과자사번
                 String  str3= req.getParameter("v_str3");  //직급(과장이상/대리이하)
				//String  str4= req.getParameter("v_str4");  //부문(능력고과/직업고과)
                 String  str5= req.getParameter("v_str5");  //공통 & (사무직 or 기술직 or 영업직)
				String  str6= req.getParameter("v_str6");  //고과자
				String  str7= req.getParameter("v_str7");  //차수
				
				if (str1==null ) {str1 ="";}
				if (str2==null ) {str2 ="";}
				if (str3==null ) {str3 ="";}
				//if (str4==null ) {str4 ="";}
				if (str5==null ) {str5 ="";}
				if (str6==null ) {str6 ="";}
				if (str7==null ) {str7 ="";}
                 
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ "EVAYM",     "GRPCD",	   "DIVCD",	    "DIVNM",  "JOBGRPH", 
					                                "JOBGRPNM",  "PRTSEQ",   "GRPITEM",   "GRPNM",  "ASKITEM",  "SCRGBN",
													"CHK01",		 "CHK02",		 "CHK03",			"CHK04",	"CHK05",
					                                "ESCR",      "GSCR",     "MSCR",      "LSCR",   "PSCR",     "SCR",
					                                "EMPNOH",	   "EMPNO",    "EVASEQ" }; 
					                                             
				int[] intArrCN = new int[]{   6,    4,  4,   30,  4, 
					                            30,   2,  4,   30,  70, 1,
																			1,		1,	1,		1,	1,
					                            4,    4,  4,    4,  4,  5,
					                            7,  7,   1}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,  -1, 
					                           -1,  0, -1, -1,  -1, -1,
																		 -1, -1, -1, -1,  -1, 
					                            2,  2,  2,   2,   2,  2,
					                           -1, -1,  0  }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT A.EVAYM, A.GRPCD, A.DIVCD,B.MINORNM AS DIVNM, A.JOBGRPH,															\n");
					sql.append( "         C.MINORNM AS JOBGRPNM, A.PRTSEQ, A.GRPITEM, D.MINORNM AS GRPNM, A.ASKITEM, E.SCRGBN,	\n");
					sql.append( "         CASE E.SCRGBN WHEN '1' THEN 'T' ELSE 'F' END AS CHK01,															\n	");
					sql.append( "         CASE E.SCRGBN WHEN '2' THEN 'T' ELSE 'F' END AS CHK02,																\n");
					sql.append( "         CASE E.SCRGBN WHEN '3' THEN 'T' ELSE 'F' END AS CHK03,															\n	");
					sql.append( "         CASE E.SCRGBN WHEN '4' THEN 'T' ELSE 'F' END AS CHK04,															\n	");
					sql.append( "         CASE E.SCRGBN WHEN '5' THEN 'T' ELSE 'F' END AS CHK05,															\n	");
					sql.append( "         A.ESCR, A.GSCR, A.MSCR, A.LSCR, A.PSCR, COALESCE(E.SCR,0) SCR,											\n	");
					sql.append( "         COALESCE(E.EMPNOH,'') AS EMPNOH, COALESCE(E.EMPNO,'') AS EMPNO, COALESCE(E.EVASEQ,0) AS EVASEQ \n");
          sql.append( "     FROM PAYROLL.HVSHEET A ");
					sql.append( "     LEFT JOIN PAYROLL.HCLCODE B ON A.DIVCD = B.MINORCD    AND B.MAJORCD='2015'\n ");
					sql.append( "     LEFT JOIN PAYROLL.HCLCODE C ON A.JOBGRPH = C.MINORCD	AND C.MAJORCD='2016' \n");
					sql.append( "     LEFT JOIN PAYROLL.HCLCODE D ON A.GRPITEM = D.MINORCD	AND D.MAJORCD='2019' \n");
          sql.append( "     LEFT JOIN PAYROLL.HVSCORES E ON A.EVAYM = E.EVAYM      AND A.GRPCD =E.GRPCD \n");
					sql.append( "                                AND A.DIVCD = E.DIVCD      AND A.JOBGRPH=E.JOBGRPH \n");
					sql.append( "                                AND A.PRTSEQ = E.PRTSEQ    AND E.EMPNO= '" + str2 +"'\n" );
					sql.append( "                                AND E.EMPNOH='" + str6 +"' AND E.EVASEQ =" + str7 );
                    sql.append( "                                AND E.EVAYM='" + str1 +"'\n"  );
					sql.append( "  WHERE A.EVAYM = '" + str1 +"'\n" );
      //    sql.append( "      AND A.GRPCD= '" + str3 +"'"  );
             sql.append( "      AND A.GRPCD= '3'     \n "  );
					//sql.append( "      AND A.DIVCD= '" + str4 +"'"  );
					sql.append( "      AND ((A.JOBGRPH= '" + str5 +"') OR (A.JOBGRPH='00'))\n "  );

					sql.append( " ORDER BY A.DIVCD, A.PRTSEQ \n");

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