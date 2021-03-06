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
public class a010001_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2");
				String  str3	= req.getParameter("v_str3");

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
				//int val = 10000000;
				//String str = String.format("W%,d", val);
				//System.out.println(":::::::::::::"+str);

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CMTYPE",	"CMNAM", "CMLEN",	"CMREMARK",	"WRDT",
				                                  "WRID",  	"UPDT",	 "UPID",	"DSUDT" }; 

				int[] intArrCN = new int[]{ 4,40,2,60,8,
					                          7,8, 7, 8,}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, 0, -1, -1,
					                           -1, -1, -1, -1}; 

                
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT CMTYPE, 	CMNAM,	CMLEN,		 											\n");
					sql.append( "        CMREMARK,		WRDT, 														\n");
					sql.append( "        WRID,		UPDT,	 UPID, RTRIM(DSUDT) DSUDT								\n");
					sql.append( " FROM ACCOUNT.COMMLIST 															\n");
					sql.append( " WHERE CMTYPE IS NOT NULL															\n");
					if (str1.equals("A")) sql.append( " AND CMTYPE LIKE '" + str2 + "%'								\n");
					if (str1.equals("A")) sql.append( " AND CMNAM  LIKE '%" + str3 + "%'							\n");
					if (str1.equals("B")&&!str2.equals("")) sql.append( " AND CMTYPE LIKE '" + str2 + "%' 			\n");
					if (str1.equals("B")&&!str3.equals("")) sql.append( " AND CMNAM LIKE '%" + str3 + "%' 			\n");
					sql.append( " AND  CMTYPE NOT IN ('B996','B997','B998','B999') 									\n");	
					sql.append( "ORDER BY  CMTYPE  																	\n");
					
					
					
					//System.out.println("a010001_s1 \n" + sql.toString());					
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