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
public class h020002_s8 extends HttpServlet {

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

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "INFODIV","INFO","CARRDIV","RFRDT","RTODT",
                                          "IFRDT","ITODT","PFRDT","PTODT","RMEMO",
                                          "IMEMO","PMEMO","NORMEMO","DSPNM"
                                        }; 

				int[] intArrCN = new int[]{  6, 50,  1,  8,  8,
				                             8,  8,  8,  8,150,
				                           150,150,150,150
                        					}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
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
					sql.append( " SELECT ");
					sql.append( "     A.INFODIV,A.INFO,A.CARRDIV,A.RFRDT,A.RTODT, ");
					sql.append( "     A.IFRDT,A.ITODT,A.PFRDT,A.PTODT,A.RMEMO,    ");
					sql.append( "     A.IMEMO,A.PMEMO,A.NORMEMO, RTRIM(A.INFO) || '-' || RTRIM(B.MINORNM) AS DSPNM ");
					sql.append( "   FROM PAYROLL.HRINFO A, ");		//채용안내정보
					sql.append( "        PAYROLL.HCLCODE B ");		//채용구분
					sql.append( "  WHERE RTRIM(A.CARRDIV) = RTRIM(B.MINORCD) ");
					sql.append( "    AND B.MAJORCD = '2010' ");
					sql.append( "    AND CAST('" + str1 + "' AS INTEGER) BETWEEN CAST(A.RFRDT AS INTEGER) AND CAST(A.RTODT AS INTEGER) ");
          sql.append( " ORDER BY A.INFO ");

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