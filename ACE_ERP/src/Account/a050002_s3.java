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
public class a050002_s3 extends HttpServlet {
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
				String  str3 = req.getParameter("v_str3");	//기수

				if(str1 == null) str1 = "";
				if(str2 == null) str2 = "";
				if(str3 == null) str3 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"VENDCNT","SHTCNT","REQAMT","VATAMT",
					"VENDCNT1","SHTCNT1","REQAMT1","VATAMT1",
					"VENDCNT2","SHTCNT2","REQAMT2","VATAMT2"
				}; 

				int[] intArrCN = new int[]{
					 7,  7,  15, 14,
					 7,  7,  15, 14,
					 7,  7,  15, 14
				}; 
			
				int[] intArrCN2 = new int[]{     
					 0,  0,  0,  0,
					 0,  0,  0,  0,
					 0,  0,  0,  0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT													\n");
					sql.append( " nvl(A.VENDCNT,0)  VENDCNT,		\n");
					sql.append( " nvl(A.SHTCNT,0)   SHTCNT,		\n");
					sql.append( " nvl(A.REQAMT,0)   REQAMT,		\n");
					sql.append( " nvl(A.VATAMT,0)   VATAMT,		\n");
					sql.append( " nvl(A.VENDCNT1,0) VENDCNT1,	\n");
					sql.append( " nvl(A.SHTCNT1,0)  SHTCNT1,		\n");
					sql.append( " nvl(A.REQAMT1,0)  REQAMT1,		\n");
					sql.append( " nvl(A.VATAMT1,0)  VATAMT1,		\n");
					sql.append( " nvl(A.VENDCNT2,0) VENDCNT2,	\n");
					sql.append( " nvl(A.SHTCNT2,0)  SHTCNT2,		\n");
					sql.append( " nvl(A.REQAMT2,0)  REQAMT2,		\n");
					sql.append( " nvl(A.VATAMT2,0)  VATAMT2		\n");
					sql.append( "  FROM ACCOUNT.AVATRPT3 A				\n");
					sql.append( "  WHERE A.FDCODE IS NOT NULL							\n");
					if(!str1.equals(""))  sql.append( " AND A.FDCODE  = '"+str1+"'	\n");
					if(!str2.equals(""))  sql.append( " AND A.ACCYY   = '"+str2+"'	\n");
					if(!str3.equals(""))  sql.append( " AND A.ACCYYQT = '"+str3+"'	\n");

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