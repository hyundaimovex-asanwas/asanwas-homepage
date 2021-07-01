package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class tr00602_s01 extends HttpServlet {

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

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "MAIGBN", "MAIYMD", "MAISEQ", "MAIREP", "MAITIME", 
													"MAISMAN", "MAISUBJ", "MAIDESC", "MAIFILES", "MAIFNAME",
													"MAIFILE", "REGNM", "MAIFLAG"
																				}; 

				int[] intArrCN = new int[]{ 1,   8,    5,  5,  12,
											 60, 255, 3000, 13, 100,
												1,  30,    1
																	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1,  0,  0, -1, 
												 -1, -1, -1,  0, -1,
												 -2, -1, -1
																	 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						case -2 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_URL)); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT X.MAIGBN,  X.MAIYMD,  X.MAISEQ,  X.MAIREP,   X.MAITIME, \n ")
					   .append( "		 X.MAISMAN, X.MAISUBJ, X.MAIDESC, X.MAIFILES, X.MAIFNAME, \n " )
					   .append( "		 X.MAIFILE, X.REGNM,   X.MAIFLAG \n " )
					   .append( "   FROM ( " )
					
					   .append( " SELECT A.MAIGBN, A.MAIYMD, A.MAISEQ, A.MAIREP, RTRIM(A.MAITIME) MAITIME, \n ")
					   .append( "		 RTRIM(A.MAISMAN) MAISMAN, RTRIM(A.MAISUBJ) MAISUBJ, RTRIM(A.MAIDESC) MAIDESC, A.MAIFILES, RTRIM(A.MAIFNAME) MAIFNAME, \n " )
					   .append( "		 '' MAIFILE, RTRIM(B.USERNAME) REGNM, A.MAIFLAG \n " )
					   .append( "   FROM TRANSFER.LTNOTICE A \n " )
					   .append( "	LEFT OUTER JOIN COMMON.USERFILE B ON RTRIM(A.MAISMAN) = RTRIM(B.USERID) \n " )
					   .append( "  WHERE A.MAIGBN = '" + str1 + "' \n " )
					   .append( "    AND A.MAIYMD LIKE '" + str2 + "%' \n " )
					   .append( "  ORDER BY A.MAIYMD DESC, A.MAISEQ DESC, A.MAIREP \n ")
                       .append( "  )X WHERE ROWNUM<=18 \n ");					          

/*********************************************************************************************/
                    //System.out.println("tr00602_s01::"+sql.toString());
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
	} //public void
} //public class