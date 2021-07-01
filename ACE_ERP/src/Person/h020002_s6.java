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
public class h020002_s6 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "INFODIV","RESINO","SEQ","REFCD","FAMNM",
                                          "RESINOF","SCHNM","CMPNM","LSTEDC"
                                 				 }; 
	
				int[] intArrCN = new int[]{  6, 13,  2,  4, 30,
																		13, 30, 100, 4
					}; 
			
				int[] intArrCN2 = new int[]{ -1, -1,  0, -1, -1,
																		 -1, -1, -1, -1
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				dSet.addDataColumn(new GauceDataColumn("REFCDNM",   GauceDataColumn.TB_STRING, 30));
				dSet.addDataColumn(new GauceDataColumn("LSTEDCNM",   GauceDataColumn.TB_STRING, 30));


				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT ");
					sql.append( "     A.INFODIV,A.RESINO,A.SEQ,A.REFCD,A.FAMNM, ");
					sql.append( "     A.RESINOF,A.SCHNM,A.CMPNM,A.LSTEDC,C.MINORNM AS REFCDNM, D.MINORNM AS LSTEDCNM ");
					sql.append( "   FROM PAYROLL.HRFAMILY A ");
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE C ON  A.REFCD=C.MINORCD AND C.MAJORCD='1132' ");	//가족관계
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE D ON  A.LSTEDC=D.MINORCD AND D.MAJORCD='1115'  ");	//학력/대졸/중졸신도
					sql.append( "  WHERE RESINO = '" + str1 + "' ");

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