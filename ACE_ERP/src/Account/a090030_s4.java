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
public class a090030_s4 extends HttpServlet {
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
				// 감가상각 조회 쿼리

				String  str1 = req.getParameter("v_str1");    //소속
				String  str2 = req.getParameter("v_str2");    //자산분류
				String  str3 = req.getParameter("v_str3");    //원가코드 
				String  str4 = req.getParameter("v_str4");    //기준년월
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"FDCODE",    "RCOSTCD",    "COSTCD",   "COSTNM",     "ATCODE",  "AST2ND", "AST2NDNM",
					                                                "ASTAQAMT",  "ABDEPRAMT", "ACDEPRAMT", "ACDEPRSUM",  "ASTRMAMT" ,"REDUAMT" 
					                              }; 

				int[] intArrCN = new int[]{ 2,  6,   6, 100,  7, 2, 30,
					                         13, 13,  13, 13,  13, 13  }; 
					
				int[] intArrCN2 = new int[]{-1, -1, -1, -1, -1, -1, -1, 
					                           0,  0,  0,  0, 0, 0 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT FDCODE,      0 RCOSTCD,      COSTCD,        COSTNM,        ATCODE,         AST2ND,   AST2NDNM,   \n"); 
					sql.append( "              ASTAQAMT,  ABDEPRAMT,    ACDEPRAMT,  ACDEPRSUM,  0 ASTRMAMT, REDUAMT                       \n"); 
					sql.append( "    FROM ACCOUNT.ASTMMCCHT                                                                  \n"); 
					sql.append( "  WHERE FDCODE ='"+str1+"'                                                                          \n"); 
					sql.append( "       AND ASTYM   ='"+str4+"'                                                                          \n"); 
					if (!str2.equals(""))sql.append( "       AND AST2ND  ='"+str2+"'                                             \n"); 
					if (!str3.equals(""))sql.append( "       AND COSTCD ='"+str3+"'                                             \n"); 

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