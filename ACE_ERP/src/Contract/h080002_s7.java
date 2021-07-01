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
public class h080002_s7 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "EMPNO","SEQ","EDCCD","GRAYY","SCHNM",
																					"CITY","PGCCD","EDCDIV","STRYY",
																					"EDCNM","PGCNM","EDIVNM"
																				};

				int[] intArrCN = new int[]{  7,  2,  4,  4,  60, 
																		40,  4,  4,  4,
																		40, 40, 40
																	}; 

				int[] intArrCN2 = new int[]{ -1,  0, -1, -1, -1,
																		 -1, -1, -1, -1,
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
					sql.append( "    A.EMPNO,A.SEQ,A.EDCCD,RTRIM(A.GRAYY) AS GRAYY,RTRIM(A.SCHNM) AS SCHNM, ");
					sql.append( "		 RTRIM(A.CITY) AS CITY,A.PGCCD,A.EDCDIV,RTRIM(A.STRYY) AS STRYY, ");
					sql.append( "		 RTRIM(B.MINORNM) AS EDCNM, RTRIM(C.MINORNM) AS PGCNM, RTRIM(D.MINORNM) AS EDIVNM ");
					sql.append( "   FROM PAYROLL.T_HIEDUC A ");
					sql.append( "				 LEFT OUTER JOIN PAYROLL.HCLCODE B ON A.EDCCD = B.MINORCD AND B.MAJORCD = '1115' ");
					sql.append( "				 LEFT OUTER JOIN PAYROLL.HCLCODE C ON A.PGCCD = C.MINORCD AND C.MAJORCD = '1129' ");
					sql.append( "				 LEFT OUTER JOIN PAYROLL.HCLCODE D ON A.EDCDIV = D.MINORCD AND D.MAJORCD = '1118' ");
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