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
public class h020003_s1 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "NMK","NMC","NME","RESINO","BIRDT",
																					"BIRCITY","HOBBY","RILIGN","SPECIAL","TELNO",
																					"HPNO","EMAIL","OADDR","CADDR","OZIPCD",
																					"CZIPCD","PHOTO","MINORNM","RMEMO","IMEMO",
																					"PMEMO","INTDT","PASSDT","INTTM","PROSTS",
																					"NORMEMO"
																				};

				int[] intArrCN = new int[]{ 30, 20,  40,  13,   8,
																		 4, 40,  20,  40,  15,
																		15, 30, 140, 140,   6,
																		 6, 30,  30, 150, 150,
																	 150,  8,   8,   4,   1,
																	 150
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1
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
					sql.append( "     A.NMK,A.NMC,A.NME,A.RESINO,A.BIRDT, ");
					sql.append( "			A.BIRCITY,A.HOBBY,B.MINORNM AS RILIGN,A.SPECIAL,A.TELNO, ");
					sql.append( "			A.HPNO,A.EMAIL,A.OADDR1 || A.OADDR2 AS OADDR, A.CADDR1 || A.CADDR2 AS CADDR, A.OZIPCD, ");
					sql.append( "			A.CZIPCD, A.PHOTO, C.MINORNM, D.RMEMO, D.IMEMO, ");
					sql.append( "     D.PMEMO, A.INTDT, A.PASSDT, A.INTTM, A.PROSTS, ");
					sql.append( "     D.NORMEMO ");
					sql.append( "   FROM PAYROLL.HRPERSON A, ");
					sql.append( "        PAYROLL.HCLCODE B, ");
					sql.append( "        PAYROLL.HCLCODE C, ");
					sql.append( "        PAYROLL.HRINFO D ");
					sql.append( "  WHERE A.RESINO = '" + str1 + "' ");
					sql.append( "    AND A.INFODIV = D.INFODIV ");
					sql.append( "    AND A.RILIGN = B.MINORCD ");
					sql.append( "    AND B.MAJORCD = '1117' ");
					sql.append( "    AND A.BIRCITY = C.MINORCD ");
					sql.append( "    AND C.MAJORCD = '2011' ");
					if (!str2.equals("")) sql.append( "    AND A.INFODIV = '" + str2 + "' ");

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