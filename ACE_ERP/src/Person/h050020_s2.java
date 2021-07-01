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
public class h050020_s2 extends HttpServlet {

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

				String [] str = new String [5];
				str[0]  = req.getParameter("v_str1");	//급여년월 
				str[1]	= req.getParameter("v_str2");	//사번
				str[2]	= req.getParameter("v_str3");	//성명
				str[3]	= req.getParameter("v_str4");	//재택구분
				str[4]	= req.getParameter("v_str5");	//정규직

				for (int s=0;s<=4;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "APPDT",		"EMPNO",		"EMPNMK",		"JTGB",		"CURDPT",  "BEFDPT", "CURDTPNM", "BEFDPTNM", 
                                          "CLOSEYN",  "JTWK",		  "REMARK",		"I_EMPNO",	"I_DATE",	"U_EMPNO", "U_DATE"
																				}; 

				int[] intArrCN = new int[]{ 6,  7,  20,  1,  4,  4, 50, 50,
                                    1,  1,  50,  7, 10,  7, 10
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,  0, -1, -1, -1, -1, 
                                     -1, -1, -1, -1, -1, -1, -1 
																	 }; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
		
					sql.append( "  SELECT A.APPDT,   A.EMPNO,   B.EMPNMK,  A.JTGB,    A.CURDPT,  A.BEFDPT, C.DEPTNMK CURDTPNM, D.DEPTNMK BEFDPTNM, \n");
					sql.append( "  			  A.CLOSEYN, A.JTWK,    A.REMARK,  A.I_EMPNO, A.I_DATE,  A.U_EMPNO, A.U_DATE  \n");
					sql.append( "  	FROM PAYROLL.HLJTGB A                                                  \n");
					sql.append( "  	LEFT JOIN PAYROLL.YIPERSON B ON A.EMPNO = B.EMPNO                      \n");
					sql.append( "  	LEFT JOIN PAYROLL.HCDEPT C ON A.CURDPT = C.DEPTCD                      \n");
					sql.append( "  	LEFT JOIN PAYROLL.HCDEPT D ON A.BEFDPT = D.DEPTCD                      \n");
					sql.append( "  	WHERE 1=1                 \n");

					if (!str[0].equals("")) sql.append( " AND A.APPDT='" + str[0] + "' \n"); 
					if (!str[1].equals("")) sql.append( " AND A.EMPNO='" + str[1] + "' \n"); 
					if (!str[2].equals("")) sql.append( " AND B.EMPNMK LIKE '" + str[2]+ "%' \n");   //
					if (!str[3].equals("")) sql.append( " AND A.JTGB = '" + str[3]+ "' \n");         //
					if (str[4].equals("R")) sql.append( " AND SUBSTR(A.EMPNO,1,1)IN ('1','2') \n");  //
					if (str[4].equals("T")) sql.append( " AND SUBSTR(A.EMPNO,1,1)IN ('3') \n");      //

					sql.append( " ORDER BY A.APPDT, A.EMPNO \n");

          logger.dbg.println(this,sql.toString());
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