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
public class h020005_s1 extends HttpServlet {

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
				String  str4	= req.getParameter("v_str4");
				String  str5	= req.getParameter("v_str5");
				String  str6	= req.getParameter("v_str6");
				String  str7	= req.getParameter("v_str7");

				if (str1==null) str1 = "";
				if (str2==null) str2 = "";
				if (str3==null) str3 = "";
				if (str4==null) str4 = "";
				if (str5==null) str5 = "";
				if (str6==null) str6 = "";
				if (str7==null) str7 = "";

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
																					"LCSCD","PROSTS","BCHK","OADDR"}; 

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
																		 4,  1,  1,100
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
																		 -1, -1, -1, -1
																		}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT \n");
					sql.append( " INFODIV,RESINO,WRDT,WRNO,NMK, \n");
					sql.append( " PHOTO,BIRDT,GLDIV,HOBBY,NMC, \n");
					sql.append( " RILIGN,NME,BIRCITY,SPECIAL,OZIPCD, \n");
					sql.append( " OADDR1,OADDR2,CZIPCD,CADDR1,CADDR2, \n");
					sql.append( " TELNO,HPNO,EMAIL,EYEL,EYER, \n");
					sql.append( " HEIGHT,WEIGHT,BLOOD,RGHANDYN,MILIDIV, \n");
					sql.append( " MILIKND,MILIGRD,MILINO,MILIPLC,MILIFRDT, \n");
					sql.append( " MILITODT,NMREASON,MRYDT,DISDIV,DISGRD, \n");
					sql.append( " MILITYPE,MRTDIV,MRTNO,REFCD,MILISPEC, \n");
					sql.append( " ENGLVL,TOESCR,JPTSCR,DELFSCR,TOFSCR, \n");
					sql.append( " DALFSCR,TEPSSCR,ETCLNG,HWGRDCD,EXGRDCD, \n");
					sql.append( " PWGRDCD,ACGRDCD,RTRIM(INTDT) INTDT,RTRIM(INTTM) INTTM,INTATTYN, \n");
					sql.append( " RTRIM(PASSDT) PASSDT,AMDT,EMPNO,AMKIND,LCSTYPE, \n");
					sql.append( " LCSCD,PROSTS, 'F' BCHK, OADDR1 || OADDR2 AS OADDR \n");
					sql.append( " FROM PAYROLL.HRPERSON \n");
					sql.append( " WHERE WRDT BETWEEN '" + str1 + "' AND '" + str2 + "' \n");

				if (!str3.equals("")) sql.append( " AND INFODIV = '" + str3 + "' \n");
				if (!str4.equals("")) sql.append( " AND WRNO BETWEEN " + str4 + " AND " + str5 + " \n");
				if (!str6.equals("")) sql.append( " AND NMK LIKE '" + str6 + "%' \n");
				if (!str7.equals("")) sql.append( " AND PROSTS = '" + str7 + "' \n");

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