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
public class h030002_s1 extends HttpServlet {

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
				String [] str = new String [19];
				str[0]	= req.getParameter("v_str1");		//재직유무
				str[1]	= req.getParameter("v_str2");		//부서코드
				str[2]	= req.getParameter("v_str3");		//직종구분
				str[3]	= req.getParameter("v_str4");		//직위코드
				str[4]	= req.getParameter("v_str5");		//자격증코드
				str[5]	= req.getParameter("v_str6");		//입사일자 fr
				str[6]	= req.getParameter("v_str7");		//입사일자 to
				str[7]	= req.getParameter("v_str8");		//승진일자 fr
				str[8]	= req.getParameter("v_str9");		//승진일자 to
				str[9] = req.getParameter("v_str10");		//퇴사일자 fr
				str[10] = req.getParameter("v_str11");	//퇴사일자 to
				str[11] = req.getParameter("v_str12");	//생년월일 fr
				str[12] = req.getParameter("v_str13");	//생년월일 to
				str[13] = req.getParameter("v_str14");	//현재년
				str[14] = req.getParameter("v_str15");	//현재년월
				str[15] = req.getParameter("v_str16");	//별정직구분
				str[16] = req.getParameter("v_str17");	//LEVEL
				str[17] = req.getParameter("v_str18");  //TREECD
				str[18] = req.getParameter("v_str19");	//발령구분

