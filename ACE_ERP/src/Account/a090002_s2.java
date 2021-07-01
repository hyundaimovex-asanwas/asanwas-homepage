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
public class a090002_s2 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");    //취득일자 from
				String  str2	= req.getParameter("v_str2");    //취득일자 to
				String  str3	= req.getParameter("v_str3");    //소속찾기
				String  str4	= req.getParameter("v_str4");    //자산분류
				String  str5	= req.getParameter("v_str5");    //자산번호
				String  str6	= req.getParameter("v_str6");    //자산명
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CHK", "FDCODE", "ASNBR", "ASAQSDAT", "ENDDAT", "STDDAT",  
											    "ASAQSAMT", "CURSUMAMT", "CURDEPAMT", "PREDEPAMT", "MONDEPAMT",
												"COSDIV", "ASLIFYER", "DEPDAT", "WRDT", "WRID", 
												 "UPDT", "UPID", "ASDSPSTS", "ASNAM", "FSSTAT",
												"ASDIVCOD", "BFDIVTCD"
												}; 

				int[] intArrCN = new int[]{ 1, 2, 14, 8, 8, 6,
											13, 13, 13, 13, 13,
											1, 3, 8, 8, 7, 
											8, 7, 1, 66, 13,
											2, 4	
											}; 
					
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1,
											0, 0, 0, 0, 0,
											-1, 0, -1, -1, -1,
											-1, -1, -1, -1, 0,
											-1, -1
										}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	

					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT ''CHK, RTRIM(A.FDCODE) FDCODE, RTRIM(A.ASNBR)ASNBR, A.ASAQSDAT,    \n " );
					sql.append( " A.ENDDAT, A.STDDAT, COALESCE(A.ASAQSAMT,0) ASAQSAMT,                     \n" );
					sql.append( " COALESCE(A.CURSUMAMT,0) CURSUMAMT, COALESCE(A.CURDEPAMT,0) CURDEPAMT,    \n" );
					sql.append( " COALESCE(A.PREDEPAMT,0) PREDEPAMT ,  COALESCE(A.MONDEPAMT,0) MONDEPAMT,  \n" );
					sql.append( " A.COSDIV, COALESCE(A.ASLIFYER,0) ASLIFYER, A.DEPDAT, A.WRDT, A.WRID,     \n" );
					sql.append( " A.UPDT, A.UPID, B. ASDSPSTS, B.ASNAM,     						\n  " );
					sql.append( " COALESCE((A.ASAQSAMT-A.CURSUMAMT),0) AS FSSTAT, B.ASDIVCOD, B.BFDIVTCD    \n " );
					sql.append( " FROM ACCOUNT.ASETDEP A 								\n" );
					sql.append( " LEFT JOIN ACCOUNT.ASETAQS B ON B.FDCODE = A.FDCODE AND B.ASNBR = A.ASNBR \n" );
					sql.append( " WHERE A.FDCODE IS NOT NULL  						\n");
					sql.append( " AND B.ASDSPSTS <> '3' 									\n");
					sql.append( " AND (((YEAR(CURRENT DATE)-A.ASLIFYER)||SUBSTR(CHAR(CURRENT DATE),6,2)||SUBSTR(CHAR(CURRENT DATE),9,2)>=A.ASAQSDAT)OR (A.ASAQSAMT-A.CURSUMAMT)<=0) \n" );
					if (!str1.equals("")) sql.append( " AND A.ASAQSDAT BETWEEN '"+str1+"' AND '"+str2+"' \n");
					if (!str3.equals("")) sql.append( " AND B.BFDIVTCD  = '" + str3 + "'			" );
					if (!str4.equals("")) sql.append( " AND B.ASDIVCOD = '" + str4 + "' 		\n" );
					if (!str5.equals("")) sql.append( " AND A.ASNBR ='" + str5 + "'					" );
					if (!str6.equals("")) sql.append( " AND B.ASNAM LIKE '%"+ str6 + "%'			" );
					
					//logger.dbg.println( this, sql.toString() );
					
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