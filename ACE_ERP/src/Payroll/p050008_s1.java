package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p050008_s1 extends HttpServlet {

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
							// 웹페이지에서 조건값을 넘겨받음

				String [] str= new String[7] ;
        str[0]  = req.getParameter("v_str1");   //부서
				str[1]	= req.getParameter("v_str2");		//성명
        str[2]	= req.getParameter("v_str3");		//상환년월
				str[3]	= req.getParameter("v_str4");		//level
				str[4]	= req.getParameter("v_str5");		//treecd
				str[5]  = req.getParameter("v_str6");		//사번

		  	for (int s=0;s<=5;s++) {
					if (str[s]==null) str[s] = "";
				}
             
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DEPTNM",	"EMPNO",	"EMPNMK",	"PAYGRDNM",	"APPDAY",	
																					"APLDAY",	"APPCNT",	"APPAMT",	"APLAMT",	"APJAMT",     
																					"APLRAT",	"PAYDAT",	"AMT_1", "REASON"
					}; 

				int[] intArrCN = new int[]{  50,  7,   20,  30,  8,
																		  8,  3,    9,   9,  9,
																		  7,  8,    9,  30														
					}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,  -1,  -1,
																		 -1,  0,  0,   0,   0, 
																			0, -1,  0,  -1
				  }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT " );
          sql.append( " C.DEPTNM, A.EMPNO,  B.EMPNMK, D.MINORNM AS PAYGRDNM, A.APPDAY, ");
					sql.append( " A.APLDAY, A.APPCNT, A.APPAMT, A.APLAMT,    A.APJAMT, A.APLRAT, A.PAYDAT, ");
					sql.append( " (A.APLAMT+A.APLRAT) AMT_1, IFNULL(RTRIM(A.REASON),'') REASON ");
					sql.append( " FROM PAYROLL.PWRONPAY A " );
          sql.append( " LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO ");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON B.DEPTCD = C.DEPTCD ");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON B.PAYGRD = D.MINORCD AND MAJORCD ='2002' ");
          sql.append( " WHERE B.EMPNMK LIKE '"+str[1]+"%'");

					if (!str[2].equals("")) sql.append( " AND SUBSTR(A.APLDAY,1,6) = '" + str[2] +"'");
					if (str[3].equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[4] +"'");
					if (str[3].equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[4] + "'");
					if (str[3].equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6)= '" + str[4] +"'");
					if (str[3].equals("4")) sql.append( " AND RTRIM(C.TREECD)= '" + str[4] + "'");
					if (!str[5].equals("")) sql.append( " AND RTRIM(A.EMPNO) = '" + str[5] + "'");
    
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