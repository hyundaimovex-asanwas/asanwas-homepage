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
public class h040001_s1 extends HttpServlet {

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
				String [] str = new String [14];
				str[0]	= req.getParameter("v_str1");		//부서코드
				str[1]	= req.getParameter("v_str2");		//직급
				str[2]	= req.getParameter("v_str3");		//사원명
				str[3]  = req.getParameter("v_str4");		//LEVEL
				str[4]  = req.getParameter("v_str5");		//TREECD

				for (int s=0;s<5;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","REGDIV","EMPNMK","CARRDIV","RECDIV",         
                                          "EMPDIV","FRDT","TODT","PAYDIV","RESINO",             
                                          "PICTURE","GRSTRTDT","STRTDT","DEPTCD","PAYGRD",
                                          "JOBGRPH","GRDDIV","PAYSEQ","FSAMDT",
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
																					"PAYGNM","LCSTNM","GETDT","LCSNO","ISSPART",
																					"DEPTPNM","CADDR","LSTEDU","PERAGE","WRKDAT",
																					"EDCCD","BCHK"
																					,"TREECD","SEQ"
																				};

				int[] intArrCN = new int[]{    7,  4, 20,  1,  4,          
                                       4,  8,  8,  4, 13,          
                                      30,  8,  8,  4,  4,          
                                       4,  4,  4,  8,           
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
																			30, 30,  8, 20, 30,
																		  30,150, 60,  4,  4,
																			 4,  1
																			,8,  3
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1,
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
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1
																		,-1,  0
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
					sql.append( "						A.EMPDIV,RTRIM(A.FRDT) AS FRDT,RTRIM(A.TODT) AS TODT,A.PAYDIV,A.RESINO,               ");
					sql.append( "						A.PICTURE,RTRIM(A.GRSTRTDT) AS GRSTRTDT,RTRIM(A.STRTDT) AS STRTDT,A.DEPTCD,RTRIM(A.PAYGRD) PAYGRD,        ");
					sql.append( "						A.JOBGRPH,A.GRDDIV,RTRIM(A.PAYSEQ) PAYSEQ,RTRIM(A.FSAMDT) AS FSAMDT,	        ");
					sql.append( "						RTRIM(A.ENDDT) AS ENDDT,A.USESTS,A.COSTDIV,RTRIM(A.DPOFFDT) AS DPOFFDT,RTRIM(A.LAMDT) AS LAMDT,           ");
					sql.append( "						RTRIM(A.LRMDT) AS LRMDT,RTRIM(A.BIRDT) AS BIRDT,A.GLDIV,A.HOBBY,A.NMC,                  ");
					sql.append( "						RTRIM(A.RILIGN) AS RILIGN,A.NME,A.BIRCITY,A.SPECIAL,A.OZIPCD,            ");
					sql.append( "						A.OADDR01,A.OADDR02,A.CZIPCD,A.CADDR01,A.CADDR02,       ");
					sql.append( "						A.TELNO,A.HPNO,A.OFFTELNO,A.EMAIL,A.HDFAMNM,            ");
					sql.append( "						A.HDFAMRET,A.HDFAMJOB,A.LABUNIYN,A.RELESAMT,A.MOVESAMT, ");
					sql.append( "						A.MRTDIV,A.MRTNO,A.REFCD,A.PAYBNKCD,A.PAYACNT,          ");
					sql.append( "						A.HOUSDIV,RTRIM(A.MRYDT) AS MRYDT,A.ENGLVL,A.TOESCR,A.JPTSCR,           ");
					sql.append( "						A.DELFSCR,A.TOFSCR,A.DALFSCR,A.TEPSSCR,A.ETCLNG,        ");
					sql.append( "						A.HWGRDCD,A.EXGRDCD,A.PWGRDCD,A.ACGRDCD,RTRIM(B.DEPTNM) AS DEPTNM,				");
					sql.append( "						RTRIM(C.MINORNM) AS PAYGNM, '' LCSTNM , '' GETDT,  '' LCSNO,  '' ISSPART,");
					sql.append( "						RTRIM(F.MINORNM) AS DEPTPNM, RTRIM(A.CADDR01) || RTRIM(A.CADDR02) AS CADDR, '' AS LSTEDU," + str[3] + " - CAST(SUBSTR(A.GRSTRTDT,1,4) AS INTEGER) AS WRKDAT, " + str[3] + "- CAST(SUBSTR(A.BIRDT,1,4) AS INTEGER) AS PERAGE, ");
					sql.append( "						'' AS EDCCD, 'F' AS BCHK ");
					sql.append( "						,B.TREECD, C.SEQ ");
					sql.append( "			  FROM PAYROLL.HIPERSON A ");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD ");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD = '2002' ");
//					sql.append( "            LEFT OUTER JOIN PAYROLL.HILICENS D ON A.EMPNO = D.EMPNO ");
//					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE E ON D.LCSTYPE = E.MINORCD AND E.MAJORCD = '1127' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE F ON B.DEPTPRT = F.MINORCD AND F.MAJORCD = '1111' ");
					sql.append( "				 WHERE A.EMPNMK LIKE '" + str[2] + "%'");
                    sql.append( "				     AND A.USESTS  !=  '3'"); 
//					sql.append( "			 LEFT OUTER JOIN PAYROLL.HIEDUC G ON A.EMPNO = G.EMPNO ");
//					sql.append( "      WHERE G.EDCCD = (SELECT MAX(EDCCD) FROM PAYROLL.HIEDUC WHERE EMPNO = A.EMPNO) ");

					if (!str[0].equals("")) sql.append( " AND A.DEPTCD = '" + str[0]+ "' ");
					if (!str[1].equals("")) sql.append( " AND A.GRDDIV = '" + str[1]+ "' ");

					if (str[3].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) ='" + str[4] + "'");
					if (str[3].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) ='" + str[4] + "'");
					if (str[3].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) ='" + str[4] + "'");
					if (str[3].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '"+ str[4] + "'");

					//sql.append( " ORDER BY B.TREECD, C.SEQ ");
					sql.append( " ORDER BY A.EMPNMK ");

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