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
public class h030005_s1 extends HttpServlet {

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
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "DEPTCD","DEPTNM","T1","T2","T3",
																					"T4","T5","T6","T7","T8",
																					"T9","T10","T11","T12","T13",
																					"T14","T15","T16","T17"
																				};

				int[] intArrCN = new int[]{  4, 30,  5,  5,  5,
																		 5,  5,  5,  5,  5,
																		 5,  5,  5,  5,  5,
																		 5,  5,  5,  5
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,  0,  0,  0
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT T.TREECD, S.DEPTCD, T.DEPTNM, SUM(S.T1) AS T1, SUM(S.T2) AS T2, SUM(S.T3) AS T3, SUM(S.T4) AS T4, SUM(S.T5) AS T5, SUM(S.T6) AS T6, SUM(S.T7) AS T7, SUM(S.T8) AS T8,	\n");
					sql.append( "              SUM(S.T9) AS T9, SUM(S.T10) AS T10, SUM(S.T11) AS T11, SUM(S.T12) AS T12, SUM(S.T13) AS T13, SUM(S.T14) AS T14, SUM(S.T15) AS T15, SUM(S.T16) AS T16, SUM(S.T8)+SUM(S.T16) AS T17	\n");
					sql.append( " FROM ( SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, COUNT(A.PAYGRD) AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5, 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10, 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.PAYGRD IN ('000','010','020','030','040','050','060','070','080','100','120')	\n");
					sql.append( "      AND A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('2','4') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, COUNT(A.PAYGRD) AS T2, 0 AS T3, 0 AS T4, 0 AS T5, 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10, 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.PAYGRD IN ('140','150','160','170')	\n");
					sql.append( "      AND A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('2','4') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, 0 AS T2, COUNT(A.PAYGRD) AS T3, 0 AS T4, 0 AS T5, 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10, 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.PAYGRD IN ('180','190')	\n");
					sql.append( "      AND A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('2','4') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, 0 AS T2, 0 AS T3, COUNT(A.PAYGRD) AS T4, 0 AS T5, 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10, 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.PAYGRD IN ('200','210')	\n");
					sql.append( "      AND A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('2','4') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, COUNT(A.PAYGRD) AS T5, 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10, 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.PAYGRD IN ('220','230')	\n");
					sql.append( "      AND A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('2','4') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5, COUNT(A.PAYGRD) AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10, 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.PAYGRD IN ('240','250','260','270','280','290')	\n");
					sql.append( "      AND A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('2','4') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5, 0 AS T6, COUNT(A.PAYGRD) AS T7, 0 AS T8, 0 AS T9, 0 AS T10, 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.PAYGRD NOT IN ('000','010','020','030','040','050','060','070','080','100','120','140','150','160','170','180','190','200','210','220','230','240','250','260','270','280','290') 	\n");
					sql.append( "      AND A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('2','4') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5, 0 AS T6, 0 AS T7, COUNT(A.PAYGRD) AS T8, 0 AS T9, 0 AS T10, 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('2','4') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5, 0 AS T6, 0 AS T7, 0 AS T8, COUNT(A.PAYGRD) AS T9, 0 AS T10, 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.PAYGRD IN ('000','010','020','030','040','050','060','070','080','100','120')	\n");
					sql.append( "      AND A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('3') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5, 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, COUNT(A.PAYGRD) AS T10, 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.PAYGRD IN ('140','150','160','170')	\n");
					sql.append( "      AND A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('3') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5, 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10, COUNT(A.PAYGRD) AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.PAYGRD IN ('180','190')	\n");
					sql.append( "      AND A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('3') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5, 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10, 0 AS T11, COUNT(A.PAYGRD) AS T12, 0 AS T13, 0 AS T14, 0 AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.PAYGRD IN ('200','210')	\n");
					sql.append( "      AND A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('3') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5, 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10, 0 AS T11, 0 AS T12, COUNT(A.PAYGRD) AS T13, 0 AS T14, 0 AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.PAYGRD IN ('220','230')	\n");
					sql.append( "      AND A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('3') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5, 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10, 0 AS T11, 0 AS T12, 0 AS T13, COUNT(A.PAYGRD) AS T14, 0 AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.PAYGRD IN ('240','250','260','270','280','290')	\n");
					sql.append( "      AND A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('3') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5, 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10, 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, COUNT(A.PAYGRD) AS T15, 0 AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.PAYGRD NOT IN ('000','010','020','030','040','050','060','070','080','100','120','140','150','160','170','180','190','200','210','220','230','240','250','260','270','280','290')	\n");
					sql.append( "      AND A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('3') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( "    UNION ALL	\n");
					sql.append( "   SELECT B.TREECD, A.DEPTCD, CASE INTEGER(RTRIM(A.JOBGRPH)) WHEN 3 THEN 2 ELSE 1 END AS JOBGRPH, 0 AS T1, 0 AS T2, 0 AS T3, 0 AS T4, 0 AS T5, 0 AS T6, 0 AS T7, 0 AS T8, 0 AS T9, 0 AS T10, 0 AS T11, 0 AS T12, 0 AS T13, 0 AS T14, 0 AS T15, COUNT(A.PAYGRD) AS T16	\n");
					sql.append( "     FROM PAYROLL.HIPERSON A	\n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD	\n");
					sql.append( "    WHERE A.USESTS <> '3'	\n");
					sql.append( "      AND RTRIM(A.JOBGRPH) IN ('3') AND B.TREECD NOT IN ('99999999')	\n");
					sql.append( "    GROUP BY B.TREECD, A.DEPTCD, A.JOBGRPH	\n");
					sql.append( " ) S	\n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT T ON S.DEPTCD = T.DEPTCD	\n");
					sql.append( " GROUP BY T.TREECD, S.DEPTCD, T.DEPTNM	\n");
					sql.append( " ORDER BY TREECD ASC	\n");

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