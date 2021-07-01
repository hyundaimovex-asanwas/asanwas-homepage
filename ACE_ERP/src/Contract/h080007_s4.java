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
public class h080007_s4 extends HttpServlet {

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

				if (str1==null) str1 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO","SEQ","LCSTYPE","LCSCD","LCSNO",
																					"GETDT","CHGDT","ISSPART","STRDT","LOSDT",
																					"APPYN","LCSTNM","LCSCNM"
																				};

				int[] intArrCN = new int[]{  7,  2,  4,  4, 20, 
																		 8,  8, 30,  8,  8,
																		 1, 40, 40
																	}; 

				int[] intArrCN2 = new int[]{ -1,  0, -1, -1, -1,
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
					sql.append( " SELECT ");
					sql.append( "    RTRIM(A.EMPNO) EMPNO,A.SEQ,RTRIM(A.LCSTYPE) LCSTYPE,RTRIM(A.LCSCD) LCSCD,RTRIM(A.LCSNO) LCSNO, ");
					sql.append( "		 RTRIM(A.GETDT) AS GETDT,RTRIM(A.CHGDT) CHGDT,RTRIM(A.ISSPART) AS ISSPART, ");
					sql.append( "    RTRIM(A.STRDT) AS STRDT,RTRIM(A.LOSDT) AS LOSDT, ");
					sql.append( "		 RTRIM(A.APPYN) APPYN, RTRIM(B.MINORNM) AS LCSTNM, RTRIM(C.MINORNM) AS LCSCNM ");
					sql.append( "   FROM PAYROLL.T_HILICENS A");
					sql.append( "				 LEFT OUTER JOIN PAYROLL.HCLCODE B ON A.LCSTYPE = B.MINORCD AND B.MAJORCD = '1127' ");
					sql.append( "				 LEFT OUTER JOIN PAYROLL.HCLCODE C ON A.LCSCD = C.MINORCD AND C.MAJORCD = '1128' ");
					sql.append( "  WHERE A.EMPNO = '" + str1 + "' ");

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