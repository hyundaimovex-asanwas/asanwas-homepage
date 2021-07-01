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
public class h050004_s8 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		Statement stmt =null;
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
				String str1	= req.getParameter("v_str1");		//기준월
				String str2	= req.getParameter("v_str2");		//근태구분

				if (str1==null) { str1 = ""; }
				if (str2==null) { str2 = ""; }

				GauceRes.enableFirstRow(dSet);
              
				String[] strArrCN = new String[]{ "EMPNO","EMPNMK","DEPTCD","DEPTNM", "PAYGRD","PAYGRDNM",
					                                "GRSTRTDT","STRTDT",  "PAYSEQ", "PAYSEQNM",
                                          "TEMP1","TEMP2","TEMP3","TEMP4","TEMP5",
                                          "TEMP6","TEMP7","TEMP8","TEMP9","TEMP10",
                                          "TEMP11","TEMP12","TCNT1"
																					};

				int[] intArrCN = new int[]{  7, 20,  4, 50,  4, 30,
					                           8,  8,  4, 30,
																		 1,  1,  1,  1,  1,
																		 1,  1,  1,  1,  1,
																		 1,  1,  2
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1,
																		  0,  0,  0,  0,  0,
																		  0,  0,  0,  0,  0,
																		  0,  0,  0
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
       
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
				
					sql.append( " SELECT RTRIM(S.EMPNO) EMPNO, RTRIM(B.EMPNMK) EMPNMK, S.DEPTCD, C.DEPTNM,          ");
					sql.append( " 		 S.PAYGRD, D.MINORNM PAYGRDNM, MAX(B.GRSTRTDT)GRSTRTDT, MAX(B.STRTDT)STRTDT,  ");
          sql.append( " 		 MAX(B.PAYSEQ) PAYSEQ, MAX(E.MINORNM) PAYSEQNM ,");
					sql.append( " 		 SUM(INTEGER(T1)) AS TEMP1,   SUM(INTEGER(T2)) AS TEMP2,                       ");
					sql.append( " 		 SUM(INTEGER(T3)) AS TEMP3,   SUM(INTEGER(T4)) AS TEMP4,                       ");
					sql.append( " 		 SUM(INTEGER(T5)) AS TEMP5,   SUM(INTEGER(T6)) AS TEMP6,                       ");
					sql.append( " 		 SUM(INTEGER(T7)) AS TEMP7,   SUM(INTEGER(T8)) AS TEMP8,                       ");
					sql.append( " 		 SUM(INTEGER(T9)) AS TEMP9,   SUM(INTEGER(T10)) AS TEMP10,                     ");
					sql.append( " 		 SUM(INTEGER(T11)) AS TEMP11, SUM(INTEGER(T12)) AS TEMP12,                    ");
					sql.append( " 		 SUM(CNT) AS TCNT1                                                              ");
					sql.append( "  FROM (  SELECT T.EMPNO,T.DEPTCD,T.PAYGRD,                                   ");
					sql.append( "            CASE T.USEDT WHEN '01' THEN COUNT(T.EMPNO) END AS T1,             ");
					sql.append( "            CASE T.USEDT WHEN '02' THEN COUNT(T.EMPNO) END AS T2,             ");
					sql.append( "            CASE T.USEDT WHEN '03' THEN COUNT(T.EMPNO) END AS T3,             ");
					sql.append( "            CASE T.USEDT WHEN '04' THEN COUNT(T.EMPNO) END AS T4,             ");
					sql.append( "            CASE T.USEDT WHEN '05' THEN COUNT(T.EMPNO) END AS T5,             ");
					sql.append( "            CASE T.USEDT WHEN '06' THEN COUNT(T.EMPNO) END AS T6,             ");
					sql.append( "            CASE T.USEDT WHEN '07' THEN COUNT(T.EMPNO) END AS T7,             ");
					sql.append( "            CASE T.USEDT WHEN '08' THEN COUNT(T.EMPNO) END AS T8,             ");
					sql.append( "            CASE T.USEDT WHEN '09' THEN COUNT(T.EMPNO) END AS T9,             ");
					sql.append( "            CASE T.USEDT WHEN '10' THEN COUNT(T.EMPNO) END AS T10,            ");
					sql.append( "            CASE T.USEDT WHEN '11' THEN COUNT(T.EMPNO) END AS T11,            ");
					sql.append( "            CASE T.USEDT WHEN '12' THEN COUNT(T.EMPNO) END AS T12,            ");
					sql.append( "            0 CNT                                                             ");
					sql.append( "            FROM ( SELECT A.EMPNO, SUBSTR(A.USEDT,5,2) AS USEDT, A.DEPTCD,          ");
					sql.append( "                          A.PAYSEQ AS PAYGRD                                        ");
					sql.append( "                     FROM PAYROLL.HLDUTYC07 A                                       ");
					sql.append( "                         WHERE A.CODE ='" + str2 + "'                               ");
					sql.append( "                           AND SUBSTR(A.USEDT,1,4)='" +str1 + "'                    ");
					sql.append( "                         ORDER BY  A.EMPNO, A.USEDT                                 ");
					sql.append( "                 ) T                                                                ");
					sql.append( "            GROUP BY T.EMPNO, T.DEPTCD, T.PAYGRD, T.USEDT                           ");
					sql.append( "            UNION ALL                                                               ");
          sql.append( "            /*합계*/                                                                ");
					sql.append( "            SELECT A.EMPNO,A.DEPTCD,A.PAYSEQ AS PAYGRD ,                            ");
					sql.append( "                   0 T1, 0 T2,0 T3,0 T4,0 T5,0 T6,0 T7,0 T8,0 T9,0 T10,0 T11,0 T12, ");
					sql.append( "                   COUNT(A.EMPNO)CNT                                                ");
					sql.append( "              FROM PAYROLL.HLDUTYC07 A                                              ");
					sql.append( "             WHERE A.CODE ='" + str2 + "'                                           ");
					sql.append( "               AND SUBSTR(A.USEDT,1,4)='" +str1 + "'                                ");
					sql.append( "            GROUP BY SUBSTR(A.USEDT,1,4),A.EMPNO,A.DEPTCD,A.PAYSEQ                  ");
					sql.append( "            ORDER BY EMPNO                                                          ");
					sql.append( "    ) S                                                                             ");
					sql.append( "  LEFT JOIN PAYROLL.HIPERSON B ON B.EMPNO = S.EMPNO                                 ");
					sql.append( "  LEFT JOIN PAYROLL.HCDEPT   C ON C.DEPTCD = S.DEPTCD                               ");
					sql.append( "  LEFT JOIN PAYROLL.HCLCODE  D ON D.MINORCD = B.PAYGRD AND D.MAJORCD = '2002'       ");
					sql.append( "  LEFT JOIN PAYROLL.HCLCODE  E ON B.PAYSEQ = E.MINORCD AND E.MAJORCD = '1184'       ");
					sql.append( "  GROUP BY S.EMPNO, B.EMPNMK, S.DEPTCD, C.DEPTNM, S.PAYGRD, D.MINORNM               ");
					sql.append( "  ORDER BY S.PAYGRD, PAYSEQ DESC, GRSTRTDT                                                                  ");
					
//				if (!str1.equals("")) sql.append( " AND A.USESTS = '" + str1 + "' ");
//				if (!str2.equals("")) sql.append( " AND A.DEPTCD = '" + str2 + "' ");
         
				 	//logger.dbg.println(this,sql.toString());
/*********************************************************************************************/
       
					stmt = conn.createStatement();
					ResultSet rs = stmt.executeQuery(sql.toString());

					int icnt = 0;
					while(rs.next()){
						GauceDataRow row = dSet.newDataRow();
		   	 		row = dSet.newDataRow();
						for (int k=1;k<strArrCN.length ;k++ ) {
							if (k<11) row.addColumnValue(new String(rs.getString(k).getBytes("KSC5601"),"8859_1"));
							else row.addColumnValue(rs.getDouble(k));
						}
 		  			dSet.addDataRow(row);
					}
         
					if (rs!=null) rs.close();

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