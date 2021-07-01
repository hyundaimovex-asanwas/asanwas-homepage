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
public class h030004_s1 extends HttpServlet {

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
				String str1	= req.getParameter("v_str1");		//부서코드

				if (str1 == null) str1 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","REGDIV","EMPNMK","CARRDIV","RECDIV",         
                                          "EMPDIV","FRDT","TODT","PAYDIV","RESINO",             
                                          "PICTURE","GRSTRTDT","STRTDT","DEPTCD","PAYGRD",
                                          "JOBGRPH","JOBDTY","GRDDIV","PAYSEQ","FSAMDT",
                                          "ENDDT","USESTS","COSTDIV","DPOFFDT","LAMDT",
                                          "LRMDT","BIRDT","GLDIV","HOBBY","NMC",
                                          "RILIGN","NME","BIRCITY","SPECIAL","OZIPCD",
                                          "OADDR01","OADDR02","CZIPCD","CADDR01","CADDR02",
                                          "TELNO","HPNO","OFFTELNO","EMAIL","HDFAMNM",
                                          "HDFAMRET","HDFAMJOB","LABUNIYN","RELESAMT","MOVESAMT",
                                          "MRTDIV","MRTNO","REFCD","PAYBNKCD","PAYACNT",
                                          "HOUSDIV","MRYDT","ENGLVL","TOESCR","JPTSCR",
                                          "DELFSCR","TOFSCR","DALFSCR","TEPSSCR","ETCLNG",
                                          "HWGRDCD","EXGRDCD","PWGRDCD","ACGRDCD","DEPTNM",
																					"PAYGNM","GRDDNM","TREECD","LEVEL"
																				};

				int[] intArrCN = new int[]{    7,  4, 20,  1,  4,          
                                       4,  8,  8,  4, 13,          
                                      30,  8,  8,  4,  4,          
                                       4,  4,  4,  4,  8,           
                                       8,  4,  4,  8,  8,           
                                       8,  8,  1, 40, 20,         
                                       4, 40,  4, 40,  6,         
                                      70, 70,  6, 70, 70,       
                                      15, 15,  4, 30, 14,       
                                       4, 30,  1,  5,  5,      
                                       4, 20,  4,  4, 20,         
                                       4,  8,  1,  4,  4,       
                                       4,  4,  4,  4, 50, 
                                       1,  1,  1,  1, 70,
																		  30, 30,  8,  1

																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1,  0,  0,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1,  0,  0,
																		  0,  0,  0,  0, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "     SELECT  ");
					sql.append( "						A.EMPNO,A.REGDIV,A.EMPNMK,A.CARRDIV,A.RECDIV,           ");
					sql.append( "						A.EMPDIV,A.FRDT,A.TODT,A.PAYDIV,A.RESINO,               ");
					sql.append( "						A.PICTURE,RTRIM(A.GRSTRTDT) AS GRSTRTDT,RTRIM(A.STRTDT) AS STRTDT,A.DEPTCD,A.PAYGRD,        ");
					sql.append( "						A.JOBGRPH,A.JOBDTY,A.GRDDIV,A.PAYSEQ,A.FSAMDT,	        ");
					sql.append( "						A.ENDDT,A.USESTS,A.COSTDIV,A.DPOFFDT,A.LAMDT,           ");
					sql.append( "						A.LRMDT,A.BIRDT,A.GLDIV,A.HOBBY,A.NMC,                  ");
					sql.append( "						A.RILIGN,A.NME,A.BIRCITY,A.SPECIAL,A.OZIPCD,            ");
					sql.append( "						A.OADDR01,A.OADDR02,A.CZIPCD,A.CADDR01,A.CADDR02,       ");
					sql.append( "						A.TELNO,A.HPNO,A.OFFTELNO,A.EMAIL,A.HDFAMNM,            ");
					sql.append( "						A.HDFAMRET,A.HDFAMJOB,A.LABUNIYN,A.RELESAMT,A.MOVESAMT, ");
					sql.append( "						A.MRTDIV,A.MRTNO,A.REFCD,A.PAYBNKCD,A.PAYACNT,          ");
					sql.append( "						A.HOUSDIV,A.MRYDT,A.ENGLVL,A.TOESCR,A.JPTSCR,           ");
					sql.append( "						A.DELFSCR,A.TOFSCR,A.DALFSCR,A.TEPSSCR,A.ETCLNG,        ");
					sql.append( "						A.HWGRDCD,A.EXGRDCD,A.PWGRDCD,A.ACGRDCD,B.DEPTNM,				");
					sql.append( "						C.MINORNM AS PAYGNM, D.MINORNM AS GRDDNM,B.TREECD,B.LEVEL	");
					sql.append( "			  FROM PAYROLL.HIPERSON A, ");
					sql.append( "            PAYROLL.HCDEPT B, ");
					sql.append( "            PAYROLL.HCLCODE C ");
					sql.append( "            LEFT JOIN PAYROLL.HCLCODE D ON A.GRDDIV = D.MINORCD  AND D.MAJORCD = '2001' ");
					sql.append( "            LEFT JOIN PAYROLL.HCLCODE E ON A.PAYGRD = E.MINORCD  AND E.MAJORCD = '2002' ");
					
					//대기발령
          if(str1.equals("CA00")) sql.append( " WHERE (A.DEPTCD = '" + str1 + "' OR A.EMPNO IN ('2030001')) ");
					else sql.append( " WHERE A.DEPTCD = '" + str1 + "' ");
  				
					if(str1.equals("C100")) sql.append( " AND A.EMPNO NOT IN ('2030001') ");
					sql.append( "        AND A.USESTS IN ( '1', '2') ");
					sql.append( "        AND A.DEPTCD = B.DEPTCD ");
					sql.append( "        AND A.PAYGRD = C.MINORCD ");
					sql.append( "        AND C.MAJORCD = '2002' ");

					

					sql.append( "  ORDER BY B.DEPTNM, E.SEQ ");

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