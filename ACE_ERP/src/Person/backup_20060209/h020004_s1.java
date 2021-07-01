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
public class h020004_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2");
				String  str3	= req.getParameter("v_str3");

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "INFODIV","RESINO","WRDT","WRNO","NMK",
																					"PHOTO","BIRDT","GLDIV","HOBBY","NMC",
																					"RILIGN","NME","BIRCITY","SPECIAL","OZIPCD",
																					"OADDR1","OADDR2","CZIPCD","CADDR1","CADDR2",
																					"TELNO","HPNO","EMAIL","EYEL","EYER",
																					"HEIGHT","WEIGHT","BLOOD","RGHANDYN","MILIDIV",
																					"MILIKND","MILIGRD","MILINO","MILIPLC","MILIFRDT",
																					"MILITODT","NMREASON","MRYDT","DISDIV","DISGRD",
																					"MILITYPE","MRTDIV","MRTNO","REFCD","MILISPEC",
																					"ENGLVL","TOESCR","JPTSCR","DELFSCR","TOFSCR",
																					"DALFSCR","TEPSSCR","ETCLNG","HWGRDCD","EXGRDCD",
																					"PWGRDCD","ACGRDCD","INTDT","INTTM","INTATTYN",
																					"PASSDT","AMDT","EMPNO","AMKIND","LCSTYPE",
																					"LCSCD","PROSTS",
																					"MINORNM","SCHNM","PGCCD","AVRUNI","INFO",
																					"BIRCNM","RILINM","MILIDNM","MILIKNM","MILIGNM",
																					"ENGLNM","MRTDNM","LCSTPNM","CARYEAR",
																					"GROWTH","SCHOOL","CAREER","AMBITION","CHK"
																					}; 

				int[] intArrCN = new int[]{  6, 13,  8,  5, 30,
																		30,  8,  1, 40, 20,
																		 4, 40,  4, 40,  6,
																		70, 70,  6, 70, 70,
																		15, 15, 30,  2,  2,
																		 3,  3,  2,  1,  4,
																		 4,  4, 15, 30,  8,
																		 8, 40,  8,  4,  4,
																		 4,  2, 20,  4,  4,
																		 1,  4,  4,  4,  4,
																		 4,  4, 50,  1,  1,
																		 1,  1,  8,  4,  1,
																		 8,  8,  6,  2,  4,
																		 4,  1, 
																		30, 60, 50,  3, 50,
																		30, 30, 30, 30, 30,
																		30, 30, 30,  2,
																	1000, 1000, 1000, 1000, 1
					}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,  0, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1,  1,  1,
																		  0,  0, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1,  0,  0,  0,  0,
																		  0,  0, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1,
																		 -1, -1, -1,  1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1,  0,
																		 -1, -1, -1, -1, -1
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT ");
					sql.append( "     A.INFODIV,	A.RESINO,		A.WRDT,		A.WRNO,			A.NMK, ");
					sql.append( "     A.PHOTO,		A.BIRDT,		A.GLDIV,	A.HOBBY,		A.NMC, ");
					sql.append( "     A.RILIGN,		A.NME,			A.BIRCITY,A.SPECIAL,	A.OZIPCD, ");
					sql.append( "     A.OADDR1,		A.OADDR2,		A.CZIPCD,	A.CADDR1,		A.CADDR2, ");
					sql.append( "     A.TELNO,		A.HPNO,			A.EMAIL,	A.EYEL,			A.EYER, ");
					sql.append( "     A.HEIGHT,		A.WEIGHT,		A.BLOOD,	A.RGHANDYN,	A.MILIDIV, ");
					sql.append( "     A.MILIKND,	A.MILIGRD,	A.MILINO,	A.MILIPLC,	A.MILIFRDT, ");
					sql.append( "     A.MILITODT,	A.NMREASON,	RTRIM(A.MRYDT) AS MRYDT,	A.DISDIV,		A.DISGRD, ");
					sql.append( "     A.MILITYPE,	A.MRTDIV,		A.MRTNO,	A.REFCD,		A.MILISPEC, ");
					sql.append( "     A.ENGLVL,		A.TOESCR,		A.JPTSCR,	A.DELFSCR,	A.TOFSCR, ");
					sql.append( "     A.DALFSCR,	A.TEPSSCR,	A.ETCLNG,	A.HWGRDCD,	A.EXGRDCD, ");
					sql.append( "     A.PWGRDCD,	A.ACGRDCD,	A.INTDT,	A.INTTM,		A.INTATTYN, ");
					sql.append( "     A.PASSDT,		A.AMDT,			A.EMPNO,	A.AMKIND,		A.LCSTYPE, ");
					sql.append( "     A.LCSCD,		A.PROSTS, ");
					sql.append( "     C.MINORNM AS MINORNM,	B.SCHNM,		B.PGCCD,	COALESCE(B.AVRUNI,0) AVRUNI,		D.INFO, ");
					sql.append( "     F.MINORNM AS BIRCNM,  G.MINORNM AS RILINM, ");
					sql.append( "     H.MINORNM AS MILIDNM, I.MINORNM AS MILIKNM, J.MINORNM AS MILIGNM, K.MINORNM AS ENGLNM,  ");
					sql.append( "     L.MINORNM AS MRTDNM,  E.MINORNM AS LCSTPNM, A.CARYEAR, ");
					sql.append( "     RTRIM(M.GROWTH) AS GROWTH, RTRIM(M.SCHOOL) AS SCHOOL, RTRIM(M.CAREER) AS CAREER, RTRIM(M.AMBITION) AS AMBITION, 'F' AS CHK ");
					sql.append( "       FROM PAYROLL.HRPERSON A, ");	//입사지원기본
					sql.append( "            PAYROLL.HRINFO D ");			//채용안내정보
					sql.append( "            LEFT OUTER JOIN PAYROLL.HREDUC B ON A.INFODIV = B.INFODIV AND A.RESINO = B.RESINO AND B.EDCCD = (SELECT COALESCE(MAX(EDCCD),'') ");
					sql.append( "                         FROM PAYROLL.HREDUC ");
					sql.append( "                        WHERE A.INFODIV = INFODIV ");
					sql.append( "                          AND A.RESINO = RESINO) ");
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE C ON B.EDCCD = C.MINORCD  AND C.MAJORCD = '1115' ");		//공통코드정보
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE E ON A.LCSTYPE = E.MINORCD AND E.MAJORCD = '1127' ");	//자격증정보
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE F ON A.BIRCITY = E.MINORCD AND E.MAJORCD = '2011' ");	//출신도
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE G ON A.RILIGN = E.MINORCD AND E.MAJORCD = '1117' ");		//종교    
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE H ON A.MILIDIV = E.MINORCD AND E.MAJORCD = '1168' ");	//병역구분
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE I ON A.MILIKND = E.MINORCD AND E.MAJORCD = '1116' ");	//군별    
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE J ON A.MILIGRD = E.MINORCD AND E.MAJORCD = '1134' ");	//계급    
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE K ON A.ENGLVL = E.MINORCD AND E.MAJORCD = '1149' ");		//영어수준
					sql.append( "            LEFT OUTER JOIN PAYROLL.HCLCODE L ON A.MRTDIV = E.MINORCD AND E.MAJORCD = '1135' ");		//보훈대상
					sql.append( "            LEFT OUTER JOIN PAYROLL.HRSELF M ON A.RESINO = M.RESINO AND A.INFODIV = M.INFODIV ");		//자기소개서
					sql.append( "  WHERE A.WRDT BETWEEN '" + str1 + "' AND '" + str2 + "'");
					sql.append( "    AND A.INFODIV = '" + str3 + "'");
					sql.append( "    AND A.INFODIV = D.INFODIV ");
					sql.append( " ORDER BY A.NMK, A.WRDT DESC ");

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