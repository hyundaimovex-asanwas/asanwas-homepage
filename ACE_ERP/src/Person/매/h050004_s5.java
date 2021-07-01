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
public class h050004_s5 extends HttpServlet {

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

				if (str1==null) str1 = "";
				if (str2==null) str2 = "";
				if (str3==null) str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "APPDT", "EMPNO", "LAZCD", "DEPTCD", "PAYSEQ",
                                          "FRDT", "TODT", "FRTIME", "TOTIME", "DTYREM",
                                          "CLOSYN", "SGDT", "SGNID", "AGRDT", "AGRID",
                                          "PAYDT", "AMT",
                                          "DEPTNM", "PAYNM", "EMPNMK", "SGNNM","AGRNM"
																				};

				int[] intArrCN = new int[]{  8,  7,  4,  4,  4,
				                             8,  8,  6,  6, 40,
				                             1,  8,  7,  8,  7,
				                             8,  7,
				                            40, 40, 40, 40, 40
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1,  0,
																		 -1, -1, -1, -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT RTRIM(A.APPDT) AS APPDT, A.EMPNO, A.LAZCD, A.DEPTCD, A.PAYSEQ,                                   ");
					sql.append( "        RTRIM(A.FRDT) AS FRDT, RTRIM(A.TODT) AS TODT, RTRIM(A.FRTIME) AS FRTIME, RTRIM(A.TOTIME) AS TOTIME, RTRIM(A.DTYREM) AS DTYREM,  ");
					sql.append( "        A.CLOSYN, A.SGDT, A.SGNID, RTRIM(A.AGRDT) AS AGRDT, A.AGRID,                                     ");
					sql.append( "        RTRIM(A.PAYDT)AS PAYDT, A.AMT,                                                                  ");
					sql.append( "        RTRIM(B.DEPTNM) AS DEPTNM, RTRIM(C.MINORNM) AS PAYNM, RTRIM(D.EMPNMK) AS EMPNMK, RTRIM(E.EMPNMK) AS SGNNM, RTRIM(F.EMPNMK) AS AGRNM    ");
					sql.append( "   FROM PAYROLL.HLDUTY A                                                                 ");
					sql.append( "        LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD                          ");
					sql.append( "        LEFT OUTER JOIN PAYROLL.HCLCODE C ON A.PAYSEQ = C.MINORCD AND C.MAJORCD = '2002' ");
					sql.append( "        LEFT OUTER JOIN PAYROLL.HIPERSON D ON A.EMPNO = D.EMPNO                          ");
					sql.append( "        LEFT OUTER JOIN PAYROLL.HIPERSON E ON A.SGNID = E.EMPNO                          ");
					sql.append( "        LEFT OUTER JOIN PAYROLL.HIPERSON F ON A.AGRID = F.EMPNO                          ");
					sql.append( "  WHERE A.APPDT BETWEEN '" + str1 + "' AND '" + str2 + "'                                ");
					sql.append( "    AND RTRIM(A.AGRDT) <> '' ");
					if(!str3.equals("")) sql.append( " AND A.LAZCD = '" + str3 + "' ");
					sql.append( "  ORDER BY A.APPDT DESC, D.EMPNMK                                                        ");

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
