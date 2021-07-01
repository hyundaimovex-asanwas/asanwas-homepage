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
public class h040002_s1 extends HttpServlet {

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
				String str1 = req.getParameter("v_str1");
				String str2 = req.getParameter("v_str2");
				String str3 = req.getParameter("v_str3");
				String str4 = req.getParameter("v_str4");
				String str5 = req.getParameter("v_str5");
				String str6 = req.getParameter("v_str6");	//LEVEL
				String str7 = req.getParameter("v_str7");	//TREECD

				if (str1 == null) { str1 = "";}
				if (str2 == null) { str2 = "";}
				if (str3 == null) { str3 = "";}
				if (str4 == null) { str4 = "";}
				if (str5 == null) { str5 = "";}
				if (str6 == null) { str6 = "";}
				if (str7 == null) { str7 = "";}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","ORDDT","SEQ","ORDCD","DEPTCD",
																					"PAYGRD","PAYSEQ","ENDDT","APPDT","EMPNMK",
																					"REGDAT","DEPTGB","TREECD","SEQ2", "ETC"
																				};

				int[] intArrCN = new int[]{    7,  8,  2,  2,  4,          
                                       4,  4,  8,  8, 20,
																			 8,  4,  8,  3, 30
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1,  0, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, 0,  -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT  \n");
					sql.append( "	 A.EMPNO,RTRIM(A.ORDDT) AS ORDDT,A.SEQ,A.ORDCD,A.DEPTCD, \n");
					sql.append( "	 A.PAYGRD,A.PAYSEQ,RTRIM(A.ENDDT) AS ENDDT,RTRIM(A.APPDT) AS APPDT, B.EMPNMK, \n");
					sql.append( "	 '' AS REGDAT, RTRIM(A.DEPTGB) AS DEPTGB, C.TREECD, IFNULL(D.SEQ,0) SEQ2, RTRIM(A.ETC)ETC \n");
					sql.append( "	 FROM PAYROLL.HOORDER A, \n");
					sql.append( "		    PAYROLL.HIPERSON B \n");
					sql.append( "  LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD = C.DEPTCD ");
					sql.append( "  LEFT JOIN PAYROLL.HCLCODE D ON A.PAYGRD = D.MINORCD AND D.MAJORCD ='2002' ");
					sql.append( "  WHERE A.EMPNO = B.EMPNO \n");
					sql.append( "  AND A.ORDDT BETWEEN '" + str3 + "' AND '" + str4 + "' \n");

					if (!str1.equals("")) sql.append( " AND A.DEPTCD = '" + str1 + "' \n");
					if (!str2.equals("")) sql.append( " AND A.ORDCD = '" + str2 + "' \n");
					if (!str5.equals("")) sql.append( " AND B.EMPNO = '" + str5 + "' \n");

					if (str6.equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4) ='" + str7 + "'");
					if (str6.equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4) ='" + str7 + "'");
					if (str6.equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6) ='" + str7 + "'");
					if (str6.equals("4")) sql.append( " AND TREIM(C.TREECD) = '" + str7 + "'");

					sql.append( " ORDER BY C.TREECD ASC, D.SEQ ASC ");

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