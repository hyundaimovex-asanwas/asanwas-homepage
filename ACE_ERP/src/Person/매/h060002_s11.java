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
public class h060002_s11 extends HttpServlet {

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
				String  str1= req.getParameter("v_str1"); //년월
				String  str2= req.getParameter("v_str2"); //부서
				String  str3= req.getParameter("v_str3"); //사번fr
				String  str4= req.getParameter("v_str4"); //사번to
				String  str5= req.getParameter("v_str5"); //입사일자
				String  str6= req.getParameter("v_str6"); //level
				String  str7= req.getParameter("v_str7"); //treecd

				if (str1==null ) {str1 ="";}
				if (str2==null ) {str2 ="";}
				if (str3==null ) {str3 ="";}
				if (str4==null ) {str4 ="";}
        if (str5==null ) {str5 ="";}
				if (str6==null ) {str6 ="";}
        if (str7==null ) {str7 ="";}

				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ "EVAYM",	 "EMPNO",	 "EMPNMK",    "DEPTCD", "DEPTNM", 
					                                "PAYGRD",  "GRDNM",  "GRSTRTDT",  "STRTDT",	 "WRDT",	
					                                "TOTAVG",  "SCR1",	 "AVG1",      "SCR2",	 "AVG2",	    
					                                "SCR3",	   "AVG3",	 "SCR4",	    "AVG4"}; 
					                                             
				int[] intArrCN = new int[]{   6,  7, 20,  4,  50, 
					                            4, 30,  8,  8,   8,  
					                            5,   5,  5,  5,   5,  
					                            5,   5,  5,  5  }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,  -1,  -1,
					                           -1, -1, -1,  -1,  -1,
					                            2,  2,  2,    2,   2,  
					                            2,   2,   2,  2}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
			
          sql.append( " SELECT A.EVAYM,    A.EMPNO,    B.EMPNMK,      A.DEPTCD,      C.DEPTNM," );
          sql.append( "        A.PAYGRD,   D.MINORNM AS GRDNM,        A.GRSTRTDT,    A.STRTDT,    SUBSTR(A.WRDT,1,6) WRDT,  ");
					sql.append( "        A.TOTAVG,   A.SCR1,      A.AVG1,       A.SCR2,        A.AVG2,  ");
					sql.append( "        A.SCR3,     A.AVG3,      A.SCR4,       A.AVG4 ");
					sql.append( "   FROM PAYROLL.HVEMP A");
          sql.append( "            LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO  = B.EMPNO ");
					sql.append( "            LEFT JOIN PAYROLL.HCDEPT   C ON A.DEPTCD = C.DEPTCD   ");
					sql.append( "            LEFT JOIN PAYROLL.HCLCODE  D ON A.PAYGRD = D.MINORCD  AND D.MAJORCD = '2002'");
          sql.append( " WHERE A.EVAYM   = '" + str1+"'" );
					//sql.append( "     AND A.DEPTCD  = '" + str2 +"'");
					if (!str3.equals("")&&!str4.equals(""))sql.append( " AND (A.EMPNO >= '" + str3 +"' AND A.EMPNO <= '" + str4 +"')");
					if (!str5.equals(""))sql.append( "     AND A.GRSTRTDT  < '" + str5 +"'");

					if (str6.equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '"+ str7 + "' \n");
					if (str6.equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4) = '"+ str7 + "' \n");
					if (str6.equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6) = '"+ str7 + "' \n");
					if (str6.equals("4")) sql.append( " AND RTRIM(C.TREECD) = '" + str7 + "'     \n");

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