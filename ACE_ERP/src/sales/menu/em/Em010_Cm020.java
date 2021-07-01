package sales.menu.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class Em010_Cm020 extends HttpServlet {

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

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
																					"COM_CODE",
																					"COM_SNAME"
																}; 

				int[] intArrCN = new int[] { 
																				10,
																				50
															}; 
			
				int[] intArrCN2 = new int[]{
																				-1,
																				-1
															}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "SELECT												\n");
						sql.append( "TRIM(DETAIL) AS COM_CODE,		\n");
						sql.append( "TRIM(DETAIL_NM) AS COM_SNAME	\n");
						sql.append( "FROM SALES.TSY010						\n");
						sql.append( "WHERE HEAD = '"+str1+"'			\n");
						sql.append( "AND ITEM4 = 'Y'			\n");
						sql.append( "AND RTRIM(DETAIL) <>''							\n");

//						logger.dbg.println(this,"Em010_Cm020"+sql.toString());
						stmt = conn.getGauceStatement(sql.toString());

//						logger.dbg.println(this,"Em010_Cm020_01");
		 				stmt.executeQuery(dSet);
//						logger.dbg.println(this,"Em010_Cm020_02");

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