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
public class h030001_s1 extends HttpServlet {

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



				for (int s=0;s<6;s++) {
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
																					"OADDRNM","CADDRNM",
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
																					"JOBKIND","INSCOD","PENCOD"

				};

				int[] intArrCN = new int[]{    7,  4, 20,  1,  4,          
                                       4,  8,  8,  4, 13,          
                                      30,  8,  8,  4,  4,          
                                       4,  4,  4,  4,  8,           
                                       8,  4,  4,  8,  8,           
                                       8,  8,  1, 40, 20,         
                                       4, 40,  4, 40,  6,         
                                      70, 70,  6, 70, 70,
																			70, 70,
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
																			 8,  8,   9, 50,
																		  1, 20,  6,   4,  4,
																		  8, 20,  1,  50,  2,
																		  2,  3,  3,   2,  1,
																		  1,  4,  4,   4, 15,
																		 30,  8,  8,  40,  4,
																			4,  1,  1,  20,  4,
																		 13, 15,  6, 100,
																		 40, 40, 40,  40, 40,
																		 40, 40, 40,   1,  1,
																		  4,  3,  3   
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1,
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
																		 -1,  0,  0
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
					sql.append( "						SELECT  ");
					sql.append( "						A.EMPNO,A.REGDIV,A.EMPNMK,A.CARRDIV,A.RECDIV,           ");
					sql.append( "						A.EMPDIV,RTRIM(A.FRDT) AS	FRDT,RTRIM(A.TODT) AS TODT,A.PAYDIV,A.RESINO,               ");
					sql.append( "						A.PICTURE,RTRIM(A.GRSTRTDT) AS GRSTRTDT,RTRIM(A.STRTDT) AS STRTDT,A.DEPTCD,A.PAYGRD,        ");
					sql.append( "						A.JOBGRPH,A.JOBDTY,A.GRDDIV,A.PAYSEQ,RTRIM(A.FSAMDT) AS FSAMDT,	        ");
					sql.append( "						RTRIM(A.ENDDT) AS ENDDT,A.USESTS,A.COSTDIV,RTRIM(A.DPOFFDT) AS DPOFFDT,RTRIM(A.LAMDT) AS LAMDT,           ");
					sql.append( "						RTRIM(A.LRMDT) AS LRMDT,RTRIM(A.BIRDT) AS BIRDT,A.GLDIV,A.HOBBY,A.NMC,                  ");
					sql.append( "						RTRIM(A.RILIGN) AS RILIGN,A.NME,A.BIRCITY,A.SPECIAL,A.OZIPCD,            ");
					sql.append( "						RTRIM(A.OADDR01) AS OADDR01,RTRIM(A.OADDR02) AS OADDR02,A.CZIPCD, ");
					sql.append( "						RTRIM(A.CADDR01) AS CADDR01,RTRIM(A.CADDR02) AS CADDR02, ");
					sql.append( "						RTRIM(A.OADDR01) || ' ' || RTRIM(A.OADDR02) AS OADDRNM, ");
					sql.append( "						RTRIM(A.CADDR01) || ' ' || RTRIM(A.CADDR02) AS CADDRNM, ");
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

					sql.append( "						RTRIM(AA.FRDT) AS AFRDT, RTRIM(AA.TODT) AS ATODT,	COALESCE(AA.ASSAMT,0) AS ASSAMT,	RTRIM(AA.ASSINST) AS ASSINST, ");
					sql.append( "						RTRIM(AA.ASSGB) AS ASSGB, RTRIM(AA.ASSNO) AS ASSNO, COALESCE(AA.RECPAMT,0) AS RECPAMT,	RTRIM(AA.DISDIV) AS DISDIV,	RTRIM(AA.DISGRD) AS DISGRD, ");
					sql.append( "						RTRIM(AA.HOSDT) AS HOSDT , RTRIM(AA.HOSPITAL) AS HOSPITAL, RTRIM(AA.HOSREVIT) AS HOSREVIT,RTRIM(AA.HOSMEMO) AS HOSMEMO, COALESCE(AA.EYEL,0) AS EYEL, ");
					sql.append( "						COALESCE(AA.EYER,0) AS EYER, COALESCE(AA.HEIGHT,0) AS HEIGHT,	COALESCE(AA.WEIGHT,0) AS WEIGHT, RTRIM(AA.BLOOD) AS BLOOD, RTRIM(AA.COLBLNYN) AS COLBLNYN, ");
					sql.append( "						RTRIM(AA.RHANDYN) AS RHANDYN,	RTRIM(AA.MILIDIV) AS MILIDIV,	RTRIM(AA.MILIKND) AS MILIKND,	RTRIM(AA.MILIGRD) AS MILIGRD,	RTRIM(AA.MILINO) AS MILINO, ");
					sql.append( "						RTRIM(AA.MILIPLC) AS MILIPLC,	RTRIM(AA.MILIFRDT) AS MILIFRDT,	RTRIM(AA.MILITODT) AS MILITODT,	RTRIM(AA.NMREASON) AS NMREASON,	RTRIM(AA.MILITYPE) AS MILITYPE, ");
					sql.append( "						RTRIM(AA.MILISPEC) AS MILISPEC,	RTRIM(AA.MILIGBN) AS MILIGBN,		RTRIM(AA.MILITGBN) AS MILITGBN,	RTRIM(AA.ASSNAME) AS ASSNAME,		RTRIM(AA.ASSRELA) AS ASSRELA, ");
					sql.append( "						RTRIM(AA.ASSRESINO) AS ASSRESINO,	RTRIM(AA.ASSTELNO) AS ASSTELNO,	RTRIM(AA.ASSPOSTNO) AS ASSPOSTNO,	RTRIM(AA.ASSADDR) AS ASSADDR, ");
					sql.append( "						RTRIM(AB.MINORNM) AS DISDNM, RTRIM(AC.MINORNM) AS DISGNM, RTRIM(AD.MINORNM) AS MILDNM, ");
					sql.append( "						RTRIM(AE.MINORNM) AS MILGNM, RTRIM(AF.MINORNM) AS MILKNM, RTRIM(AG.MINORNM) AS MILTNM, ");
					sql.append( "						RTRIM(AH.MINORNM) AS MILHNM, RTRIM(AI.MINORNM) AS COLBNM, ");
					sql.append( "						A.SEX, A.TRAINYN, A.JOBKIND, A.INSCOD, A.PENCOD ");

					sql.append( "			  FROM PAYROLL.HIPERSON A ");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD ");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD = '2002' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE F ON B.DEPTPRT = F.MINORCD AND F.MAJORCD = '1111' ");

