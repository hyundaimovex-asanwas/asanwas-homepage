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
public class tr00505_s1 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "SETTLE_CD", "SETTLE_NM", "ACC_CODE",	"SELL_TYPE", "SORT_NO",
												  "REMARK",  "CREATE_USR",  "UPDATE_USR"
														}; 

				int[] intArrCN = new int[]{  4, 50, 10, 4, 4,
										50, 10, 10
														}; 
		
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, 0,
												-1,-1, -1
													}; 
//logger.dbg.println(this,"test12");

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

//logger.dbg.println(this,"test14");
				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

//logger.dbg.println(this,"test15");
					sql.append( " SELECT RTRIM(SETTLE_CD) SETTLE_CD, RTRIM(SETTLE_NM) SETTLE_NM,    " );
					sql.append( "		 ACC_CODE, SELL_TYPE,       " );
					sql.append( "		 COALESCE(SORT_NO,0) SORT_NO , RTRIM(REMARK) REMARK,          " );
					sql.append( "		 RTRIM(CREATE_USR) CREATE_USR, RTRIM(UPDATE_USR) UPDATE_USR  " );
					sql.append( " FROM TRANSFER.LTSTTMNTCD " );
//logger.dbg.println(this,"test 17");
					
					sql.append( " WHERE SETTLE_CD <> '' ");

					if (!str1.equals("")) sql.append( " AND SETTLE_CD = '" + str1 + "'");
					if (!str2.equals("")) sql.append( " AND SETTLE_NM LIKE '" + str2 + "%'" );

					sql.append( " ORDER BY SETTLE_CD " );
				
					//logger.dbg.println( this, sql.toString() );
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