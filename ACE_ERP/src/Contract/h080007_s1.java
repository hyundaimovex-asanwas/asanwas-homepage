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
public class h080007_s1 extends HttpServlet {

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
				str[4]	= req.getParameter("v_str5");		//Level
				str[5]	= req.getParameter("v_str6");		//treecd
				str[6]	= req.getParameter("v_str7");		//userid

				for (int s=0;s<7;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","REGDIV","EMPNMK","CARRDIV","RECDIV","RECDIVNM",         
                                          "EMPDIV","EMPDIVNM","FRDT","TODT","PAYDIV","RESINO",             
                                          "PICTURE","GRSTRTDT","STRTDT","DEPTCD","PAYGRD",
                                          "JOBGRPH","JOBGRPHNM","JOBDTY","GRDDIV","PAYSEQ","FSAMDT",
                                          "ENDDT","USESTS","COSTDIV","DPOFFDT","LAMDT",
                                          "LRMDT","BIRDT","GLDIV","HOBBY","NMC",
                                          "RILIGN","RILIGNM","NME","BIRCITY","SPECIAL","OZIPCD",
                                          "OADDR01","OADDR02","CZIPCD","CADDR01","CADDR02",
																					"OADDRNM","CADDRNM",
                                          "TELNO","HPNO","OFFTELNO","EMAIL","HDFAMNM",
                                          "HDFAMRET","HDFAMJOB","LABUNIYN","RELESAMT","MOVESAMT",
                                          "MRTDIV","MRTDIVNM","MRTNO","REFCD","PAYBNKCD","PAYBNKCDNM",
																					"PAYACNT","HOUSDIV","MRYDT","ENGLVL","TOESCR","JPTSCR",
                                          "DELFSCR","TOFSCR","DALFSCR","TEPSSCR","ETCLNG",
                                          "HWGRDCD","EXGRDCD","PWGRDCD","ACGRDCD","DEPTNM",
																					"PAYGNM",
																					"DEPTPNM","CADDR","PERAGE","WRKDAT",
																					"PICFILE","ORDDT","HITCHYN","RELATNM","RELATGRD",
																					"RELATRE","NOMINNM","NOMINGRD","NOMINRE","HSKSCR",

																					"AFRDT","ATODT","ASSAMT","ASSINST",
																					"ASSGB","ASSNO","RECPAMT","DISDIV","DISGRD",
																					"HOSDT","HOSPITAL","HOSREVIT","HOSMEMO","EYEL",
																					"EYER","HEIGHT","WEIGHT","BLOOD","COLBLNYN",
																					"RHANDYN","MILIDIV","MILIKND","MILIGRD","MILINO",
																					"MILIPLC","MILIFRDT","MILITODT","NMREASON","MILITYPE",
																					"MILISPEC","MILIGBN","MILITGBN","ASSNAME","ASSRELA",
																					"ASSRESINO","ASSTELNO","ASSPOSTNO","ASSADDR",
																					"DISDNM","DISGNM","MILDNM",
																					"MILGNM","MILKNM","MILTNM",
																					"MILHNM","COLBNM","SEX","TRAINYN",
																					"JOBKIND","JOBKINDNM","INSCOD","PENCOD"
																					,"TREECD","LEVEL"

				};