					sql.append( "						 LEFT OUTER JOIN PAYROLL.HIASSUR AA ON A.EMPNO = AA.EMPNO ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AB ON AA.DISDIV = AB.MINORCD AND AB.MAJORCD = '1135' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AC ON AA.DISGRD = AC.MINORCD AND AC.MAJORCD = '1136' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AD ON AA.MILIDIV = AD.MINORCD AND AD.MAJORCD = '1168' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AE ON AA.MILIGRD = AE.MINORCD AND AE.MAJORCD = '1134' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AF ON AA.MILIKND = AF.MINORCD AND AF.MAJORCD = '1116' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AG ON AA.MILITYPE = AG.MINORCD AND AG.MAJORCD = '1133' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AH ON AA.MILITGBN = AH.MINORCD AND AH.MAJORCD = '2021' ");
					sql.append( "						 LEFT OUTER JOIN PAYROLL.HCLCODE AI ON AA.COLBLNYN = AI.MINORCD AND AI.MAJORCD = '2022' ");

					sql.append( "      WHERE A.EMPNMK LIKE '" + str[2] + "%' ");

					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND A.USESTS = '" + str[0] + "' ");
					//if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND A.DEPTCD = '" + str[1]+ "' ");
					if (!str[2].equals("")) sql.append( " AND A.EMPNMK LIKE '" + str[2] + "%'");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4)= '" + str[5] +"'");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4)= '" + str[5] + "'");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6)= '" + str[5] +"'");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD)= '" + str[5] + "'");
                    
					sql.append( "      ORDER BY B.TREECD, C.SEQ  ");
					
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