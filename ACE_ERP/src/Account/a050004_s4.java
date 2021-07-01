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
public class a050004_s4 extends HttpServlet {
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
				String  str1 = req.getParameter("v_str1");	//지점
				String  str2 = req.getParameter("v_str2");	//년도
				String  str3 = req.getParameter("v_str3");	//기수기간from
				String  str4 = req.getParameter("v_str4");	//기수기간from

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";
				if(str4 == null) str4 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
		          "ILBAN_CNT"   , "ILBAN_GONAMT" , "ILBAN_VATAMT" , "GITA_CNT","GITA_GONAMT",
		          "GITA_VATAMT","BUL_CNT" , "BUL_GONAMT","BUL_VATAMT"
				}; 

				int[] intArrCN = new int[]{
		          15, 15, 15, 15, 15,
		          15, 15, 15, 15
				}; 
			
				int[] intArrCN2 = new int[]{
					0,  0,  0,  0,  0, 
					 0,  0,  0,  0
				}; 

				for (int i=0; i<strArrCN.length; i++) { 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
			          sql.append("\n SELECT SUM(CASE TAXKND WHEN '1' THEN 1 WHEN '2' THEN 1 ELSE 0 END) ILBAN_CNT,				/*일반 매입 매수*/                                       ");
			          sql.append("\n              SUM(CASE TAXKND WHEN '1' THEN TAXSUM WHEN '2' THEN TAXSUM ELSE 0 END) ILBAN_GONAMT,		/*일반 매입 공급가액*/                         ");
			          sql.append("\n              SUM(CASE TAXKND WHEN '1' THEN TAXVATAMT WHEN '2' THEN TAXVATAMT ELSE 0 END) ILBAN_VATAMT,	/*일반 매입 부가세액*/                         ");
			          sql.append("\n              SUM(CASE TAXKND WHEN '7' THEN 1 WHEN '8' THEN 1 ELSE 0 END) GITA_CNT,							/*기타 매입 매수*/             ");
			          sql.append("\n              SUM(CASE TAXKND WHEN '7' THEN TAXSUM WHEN '8' THEN TAXSUM ELSE 0 END) GITA_GONAMT,			/*기타 매입 공급가액*/   ");
			          sql.append("\n              SUM(CASE TAXKND WHEN '7' THEN TAXVATAMT WHEN '8' THEN TAXVATAMT ELSE 0 END) GITA_VATAMT,	/*기타 매입 부가세액*/ ");
			          sql.append("\n              SUM(CASE TAXKND WHEN '4' THEN 1 ELSE 0 END) BUL_CNT,					/*불공제 매입 매수*/                               ");
			          sql.append("\n              SUM(CASE TAXKND WHEN '4' THEN TAXSUM ELSE 0 END) BUL_GONAMT,		/*불공제 매입 공급가액*/                         ");
			          sql.append("\n              SUM(CASE TAXKND WHEN '4' THEN TAXVATAMT ELSE 0 END) BUL_VATAMT	/*불공제 매입 부가세액*/                         ");
			          sql.append("\n    FROM ACCOUNT.ATTAXMST	                                                                                                     ");
			          sql.append("\n  WHERE COCODE = '"+str1+"'		/*사업소*/                                                                                             ");
			          sql.append("\n      AND TAXDAT >= '"+str3+"'	/*거래기간FROM*/                                                                               ");
			          sql.append("\n      AND TAXDAT <= '"+str4+"'	/*거래기간TO*/                                                                                 ");
			          sql.append("\n      AND TAXDIV = '0001'                                                                                                      ");
			          sql.append("\n      AND TAXIODIV = 'A'                                                                                                     ");
				 	
			          //System.out.println("# Query : \n" + sql);
			          //logger.dbg.println(this,sql.toString());

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