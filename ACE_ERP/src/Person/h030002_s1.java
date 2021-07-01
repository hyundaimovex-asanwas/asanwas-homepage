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
				String [] str = new String [26];
				str[0]	= req.getParameter("v_str1");		//재직유무
				str[1]	= req.getParameter("v_str2");		//부서코드
				str[2]	= req.getParameter("v_str3");		//직종구분
				str[3]	= req.getParameter("v_str4");		//직위코드
				str[4]	= req.getParameter("v_str5");		//자격증코드
				str[5]	= req.getParameter("v_str6");		//입사일자 fr
				str[6]	= req.getParameter("v_str7");		//입사일자 to
				str[7]	= req.getParameter("v_str8");		//승진일자 fr
				str[8]	= req.getParameter("v_str9");		//승진일자 to
				str[9]  = req.getParameter("v_str10");	//퇴사일자 fr
				str[10] = req.getParameter("v_str11");	//퇴사일자 to
				str[11] = req.getParameter("v_str12");	//생년월일 fr
				str[12] = req.getParameter("v_str13");	//생년월일 to
				str[13] = req.getParameter("v_str14");	//현재년
				str[14] = req.getParameter("v_str15");	//현재년월
				str[15] = req.getParameter("v_str16");	//별정직구분
				str[16] = req.getParameter("v_str17");	//LEVEL
				str[17] = req.getParameter("v_str18");  //TREECD
				str[18] = req.getParameter("v_str19");	//발령구분
				str[19] = req.getParameter("v_str20");	//발령일자 fr
				str[20] = req.getParameter("v_str21");	//발령일자 to
				str[21] = req.getParameter("v_str22");	//그룹일자 fr
				str[22] = req.getParameter("v_str23");	//그룹일자 to
				str[23] = req.getParameter("v_str24");	//호봉
				str[24] = req.getParameter("v_str25");	//성별
				str[25] = req.getParameter("v_str26");	//ODER BY (ASC/DESC)

				for (int s=0;s<=25;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","REGDIV","EMPNMK","CARRDIV","RECDIV","EDCDNM", "EDCCNM",        
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
																					"DEPTPNM","CADDR","LSTEDU","LSTHB","PERAGE","WRKDAT",
																					"ASSGB","AFRDT","ATODT","ASSNO","ASSINST",
																					"ASSAMT","RECPAMT","ASSNAME","GRAYY","DUYEAR"
																					,"TREECD","SEQ1","SEQ2","ORDCD","ORDNM", "ORDDT"
																				};

				int[] intArrCN = new int[]{    7,  4, 20,  1,  4,30,30,         
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
																		  30,150, 60,20, 4,  4,
																			 1,  8,  8, 20, 50,
																			 9,  6, 20,  4,  2
																			,8,  3,  3,  2, 30,  8

																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,-1,-1,
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
																		 -1, -1, -1, -1, -1,-1,
																		 -1, -1, -1, -1, -1,
																			0,  0, -1, -1,  0
																		,-1,  0,  0, -1, -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT  DISTINCT  \n");
					sql.append( "			A.EMPNO,A.REGDIV,A.EMPNMK,'' AS CARRDIV,A.RECDIV, WW.MINORNM AS EDCDNM,WWW.MINORNM AS EDCCNM,																						\n");
					sql.append( "			A.EMPDIV,RTRIM(A.FRDT) AS FRDT,RTRIM(A.TODT) AS TODT,A.PAYDIV,A.RESINO,													\n");
					sql.append( "			A.PICTURE,RTRIM(A.GRSTRTDT) AS GRSTRTDT,RTRIM(A.STRTDT) AS STRTDT,A.DEPTCD,A.PAYGRD,						\n");
					sql.append( "			A.JOBGRPH,A.JOBDTY,A.GRDDIV,RTRIM(A.PAYSEQ) PAYSEQ,RTRIM(A.FSAMDT) AS FSAMDT,										\n");
					sql.append( "			RTRIM(A.ENDDT) AS ENDDT,A.USESTS,A.COSTDIV,RTRIM(A.DPOFFDT) AS DPOFFDT,RTRIM(A.LAMDT) AS LAMDT, \n");
					sql.append( "			RTRIM(A.LRMDT) AS LRMDT,RTRIM(A.BIRDT) AS BIRDT,A.GLDIV,A.HOBBY,A.NMC,													\n");
					sql.append( "			A.RILIGN,A.NME,A.BIRCITY,A.SPECIAL,A.OZIPCD,																										\n");
					sql.append( "			A.OADDR01,A.OADDR02,A.CZIPCD,A.CADDR01,A.CADDR02,A.TELNO,A.HPNO,A.OFFTELNO,A.EMAIL,A.HDFAMNM,   \n");
					sql.append( "			A.HDFAMRET,A.HDFAMJOB,A.LABUNIYN,COALESCE(A.RELESAMT,0) RELESAMT,COALESCE(A.MOVESAMT,0) MOVESAMT, \n");
					sql.append( "     A.MRTDIV,A.MRTNO,A.REFCD,A.PAYBNKCD,			\n");
					sql.append( "			A.PAYACNT,A.HOUSDIV,RTRIM(A.MRYDT) AS MRYDT,A.ENGLVL,COALESCE(A.TOESCR,0) TOESCR,               \n");
					sql.append( "     COALESCE(A.JPTSCR,0) JPTSCR,COALESCE(A.DELFSCR,0) DELFSCR,COALESCE(A.TOFSCR,0) TOFSCR,          \n");
					sql.append( "			COALESCE(A.DALFSCR,0) DALFSCR,COALESCE(A.TEPSSCR,0) TEPSSCR,A.ETCLNG,A.HWGRDCD,A.EXGRDCD,       \n");
					sql.append( "     A.PWGRDCD,A.ACGRDCD,  \n");
					if (!str[18].equals("")) {
						sql.append( "   J.DEPTNM,	\n");		//소속명
					}else{
						sql.append( "   B.DEPTNM,	\n");
					}
					sql.append( "			C.MINORNM AS PAYGNM, /*E.MINORNM AS LCSTNM,RTRIM(D.GETDT) AS GETDT,D.LCSNO,D.ISSPART,*/	        \n");
					
					if (!str[18].equals("")) {
						sql.append( "		F.MINORNM DEPTPNM, ");	//근무지
					}else{
						sql.append( "		F.MINORNM DEPTPNM, ");
					}
					
					sql.append( "     RTRIM(A.CADDR01) || ' ' || RTRIM(CADDR02) AS CADDR,																							\n");
					sql.append( "     G.SCHNM AS LSTEDU,W.MINORNM AS LSTHB," + str[13] + " - CAST(SUBSTR(A.GRSTRTDT,1,4) AS INTEGER) AS WRKDAT,          \n");
					sql.append( "     " + str[13] + "- CAST(SUBSTR(A.BIRDT,1,4) AS INTEGER) AS PERAGE,																\n");
					sql.append( "			H.ASSGB, RTRIM(H.FRDT) AS AFRDT, RTRIM(H.TODT) AS ATODT, H.ASSNO, H.ASSINST,										\n");
					sql.append( "			COALESCE(H.ASSAMT,0) AS ASSAMT,COALESCE(H.RECPAMT,0) AS RECPAMT, H.ASSNAME,											\n");
					sql.append( "     G.GRAYY, COALESCE(I.DUYEAR,0) AS DUYEAR,																											  \n");
					sql.append( "     B.TREECD,COALESCE(C.SEQ,0) SEQ1, COALESCE(P.SEQ,0) SEQ2																												    \n");
					if (!str[18].equals("")) {
						sql.append( "  ,K.ORDCD,M.ORDNM,K.ORDDT               \n");	
					}else {
						sql.append( "  ,'' AS ORDCD, '' AS ORDNM, '' AS ORDDT \n"); 					
					}
					sql.append( " FROM PAYROLL.HIPERSON A, PAYROLL.HCORDCOD M																													\n");
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD																					\n");
					sql.append( "  LEFT OUTER JOIN PAYROLL.HIEDUC G ON A.EMPNO = G.EMPNO																						\n");
					sql.append( "   AND G.GRAYY = (SELECT MAX(GRAYY) AS GRAYY																						\n");
					sql.append( "   FROM PAYROLL.HIEDUC WHERE EMPNO = A.EMPNO)																						\n");
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCLCODE C ON A.PAYGRD = C.MINORCD AND C.MAJORCD = '2002'								\n");
					sql.append( "  LEFT OUTER JOIN PAYROLL.HILICENS D ON A.EMPNO = D.EMPNO																					\n");
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCLCODE E ON D.LCSTYPE = E.MINORCD AND E.MAJORCD = '1127'								\n");					
					sql.append( "  LEFT OUTER JOIN PAYROLL.HIASSUR H ON A.EMPNO = H.EMPNO																					\n");
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCLCODE P ON B.GROUPID = P.MINORCD AND P.MAJORCD = '2051'								\n");
//					sql.append( "  LEFT OUTER JOIN PAYROLL.PBPAY I ON A.EMPNO = I.EMPNO AND I.APPDT = '" + str[14] + "'						\n");
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCLCODE W ON G.PGCCD  = W.MINORCD AND W.MAJORCD = '1129' ");
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCLCODE WW ON G.EDCDIV  = WW.MINORCD AND WW.MAJORCD = '1118' ");
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCLCODE WWW ON G.EDCCD  = WWW.MINORCD AND WWW.MAJORCD = '1115' ");
					if (!str[18].equals("")) {
					sql.append( "  LEFT OUTER JOIN PAYROLL.HOORDER  K ON A.EMPNO = K.EMPNO																\n");
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCORDCOD M ON K.ORDCD = M.ORDCD																\n");
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCDEPT   J ON K.DEPTCD = J.DEPTCD															\n");
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCLCODE  F ON J.DEPTPRT = F.MINORCD AND F.MAJORCD = '1111'		\n");
					}else{
					sql.append( "  LEFT OUTER JOIN PAYROLL.HCLCODE F ON B.DEPTPRT = F.MINORCD AND F.MAJORCD = '1111'		\n");
					}
					sql.append( "	 LEFT OUTER JOIN (SELECT X.EMPNO, X.APPDT, MAX(X.DUYEAR)DUYEAR	\n");
          sql.append( "           FROM PAYROLL.PBPAY X	\n");
          sql.append( "          WHERE X.APPDT = '" + str[14] + "'		\n");
          sql.append( "          GROUP BY X.EMPNO, X.APPDT ) I ON A.EMPNO = I.EMPNO AND  I.APPDT = '" + str[14] + "'		\n");
					if (!str[0].equals("")&&!str[0].equals("0")) { 
						sql.append(" WHERE A.USESTS IN ('" + str[0] + "') \n");
					}else if (str[0].equals("0")) {
						sql.append(" WHERE A.USESTS IN ('1','2','3') \n");
					}else {
						sql.append(" WHERE RTRIM(A.USESTS) IN ('1') \n");
					}

					//if (!str[1].equals("")) sql.append( " AND A.DEPTCD = '" + str[1] + "' ");
					if (!str[2].equals(""))   sql.append( " AND A.JOBGRPH = '" + str[2] + "' \n");
					if (!str[3].equals(""))   sql.append( " AND A.PAYGRD  = '" + str[3] + "' \n");
					if (!str[4].equals(""))   sql.append( " AND D.LCSTYPE = '" + str[4] + "' \n");
					if (!str[5].equals(""))   sql.append( " AND A.STRTDT BETWEEN '" + str[5] + "' AND '" + str[6] + "'			\n");	//입사일자
					if (!str[21].equals(""))  sql.append( " AND A.GRSTRTDT BETWEEN '" + str[21] + "' AND '" + str[22] + "'	\n");	//그룹일자
					if (!str[7].equals(""))   sql.append( " AND A.LAMDT BETWEEN '" + str[7] + "' AND '" + str[8] + "'				\n");	//승진일자
					if (!str[9].equals(""))   sql.append( " AND A.ENDDT BETWEEN '" + str[9] + "' AND '" + str[10] + "'			\n");	//퇴사일자
					if (!str[11].equals(""))  sql.append( " AND A.BIRDT BETWEEN '" + str[11] + "' AND '" + str[12] + "'			\n");	//생년월일
					if (!str[15].equals("A")) sql.append( " AND A.EMPDIV = '2' \n");
					else sql.append(" AND A.EMPDIV IN ('1', '2', '0','8') \n"); 
/*
    			    if (str[16].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[17] + "' \n");
					if (str[16].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,4) = '"+ str[17] + "' \n");
					if (str[16].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,6) = '"+ str[17] + "' \n");
					if (str[16].equals("4")) sql.append( " AND RTRIM(B.TREECD) = '" + str[17] + "'     \n");
*/ 
					if (str[16].equals("1")) sql.append( " AND SUBSTR(B.TREECD,1,2)= '" + str[17] +"'  \n");
					if (str[16].equals("2")) sql.append( " AND SUBSTR(B.TREECD,1,2)= '" + str[17] +"'  \n");
					if (str[16].equals("3")) sql.append( " AND SUBSTR(B.TREECD,1,4)= '" + str[17] + "' \n");
					if (str[16].equals("4")) sql.append( " AND SUBSTR(B.TREECD,1,6)= '" + str[17] +"'  \n");
					if (str[16].equals("5")) sql.append( " AND RTRIM(B.TREECD)= '" + str[17] + "'      \n");
					
					if (!str[18].equals("")&&!str[18].equals("1")) { 
						sql.append( " AND K.APPDT <> '' ");	//인사적용일
						sql.append( " AND K.ORDCD IN ('"+str[18]+"') ");
						if (!str[19].equals("")) sql.append( " AND K.ORDDT BETWEEN '" + str[19] + "' AND '" + str[20] + "' \n");
					} else if (str[18].equals("1")) { 
						sql.append( " AND K.APPDT <> '' ");	//인사적용일
						sql.append(" AND K.ORDCD IN ('C1','C3') \n"); 
						if (!str[19].equals("")) sql.append( " AND K.ORDDT BETWEEN '" + str[19] + "' AND '" + str[20] + "' \n");
					}

					if (!str[23].equals("")&&!str[24].equals("0")) sql.append( " AND A.PAYSEQ ='"+str[23]+"' \n");
					if (!str[24].equals("")&&!str[24].equals("0")) sql.append( " AND A.SEX = '"+str[24]+"' \n");

					if (str[25].equals("1")) 	{
						sql.append( " ORDER BY PAYGRD, PAYSEQ DESC, EMPNMK ASC \n");
					}else {
						sql.append( " ORDER BY PAYGRD, PAYSEQ ASC, EMPNMK ASC \n");
					}
					//sql.append( " ORDER BY B.TREECD,SEQ2, SEQ1,A.EMPNMK \n");
					
					// logger.dbg.println(this, sql.toString());
                     
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