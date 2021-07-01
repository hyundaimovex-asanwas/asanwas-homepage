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
				str[6]	= req.getParameter("v_str7");		//userid
				str[7]	= req.getParameter("v_str8");		//직위코드
				str[8]	= req.getParameter("v_str9");		//사원번호
        
				//2009.03.30 jys 
				str[9]	= req.getParameter("v_str10");  //직책코드

				for (int s=0;s<=8;s++) {
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
																					"JOBKIND","INSCOD","PENCOD","TREECD","LEVEL",
																					"EMPDIVNM","RECDIVNM","JOBKINDNM","RILIGNNM"

				};

				int[] intArrCN = new int[]{    7,  4, 20,  1,  4,          
                                       4,  8,  8,  4, 13,          
                                      30,  8,  8,  4,  4,          
                                       4,  4,  4,  4,  8,           
                                       8,  4,  4,  8,  8,           
                                       8,  8,  1, 40, 20,         
                                       4, 40,  4, 40,  6,         
                                      70, 70,  6, 70, 70,
																			100, 100,

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
																		  8, 20,  1,  50,  2,	//시력

																		  2,  3,  3,   2,  1,
																		  1,  4,  4,   4, 15,
																		 30,  8,  8,  40,  4,
																			4,  1,  1,  20,  4,
																		 13, 15,  6, 100,
																		 40, 40, 40,  40, 40,
																		 40, 40, 40,   1,  1,
																		  4,  3,  3,   8,  1,
																		 30, 30, 30,  30
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
																		 -1,  0,  0, -1, -1,
																		 -1, -1, -1, -1
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
					sql.append( " SELECT																																											\n");
					sql.append( "				A.EMPNO,A.REGDIV,A.EMPNMK,A.CARRDIV,A.RECDIV,																				  \n");
					sql.append( "				A.EMPDIV,RTRIM(A.FRDT) AS	FRDT,RTRIM(A.TODT) AS TODT,A.PAYDIV,A.RESINO,               \n");
					sql.append( "				A.PICTURE,RTRIM(A.GRSTRTDT) AS GRSTRTDT,RTRIM(A.STRTDT) AS STRTDT,A.DEPTCD,RTRIM(A.PAYGRD)PAYGRD,  \n");
					sql.append( "				A.JOBGRPH,A.JOBDTY,A.GRDDIV,A.PAYSEQ,RTRIM(A.FSAMDT) FSAMDT,	RTRIM(A.ENDDT) ENDDT,		\n");
					sql.append( "				A.USESTS,A.COSTDIV,RTRIM(A.DPOFFDT) DPOFFDT,RTRIM(A.LAMDT) LAMDT,											\n");
					sql.append( "				RTRIM(A.LRMDT) AS LRMDT,RTRIM(A.BIRDT) AS BIRDT,A.GLDIV,A.HOBBY,A.NMC,                \n");
					sql.append( "				RTRIM(A.RILIGN) AS RILIGN,A.NME,A.BIRCITY,A.SPECIAL,A.OZIPCD,													\n");
					sql.append( "				RTRIM(A.OADDR01) AS OADDR01,RTRIM(A.OADDR02) AS OADDR02,A.CZIPCD,											\n");
					sql.append( "       RTRIM(A.CADDR01) AS CADDR01,RTRIM(A.CADDR02) AS CADDR02,															\n");
					sql.append( "				RTRIM(A.OADDR01) || ' ' || RTRIM(A.OADDR02) AS OADDRNM,																\n");
					sql.append( "				RTRIM(A.CADDR01) || ' ' || RTRIM(A.CADDR02) AS CADDRNM,																\n");
					sql.append( "				A.TELNO,A.HPNO,A.OFFTELNO,A.EMAIL,A.HDFAMNM,																					\n");
					sql.append( "				A.HDFAMRET,A.HDFAMJOB,A.LABUNIYN,A.RELESAMT,A.MOVESAMT,																\n");
					sql.append( "				A.MRTDIV,A.MRTNO,A.REFCD,A.PAYBNKCD,A.PAYACNT,																				\n");
					sql.append( "				A.HOUSDIV,RTRIM(A.MRYDT) AS MRYDT,A.ENGLVL,A.TOESCR,A.JPTSCR,													\n");
					sql.append( "				A.DELFSCR,A.TOFSCR,A.DALFSCR,A.TEPSSCR,A.ETCLNG,																			\n");
					sql.append( "				A.HWGRDCD,A.EXGRDCD,A.PWGRDCD,A.ACGRDCD,																		          \n");
					sql.append( "				CASE WHEN A.USESTS='3' AND A.ENDDT<'20080101' THEN BB.DEPTNM ELSE B.DEPTNM END DEPTNM,\n");
					sql.append( "				C.MINORNM AS PAYGNM,F.MINORNM DEPTPNM, 																								\n");
					sql.append( "				A.CADDR01 || CADDR02 AS CADDR,																												\n");
					sql.append( "       " + str[3] + " - CAST(SUBSTR(A.GRSTRTDT,1,4) AS INTEGER) AS WRKDAT,										\n");
					sql.append( "       " + str[3] + " - CAST(SUBSTR(A.BIRDT,1,4) AS INTEGER) AS PERAGE,											\n");
					sql.append( "				A.PICFILE, RTRIM(A.ORDDT) AS ORDDT, A.HITCHYN,																				\n");
					sql.append( "				A.RELATNM, A.RELATGRD, A.RELATRE, A.NOMINNM, A.NOMINGRD,															\n");
					sql.append( "				A.NOMINRE, A.HSKSCR,																																	\n");
					sql.append( "				RTRIM(AA.FRDT) AS AFRDT, RTRIM(AA.TODT) AS ATODT,	COALESCE(AA.ASSAMT,0) AS ASSAMT,	  \n");
					sql.append( "       RTRIM(AA.ASSINST) AS ASSINST,RTRIM(AA.ASSGB) AS ASSGB, RTRIM(AA.ASSNO) AS ASSNO,      \n");																		
					sql.append( "				COALESCE(AA.RECPAMT,0) RECPAMT,	RTRIM(AA.DISDIV) DISDIV,	RTRIM(AA.DISGRD) DISGRD,		\n");
					sql.append( "				RTRIM(AA.HOSDT) HOSDT , RTRIM(AA.HOSPITAL) HOSPITAL, RTRIM(AA.HOSREVIT) HOSREVIT,     \n");
					sql.append( "       RTRIM(AA.HOSMEMO) HOSMEMO,                                                            \n");
					sql.append( "       COALESCE(AA.EYEL,0) EYEL,COALESCE(AA.EYER,0) EYER,					                          \n");
					sql.append( "				COALESCE(AA.HEIGHT,0) HEIGHT,	COALESCE(AA.WEIGHT,0) WEIGHT, RTRIM(AA.BLOOD) BLOOD,    \n");
					sql.append( "       RTRIM(AA.COLBLNYN) COLBLNYN,	RTRIM(AA.RHANDYN) RHANDYN,	RTRIM(AA.MILIDIV) MILIDIV,	\n");
					sql.append( "				RTRIM(AA.MILIKND) MILIKND,	RTRIM(AA.MILIGRD) MILIGRD,	RTRIM(AA.MILINO) MILINO,			\n");
					sql.append( "				RTRIM(AA.MILIPLC) MILIPLC,RTRIM(AA.MILIFRDT) MILIFRDT,RTRIM(AA.MILITODT) MILITODT,	  \n");
					sql.append( "       RTRIM(AA.NMREASON) NMREASON,RTRIM(AA.MILITYPE) MILITYPE, RTRIM(AA.MILISPEC) MILISPEC, \n");
					sql.append( "				RTRIM(AA.MILIGBN) MILIGBN,RTRIM(AA.MILITGBN) MILITGBN,RTRIM(AA.ASSNAME) ASSNAME,		  \n");
					sql.append( "       RTRIM(AA.ASSRELA) ASSRELA, RTRIM(AA.ASSRESINO) ASSRESINO,RTRIM(AA.ASSTELNO) ASSTELNO, \n");
					sql.append( "				RTRIM(AA.ASSPOSTNO) ASSPOSTNO,RTRIM(AA.ASSADDR) ASSADDR,RTRIM(AB.MINORNM) DISDNM,			\n");
					sql.append( "				RTRIM(AC.MINORNM) DISGNM, RTRIM(AD.MINORNM) MILDNM,	RTRIM(AE.MINORNM) MILGNM,         \n");																																		
					sql.append( "				RTRIM(AF.MINORNM) MILKNM, RTRIM(AG.MINORNM) MILTNM, RTRIM(AH.MINORNM) MILHNM,         \n");
					sql.append( "				RTRIM(AI.MINORNM) COLBNM, A.SEX, A.TRAINYN, A.JOBKIND, A.INSCOD, A.PENCOD,            \n");
					sql.append( "				B.TREECD,B.LEVEL,																																			\n");

					sql.append( "       RTRIM(O.MINORNM) EMPDIVNM, RTRIM(P.MINORNM) RECDIVNM, RTRIM(Q.MINORNM) JOBKINDNM,     \n");
					sql.append( "       RTRIM(R.MINORNM) RILIGNNM \n");

					sql.append( "	FROM PAYROLL.HIPERSON A																																			\n");
					sql.append( " LEFT OUTER JOIN PAYROLL.HCDEPT  B  ON A.DEPTCD    = B.DEPTCD																\n");	//부서
					 sql.append( " 					        AND B.CHGYM =  (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT	)                   \n");
          
					sql.append( " LEFT OUTER JOIN PAYROLL.HCLCODE C  ON A.PAYGRD    = C.MINORCD AND C.MAJORCD = '2002'				\n");	//직위
					sql.append( "	LEFT OUTER JOIN PAYROLL.HCLCODE F  ON B.DEPTPRT   = F.MINORCD AND F.MAJORCD = '1111'				\n");	//근무지
					sql.append( "	LEFT OUTER JOIN PAYROLL.HIASSUR AA ON A.EMPNO     = AA.EMPNO																\n");	//보증보험
					sql.append( "	LEFT OUTER JOIN PAYROLL.HCLCODE AB ON AA.DISDIV   = AB.MINORCD AND AB.MAJORCD = '1135'			\n");	//보훈대상자
					sql.append( "	LEFT OUTER JOIN PAYROLL.HCLCODE AC ON AA.DISGRD   = AC.MINORCD AND AC.MAJORCD = '1136'			\n");	//장애
					sql.append( "	LEFT OUTER JOIN PAYROLL.HCLCODE AD ON AA.MILIDIV  = AD.MINORCD AND AD.MAJORCD = '1168'			\n");	//병역구분
					sql.append( "	LEFT OUTER JOIN PAYROLL.HCLCODE AE ON AA.MILIGRD  = AE.MINORCD AND AE.MAJORCD = '1134'			\n");	//계급
					sql.append( "	LEFT OUTER JOIN PAYROLL.HCLCODE AF ON AA.MILIKND  = AF.MINORCD AND AF.MAJORCD = '1116'			\n");	//군별
					sql.append( "	LEFT OUTER JOIN PAYROLL.HCLCODE AG ON AA.MILITYPE = AG.MINORCD AND AG.MAJORCD = '1133'			\n");	//역종
					sql.append( "	LEFT OUTER JOIN PAYROLL.HCLCODE AH ON AA.MILITGBN = AH.MINORCD AND AH.MAJORCD = '2021'			\n");	//제대구분
					sql.append( "	LEFT OUTER JOIN PAYROLL.HCLCODE AI ON AA.COLBLNYN = AI.MINORCD AND AI.MAJORCD = '2022'			\n");	//색맹구분
					sql.append( "	LEFT OUTER JOIN PAYROLL.HCLCODE O ON A.EMPDIV     = O.MINORCD  AND O.MAJORCD  = '1119'			\n");	//입사구분
					sql.append( "	LEFT OUTER JOIN PAYROLL.HCLCODE P ON A.RECDIV     = P.MINORCD  AND P.MAJORCD  = '2035'			\n");	//입사채용
					sql.append( "	LEFT OUTER JOIN PAYROLL.HCLCODE Q ON A.JOBKIND    = Q.MINORCD  AND Q.MAJORCD  = '2034'			\n");	//직종구분
					sql.append( "	LEFT OUTER JOIN PAYROLL.HCLCODE R ON A.RILIGN     = R.MINORCD  AND R.MAJORCD  = '1117'			\n");	//종교
          sql.append( "	LEFT OUTER JOIN PAYROLL.HCDEPT_99 BB  ON A.DEPTCD  = BB.DEPTCD			\n");	//과거부서
					

				  sql.append( " WHERE A.EMPNMK LIKE '" + str[2] + "%' \n");
					if (!str[8].equals(""))sql.append( " AND A.EMPNO LIKE '" + str[8] + "%' \n");

					if (!str[0].equals("")&&!str[0].equals("0")) sql.append( " AND A.USESTS = '" + str[0] + "' \n");
					//if (!str[1].equals("")&&!str[1].equals("0")) sql.append( " AND A.DEPTCD = '" + str[1]+ "' ");
					//if (!str[2].equals("")) sql.append( " AND A.EMPNMK LIKE '" + str[2] + "%'");
					if (!str[6].equals("")) sql.append( " AND A.EMPNO = '" + str[6] + "' \n");

					if (str[4].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,2)= '" + str[5] +"'  \n");
					if (str[4].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,2)= '" + str[5] +"'  \n");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,4)= '" + str[5] + "' \n");
					if (str[4].equals("4")) sql.append( " AND SUBSTR(B.TREECD,1,6)= '" + str[5] +"'  \n");
					if (str[4].equals("5")) sql.append( " AND RTRIM(B.TREECD)= '" + str[5] + "'      \n");
				
					if (!str[7].equals("")) sql.append( " AND A.PAYGRD = '" + str[7] + "' \n");
          
					//2009.03.30 JYS 추가				            
          //경영지원본부 && 담당중역 일 경우 - 전략기획팀 및 변호사 제외
          if (str[1].equals("C000")&&str[9].equals("04")) sql.append( " AND ( A.JOBDTY<>'03' AND A.DEPTCD <> 'C810'  ) \n"); // AND A.EMPNO<>'2070034'
					if (str[1].equals("J000")&&str[9].equals("33")) sql.append( " AND ( A.JOBDTY<>'06') \n");
					if (str[9].equals("04")) sql.append( " AND ( A.JOBDTY<>'03') \n");

					//2009.09.25 JYS 추가				  
					if (str[9].equals("38")) sql.append( " AND ( A.JOBDTY<>'03') \n");

					sql.append( " ORDER BY B.TREECD, C.SEQ \n");

       //   logger.dbg.println(this, sql.toString());

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