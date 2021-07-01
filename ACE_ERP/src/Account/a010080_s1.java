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
public class a010080_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //거래처코드 
				String  str2	= req.getParameter("v_str2"); //거래처명
				String  str3	= req.getParameter("v_str3"); //사업자등록번호 

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
	    		GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{   "CHK",       "VEND_CD",  	"VEND_NM",	    "VEND_ID",	   	"VD_DIRECT",	
													"BSNS_CND",	 "BSNS_KND",    "USE_TAG_1",	
													"VEND_SEQ",  "MINOR_CD",    "POST_NO",  	"ADDRESS1",	    "ADDRESS2",	   	
													"USE_TAG",	 "CLOSE_DT",
													"IPT_MAN",   "IPT_YMD",     "UPT_MAN",      "UPT_YMD"
											     }; 

				int[] intArrCN = new int[]{  1, 13, 62, 15, 62,		
											 62, 62, 1,	
											 10,  4, 5, 132, 72,
											  1,  8,
											 10, 10, 10, 10
											}; 

				int[] intArrCN2 = new int[]{  -1, -1, -1, -1, -1,
											   -1, -1, -1,
											    0, -1, -1, -1, -1,
											   -1, -1, 
											   -1, -1, -1, -1 
											 }; 
				
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

			   

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT  'F' CHK,    A.VEND_CD,  B.VEND_NM, B.VEND_ID,    	\n" );
					sql.append( "         CASE WHEN A.VD_DIRECT IS NULL THEN B.VD_DIRECT ELSE A.VD_DIRECT END VD_DIRECT, \n" );
					sql.append( "         B.BSNS_CND, B.BSNS_KND, B.USE_TAG AS USE_TAG_1, 				\n" );
					sql.append( "         A.VEND_SEQ, A.MINOR_CD, A.POST_NO, A.ADDRESS1, A.ADDRESS2, 	\n" );
					sql.append( "         A.USE_TAG,  TO_CHAR(A.CLOSE_DT,'YYYYMMDD') CLOSE_DT,      	\n" );
					sql.append( "         A.IPT_MAN, A.IPT_YMD, A.UPT_MAN, A.UPT_YMD        	\n" );
					sql.append( "   FROM ACCOUNT.MINORPLACE A, ACCOUNT.GCZM_VENDER B            \n" );
					sql.append( "  WHERE A.VEND_CD = B.VEND_CD    								\n" );
					if (!str1.equals("")) sql.append( " AND A.VEND_CD LIKE '%" + str1 + "%'		\n");
					if (!str2.equals("")) sql.append( " AND B.VEND_NM LIKE '%" + str2 + "%'	    \n");
					if (!str3.equals("")) sql.append( " AND B.VEND_ID LIKE '%" + str3 + "%'		\n");
					
					sql.append( " ORDER BY A.VEND_CD,A.VEND_SEQ             					\n");
					
				    //System.out.println("a010080::"+sql.toString()); 
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