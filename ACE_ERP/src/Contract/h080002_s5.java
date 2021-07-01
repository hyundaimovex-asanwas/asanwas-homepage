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
public class h080002_s5 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "EMPNO","ORDDT","SEQ","DEPTCD",
																					"JOBKIND","BASICPAY",
																					"DEPTNM","JOBKINDNM"
																				};

				int[] intArrCN = new int[]{  7,  8,  2,  4, 
																		 4,  9,
																		40, 30
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1,  0, -1,
																		 -1,  0,
																		 -1, -1
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
					sql.append( "    A.EMPNO,A.ORDDT,A.SEQ,RTRIM(A.DEPTCD) AS DEPTCD, ");
					sql.append( "		 A.JOBKIND, A.BASICPAY, " );
					sql.append( "		 RTRIM(B.DEPTNM) AS DEPTNM, RTRIM(C.MINORNM) AS JOBKINDNM ");
					sql.append( "   FROM PAYROLL.T_HOORDER A");
					sql.append( "				 LEFT OUTER JOIN PAYROLL.HCDEPT B ON A.DEPTCD = B.DEPTCD ");
					sql.append( "				 LEFT OUTER JOIN PAYROLL.HCLCODE C ON A.JOBKIND = C.MINORCD AND C.MAJORCD = '2036' ");
					//sql.append( "				 LEFT OUTER JOIN PAYROLL.HCLCODE D ON A.PAYSEQ = D.MINORCD AND D.MAJORCD = '1184' ");
					//sql.append( "				 LEFT OUTER JOIN PAYROLL.HCORDCOD E ON A.ORDCD = E.ORDCD ");
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