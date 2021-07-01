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
public class h080001_s7 extends HttpServlet {

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

				if (str1==null) str1 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","ORDDT","SEQ","ORDCD","DEPTCD",
																					"PAYGRD","PAYSEQ","ENDDT","APPDT","JOBKIND",
																					"BASICPAY","ORDNM","DEPTNM","PAYGNM","GRDDIV", "ETC", "GRDDIVNM"
																				};

				int[] intArrCN = new int[]{  7,  8,  2,  4,  4, 
																		 4,  4,  8,  8,  4,
																		 9, 30, 30, 30,  4, 30, 30
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1,  0, -1, -1,
																		 -1, -1, -1, -1, -1,
																			0, -1, -1, -1, -1,-1,-1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					/* 2008.02.20 정영식 임의로 막음.
					sql.append( " SELECT		                                                                                ");
					sql.append( "    A.EMPNO,A.ORDDT,A.SEQ,A.ORDCD,RTRIM(A.DEPTCD) AS DEPTCD,																");
					sql.append( "	   RTRIM(A.PAYGRD) AS PAYGRD,A.PAYSEQ,RTRIM(A.ENDDT) AS ENDDT,RTRIM(A.APPDT) AS APPDT,		");
					sql.append( "    RTRIM(A.JOBKIND) AS JOBKIND, A.BASICPAY,																								");
					sql.append( "    RTRIM(B.ORDNM) AS ORDNM,RTRIM(C.DEPTNM) AS DEPTNM,RTRIM(D.MINORNM) AS PAYGNM,A.GRDDIV  ");
					sql.append( " FROM PAYROLL.T_HOORDER A												 																					");
					sql.append( " LEFT JOIN PAYROLL.HCORDCOD B ON A.ORDCD = B.ORDCD																					");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD = C.DEPTCD																					");
          sql.append( "                           AND C.CHGYM = (SELECT MAX(CHGYM)                                ");
          sql.append( "                                            FROM PAYROLL.HCDEPT                            ");
          sql.append( "                                           WHERE CHGYM <=( SELECT MAX(CASE WHEN SUBSTR(Z.APPDT,1,6)<='200712' THEN '200701'  ");
          sql.append( "                                                                      ELSE SUBSTR(Z.APPDT,1,6) END)                          ");
          sql.append( "                                                             FROM PAYROLL.T_HOORDER Z                                        ");
          sql.append( "                                                            WHERE A.EMPNO = Z.EMPNO                                          ");
          sql.append( "                                                              AND A.ORDDT = Z.ORDDT                                          ");
          sql.append( "                                                              AND A.SEQ = Z.SEQ                                              ");
          sql.append( "                                                          )                                                                  ");
          sql.append( "                                           )                                                                                 ");
				  //sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD = C.DEPTCD																					");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON A.PAYGRD = D.MINORCD AND D.MAJORCD='2002'									");
					sql.append( " WHERE A.EMPNO = '" + str1 + "'																														");
					*/

					sql.append( " SELECT		                                                                                ");
					sql.append( "    A.EMPNO,A.ORDDT,A.SEQ,A.ORDCD,RTRIM(A.DEPTCD) AS DEPTCD,																");
					sql.append( "	   RTRIM(A.PAYGRD) AS PAYGRD,A.PAYSEQ,RTRIM(A.ENDDT) AS ENDDT,RTRIM(A.APPDT) AS APPDT,		");
					sql.append( "    RTRIM(A.JOBKIND) AS JOBKIND, A.BASICPAY,																								");
					sql.append( "    RTRIM(B.ORDNM) AS ORDNM,  ");
					sql.append( "    CASE WHEN RTRIM(C.DEPTNM)='' OR C.DEPTNM IS NULL THEN E.DEPTNM ELSE RTRIM(C.DEPTNM) END DEPTNM,  ");
					sql.append( "    RTRIM(D.MINORNM) AS PAYGNM,A.GRDDIV, A.ETC, RTRIM(F.MINORNM)GRDDIVNM  ");
					sql.append( " FROM PAYROLL.T_HOORDER A												 																					");
					sql.append( " LEFT JOIN PAYROLL.HCORDCOD B ON A.ORDCD = B.ORDCD																					");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD = C.DEPTCD																					");
          sql.append( "                           AND C.CHGYM = (SELECT MAX(CHGYM)                                ");
          sql.append( "                                            FROM PAYROLL.HCDEPT                            ");
					sql.append( "                                           WHERE CHGYM <=( SELECT MAX(CASE WHEN Z.APPDT='20071231' THEN '200801'  ");
          //sql.append( "                                                                           WHEN SUBSTR(Z.APPDT,1,6)<='200712' THEN '200701'  ");
          //sql.append( "                                                                      ELSE SUBSTR(Z.APPDT,1,6) END)                          ");
          sql.append( "                                                                           WHEN Z.ORDDT <'20080107' THEN '200701'  ");
          sql.append( "                                                                      ELSE SUBSTR(Z.ORDDT,1,6) END)                          ");
					sql.append( "                                                             FROM PAYROLL.T_HOORDER Z                                        ");
          sql.append( "                                                            WHERE A.EMPNO = Z.EMPNO                                          ");
          sql.append( "                                                              AND A.ORDDT = Z.ORDDT                                          ");
          sql.append( "                                                              AND A.SEQ = Z.SEQ                                              ");
          sql.append( "                                                          )                                                                  ");
          sql.append( "                                           )                                                                                 ");
				  //sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD = C.DEPTCD																					");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON A.PAYGRD = D.MINORCD AND D.MAJORCD='2002'									");
          sql.append( " LEFT JOIN PAYROLL.HCDEPT_99 E ON A.DEPTCD = E.DEPTCD	");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE F ON A.GRDDIV =F.MINORCD AND F.MAJORCD='2001'									");
		
					sql.append( " WHERE A.EMPNO = '" + str1 + "'																														");

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