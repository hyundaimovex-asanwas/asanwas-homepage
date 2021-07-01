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
public class vendertr_popup_s1 extends HttpServlet {
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

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "CORP_CD", "VEND_GB", "VEND_CD",	"VEND_NM",   
																					"VD_DIRECT", "BSNS_CND", "BSNS_KND", "VD_TELNO", 
																					"VD_FAXNO", "POST_NM","POST_NO1", "POST_NO2", "ADDRESS1",
																					"ADDRESS2", "C_BANKCD", "C_ACCTNO", "C_ACCTNO_NM",
																					"C_ACCTNM", "B_BANKCD", "B_ACCTNO", "B_ACCTNO_NM",
																					"B_ACCTNM", "O_VENDGB", "O_VENDCD", "VEND_MAG",
																					"USE_TAG", "REMARK",   "CREAT_DT", "CREAT_NM" }; 

				int[] intArrCN = new int[]{ 6, 1, 13, 32,
																	 12, 22, 22, 14,
																	 14, 6, 3, 3, 72,
																	 72, 5, 22, 32,
																	 32, 5, 22, 32,
																	 32, 1, 13, 10,
																		1, 66, 12, 10	}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,
																		-1, -1, -1, -1,
																		-1, -1, -1, -1, -1,
																		-1, -1, -1, -1,
																		-1, -1, -1, -1,
																		-1, -1, -1, -1,
																		-1, -1, -1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT CORP_CD, VEND_GB, RTRIM(VEND_CD) VEND_CD, RTRIM(VEND_NM) VEND_NM,  " );
					sql.append( "		 VD_DIRECT, BSNS_CND, BSNS_KND, VD_TELNO,    " );
					sql.append( "		 VD_FAXNO, POST_NO1 ||  POST_NO2 as POST_NM, POST_NO1, POST_NO2, ADDRESS1,     " );
					sql.append( "		 ADDRESS2, C_BANKCD, C_ACCTNO, C_ACCTNO_NM,  " );
					sql.append( "		 C_ACCTNM, B_BANKCD, B_ACCTNO, B_ACCTNO_NM,  " );
					sql.append( "		 B_ACCTNM, O_VENDGB, O_VENDCD, VEND_MAG,     " );
					sql.append( "		 USE_TAG, REMARK, CREAT_DT, CREAT_NM			   " );
					sql.append( " FROM ACCOUNT.GCZM_VENDER " );
					sql.append( " WHERE VEND_CD <> '' ");

					if (!str1.equals("")) sql.append( " AND VEND_CD = '" + str1 + "'");
					if (!str2.equals("")) sql.append( " AND VEND_NM LIKE '" + str2 + "%'" );

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