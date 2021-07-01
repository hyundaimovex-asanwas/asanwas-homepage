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
public class Em010_S4 extends HttpServlet {

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
																					"EMPNO",
																					"SEQ",
																					"CUST_SID",
																					"START_DT",
																					"END_DT",
																					"COMPNM",
																					"POSINM",
																					"DUTYNM",
																					"CARRAT",
																					"REAMRK",
																					"I_EMPNO",
																					"U_EMPNO",
																					"I_DATE",
																					"U_DATE"
																}; 

				int[] intArrCN = new int[] { 
																				10,
																				2,	
																				10,	
																				8,
																				8,
																				40, 
																				40, 
																				40, 
																				5,
																				60, 
																				10,
																				10,
																				10,
																				10 
															}; 
			
				int[] intArrCN2 = new int[]{
																				-1,
																				0,
																				0,
																				-1,
																				-1,
																				-1,
																				-1,
																				-1,
																				2,
																				-1,
																				-1,
																				-1,
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

						sql.append( "SELECT                  \n");
						sql.append( "EMPNO,                  \n");
						sql.append( "SEQ,                    \n");
						sql.append( "CUST_SID,               \n");
						sql.append( "START_DT,               \n");
						sql.append( "END_DT,                 \n");
						sql.append( "COMPNM,                 \n");
						sql.append( "POSINM,                 \n");
						sql.append( "DUTYNM,                 \n");
						sql.append( "CARRAT,                 \n");
						sql.append( "REAMRK,                 \n");
						sql.append( "I_EMPNO,                \n");
						sql.append( "U_EMPNO,                \n");
						sql.append( "I_DATE,                 \n");
						sql.append( "U_DATE                  \n");
						sql.append( "FROM SALES.TCM310       \n");
						sql.append( "WHERE EMPNO = '"+str1+"'\n");
						sql.append( "ORDER BY EMPNO DESC			\n");


//System.out.println("Em010_S4"+sql.toString());
						stmt = conn.getGauceStatement(sql.toString());
//System.out.println("Em010_S4");
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