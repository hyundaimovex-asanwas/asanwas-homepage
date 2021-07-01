package northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class KS_Em027_S2 extends HttpServlet {

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
				
				
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{ "ATT_DT", "DAY_CD", "DAY_GB" }; 
				
				int[] intArrCN = new int[] { 8, 1, 1 }; 
							
				int[] intArrCN2 = new int[]{ -1, -1, -1 }; 
				
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
				
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
				
					sql.append( "SELECT	A.ATT_DT, A.DAY_CD, A.DAY_GB	\n");
					sql.append( "  FROM NORTHHR.KST130 A			\n");					
				
					sql.append( "	WHERE A.ATT_DT between  '"+str1+"' and '"+str2+"'	\n");
					sql.append( "	AND A.DAY_CD between '2' and '7' 								\n");
					sql.append( "	AND A.DAY_GB != '4' 												\n");
				//	sql.append( "	WHERE A.ITEM1 = 'Y'	\n");
				//	sql.append( "	  AND A.HEAD = '"+str1+"'	\n");
				//	sql.append( "	  AND RTRIM(A.DETAIL)<>''	\n");
				//	sql.append( "	   LEFT JOIN NORTHHR.KST130 B ON B.ATT_DT =A.DEPT_CD AND C.HEAD = 'KS006' AND TRIM(C.DETAIL)<>''\n");
				
				
				//	logger.dbg.println(this,sql.toString());
				 
					stmt = conn.getGauceStatement(sql.toString());
					stmt.executeQuery(dSet);
				}			 
/*********************************************************************************************/

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