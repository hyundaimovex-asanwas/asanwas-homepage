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
public class h080002_s1 extends HttpServlet {

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
				str[0]	= req.getParameter("v_str1");		//재직유무
				str[1]	= req.getParameter("v_str2");		//부서코드
				str[2]	= req.getParameter("v_str3");		//사원명
				str[3]	= req.getParameter("v_str4");		//현재일자

				for (int s=0;s<4;s++) {
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
																					"PAYGNM",
																					"DEPTPNM","CADDR","PERAGE","WRKDAT",
																					"PICFILE","ORDDT","HITCHYN","RELATNM","RELATGRD",
																					"RELATRE","NOMINNM","NOMINGRD","NOMINRE","HSKSCR",

																					"PAYAMT","AGENCY","SEX","PEOPLE","PASSPORT",
																					"PASSEDT","ADDRCHINA","LASTSCHNM","GRAYY","EDCGB",
																					"HEIGHT","WEIGHT","JOBKIND"
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
																			30,
																		  30,150,  4,  4,
																			 0,  8,  1, 20,  4,
																			 4, 20,  4,  4,  4,

																			 9,  4,  1,  4, 15,
																			 8, 70, 20,  4, 20,
																			 3,  3,  4
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
																		 -1,
																		 -1, -1, -1, -1,
																		 -2, -1, -1, -1, -1,
																		 -1, -1, -1, -1,  0,

																		  0, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																			0,  0, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						case -2 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_URL)); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "     SELECT  ");
					sql.append( "						A.EMPNO,A.REGDIV,A.EMPNMK,A.CARRDIV,A.RECDIV,           ");
					sql.append( "						A.EMPDIV,RTRIM(A.FRDT) AS	FRDT,RTRIM(A.TODT) AS TODT,A.PAYDIV,A.RESINO,               ");
					sql.append( "						A.PICTURE,RTRIM(A.GRSTRTDT) AS GRSTRTDT,RTRIM(A.STRTDT) AS STRTDT,A.DEPTCD,A.PAYGRD,        ");
					sql.append( "						A.JOBGRPH,A.JOBDTY,A.GRDDIV,A.PAYSEQ,RTRIM(A.FSAMDT) AS FSAMDT,	        ");
					sql.append( "						RTRIM(A.ENDDT) AS ENDDT,A.USESTS,A.COSTDIV,RTRIM(A.DPOFFDT) AS DPOFFDT,RTRIM(A.LAMDT) AS LAMDT,           ");
					sql.append( "						RTRIM(A.LRMDT) AS LRMDT,RTRIM(A.BIRDT) AS BIRDT,A.GLDIV,A.HOBBY,A.NMC,                  ");
					sql.append( "						RTRIM(A.RILIGN) AS RILIGN,A.NME,A.BIRCITY,A.SPECIAL,A.OZIPCD,            ");
					sql.append( "						A.OADDR01,A.OADDR02,A.CZIPCD,A.CADDR01,A.CADDR02,       ");
					sql.append( "						A.TELNO,A.HPNO,A.OFFTELNO,A.EMAIL,A.HDFAMNM,            ");
					sql.append( "						A.HDFAMRET,A.HDFAMJOB,A.LABUNIYN,A.RELESAMT,A.MOVESAMT, ");
					sql.append( "						A.MRTDIV,A.MRTNO,A.REFCD,A.PAYBNKCD,A.PAYACNT,          ");
					sql.append( "						A.HOUSDIV,RTRIM(A.MRYDT) AS MRYDT,A.ENGLVL,A.TOESCR,A.JPTSCR,           ");
					sql.append( "						A.DELFSCR,A.TOFSCR,A.DALFSCR,A.TEPSSCR,A.ETCLNG,        ");
					sql.append( "						A.HWGRDCD,A.EXGRDCD,A.PWGRDCD,A.ACGRDCD,B.DEPTNM,				");
					sql.append( "						C.MINORNM AS PAYGNM, ");
					sql.append( "						F.MINORNM DEPTPNM, A.CADDR01 || CADDR02 AS CADDR, " + str[3] + " - CAST(SUBSTR(A.GRSTRTDT,1,4) AS INTEGER) AS WRKDAT, " + str[3] + "- CAST(SUBSTR(A.BIRDT,1,4) AS INTEGER) AS PERAGE, ");
					sql.append( "						A.PICFILE, RTRIM(A.ORDDT) AS ORDDT, A.HITCHYN, ");
					sql.append( "						A.RELATNM, A.RELATGRD, A.RELATRE, A.NOMINNM, A.NOMINGRD, ");
					sql.append( "						A.NOMINRE, A.HSKSCR, ");
					sql.append( "						A.PAYAMT, A.AGENCY, A.SEX, A.PEOPLE, A.PASSPORT, ");
					sql.append( "						A.PASSEDT, A.ADDRCHINA, A.LASTSCHNM, A.GRAYY, A.EDCGB, ");
					sql.append( "						COALESCE(AA.HEIGHT,0) AS HEIGHT, COALESCE(AA.WEIGHT,0) AS WEIGHT, A.JOBKIND ");
					sql.append( "			  FROM PAYROLL.T_HIPERSON A ");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD ");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD = '2002' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE F ON B.DEPTPRT = F.MINORCD AND F.MAJORCD = '1111' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.T_HIASSUR AA ON A.EMPNO = AA.EMPNO ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AB ON AA.DISDIV = AB.MINORCD AND AB.MAJORCD = '1135' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AC ON AA.DISGRD = AC.MINORCD AND AC.MAJORCD = '1136' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AD ON AA.MILIDIV = AD.MINORCD AND AD.MAJORCD = '1168' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AE ON AA.MILIGRD = AE.MINORCD AND AE.MAJORCD = '1134' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AF ON AA.MILISPEC = AF.MINORCD AND AF.MAJORCD = '1147' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AG ON AA.MILITYPE = AG.MINORCD AND AG.MAJORCD = '1133' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AH ON AA.MILITGBN = AH.MINORCD AND AH.MAJORCD = '2021' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AI ON AA.COLBLNYN = AI.MINORCD AND AI.MAJORCD = '2022' ");

					sql.append( "      WHERE A.EMPNMK LIKE '" + str[2] + "%' ");
					sql.append( "				 AND A.EMPDIV = '5' ");

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