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
public class EmPopup_S extends HttpServlet {

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
				String  str3	= req.getParameter("v_str3"); 
				if (str2 == null) { str2 = ""; }
				if (str3 == null) { str3 = ""; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
																					"USTS",
																					"CUST_NM",
																					"CUST_SID",
																					"BIRTHDAY",
																					"SEX",
																					"PASS_NO",
																					"PASS_EXPIRE_DATE",
																					"N_CARD_NO",
																					"COUNTRY_CD",
																					"TEL_NO",//10
																					"MOBILE_NO",
																					"ADDRESS1",
																					"ADDRESS2",
																					"ZIP_CD",
																					"LAST_NM",
																					"FIRST_NM",
																					"ENG_NM"
																}; 

				int[] intArrCN = new int[] { 
																			1,	//USTS 추가
																			30,
																			10,
																			8,
																			1,
																			20,
																			8,
																			20,
																			3,
																			20,//10
																			20,
																			80,
																			60,
																			6,
																			30,
																			30,
																			60
															}; 
			
				int[] intArrCN2 = new int[]{
																			-1,	//USTS 추가
																			-1,
																			-1,	
																			-1,
																			-1,
																			-1,
																			-1,
																			-1,
																			-1,
																			-1,//10
																			-1,
																			-1,
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
						sql.append( "	A.PASS_NO   AS  PASS_NO,                                \n");
						sql.append( "	A.PASS_EXPIRE_DATE  AS  PASS_EXPIRE_DATE,               \n");
						sql.append( "	A.COUNTRY_CD AS  COUNTRY_CD,                            \n");
						sql.append( "	A.TEL_NO    AS  TEL_NO,                                 \n");
						sql.append( "	A.MOBILE_NO AS  MOBILE_NO,                              \n");
						sql.append( "	A.ADDRESS1  AS  ADDRESS1,                               \n");
						sql.append( "	A.ADDRESS2  AS  ADDRESS2,                               \n");
						sql.append( "	A.ZIP_CD  AS  ZIP_CD,                                   \n");
						sql.append( "	A.LAST_NM  AS  LAST_NM,                                 \n");
						sql.append( "	A.FIRST_NM  AS  FIRST_NM,                               \n");
						sql.append( "	LAST_NM ||'-'|| FIRST_NM AS ENG_NM,                     \n");
						sql.append( "	B.N_CARD_NO AS  N_CARD_NO                               \n");
						sql.append( "	FROM SALES.TCU010 A                                     \n");
						sql.append( "	LEFT OUTER JOIN SALES.TCU060 B ON A.CUST_SID=B.CUST_SID \n");
						sql.append( "	WHERE A.CUST_GU = '2'                                   \n");
						sql.append( " AND (PASS_NO IS NOT NULL AND RTRIM(PASS_NO)<>'')        \n");
						sql.append( "	AND NOT EXISTS ( SELECT CUST_SID FROM SALES.TCM300      \n");
						sql.append( "	                  WHERE CUST_SID = A.CUST_SID)          \n");
						sql.append( "	AND A.CUST_NM LIKE '"+str1+"%'                          \n");
						if(!str2.equals(""))sql.append( "	AND A.CUST_SID ='"+str2+"'		      \n");
						if(!str3.equals(""))sql.append( "	AND A.NATION_CD = '"+str3+"'        \n");
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