				int[] intArrCN = new int[]{    7,  4, 20,  1,  4, 30,          
                                       4, 30,  8,  8,  4, 13,          
                                      30,  8,  8,  4,  4,          
                                       4, 30,  4,  4,  4,  8,           
                                       8,  4,  4,  8,  8,           
                                       8,  8,  1, 40, 20,         
                                       4, 30, 40,  4, 40,  6,         
                                      70, 70,  6, 70, 70,
																			70, 70,
                                      15, 15,  4, 30, 14,       
                                       4, 30,  1,  5,  5,      
                                       4, 30, 20,  4,  4, 30, 
																			20,  4,  8,  1,  4,  4,       
                                       4,  4,  4,  4, 50, 
                                       1,  1,  1,  1, 70,
																			30,
																		  30,150,  4,  4,
																			 0,  8,  1, 20,  4,

																			 4, 20,  4,  4,  4,
																			 8,  8,   9, 50,
																		  1, 20,  6,   4,  4,
																		  8, 20,  1,  50,  2,
																		  2,  3,  3,   2,  1,
																		  1,  4,  4,   4, 15,
																		 30,  8,  8,  40,  4,
																			4,  1,  1,  20,  4,
																		 13, 15,  6, 100,
																		 40, 40, 40,  40, 40,
																		 40, 40, 40,  30,  1,
																		  4, 30,  3,  3
																		 ,8,  1
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1,  0,  0,
																		 -1, -1, -1, -1, -1, -1, 
																		 -1, -1, -1, -1,  0,  0,
																		  0,  0,  0,  0, -1,
																		 -1, -1, -1, -1, -1,
																		 -1,
																		 -1, -1, -1, -1,
																		 -2, -1, -1, -1, -1,
																		 -1, -1, -1, -1,  0,

																		 -1, -1,  0, -1,
																		 -1, -1,  0, -1, -1,
																		 -1, -1, -1, -1,  1,
																		  1,  0,  0, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1,  0,  0
																		,-1, -1
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
					sql.append( " SELECT  \n");
					sql.append( "			A.EMPNO,A.REGDIV,A.EMPNMK,A.CARRDIV,A.RECDIV,RTRIM(I.MINORNM) RECDIVNM, \n");
					sql.append( "			A.EMPDIV,RTRIM(H.MINORNM) EMPDIVNM, RTRIM(A.FRDT) FRDT,RTRIM(A.TODT) TODT,A.PAYDIV,A.RESINO, \n");
					sql.append( "			A.PICTURE,RTRIM(A.GRSTRTDT) GRSTRTDT,RTRIM(A.STRTDT) STRTDT,A.DEPTCD,A.PAYGRD, \n");
					sql.append( "			A.JOBGRPH,RTRIM(G.MINORNM) JOBGRPHNM,A.JOBDTY,A.GRDDIV,A.PAYSEQ,RTRIM(A.FSAMDT) FSAMDT,	\n");
					sql.append( "			RTRIM(A.ENDDT) ENDDT,A.USESTS,A.COSTDIV,RTRIM(A.DPOFFDT) AS DPOFFDT,RTRIM(A.LAMDT) AS LAMDT, \n");
					sql.append( "			RTRIM(A.LRMDT) LRMDT,RTRIM(A.BIRDT) AS BIRDT,A.GLDIV,A.HOBBY,A.NMC, \n");
					sql.append( "			RTRIM(A.RILIGN) RILIGN,RTRIM(K.MINORNM) RILIGNM,A.NME,A.BIRCITY,A.SPECIAL,A.OZIPCD, \n");
					sql.append( "			RTRIM(A.OADDR01) OADDR01,RTRIM(A.OADDR02) AS OADDR02,A.CZIPCD, \n");
					sql.append( "      RTRIM(A.CADDR01) CADDR01,RTRIM(A.CADDR02) AS CADDR02, \n");
					sql.append( "			RTRIM(A.OADDR01) || ' ' || RTRIM(A.OADDR02) AS OADDRNM, \n");
					sql.append( "			RTRIM(A.CADDR01) || ' ' || RTRIM(A.CADDR02) AS CADDRNM, \n");
					sql.append( "			A.TELNO,A.HPNO,A.OFFTELNO,A.EMAIL,A.HDFAMNM, \n");
					sql.append( "			A.HDFAMRET,A.HDFAMJOB,A.LABUNIYN,A.RELESAMT,A.MOVESAMT, \n");
					sql.append( "			A.MRTDIV,RTRIM(L.MINORNM) MRTDIVNM,A.MRTNO,A.REFCD,A.PAYBNKCD,RTRIM(M.MINORNM) PAYBNKCDNM,A.PAYACNT, \n");
					sql.append( "			A.HOUSDIV,RTRIM(A.MRYDT) AS MRYDT,A.ENGLVL,A.TOESCR,A.JPTSCR, \n");
					sql.append( "			A.DELFSCR,A.TOFSCR,A.DALFSCR,A.TEPSSCR,A.ETCLNG, \n");
					sql.append( "			A.HWGRDCD,A.EXGRDCD,A.PWGRDCD,A.ACGRDCD,B.DEPTNM,	\n");
					sql.append( "			C.MINORNM AS PAYGNM, F.MINORNM DEPTPNM, \n");
					sql.append( "			A.CADDR01 || CADDR02 AS CADDR, "+str[3]+" - CAST(SUBSTR(A.GRSTRTDT,1,4) AS INTEGER) WRKDAT, " + str[3] + "- CAST(SUBSTR(A.BIRDT,1,4) AS INTEGER) PERAGE, \n");
					sql.append( "			A.PICFILE, RTRIM(A.ORDDT) AS ORDDT, A.HITCHYN, A.RELATNM, A.RELATGRD, A.RELATRE, A.NOMINNM, A.NOMINGRD, \n");
					sql.append( "			A.NOMINRE, A.HSKSCR, RTRIM(AA.FRDT) AFRDT, RTRIM(AA.TODT) AS ATODT, COALESCE(AA.ASSAMT,0) AS ASSAMT, \n");
					sql.append( "			RTRIM(AA.ASSINST) ASSINST, RTRIM(AA.ASSGB) ASSGB, RTRIM(AA.ASSNO) ASSNO, COALESCE(AA.RECPAMT,0) RECPAMT, \n");
					sql.append( "			RTRIM(AA.DISDIV) DISDIV,	RTRIM(AA.DISGRD) DISGRD, \n");
					sql.append( "			RTRIM(AA.HOSDT) HOSDT , RTRIM(AA.HOSPITAL) HOSPITAL, RTRIM(AA.HOSREVIT) HOSREVIT, \n");
					sql.append( "     RTRIM(AA.HOSMEMO) HOSMEMO, COALESCE(AA.EYEL,0) EYEL, COALESCE(AA.EYER,0) EYER, COALESCE(AA.HEIGHT,0) HEIGHT, \n");
					sql.append( "			COALESCE(AA.WEIGHT,0) AS WEIGHT, RTRIM(AA.BLOOD) AS BLOOD, RTRIM(AA.COLBLNYN) AS COLBLNYN, \n");
					sql.append( "			RTRIM(AA.RHANDYN) RHANDYN,	  RTRIM(AA.MILIDIV) AS MILIDIV,	RTRIM(AA.MILIKND) AS MILIKND,	\n");
					sql.append( "     RTRIM(AA.MILIGRD)  MILIGRD,	  RTRIM(AA.MILINO) AS MILINO, RTRIM(AA.MILIPLC) MILIPLC, \n");
					sql.append( "			RTRIM(AA.MILIFRDT) MILIFRDT,	RTRIM(AA.MILITODT) AS MILITODT,	RTRIM(AA.NMREASON) AS NMREASON,	\n"); 
					sql.append( "     RTRIM(AA.MILITYPE) MILITYPE,  RTRIM(AA.MILISPEC) MILISPEC,	  RTRIM(AA.MILIGBN) AS MILIGBN, \n");
					sql.append( "			RTRIM(AA.MILITGBN) MILITGBN,	RTRIM(AA.ASSNAME) AS ASSNAME,		RTRIM(AA.ASSRELA) AS ASSRELA, \n");
					sql.append( "			RTRIM(AA.ASSRESINO) ASSRESINO,RTRIM(AA.ASSTELNO) AS ASSTELNO,	RTRIM(AA.ASSPOSTNO) AS ASSPOSTNO,	\n");
					sql.append( "     RTRIM(AA.ASSADDR) AS ASSADDR, RTRIM(AB.MINORNM) DISDNM, RTRIM(AC.MINORNM) AS DISGNM, \n");
					sql.append( "			RTRIM(AD.MINORNM) AS MILDNM, RTRIM(AE.MINORNM) MILGNM, RTRIM(AF.MINORNM) AS MILKNM, \n");
					sql.append( "			RTRIM(AG.MINORNM) AS MILTNM, RTRIM(AH.MINORNM) MILHNM, RTRIM(AI.MINORNM) AS COLBNM, \n");
					sql.append( "			CASE WHEN A.SEX='1' THEN '남자' ELSE '여자' END AS SEX, \n");
					sql.append( "     A.TRAINYN, A.JOBKIND, RTRIM(J.MINORNM) JOBKINDNM, A.INSCOD, A.PENCOD, \n");
					sql.append( "			B.TREECD,B.LEVEL \n");
					sql.append( " FROM PAYROLL.T_HIPERSON A \n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCDEPT  B  ON A.DEPTCD    = B.DEPTCD \n");
					sql.append( "     LEFT OUTER JOIN PAYROLL.HCLCODE C  ON A.PAYGRD    = C.MINORCD AND C.MAJORCD = '2002'   \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE F  ON B.DEPTPRT   = F.MINORCD AND F.MAJORCD = '1111'   \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HIASSUR AA ON A.EMPNO     = AA.EMPNO ");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE AB ON AA.DISDIV   = AB.MINORCD AND AB.MAJORCD = '1135' \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE AC ON AA.DISGRD   = AC.MINORCD AND AC.MAJORCD = '1136' \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE AD ON AA.MILIDIV  = AD.MINORCD AND AD.MAJORCD = '1168' \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE AE ON AA.MILIGRD  = AE.MINORCD AND AE.MAJORCD = '1134' \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE AF ON AA.MILIKND  = AF.MINORCD AND AF.MAJORCD = '1116' \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE AG ON AA.MILITYPE = AG.MINORCD AND AG.MAJORCD = '1133' \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE AH ON AA.MILITGBN = AH.MINORCD AND AH.MAJORCD = '2021' \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE AI ON AA.COLBLNYN = AI.MINORCD AND AI.MAJORCD = '2022' \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE G  ON A.JOBGRPH   = G.MINORCD  AND G.MAJORCD  = '2000' \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE H  ON A.EMPDIV    = H.MINORCD  AND H.MAJORCD  = '1119' \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE I  ON A.RECDIV    = I.MINORCD  AND I.MAJORCD  = '2035' \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE J  ON A.JOBKIND   = J.MINORCD  AND J.MAJORCD  = '2034' \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE K  ON A.RILIGN    = K.MINORCD  AND K.MAJORCD  = '1117' \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE L  ON A.MRTDIV    = L.MINORCD  AND L.MAJORCD  = '1135' \n");
					sql.append( "			LEFT OUTER JOIN PAYROLL.HCLCODE M  ON A.PAYBNKCD  = M.MINORCD  AND M.MAJORCD  = '1411' \n");

					sql.append( " WHERE A.EMPNMK LIKE '" + str[2] + "%' \n");

					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND A.USESTS = '" + str[0] + "' \n");
					//if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND A.DEPTCD = '" + str[1]+ "' ");
					//if (!str[2].equals("")) sql.append( " AND A.EMPNMK LIKE '" + str[2] + "%'");
					if (!str[6].equals("")) sql.append( " AND A.EMPNO = '" + str[6] + "'             \n");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4)= '" + str[5] +"'  \n");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4)= '" + str[5] + "' \n");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6)= '" + str[5] +"'  \n");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD)= '" + str[5] + "'      \n");
                    
					sql.append( "      ORDER BY B.TREECD, C.SEQ  \n");
					
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