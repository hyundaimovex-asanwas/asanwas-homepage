/* 전체 조회 */
package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h090006_s1 extends HttpServlet {

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
				String  str3	= req.getParameter("v_str3");  //사번
				String  str4	= req.getParameter("v_str4");
				String  str5	= req.getParameter("v_str5");
				String  str6	= req.getParameter("v_str6");  //사번2
				String  str7	= req.getParameter("v_str7");  //이름

				if (str1==null) str1 = "";
				if (str2==null) str2 = "";
				if (str3==null) str3 = "";
				if (str4==null) str4 = "";
				if (str5==null) str5 = "";
				if (str6==null) str6 = "";
				if (str7==null) str7 = "";


				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "APPDT",		"EMPNO",		"LAZCD",		"DEPTCD",		"PAYSEQ",
																					"FRDT",			"TODT",			"DTYREM",
																					"CLOSYN",		"SGDT",			"SGNID",		"AGRDT",		"AGRID",
																					"PAYDT",		"AMT",			"DEPTNM",		"MINORNM",	"EMPNMK",
																					"LAZFEENM", "BEFYEAR",   "CURYEAR",	          "USEYEAR",	"PAYYEAR",
																					"SGNM",  "MINORCD",	"AGNM"   
																					}; 

				int[] intArrCN = new int[]{ 8,  7,  4,  4,  4,
																		8,  8, 100,
																		1,  8,  7,  8,  7,
																		8,  7, 50, 30, 20,
																		20, 3, 3,  3,  3, 
																		20, 4,	20, 20, 
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1,  0, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
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
		
					sql.append( " SELECT ");
					sql.append( " RTRIM(D.APPDT) APPDT,RTRIM(D.EMPNO) EMPNO, RTRIM(D.LAZCD) LAZCD, RTRIM(D.DEPTCD) DEPTCD, RTRIM(D.PAYSEQ) PAYSEQ, ");
					sql.append( " RTRIM(D.FRDT) FRDT, RTRIM(D.TODT) TODT, RTRIM(D.DTYREM) DTYREM, ");
					sql.append( " RTRIM(D.CLOSYN) CLOSYN, RTRIM(D.SGDT) SGDT, RTRIM(D.SGNID) SGNID, RTRIM(D.AGRDT) AGRDT, RTRIM(D.AGRID) AGRID, ");
					//sql.append( " RTRIM(D.PAYDT) PAYDT,  D.AMT, C.DEPTNM,  B.MINORNM, A.EMPNMK, E.LAZFEENM, ");
                    sql.append( " RTRIM(D.PAYDT) PAYDT,  IFNULL(D.AMT,0) AMT, C.DEPTNM,  B.MINORNM, A.EMPNMK, E.LAZFEENM, ");
					sql.append( " COALESCE(F.BEFYEAR,0) AS BEFYEAR, COALESCE(F.CURYEAR,0) AS CURYEAR, COALESCE(F.USEYEAR,0) AS USEYEAR,  COALESCE(F.PAYYEAR,0) AS PAYYEAR, ");
					sql.append( " G.EMPNMK AS SGNM, B.MINORCD,I.EMPNMK AS AGNM ");
					sql.append( " FROM ");
					sql.append( "	PAYROLL.T_HIPERSON A ");
					sql.append( "	LEFT  OUTER JOIN PAYROLL.HLDUTY D ON A.EMPNO = D.EMPNO   ");

                        if (!str7.equals(""))
                    sql.append( " AND A.EMPNMK LIKE '" + str7 + "%'" );
		    			if (!str1.equals("")) { sql.append( " AND APPDT BETWEEN '" + str1 + "' AND '" + str2 + "' ");
                    
					sql.append( "	 AND (D.LAZCD LIKE 'C%' OR D.LAZCD LIKE 'G%' OR D.LAZCD LIKE 'H%')");
					sql.append( "	LEFT  OUTER JOIN PAYROLL.T_HIPERSON G ON D.SGNID   = G.EMPNO ");
					sql.append( "	LEFT  OUTER JOIN PAYROLL.T_HIPERSON I ON D.AGRID   = I.EMPNO");
					sql.append( "	LEFT  OUTER JOIN PAYROLL.HCDEPT   C ON A.DEPTCD   = C.DEPTCD ");
					sql.append( "   LEFT  OUTER JOIN PAYROLL.HCLCODE  B ON B.MINORCD  = A.PAYGRD AND B.MAJORCD='2002' ");
					sql.append( "	LEFT  OUTER JOIN PAYROLL.HCHOLFEE E ON D.LAZCD    = E.LAZCD ");
		            sql.append( "   LEFT  OUTER JOIN PAYROLL.PCMONPAY F ON A.EMPNO = F.EMPNO ");
					sql.append( " AND F.STRDT = (SELECT MAX(STRDT) STRDT FROM PAYROLL.PCMONPAY WHERE F.EMPNO = A.EMPNO )"); 
					sql.append( " WHERE A.EMPNO <>'' " );
			       		if (!str3.equals("")&&!str6.equals(""))
		 			sql.append( " AND A.EMPNO BETWEEN '" + str3 + "' AND '" + str6 +  "'" );  
                      }
					sql.append( " ORDER BY APPDT ");

					logger.dbg.println(this, sql.toString());

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