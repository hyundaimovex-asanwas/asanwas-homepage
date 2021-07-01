package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a010006_s3 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
				String  str1	= req.getParameter("v_str1"); //통화코드
				String  str2    = req.getParameter("v_str2"); //기준일자 from
				String  str3    = req.getParameter("v_str3"); //기준일자 to

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ERCODE", "ERSTDDAT", "ERSED", "ERREV", "ERSTD",
													"ERCASED", "ERCAREV", "ERCRORAT", "ERMMLAST", "ERAVG", "ERHIS", "ERCODENM"
				}; 

				int[] intArrCN = new int[]{ 3, 8, 13, 66, 10,
											10, 10, 10, 10, 10, 10, 50
				}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, 5,
												5, 5, 5, 5, 5, 5, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT RTRIM(ERCODE) ERCODE, RTRIM(ERSTDDAT) ERSTDDAT,        										\n");
					sql.append( " 			RTRIM(ERSED) ERSED, RTRIM(ERREV) ERREV, nvl(ERSTD,0) ERSTD,       							\n");
					sql.append( " nvl(ERCASED,0) ERCASED, nvl(ERCAREV,0) ERCAREV, nvl(ERCRORAT,0) ERCRORAT,  					\n");
					sql.append( " nvl(ERMMLAST,0) ERMMLAST, nvl(ERAVG,0) ERAVG,     															\n");
					sql.append( " nvl(ERHIS,0) ERHIS, RTRIM(B.CDNAM) AS ERCODENM    															\n");
					sql.append( "   FROM ACCOUNT.EXCRATE        																							\n");
					sql.append( "   LEFT JOIN ACCOUNT.COMMDTIL B ON ERCODE = B.CDCODE AND B.CMTYPE='1043'        			\n");
					sql.append( "  WHERE 'Y' = 'Y' AND RTRIM(ERCODE) = '"+str1+"'  																	\n");
					if (!str2.equals("") && !str3.equals(""))sql.append( " AND RTRIM(ERSTDDAT) BETWEEN '"+str2+"' AND '"+str3+"'		\n");
					sql.append( "  ORDER BY ERSTDDAT DESC 																								\n");

					//System.out.println("# Query : " + sql);
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