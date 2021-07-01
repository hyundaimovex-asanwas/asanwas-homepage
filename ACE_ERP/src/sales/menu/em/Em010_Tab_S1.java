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
public class Em010_Tab_S1 extends HttpServlet {

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
																					"ZIP_ADD",			
																					"ZIP_CD",			
																					"ADDRESS1",		
																					"ADDRESS2",		
																					"TEL_NO",			
																					"MOBILE_NO",	
																					"HEIGHT",			
																					"WEIGHT",			
																					"SIZE_UP",		
																					"SIZE_DN",		
																					"SIZE_FT",		
																					"SIZE_WT",		
																					"BLOOD"				
																}; 

				int[] intArrCN = new int[] { 
																				86,
																				6,
																				80,
																				60,
																				20,
																				20,
																				4,
																				4,
																				3,
																				3,
																				3,
																				3,
																				1
															}; 
			
				int[] intArrCN2 = new int[]{
																			-1,	
																			-1,	
																			-1,	
																			-1,	
																			-1,	
																			-1,	
																			0,	
																			0,	
																			-1,	
																			-1,	
																			0,	
																			0,	
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

						sql.append( "	SELECT																										\n");
						sql.append( "	B.ZIP_CD AS ZIP_CD,																				\n");
						sql.append( "	TRIM(B.ADDRESS1) AS ADDRESS1,															\n");
						sql.append( "	ZIP_CD||'-'||ADDRESS1 AS ZIP_ADD,												\n");
						sql.append( "	TRIM(B.ADDRESS2) AS ADDRESS2,															\n");
						sql.append( "	TRIM(B.TEL_NO)  AS  TEL_NO,																\n");
						sql.append( "	TRIM(B.MOBILE_NO)   AS  MOBILE_NO,												\n");
						sql.append( "	TRIM(A.SIZE_UP) AS  SIZE_UP,															\n");
						sql.append( "	TRIM(A.SIZE_DN) AS  SIZE_DN,															\n");
						sql.append( "	TRIM(A.BLOOD)   AS  BLOOD,																\n");
						sql.append( "	A.HEIGHT    AS  HEIGHT,																		\n");
						sql.append( "	A.WEIGHT    AS  WEIGHT,																		\n");
						sql.append( "	A.SIZE_FT   AS  SIZE_FT,																	\n");
						sql.append( "	A.SIZE_WT   AS  SIZE_WT																		\n");
						sql.append( "	FROM SALES.TCM300 A																				\n");
						sql.append( "	LEFT OUTER JOIN SALES.TCU010 B ON A.CUST_SID=B.CUST_SID		\n");
						sql.append( "	WHERE A.EMPNO = '"+str1+"'																\n");
						sql.append( "	ORDER BY A.EMPNO DESC																			\n");

								logger.dbg.println(this,sql.toString());

						stmt = conn.getGauceStatement(sql.toString());

								logger.dbg.println(this,"OK_Em010_Tab_start");

		 				stmt.executeQuery(dSet);
						
								logger.dbg.println(this,"OK_Em010_Tab_end");
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