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
public class a050005_s02 extends HttpServlet {
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
          "DATADIV","VENDID","FILLER","VENDCNT","SHTCNT",
          "REQAMT","VATAMT","VENDCNT1","SHTCNT1","REQAMT1",
          "VATAMT1","VENDCNT2","SHTCNT2","REQAMT2","VATAMT2"
        }; 

				int[] intArrCN  = new int[]{
          1  ,10 ,30 ,7  ,7  ,
          15 ,14 ,7  ,7  ,15 ,
          14 ,7  ,7  ,15 ,14
        }; 
			
				int[] intArrCN2 = new int[]{
          -1,-1,-1, 0, 0,
           0, 0, 0, 0, 0,
           0, 0, 0, 0, 0
        }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

			          sql.append("\n SELECT                                                                                                                                 ");
			          sql.append("\n   DATADIV,VENDID,TRIM(FILLER) FILLER,nvl(VENDCNT,0) VENDCNT,nvl(SHTCNT,0) SHTCNT,                                                             ");
			          sql.append("\n   nvl(REQAMT,0) REQAMT,nvl(VATAMT,0) VATAMT,nvl(VENDCNT1,0) VENDCNT1,nvl(SHTCNT1,0) SHTCNT1,nvl(REQAMT1,0) REQAMT1,     ");
			          sql.append("\n   nvl(VATAMT1,0) VATAMT1,nvl(VENDCNT2,0) VENDCNT2,nvl(SHTCNT2,0) SHTCNT2,nvl(REQAMT2,0) REQAMT2,nvl(VATAMT2,0) VATAMT2  ");
			          sql.append("\n  FROM ACCOUNT.AVATRPT3                                                                                                                 ");
			          sql.append("\n WHERE FDCODE IS NOT NULL																														\n");
			          if(!str1.equals(""))  sql.append( "\n AND FDCODE = '"+str1+"'																\n");
			          if(!str2.equals(""))  sql.append( "\n AND ACCYY  = '"+str2+"'																\n");
			          if(!str3.equals(""))  sql.append( "\n AND ACCYYQT = '"+str3+"'															\n");
			          
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