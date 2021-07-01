package sales.menu.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class KS_EmPopup_S extends HttpServlet {

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
				String  str2	= req.getParameter("v_str2"); 
				if (str2 == null) { str2 = ""; }


				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
																					"USTS",
																					"CUST_NM",
																					"CUST_SID",
																					"BIRTHDAY",
																					"SEX",
																					"ADDRESS1"

																}; 

				int[] intArrCN = new int[] { 
																			1,	//USTS 추가
																			30,
																			10,
																			8,
																			1,
																			80

															}; 
			
				int[] intArrCN2 = new int[]{
																			-1,	//USTS 추가
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

						sql.append( "	SELECT                                                  \n");
						sql.append( "	'1' AS USTS,                                            \n");
						sql.append( "	A.CUST_NM   AS  CUST_NM,                                \n");
						sql.append( "	A.CUST_SID  AS  CUST_SID,                               \n");
						sql.append( "	A.BIRTHDAY  AS  BIRTHDAY,                               \n");
						sql.append( "	A.SEX   AS  SEX,                                        \n");
						sql.append( "	A.ADDRESS  AS  ADDRESS,                               \n");
						sql.append( "	FROM SALES.TCU010 A                                     \n");
						sql.append( "	LEFT OUTER JOIN SALES.TCU060 B ON A.CUST_SID=B.CUST_SID \n");
						sql.append( "	WHERE A.CUST_GU = '2'                                   \n");

	//					sql.append( "	AND NOT EXISTS ( SELECT CUST_SID FROM SALES.TCM300      \n");
	//					sql.append( "	                  WHERE CUST_SID = A.CUST_SID)          \n");
						sql.append( "	AND A.CUST_NM LIKE '"+str1+"%'                          \n");
						if(!str2.equals(""))sql.append( "	AND A.CUST_SID ='"+str2+"'		      \n");

						sql.append( "	ORDER BY CUST_NM DESC                                   \n");

           // logger.dbg.println(this,"금강산 jys sql" + sql.toString());

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