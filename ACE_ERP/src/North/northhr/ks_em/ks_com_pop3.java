/************************************************************************************************
 * 개인정보관리 : 협력업체 조회
 ************************************************************************************************/
package North.northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.

public class ks_com_pop3 extends HttpServlet {

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
        		String  str1	= GauceReq.getParameter("v_str1"); 				
				String  str2	= GauceReq.getParameter("v_str2"); 
				
				if (str1==null || str1=="") str1 = "";
				if (str2==null || str2=="") str2 = "";
				
				GauceRes.enableFirstRow(dSet);
				
				String[] strArrCN = new String[]{  "EMPNO"  ,"EMPNMK", "DEPT_NM" , "DEPT_CD"}; 

				int[] intArrCN = new int[] { 10,  30, 10 , 5	}; 
			
				int[] intArrCN2 = new int[]{ -1,-1,  -1, -1 };

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				StringBuffer sql = new StringBuffer();

				sql.append( " SELECT  A.EMPNO,A.EMPNMK,					   													\n");
				sql.append( " 				K.DETAIL_NM AS DEPT_NM,  A.DEPT_CD  											\n");	
				sql.append( "   FROM ATP.KST010 A      																				\n");
				sql.append( "		LEFT JOIN ATP.TSY010 K ON RTRIM(K.DETAIL) = RTRIM(A.DEPT_CD)   	   		\n");
				sql.append( "		AND K.HEAD='KS006'  AND RTRIM(K.DETAIL) IS NOT NULL   							\n");				
				sql.append( " WHERE 1=1																									\n");
				sql.append( " AND A.USESTS = '1'																						\n");							
				if (!str1.equals("")) sql.append( " AND A.EMPNO = '"+str1+"'													\n");				
				if (!str2.equals("")) sql.append( " AND A.EMPNMK LIKE '"+str2+"%'												\n");
				sql.append( "  ORDER BY A.EMPNO 																					\n");

				//logger.dbg.println(this,sql.toString());

				stmt = conn.getGauceStatement(sql.toString());
				stmt.executeQuery(dSet);

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