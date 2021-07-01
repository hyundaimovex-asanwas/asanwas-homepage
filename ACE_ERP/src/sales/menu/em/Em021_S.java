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
public class Em021_S extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1==null) {str1="";}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
                                          "YYYYMM","SKILL_CD","CON_YEAR","B_PAY","T_PAY",
                                          "I_EMPNO","U_EMPNO","I_DATE","U_DATE"
																			  }; 

				int[] intArrCN = new int[] { 
                                          10, 3, 2, 10, 10,
                                          10, 10, 10, 10
																			}; 
			
				int[] intArrCN2 = new int[]{
                                          -1,-1, 0, 2, 2,
                                          -1,-1,-1,-1
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();


                    sql.append( "	SELECT                    \n");
                    sql.append( "	YYYYMM,                   \n");
                    sql.append( "	SKILL_CD,                 \n");
                    sql.append( "	CON_YEAR,                 \n");
                    sql.append( "	B_PAY,                    \n");
                    sql.append( "	T_PAY,                    \n");
                    sql.append( "	I_EMPNO,                  \n");
                    sql.append( "	U_EMPNO,                  \n");
                    sql.append( "	I_DATE,                   \n");
                    sql.append( "	U_DATE                    \n");
                    sql.append( "	FROM SALES.TCM410         \n");
if(!str1.equals(""))sql.append( "	WHERE YYYYMM = '"+str1+"' \n");
//                    sql.append( "	AND SKILL_CD = ? \n");
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