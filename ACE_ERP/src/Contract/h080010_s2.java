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
public class h080010_s2 extends HttpServlet {

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
					sql.append( "						 COALESCE(A.EMPNO,'')EMPNO,COALESCE(A.REGDIV,'')REGDIV,COALESCE(A.EMPNMK,'')EMPNMK,COALESCE(A.CARRDIV,'')CARRDIV,COALESCE(A.RECDIV,'')RECDIV,          \n ");
					sql.append( "						                        COALESCE(A.EMPDIV,'')EMPDIV,COALESCE(RTRIM(A.FRDT),'') AS FRDT, IFNULL(RTRIM(A.TODT),'') AS TODT, COALESCE(A.PAYDIV,'')PAYDIV,COALESCE(A.RESINO,'')RESINO,     \n ");
					sql.append( "						                        COALESCE(A.PICTURE,'')PICTURE,COALESCE(RTRIM(A.GRSTRTDT),'') AS GRSTRTDT,COALESCE(RTRIM(A.STRTDT),'') AS STRTDT,COALESCE(A.DEPTCD,'')DEPTCD,COALESCE(RTRIM(A.PAYGRD),'') PAYGRD,       \n ");
					sql.append( "						                        COALESCE(A.JOBGRPH,'')JOBGRPH,COALESCE(A.GRDDIV,'')GRDDIV,COALESCE(RTRIM(A.PAYSEQ),'') PAYSEQ,COALESCE(RTRIM(A.FSAMDT),'') AS FSAMDT, ");
					sql.append( "						                        COALESCE(RTRIM(A.ENDDT),'') AS ENDDT,A.USESTS,COALESCE(A.COSTDIV,'')COSTDIV,COALESCE(RTRIM(A.DPOFFDT),'') AS DPOFFDT,COALESCE(RTRIM(A.LAMDT),'') AS LAMDT,");
					sql.append( "						                        COALESCE(RTRIM(A.LRMDT),'') AS LRMDT,COALESCE(RTRIM(A.BIRDT),'') AS BIRDT,COALESCE(A.GLDIV,'')GLDIV,COALESCE(A.HOBBY,'')HOBBY,COALESCE(A.NMC,'')NMC, ");
					sql.append( "						                        COALESCE(RTRIM(A.RILIGN),'') AS RILIGN,COALESCE(A.NME,'')NME,COALESCE(A.BIRCITY,'')BIRCITY,COALESCE(A.SPECIAL,'')SPECIAL,COALESCE(A.OZIPCD,'')OZIPCD, ");
					sql.append( "						                        COALESCE(A.OADDR01,'')OADDR01,COALESCE(A.OADDR02,'')OADDR02,COALESCE(A.CZIPCD,'')CZIPCD,COALESCE(A.CADDR01,'')CADDR01,COALESCE(A.CADDR02,'')CADDR02, ");
					sql.append( "						                        COALESCE(A.TELNO,'')TELNO,COALESCE(A.HPNO,'')HPNO,COALESCE(A.OFFTELNO,'')OFFTELNO,COALESCE(A.EMAIL,'')EMAIL,COALESCE(A.HDFAMNM,'')HDFAMNM, ");
					sql.append( "						                        COALESCE(A.HDFAMRET,'')HDFAMRET,COALESCE(A.HDFAMJOB,'')HDFAMJOB,COALESCE(A.LABUNIYN,'')LABUNIYN,COALESCE(A.RELESAMT,'')RELESAMT,COALESCE(A.MOVESAMT,'')MOVESAMT, ");
					sql.append( "						                        COALESCE(A.MRTDIV,'')MRTDIV,COALESCE(A.MRTNO,'')MRTNO,COALESCE(A.REFCD,'')REFCD,COALESCE(A.PAYBNKCD,'')PAYBNKCD,COALESCE(A.PAYACNT,'')PAYACNT, ");
					sql.append( "						                        COALESCE(A.HOUSDIV,'')HOUSDIV,COALESCE(RTRIM(A.MRYDT),'') AS MRYDT,COALESCE(A.ENGLVL,'')ENGLVL,COALESCE(A.TOESCR,0)TOESCR ,COALESCE(A.JPTSCR,0)JPTSCR , ");
					sql.append( "						                        COALESCE(A.DELFSCR,0)DELFSCR,COALESCE(A.TOFSCR,0)TOFSCR,COALESCE(A.DALFSCR,0)DALFSCR,COALESCE(A.TEPSSCR,0)TEPSSCR,COALESCE(A.ETCLNG,'')ETCLNG, ");
					sql.append( "						                        COALESCE(A.HWGRDCD,'')HWGRDCD,COALESCE(A.EXGRDCD,'')EXGRDCD,COALESCE(A.PWGRDCD,'')PWGRDCD,COALESCE(A.ACGRDCD,'')ACGRDCD,COALESCE(RTRIM(B.DEPTNM),'') AS DEPTNM, ");
					sql.append( "						RTRIM(C.MINORNM) AS PAYGNM, '' LCSTNM , '' GETDT,  '' LCSNO,  '' ISSPART,\n ");
					sql.append( "						RTRIM(F.MINORNM) AS DEPTPNM, COALESCE(RTRIM(A.CADDR01) || RTRIM(A.CADDR02),'') AS CADDR, '' AS LSTEDU," + str[3] + " - CAST(SUBSTR(A.GRSTRTDT,1,4) AS INTEGER) AS WRKDAT, " + str[3] + "- CAST(SUBSTR(A.BIRDT,1,4) AS INTEGER) AS PERAGE, \n ");
					sql.append( "						'' AS EDCCD, 'F' AS BCHK \n ");
					sql.append( "						,B.TREECD, IFNULL(C.SEQ,0)SEQ \n ");
					sql.append( "			  FROM PAYROLL.T_HIPERSON A \n ");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD \n ");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD = '2002' \n ");
//					sql.append( "            LEFT OUTER JOIN PAYROLL.HILICENS D ON A.EMPNO = D.EMPNO \n ");
//					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE E ON D.LCSTYPE = E.MINORCD AND E.MAJORCD = '1127' \n ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE F ON B.DEPTPRT = F.MINORCD AND F.MAJORCD = '1111' \n ");
					sql.append( "				 WHERE A.EMPNMK LIKE '" + str[2] + "%'\n ");
          sql.append( "          AND A.EMPNO NOT IN ( '3040022' ) \n ");

//					sql.append( "				     AND A.USESTS  =  '1'\n ");
//					sql.append( "				     AND A.USESTS  =  '2'\n ");
//          sql.append( "				     AND A.USESTS  =  '3'\n "); 
//					sql.append( "			 LEFT OUTER JOIN PAYROLL.HIEDUC G ON A.EMPNO = G.EMPNO \n ");
//					sql.append( "      WHERE G.EDCCD = (SELECT MAX(EDCCD) FROM PAYROLL.HIEDUC WHERE EMPNO = A.EMPNO) \n ");

					if (!str[0].equals("")) sql.append( " AND A.DEPTCD = '" + str[0]+ "' \n ");
					if (!str[1].equals("")) sql.append( " AND A.GRDDIV = '" + str[1]+ "' \n ");

					if (str[3].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) ='" + str[4] + "'\n ");
					if (str[3].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) ='" + str[4] + "'\n ");
					if (str[3].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) ='" + str[4] + "'\n ");
					if (str[3].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '"+ str[4] + "'\n ");

					//sql.append( " ORDER BY B.TREECD, C.SEQ \n ");
					sql.append( " ORDER BY A.EMPNMK \n ");

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