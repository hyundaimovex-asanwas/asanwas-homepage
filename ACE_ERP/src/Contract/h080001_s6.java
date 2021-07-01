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
public class h080001_s6 extends HttpServlet {

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

				if (str1==null) str1 = "";
				if (str2==null) str2 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","AFRDT","ATODT","ASSAMT","ASSINST",
																					"ASSGB","ASSNO","RECPAMT","DISDIV","DISGRD",
																					"HOSDT","HOSPITAL","HOSREVIT","HOSMEMO","EYEL",
																					"EYER","HEIGHT","WEIGHT","BLOOD","COLBLNYN",
																					"RHANDYN","MILIDIV","MILIKND","MILIGRD","MILINO",
																					"MILIPLC","MILIFRDT","MILITODT","NMREASON","MILITYPE",
																					"MILISPEC","MILIGBN","MILITGBN","ASSNAME","ASSRELA",
																					"ASSRESINO","ASSTELNO","ASSPOSTNO","ASSADDR",
																					"DISDNM","DISGNM","MILDNM",
																					"MILGNM","MILSNM","MILTNM",
																					"MILHNM","COLBNM"
																				};

				int[] intArrCN = new int[]{   7,  8,  8,   9, 50,
																		  1, 20,  6,   4,  4,
																		  8, 20,  1,  50,  2,
																		  2,  3,  3,   2,  1,
																		  1,  4,  4,   4, 15,
																		 30,  8,  8,  40,  4,
																			4,  1,  4,  20,  4,
																		 13, 15,  6, 100,
																		 40, 40, 40,  40, 40,
																		 40, 40, 40
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1,  0, -1,
																		 -1, -1,  0, -1, -1,
																		 -1, -1, -1, -1,  1,
																		  1,  0,  0, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "    SELECT RTRIM(A.EMPNO) AS EMPNO,RTRIM(A.FRDT) AS AFRDT,RTRIM(A.TODT) AS ATODT,A.ASSAMT,A.ASSINST,                            ");
					sql.append( "        A.ASSGB,A.ASSNO,A.RECPAMT,A.DISDIV,A.DISGRD,                                                            ");
					sql.append( "        RTRIM(A.HOSDT) AS HOSDT ,RTRIM(A.HOSPITAL) AS HOSPITAL,A.HOSREVIT,RTRIM(A.HOSMEMO) AS HOSMEMO,A.EYEL,   ");
					sql.append( "        A.EYER,A.HEIGHT,A.WEIGHT,A.BLOOD,A.COLBLNYN,                                                            ");
					sql.append( "        A.RHANDYN,A.MILIDIV,A.MILIKND,A.MILIGRD,A.MILINO,                                                       ");
					sql.append( "        A.MILIPLC,A.MILIFRDT,A.MILITODT,A.NMREASON,A.MILITYPE,                                                  ");
					sql.append( "        A.MILISPEC,A.MILIGBN,A.MILITGBN,A.ASSNAME,A.ASSRELA,                                                    ");
					sql.append( "        A.ASSRESINO,A.ASSTELNO,A.ASSPOSTNO,A.ASSADDR,                                                           ");
					sql.append( "        RTRIM(B.MINORNM) AS DISDNM, RTRIM(C.MINORNM) AS DISGNM, RTRIM(D.MINORNM) AS MILDNM,                     ");
					sql.append( "        RTRIM(E.MINORNM) AS MILGNM, RTRIM(F.MINORNM) AS MILSNM, RTRIM(G.MINORNM) AS MILTNM,                     ");
					sql.append( "        RTRIM(H.MINORNM) AS MILHNM, RTRIM(I.MINORNM) AS COLBNM                                                  ");
					sql.append( "      FROM PAYROLL.T_HIASSUR A                                                                                    ");
					sql.append( "           LEFT OUTER JOIN PAYROLL.HCLCODE B ON A.DISDIV = B.MINORCD AND B.MAJORCD = '1135'                     ");
					sql.append( "           LEFT OUTER JOIN PAYROLL.HCLCODE C ON A.DISGRD = C.MINORCD AND C.MAJORCD = '1136'                     ");
					sql.append( "           LEFT OUTER JOIN PAYROLL.HCLCODE D ON A.MILIDIV = D.MINORCD AND D.MAJORCD = '1168'                    ");
					sql.append( "           LEFT OUTER JOIN PAYROLL.HCLCODE E ON A.MILIGRD = E.MINORCD AND E.MAJORCD = '1134'                    ");
					sql.append( "           LEFT OUTER JOIN PAYROLL.HCLCODE F ON A.MILIKND = F.MINORCD AND F.MAJORCD = '1116'                   ");
					sql.append( "           LEFT OUTER JOIN PAYROLL.HCLCODE G ON A.MILITYPE = G.MINORCD AND G.MAJORCD = '1133'                   ");
					sql.append( "           LEFT OUTER JOIN PAYROLL.HCLCODE H ON A.MILITGBN = H.MINORCD AND H.MAJORCD = '2021'                   ");
					sql.append( "           LEFT OUTER JOIN PAYROLL.HCLCODE I ON A.COLBLNYN = I.MINORCD AND I.MAJORCD = '2022'                   ");
					sql.append( "     WHERE A.EMPNO = '"+ str1 + "'                                                                              ");

/*
					if (str2.equals("A")) sql.append( " AND FRDT <> '' " );
					else if (str2.equals("B")) sql.append( " AND MILIDIV <> '' " );
*/
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