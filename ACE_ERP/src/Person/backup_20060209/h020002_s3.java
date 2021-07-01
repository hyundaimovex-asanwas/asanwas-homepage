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
public class h020002_s3 extends HttpServlet {

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

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "INFODIV","RESINO","WRDT","WRNO","NMK",
																					"PHOTO","BIRDT","GLDIV","HOBBY","NMC",
																					"RILIGN","NME","BIRCITY","SPECIAL","OZIPCD",
																					"OADDRNM",//"OADDR1","OADDR2",
																					"CZIPCD",
																					"CADDRNM",//"CADDR1","CADDR2",
																					"TELNO","HPNO","EMAIL","EYEL","EYER",
																					"HEIGHT","WEIGHT","BLOOD","RGHANDYN","MILIDIV",
																					"MILIKND","MILIGRD","MILINO","MILIPLC","MILIFRDT",
																					"MILITODT","NMREASON","MRYDT","DISDIV","DISGRD",
																					"MILITYPE","MRTDIV","MRTNO","REFCD","MILISPEC",
																					"ENGLVL","TOESCR","JPTSCR","DELFSCR","TOFSCR",
																					"DALFSCR","TEPSSCR","ETCLNG","HWGRDCD","EXGRDCD",
																					"PWGRDCD","ACGRDCD","INTDT","INTTM","INTATTYN",
																					"PASSDT","AMDT","EMPNO","AMKIND","LCSTYPE",
																					"LCSCD","PROSTS","CARYEAR",
																					"MILIDIVNM","MILIKNDNM","MILIGRDNM","BIRCITYNM","RILIGNM" };

				int[] intArrCN = new int[]{  6, 13,  8,  5, 30,
																		30,  8,  1, 40, 20,
																		 4, 40,  4, 40,  6,
																		70,// 70,  
																		6, 
																		70,// 70,
																		15, 15, 30,  2,  2,
																		 3,  3,  2,  1,  4,
																		 4,  4, 15, 30,  8,
																		 8, 40,  8,  4,  4,
																		 4,  2, 20,  4,  4,
																		 1,  4,  4,  4,  4,
																		 4,  4, 50,  1,  1,
																		 1,  1,  8,  4,  1,
																		 8,  8,  6,  2,  4,
																		 4,  1,  2,
																		30, 30, 30, 30, 30
					};

				int[] intArrCN2 = new int[]{ -1, -1, -1,  0, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, //-1, 
																		 -1, 
																		 -1, //-1,
																		 -1, -1, -1,  1,  1,
																		  0,  0, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1,  0,  0,  0,  0,
																		  0,  0, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1,  0,
																		 -1, -1, -1, -1, -1
					};

				for (int i=0; i<strArrCN.length; i++) { // set column column
					switch ( intArrCN2[i] ) {
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break;
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break;
					}
				}

				dSet.addDataColumn(new GauceDataColumn("PICFILE",   GauceDataColumn.TB_URL));
				dSet.addDataColumn(new GauceDataColumn("HSKSCR",   GauceDataColumn.TB_DECIMAL, 4,0));
				dSet.addDataColumn(new GauceDataColumn("INFO",   GauceDataColumn.TB_STRING, 50));

				if (!GauceReq.isBuilderRequest()) {
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT \n");
					sql.append( " A.INFODIV,	A.RESINO,		A.WRDT,		A.WRNO,			A.NMK, \n");
					sql.append( " A.PHOTO,		A.BIRDT,		A.GLDIV,	A.HOBBY,		A.NMC, \n");
					sql.append( " A.RILIGN,		A.NME,			A.BIRCITY,A.SPECIAL,	A.OZIPCD, \n");
					sql.append( " RTRIM(A.OADDR1) || ' ' || RTRIM(A.OADDR2) AS OADDRNM,	\n");
					sql.append( " A.CZIPCD,	\n");
					sql.append( " RTRIM(A.CADDR1) || ' ' || RTRIM(A.CADDR2) AS CADDRNM, \n");
					sql.append( " A.TELNO,		A.HPNO,			A.EMAIL,	A.EYEL,			A.EYER, \n");
					sql.append( " A.HEIGHT,		A.WEIGHT,		A.BLOOD,	A.RGHANDYN,	A.MILIDIV, \n");
					sql.append( " A.MILIKND,	A.MILIGRD,	A.MILINO,	A.MILIPLC,	A.MILIFRDT, \n");
					sql.append( " A.MILITODT,	A.NMREASON,	A.MRYDT,	A.DISDIV,		A.DISGRD, \n");
					sql.append( " A.MILITYPE,	A.MRTDIV,		A.MRTNO,	A.REFCD,		A.MILISPEC, \n");
					sql.append( " A.ENGLVL,		A.TOESCR,		A.JPTSCR,	A.DELFSCR,	A.TOFSCR, \n");
					sql.append( " A.DALFSCR,	A.TEPSSCR,	A.ETCLNG,	A.HWGRDCD,	A.EXGRDCD, \n");
					sql.append( " A.PWGRDCD,	A.ACGRDCD,	A.INTDT,	A.INTTM,		A.INTATTYN, \n");
					sql.append( " A.PASSDT,		A.AMDT,			A.EMPNO,	A.AMKIND,		A.LCSTYPE, \n");
					sql.append( " A.LCSCD,		A.PROSTS,		A.CARYEAR, A.PICFILE,  A.HSKSCR, B.INFO, \n");
					sql.append( " RTRIM(C.MINORNM) AS MILIDIVNM \n, ");		//병역구분
					sql.append( " RTRIM(D.MINORNM) AS MILIKNDNM \n, ");		//군별
					sql.append( " RTRIM(E.MINORNM) AS MILIGRDNM \n, ");		//계급
					sql.append( " RTRIM(F.MINORNM) AS BIRCITYNM \n, ");		//출신도
					sql.append( " RTRIM(G.MINORNM) AS RILIGNM   \n  ");		//종교
					sql.append( " FROM PAYROLL.HRPERSON A \n");						//입사지원기본
					sql.append( " LEFT JOIN PAYROLL.HRINFO B  ON  A.INFODIV=B.INFODIV \n");	//입사지원기본
					sql.append( " LEFT JOIN PAYROLL.HCLCODE C ON  A.MILIDIV=C.MINORCD AND C.MAJORCD='1168' \n");	//병역구분
					sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON  A.MILIKND=D.MINORCD AND D.MAJORCD='1116' \n");	//군별
					sql.append( " LEFT JOIN PAYROLL.HCLCODE E ON  A.MILIGRD=E.MINORCD AND E.MAJORCD='1134' \n");	//계급
					sql.append( " LEFT JOIN PAYROLL.HCLCODE F ON  F.MINORCD=A.BIRCITY AND F.MAJORCD='2011' \n");	//--출신도
					sql.append( " LEFT JOIN PAYROLL.HCLCODE G ON  G.MINORCD=A.RILIGN  AND G.MAJORCD='1117' \n");	//--종교
					sql.append( " WHERE A.INFODIV = '" + str2 + "' \n");
					sql.append( " AND A.RESINO = '" + str1 + "' \n");

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