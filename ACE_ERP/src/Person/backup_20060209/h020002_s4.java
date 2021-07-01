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
public class h020002_s4 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "INFODIV","RESINO","SEQ","EDCCD","GRAYY",
                                          "SCHNM","CITY","PGCCD","EDCDIV","AVRUNI",
																					"PERFECT"
                                 				 }; 
	
				int[] intArrCN = new int[]{  6, 13,  2,  4,  4,
																		60, 40, 50,  4,  2,
																		 2
					}; 
			
				int[] intArrCN2 = new int[]{ -1, -1,  0, -1, -1,
																		 -1, -1, -1, -1,  1,
																		  1
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


				dSet.addDataColumn(new GauceDataColumn("EDCCDNM",   GauceDataColumn.TB_STRING, 30));
				dSet.addDataColumn(new GauceDataColumn("PGCCDNM",   GauceDataColumn.TB_STRING, 30));
				dSet.addDataColumn(new GauceDataColumn("EDCDIVNM",   GauceDataColumn.TB_STRING, 30));

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT ");
					sql.append( "     A.INFODIV,A.RESINO,A.SEQ,A.EDCCD,A.GRAYY, ");
					sql.append( "     A.SCHNM,A.CITY,A.PGCCD,A.EDCDIV,A.AVRUNI, ");
					sql.append( "     A.PERFECT,B.MINORNM AS EDCCDNM,C.MINORNM AS PGCCDNM,D.MINORNM AS EDCDIVNM  ");
					sql.append( "   FROM PAYROLL.HREDUC A");
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE B ON  A.EDCCD=B.MINORCD AND B.MAJORCD='1115'  ");	//학력
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE C ON  A.PGCCD=C.MINORCD AND C.MAJORCD='1129' ");	//전공
					sql.append( "   LEFT JOIN PAYROLL.HCLCODE D ON  A.EDCDIV=D.MINORCD AND D.MAJORCD='1118'  ");	//졸업구분
					sql.append( "  WHERE RESINO = '" + str1 + "' ");

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