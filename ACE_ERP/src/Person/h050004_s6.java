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
public class h050004_s6 extends HttpServlet {

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
				String  str3  = req.getParameter("v_str3");		//LEVEL
				String  str4  = req.getParameter("v_str4");		//TREECD

				if (str1==null) str1 = "";
				if (str2==null) str2 = "";
				if (str3==null) str3 = "";
				if (str4==null) str4 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DEPTNM", "EMPNMK", "PAYGNM",
																					"LCNT", "HCNT", "TCNT", "ETC"
																					,"TREECD","SEQ"
																				};

				int[] intArrCN = new int[]{ 40, 40, 40,
																		 7,  7,  7,  40
																		,8,  3
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1,
																			0,  0,  0, -1
																		,-1, 0
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT RTRIM(K1.DEPTNM) AS DEPTNM, RTRIM(K2.EMPNMK) AS EMPNMK, RTRIM(K3.MINORNM) AS PAYGNM,  ");
					sql.append( " COALESCE(SUM(T.LCNT),0) AS LCNT, COALESCE(SUM(T.HCNT),0) AS HCNT, ");
					sql.append( " COALESCE(SUM(T.TCNT),0) AS TCNT, '' AS ETC ");
					sql.append( "	,K1.TREECD, K3.SEQ ");
					sql.append( " FROM PAYROLL.HIPERSON K2                                   ");
					sql.append( "		LEFT OUTER JOIN                                    ");
					sql.append( "  ( SELECT DEPTCD, EMPNO, PAYSEQ, 1 AS LCNT, 0 AS HCNT, 0 AS TCNT                 ");
					sql.append( "    FROM PAYROLL.HLDUTY                                                                       ");
					sql.append( "   WHERE (SUBSTR(LAZCD,1,1)='S' AND LAZCD<>'S05')                  ");
					sql.append( "     AND SUBSTR(FRDT,1,6) = '" + str1 + "'                                                 ");
				//	if (!str2.equals("")) sql.append( "     AND A1.DEPTCD = '" + str2 + "'                                     ");
					sql.append( "  UNION ALL                                                                                   ");
					sql.append( "  SELECT DEPTCD, EMPNO, PAYSEQ, 0 AS LCNT, 1 AS HCNT, 0 AS TCNT                 ");
					sql.append( "    FROM PAYROLL.HLDUTY																																			 ");
					sql.append( "   WHERE LAZCD = 'S05'                                                                   ");
					sql.append( "     AND SUBSTR(FRDT,1,6) = '" + str1 + "'                                                 ");
				//	if (!str2.equals("")) sql.append( "     AND A1.DEPTCD = '" + str2 + "'                                     ");
					sql.append( "  UNION ALL                                                                                   ");
					sql.append( "  SELECT A1.DEPTCD, A1.EMPNO, A1.PAYSEQ, 0 AS LCNT, 0 AS HCNT, A1.AMT AS TCNT                 ");
					sql.append( "    FROM PAYROLL.HLDUTY A1                                                                   ");
					sql.append( "   WHERE   SUBSTR(A1.FRDT,1,6) = '" + str1 + "'                                                            ");
					sql.append( "     AND SUBSTR(A1.LAZCD,1,1) ='S'                                             ");
				//	if (!str2.equals("")) sql.append( "     AND A1.DEPTCD = '" + str2 + "'                                     ");
					sql.append( " ) T ON K2.EMPNO = T.EMPNO                                                                    ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT K1 ON K2.DEPTCD = K1.DEPTCD                                    ");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE K3 ON K2.PAYGRD = K3.MINORCD AND K3.MAJORCD = '2002'          ");
                    sql.append( "	WHERE K2.USESTS IN ('1', '2') " );	
				//	if (!str2.equals("")) sql.append( " AND K2.DEPTCD = '" + str2 + "' ");

					if (str3.equals("1")) sql.append( " AND SUBSTR(K1.TREECD,1,4) ='"+str4+"'");
					if (str3.equals("2")) sql.append( " AND SUBSTR(K1.TREECD,1,4) ='"+str4+"'");
					if (str3.equals("3")) sql.append( " AND SUBSTR(K1.TREECD,1,6) ='"+str4+"'");
					if (str3.equals("4")) sql.append( " AND RTRIM(K1.TREECD) ='"+str4+"'");

					sql.append( " GROUP BY K1.DEPTNM, K2.EMPNMK, K3.MINORNM ,K1.TREECD, K3.SEQ                                  ");
					sql.append( " ORDER BY K1.TREECD, K3.SEQ ");
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