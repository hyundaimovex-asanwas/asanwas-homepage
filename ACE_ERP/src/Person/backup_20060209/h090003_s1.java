/* 전체 조회 */
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
public class h090003_s1 extends HttpServlet {

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

				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2");
				String  str3	= req.getParameter("v_str3");
				String  str4	= req.getParameter("v_str4");
				String  str5	= req.getParameter("v_str5");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "APPDT",		"EMPNO",		"LAZCD",		"DEPTCD",		"PAYSEQ",
																					"FRDT",			"TODT",			"FRTIME",		"TOTIME",		"DTYREM",
																					"CLOSYN",		"SGDT",			"SGNID",		"AGRDT",		"AGRID",
																					"PAYDT",		"AMT",			"DEPTNM",		"MINORNM",	"EMPNMK",
																					"LAZFEENM", "CURYEAR",	"USEYEAR",	"PAYYEAR",	"SGNM",
																					"MINORCD",	"AGNM"
																					}; 

				int[] intArrCN = new int[]{ 8,  7,  4,  4,  4,
																		8,  8,  6,  6, 40,
																		1,  8,  7,  8,  7,
																		8,  7, 50, 30, 20,
																		20, 3,  3,  3, 20,
																		4,	20
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1,  0, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1
																	}; 
			
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
		
					sql.append( " SELECT ");
					sql.append( " RTRIM(D.APPDT) APPDT,RTRIM(D.EMPNO) EMPNO, RTRIM(D.LAZCD) LAZCD, RTRIM(D.DEPTCD) DEPTCD, RTRIM(D.PAYSEQ) PAYSEQ, ");
					sql.append( " RTRIM(D.FRDT) FRDT, RTRIM(D.TODT) TODT, RTRIM(D.FRTIME) FRTIME, RTRIM(D.TOTIME) TOTIME, RTRIM(D.DTYREM) DTYREM, ");
					sql.append( " RTRIM(D.CLOSYN) CLOSYN, RTRIM(D.SGDT) SGDT, RTRIM(D.SGNID) SGNID, RTRIM(D.AGRDT) AGRDT, RTRIM(D.AGRID) AGRID, ");
					sql.append( " RTRIM(D.PAYDT) PAYDT, D.AMT, C.DEPTNM,  B.MINORNM, A.EMPNMK,   ");
					sql.append( " E.LAZFEENM, F.CURYEAR, F.USEYEAR, F.PAYYEAR, G.EMPNMK AS SGNM, B.MINORCD,I.EMPNMK AS AGNM ");
					sql.append( " FROM ");
					sql.append( "	PAYROLL.T_HLDUTY D ");
					sql.append( "	LEFT JOIN PAYROLL.T_HIPERSON A ON D.EMPNO		= A.EMPNO ");
					sql.append( "	LEFT JOIN PAYROLL.T_HIPERSON G ON D.SGNID		= G.EMPNO ");
					sql.append( "	LEFT JOIN PAYROLL.T_HIPERSON I ON D.AGRID		= I.EMPNO ");
					sql.append( "	LEFT JOIN PAYROLL.HCLCODE		 B ON B.MINORCD	= A.PAYGRD AND B.MAJORCD='2002' ");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT     C ON D.DEPTCD	= C.DEPTCD ");
					sql.append( "	LEFT JOIN PAYROLL.HCHOLFEE E ON D.LAZCD		= E.LAZCD ");
					sql.append( " LEFT JOIN PAYROLL.PCMONPAY   F ON F.EMPNO   = D.EMPNO AND F.STRDT >= '"+str4+"' AND F.STRDT <= '"+str5+"'"); 
					sql.append( " WHERE " );
					sql.append( " A.EMPNO='" + str3 + "' " );
					sql.append( " AND D.LAZCD LIKE 'S%' ");
					//if (str4 !=null) { sql.append( " AND F.STRDT = '" + str4 + "' " ); }
					if (str1 !=null) { sql.append( " AND APPDT BETWEEN '" + str1 + "' AND '" + str2 + "' "); }
					sql.append( " ORDER BY APPDT ");

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