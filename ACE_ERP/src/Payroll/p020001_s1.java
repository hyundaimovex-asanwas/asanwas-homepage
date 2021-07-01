package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p020001_s1 extends HttpServlet {

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
                                          "TELNO","HPNO","OFFTELNO","EMAIL","HDFAMNM",
                                          "HDFAMRET","HDFAMJOB","LABUNIYN","RELESAMT","MOVESAMT",
                                          "MRTDIV","MRTNO","REFCD","PAYBNKCD","PAYACNT",
                                          "HOUSDIV","MRYDT","ENGLVL","TOESCR","JPTSCR",
                                          "DELFSCR","TOFSCR","DALFSCR","TEPSSCR","ETCLNG",
                                          "HWGRDCD","EXGRDCD","PWGRDCD","ACGRDCD","DEPTNM",
																					"PAYGNM","DEPTPNM","CADDR","WRKDAT","PERAGE"
																				};

				int[] intArrCN = new int[]{    7,  4, 20,  1,  4,          
                                       4,  8,  8,  4, 13,          
                                      30,  8,  8,  4,  4,          
                                       30,  4,  30,  4,  8,           
                                       8,  30,  4,  8,  8,           
                                       8,  8,  1, 40, 20,         
                                       4, 40,  4, 40,  6,         
                                      70, 70,  6, 70, 70,       
                                      15, 15,  4, 30, 14,       
                                       4, 30,  1,  5,  5,      
                                       4, 20,  4,  4, 20,         
                                       4,  8,  1,  4,  4,       
                                       4,  4,  4,  4, 50, 
                                       1,  1,  1,  1, 70,
																			30, 30,150,  4,  4
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
																		 -1, -1, -1, -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				dSet.addDataColumn(new GauceDataColumn("PICFILE",   GauceDataColumn.TB_URL));
				dSet.addDataColumn(new GauceDataColumn("ORDDT",			GauceDataColumn.TB_STRING, 8));
				dSet.addDataColumn(new GauceDataColumn("HITCHYN",   GauceDataColumn.TB_STRING, 1));
				dSet.addDataColumn(new GauceDataColumn("RELATNM",   GauceDataColumn.TB_STRING, 20));
				dSet.addDataColumn(new GauceDataColumn("RELATGRD",  GauceDataColumn.TB_STRING, 4));

				dSet.addDataColumn(new GauceDataColumn("RELATRE",   GauceDataColumn.TB_STRING, 4));
				dSet.addDataColumn(new GauceDataColumn("NOMINNM",   GauceDataColumn.TB_STRING, 20));
				dSet.addDataColumn(new GauceDataColumn("NOMINGRD",  GauceDataColumn.TB_STRING, 4));
				dSet.addDataColumn(new GauceDataColumn("NOMINRE",   GauceDataColumn.TB_STRING, 4));

				dSet.addDataColumn(new GauceDataColumn("DUYEAR",		GauceDataColumn.TB_DECIMAL, 2));
				dSet.addDataColumn(new GauceDataColumn("DUYMM",			GauceDataColumn.TB_DECIMAL, 2));
				dSet.addDataColumn(new GauceDataColumn("DUDAY",			GauceDataColumn.TB_DECIMAL, 2));
				dSet.addDataColumn(new GauceDataColumn("PAYBNKCDNM",GauceDataColumn.TB_STRING, 30));

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT  ");
					sql.append( "		A.EMPNO,A.REGDIV,A.EMPNMK,A.CARRDIV,A.RECDIV, ");
					sql.append( "		A.EMPDIV,A.FRDT,A.TODT,A.PAYDIV,A.RESINO, ");
					sql.append( "		A.PICTURE,A.GRSTRTDT,A.STRTDT,A.DEPTCD,A.PAYGRD, ");
					sql.append( "		G.MINORNM AS JOBGRPH,A.JOBDTY,D.MINORNM AS GRDDIV,	");
					sql.append( "   E.MINORNM AS PAYSEQ,A.FSAMDT,A.ENDDT,H.MINORNM AS USESTS, ");
					sql.append( "		A.COSTDIV,RTRIM(A.DPOFFDT) AS DPOFFDT,RTRIM(A.LAMDT) AS LAMDT, ");
					sql.append( "		RTRIM(A.LRMDT) AS LRMDT,A.BIRDT,A.GLDIV,A.HOBBY,A.NMC, ");
					sql.append( "		RTRIM(A.RILIGN) AS RILIGN,A.NME,A.BIRCITY,A.SPECIAL,A.OZIPCD, ");
					sql.append( "		A.OADDR01,A.OADDR02,A.CZIPCD,A.CADDR01,A.CADDR02, ");
					sql.append( "		A.TELNO,A.HPNO,A.OFFTELNO,A.EMAIL,A.HDFAMNM, ");
					sql.append( "		A.HDFAMRET,A.HDFAMJOB,A.LABUNIYN,A.RELESAMT,A.MOVESAMT, ");
					sql.append( "		A.MRTDIV,A.MRTNO,A.REFCD,A.PAYBNKCD,A.PAYACNT, ");
					sql.append( "		A.HOUSDIV,A.MRYDT,A.ENGLVL,A.TOESCR,A.JPTSCR, ");
					sql.append( "		A.DELFSCR,A.TOFSCR,A.DALFSCR,A.TEPSSCR,A.ETCLNG, ");
					sql.append( "		A.HWGRDCD,A.EXGRDCD,A.PWGRDCD,A.ACGRDCD, ");
					sql.append( "		B.DEPTNM,C.MINORNM AS PAYGNM,F.MINORNM DEPTPNM, ");
					sql.append( "		A.CADDR01 || CADDR02 AS CADDR, ");
					sql.append(     str[3] + " - CAST(SUBSTR(A.GRSTRTDT,1,4) AS INTEGER) AS WRKDAT, ");
					sql.append(     str[3] + "- CAST(SUBSTR(A.BIRDT,1,4) AS INTEGER) AS PERAGE, ");
					sql.append( "		A.PICFILE, A.ORDDT, A.HITCHYN, ");
					sql.append( "		A.RELATNM, A.RELATGRD, A.RELATRE, A.NOMINNM, A.NOMINGRD, ");
					sql.append( "		A.NOMINRE ,A.DUYEAR,A.DUYMM,A.DUDAY, I.MINORNM AS PAYBNKCDNM ");
					sql.append( "	  FROM PAYROLL.HIPERSON A  ");
					sql.append( "     LEFT JOIN  PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD "); //부서
					sql.append( "     LEFT JOIN  PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD = '2002' ");//직위
					sql.append( "     LEFT JOIN  PAYROLL.HCLCODE D ON  A.GRDDIV = D.MINORCD AND D.MAJORCD = '2001' ");  //직급
					sql.append( "     LEFT JOIN  PAYROLL.HCLCODE E ON A.PAYSEQ = E.MINORCD AND E.MAJORCD = '1184' "); //호봉
					sql.append( "	    LEFT JOIN 	 PAYROLL.HCLCODE F ON B.DEPTPRT = F.MINORCD AND F.MAJORCD = '1111' ");
					sql.append( "	    LEFT JOIN 	 PAYROLL.HCLCODE G ON  A.JOBGRPH = G.MINORCD AND G.MAJORCD = '2000' "); //직군
					sql.append( "	    LEFT JOIN 	 PAYROLL.HCLCODE H ON A.USESTS = H.MINORCD AND H.MAJORCD = '1121' "); //재직구분
					sql.append( "	    LEFT JOIN 	 PAYROLL.HCLCODE I ON  A.PAYBNKCD = I.MINORCD AND I.MAJORCD = '1411' ");//은행
					sql.append( "  WHERE RTRIM(A.EMPNO) <> '' ");    

					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND A.USESTS = '" + str[0] + "' ");
				  //if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND A.DEPTCD = '" + str[1]+ "' ");
					if (!str[2].equals("")) sql.append( " AND A.EMPNMK LIKE '" + str[2] + "%'");
          if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4)= '" + str[5] +"'");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4)= '" + str[5] + "'");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6)= '" + str[5] +"'");
					if (str[4].equals("4")) sql.append( " AND RTRIM(B.TREECD)= '" + str[5] + "'");

					sql.append( "	ORDER BY B.TREECD, C.SEQ ");

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