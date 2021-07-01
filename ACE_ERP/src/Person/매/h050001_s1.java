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
public class h050001_s1 extends HttpServlet {

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

				String [] str = new String [12];
				str[1]  = req.getParameter("v_str1");	//검색일자 from
				str[2]	= req.getParameter("v_str2");	//검색일자 to
				str[3]	= req.getParameter("v_str3");	//사번
				str[4]	= req.getParameter("v_str4");	//년월 from
				str[5]	= req.getParameter("v_str5");	//년월 to
				str[6]  = req.getParameter("v_str6");	//사번 from
				str[7]  = req.getParameter("v_str7");	//사번 to
				str[8]  = req.getParameter("v_str8");	//성명

				for (int s=0;s<=8;s++) {
					if (str[s]==null) str[s] = "";
				}

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
		
					sql.append( " SELECT \n");
					sql.append( " RTRIM(D.APPDT) AS APPDT,RTRIM(D.EMPNO) AS EMPNO, RTRIM(D.LAZCD) AS LAZCD, \n");
					sql.append( " RTRIM(D.DEPTCD) AS DEPTCD, RTRIM(D.PAYSEQ) AS PAYSEQ, \n");
					sql.append( " RTRIM(D.FRDT) AS FRDT, RTRIM(D.TODT) AS TODT, RTRIM(D.FRTIME) AS FRTIME, \n");
					sql.append( " RTRIM(D.TOTIME) AS TOTIME, RTRIM(D.DTYREM) AS DTYREM, \n");
					sql.append( " RTRIM(D.CLOSYN) AS CLOSYN, RTRIM(D.SGDT) AS SGDT, RTRIM(D.SGNID) AS SGNID, \n");
					sql.append( " RTRIM(D.AGRDT) AS AGRDT, RTRIM(D.AGRID) AS AGRID, \n");
					sql.append( " RTRIM(D.PAYDT) AS PAYDT, COALESCE(D.AMT,0) AS AMT, RTRIM(C.DEPTNM) DEPTNM, RTRIM(B.MINORNM) AS MINORNM, \n");
					sql.append( " RTRIM(A.EMPNMK) AS EMPNMK, RTRIM(E.LAZFEENM) AS LAZFEENM, \n");
					sql.append( " COALESCE(F.CURYEAR,0) AS CURYEAR, COALESCE(F.USEYEAR,0) AS USEYEAR, \n");
					sql.append( " (COALESCE(F.CURYEAR,0)-COALESCE(F.USEYEAR,0))  AS PAYYEAR, \n");
					sql.append( " RTRIM(G.EMPNMK) AS SGNM, RTRIM(B.MINORCD) AS MINORCD, RTRIM(I.EMPNMK) AS AGNM \n");
					sql.append( "	FROM PAYROLL.HLDUTY D ");
					sql.append( "	LEFT JOIN PAYROLL.HIPERSON A ON D.EMPNO		= A.EMPNO \n");
					sql.append( "	LEFT JOIN PAYROLL.HIPERSON G ON D.SGNID		= G.EMPNO \n");
					sql.append( "	LEFT JOIN PAYROLL.HIPERSON I ON D.AGRID		= I.EMPNO \n");
					sql.append( "	LEFT JOIN PAYROLL.HCLCODE	 B ON B.MINORCD	= A.PAYGRD AND B.MAJORCD='2002' \n");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT   C ON D.DEPTCD	= C.DEPTCD \n");
					sql.append( "	LEFT JOIN PAYROLL.HCHOLFEE E ON D.LAZCD		= E.LAZCD  \n");
					sql.append( " LEFT JOIN PAYROLL.PCMONPAY F ON F.EMPNO = D.EMPNO AND F.STRDT >= '"+str[4]+"' AND F.STRDT <= '"+str[5]+"' \n"); 
					sql.append( " WHERE D.LAZCD LIKE 'S%' AND A.USESTS = '1' \n");

					if (!str[3].equals("")) { sql.append( " AND A.EMPNO='" + str[3] + "' \n"); }
					if (!str[1].equals("")) { sql.append( " AND APPDT BETWEEN '" + str[1] + "' AND '" + str[2] + "' \n"); }
					if (!str[6].equals("") && !str[7].equals(""))
						sql.append( " AND A.EMPNO BETWEEN '" + str[6]+ "' AND '" + str[7]+ "'  \n");
					if (!str[8].equals("")) sql.append( " AND A.EMPNMK LIKE '" + str[8]+ "%' \n");  //성명

					sql.append( " ORDER BY APPDT \n");

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