				for (int s=0;s<=18;s++) {
					if (str[s]==null) str[s] = "";
				}

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
																					"PAYGNM",/*"LCSTNM","GETDT","LCSNO","ISSPART",*/
																					"DEPTPNM","CADDR","LSTEDU","PERAGE","WRKDAT",
																					"ASSGB","AFRDT","ATODT","ASSNO","ASSINST",
																					"ASSAMT","RECPAMT","ASSNAME","GRAYY","DUYEAR"
																					,"TREECD","SEQ","ORDCD","ORDNM"
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
																			30,/* 30,  8, 20, 30,*/
																		  30,150, 60,  4,  4,
																			 1,  8,  8, 20, 50,
																			 9,  6, 20,  4,  2
																			,8,  3,  2, 30

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
																		 -1, /*-1, -1, -1, -1,*/
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																			0,  0, -1, -1,  0
																		,-1,  0, -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "     SELECT  DISTINCT  ");
					sql.append( "						A.EMPNO,A.REGDIV,A.EMPNMK,'' AS CARRDIV,A.RECDIV, ");
					sql.append( "						A.EMPDIV,RTRIM(A.FRDT) AS FRDT,RTRIM(A.TODT) AS TODT,A.PAYDIV,A.RESINO, ");
					sql.append( "						A.PICTURE,RTRIM(A.GRSTRTDT) AS GRSTRTDT,RTRIM(A.STRTDT) AS STRTDT,A.DEPTCD,A.PAYGRD, ");
					sql.append( "						A.JOBGRPH,A.JOBDTY,A.GRDDIV,RTRIM(A.PAYSEQ) PAYSEQ,RTRIM(A.FSAMDT) AS FSAMDT,	");
					sql.append( "						RTRIM(A.ENDDT) AS ENDDT,A.USESTS,A.COSTDIV,RTRIM(A.DPOFFDT) AS DPOFFDT,RTRIM(A.LAMDT) AS LAMDT,           ");
					sql.append( "						RTRIM(A.LRMDT) AS LRMDT,RTRIM(A.BIRDT) AS BIRDT,A.GLDIV,A.HOBBY,A.NMC, ");
					sql.append( "						A.RILIGN,A.NME,A.BIRCITY,A.SPECIAL,A.OZIPCD, ");
					sql.append( "						A.OADDR01,A.OADDR02,A.CZIPCD,A.CADDR01,A.CADDR02, ");
					sql.append( "						A.TELNO,A.HPNO,A.OFFTELNO,A.EMAIL,A.HDFAMNM, ");
					sql.append( "						A.HDFAMRET,A.HDFAMJOB,A.LABUNIYN,A.RELESAMT,A.MOVESAMT, ");
					sql.append( "						A.MRTDIV,A.MRTNO,A.REFCD,A.PAYBNKCD,A.PAYACNT, ");
					sql.append( "						A.HOUSDIV,RTRIM(A.MRYDT) AS MRYDT,A.ENGLVL,A.TOESCR,A.JPTSCR, ");
					sql.append( "						A.DELFSCR,A.TOFSCR,A.DALFSCR,A.TEPSSCR,A.ETCLNG, ");
					sql.append( "						A.HWGRDCD,A.EXGRDCD,A.PWGRDCD,A.ACGRDCD,B.DEPTNM,	");
					sql.append( "						C.MINORNM AS PAYGNM, /*E.MINORNM AS LCSTNM,RTRIM(D.GETDT) AS GETDT,D.LCSNO,D.ISSPART,*/	");
					sql.append( "						F.MINORNM DEPTPNM, RTRIM(A.CADDR01) || ' ' || RTRIM(CADDR02) AS CADDR, G.SCHNM AS LSTEDU," + str[13] + " - CAST(SUBSTR(A.GRSTRTDT,1,4) AS INTEGER) AS WRKDAT, " + str[13] + "- CAST(SUBSTR(A.BIRDT,1,4) AS INTEGER) AS PERAGE,");
					sql.append( "						H.ASSGB, RTRIM(H.FRDT) AS AFRDT, RTRIM(H.TODT) AS ATODT, H.ASSNO, H.ASSINST, ");
					sql.append( "						COALESCE(H.ASSAMT,0) AS ASSAMT,COALESCE(H.RECPAMT,0) AS RECPAMT, H.ASSNAME, ");
					sql.append( "           G.GRAYY, COALESCE(I.DUYEAR,0) AS DUYEAR ");
					sql.append( "           , B.TREECD,C.SEQ ");
					sql.append( "           ,K.ORDCD,M.ORDNM ");
					sql.append( "			  FROM PAYROLL.HIPERSON A, PAYROLL.HCORDCOD M ");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HIEDUC G ON A.EMPNO = G.EMPNO ");
					sql.append( "                       AND G.GRAYY = (SELECT MAX(GRAYY) AS GRAYY ");
					sql.append( "                       FROM PAYROLL.HIEDUC WHERE EMPNO = A.EMPNO) ");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD = '2002' ");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HILICENS D ON A.EMPNO = D.EMPNO ");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE E ON D.LCSTYPE = E.MINORCD AND E.MAJORCD = '1127' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE F ON B.DEPTPRT = F.MINORCD AND F.MAJORCD = '1111' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HIASSUR H ON A.EMPNO = H.EMPNO");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.PBPAY I ON A.EMPNO = I.EMPNO AND I.APPDT = '" + str[14] + "'");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HOORDER K ON A.EMPNO = K.EMPNO ");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCORDCOD M ON K.ORDCD = M.ORDCD ");

					if (!str[0].equals("")) sql.append( " WHERE A.USESTS IN ('" + str[0] + "') ");
					else sql.append( " WHERE A.USESTS <> '' ");
					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					if (!str[2].equals("")) sql.append( " AND A.JOBGRPH = '" + str[2] + "'");
					if (!str[3].equals("")) sql.append( " AND A.PAYGRD = '" + str[3] + "'");
					if (!str[4].equals("")) sql.append( " AND D.LCSTYPE = '" + str[4] + "'");
					if (!str[5].equals("")) sql.append( " AND A.GRSTRTDT BETWEEN '" + str[5] + "' AND '" + str[6] + "'");
					if (!str[7].equals("")) sql.append( " AND A.LAMDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'");
					if (!str[9].equals("")) sql.append( " AND A.ENDDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'");
					if (!str[11].equals("")) sql.append( " AND A.BIRDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'");
					if (!str[15].equals("A")) sql.append( " AND A.EMPDIV = '2' ");

					if (str[16].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[17] + "'");
					if (str[16].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[17] + "'");
					if (str[16].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[17] + "'");
					if (str[16].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[17] + "'");
					if (!str[18].equals("")) sql.append( " AND K.ORDCD IN ('"+str[18]+"') ");

					sql.append( " ORDER BY B.TREECD ASC, C.SEQ ASC ");

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