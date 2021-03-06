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
public class h030003_s1 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//FROM
				str[1]	= req.getParameter("v_str2");		//TO
				str[2]	= req.getParameter("v_str3");		//증명서종류
				str[3]	= req.getParameter("v_str4");		//사원명
				str[4]	= req.getParameter("v_str5");		//사원ID

				for (int k=0 ;k<4 ;k++ ) if (str[k]==null) str[k] = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","EMPNMK", "PAYGNM","DEPTNM","CERTINO",
																					"CERDATE","CERKIND","CERUSE","CERNUM","CERETC",
																					"OADDR","CADDR","RESINO","STRTDT","ENDDT",
																					"CURDT","CERPLC","CERFR","CERTO","CERDAT",
																					"DEPTCD","PAYGRD","PREDEPT","JOBDTYNM","ORDDT",
																					"RCVNM","BIRDT"//,"PREDEPTNM"
																				};

				int[] intArrCN = new int[]{    7,  20,  30,  30,    8,
																			 8,   1,  30,   3,  100,
																		 200, 200,  13,   8,    8,
																			 8,  50,   8,   8,   16,
																			 4,   4,   4,  30,    8,
																			50,   8//,  50
				}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1,  0, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1//, -1
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT  ");
					sql.append( "		RTRIM(A.EMPNO) AS EMPNO,RTRIM(A.EMPNMK) AS EMPNMK,RTRIM(B.MINORNM) AS PAYGNM,RTRIM(C.DEPTNM) AS DEPTNM, ");
					sql.append( "		RTRIM(D.CERTINO) AS CERTINO, RTRIM(D.CERDATE) AS CERDATE, RTRIM(D.CERKIND) AS CERKIND, ");
					sql.append( "   RTRIM(D.CERUSE) AS CERUSE,D.CERNUM, RTRIM(D.CERETC) AS CERETC, ");
					sql.append( "		RTRIM(A.OADDR01) || ' ' || RTRIM(A.OADDR02) AS OADDR, RTRIM(A.CADDR01) || ' ' || RTRIM(A.CADDR02) AS CADDR, ");
					sql.append( "   A.RESINO, RTRIM(A.STRTDT) AS STRTDT, ");
					sql.append( "		RTRIM(A.ENDDT) AS ENDDT,'' AS CURDT, RTRIM(D.CERPLC) AS CERPLC, RTRIM(D.CERFR) AS CERFR, ");
					sql.append( "   RTRIM(D.CERTO) AS CERTO, D.CERFR || D.CERTO AS CERDAT, ");
					sql.append( "		RTRIM(D.DEPTCD) AS DEPTCD,RTRIM(D.PAYGRD) AS PAYGRD,RTRIM(D.PREDEPT) AS PREDEPT,RTRIM(D.JOBDTYNM) AS JOBDTYNM, ");
					sql.append( "   RTRIM(D.ORDDT) AS ORDDT,RTRIM(D.RCVNM) AS RCVNM, RTRIM(A.BIRDT) AS BIRDT ");
					
					//sql.append( "		RTRIM(G.DEPTNM) AS PREDEPTNM ");
					sql.append( "	FROM PAYROLL.HIPERSON A, ");
					sql.append( "   PAYROLL.HCLCODE B, ");
					sql.append( "		PAYROLL.HCDEPT  C, ");
					sql.append( "		PAYROLL.HICERTI D ");
					/*
					sql.append( "	LEFT JOIN (SELECT Y.EMPNO,Y.DEPTCD,Y.ORDDT ");
					sql.append( "						 FROM PAYROLL.HOORDER Y ");
					sql.append( "		         WHERE Y.ORDDT = (SELECT MAX(X.ORDDT) ");
					sql.append( "															FROM PAYROLL.HOORDER X ");
					sql.append( "															WHERE X.ORDDT < (SELECT MAX(F.ORDDT) ");
					sql.append( "										  												 FROM PAYROLL.HOORDER F ");
					sql.append( "																							 WHERE F.EMPNO='"+str[4]+"' ) ");
					sql.append( "														  AND X.EMPNO='"+str[4]+"') ");
					sql.append( "						 AND Y.EMPNO='"+str[4]+"')XX ON A.EMPNO = XX.EMPNO");
					sql.append( "	LEFT JOIN PAYROLL.HCDEPT G ON XX.DEPTCD = G.DEPTCD ");
					*/
					sql.append( "	WHERE A.PAYGRD	= B.MINORCD ");
					sql.append( "	AND		A.DEPTCD	= C.DEPTCD ");
					sql.append( "	AND		B.MAJORCD = '2002' ");
					sql.append( " AND		A.EMPNO		= D.EMPNO ");
					sql.append( "	AND		D.CERDATE BETWEEN '" + str[0] + "' AND '" + str[1] + "' ");
					if (!str[2].equals("")) sql.append( "				 AND D.CERKIND = '" + str[2] + "' ");
					sql.append( " AND A.EMPNMK LIKE '" + str[3] + "%' ");

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