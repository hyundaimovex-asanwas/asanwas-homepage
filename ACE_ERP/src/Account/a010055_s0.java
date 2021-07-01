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
public class a010055_s0 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); // 거래처코드
				String  str2	= req.getParameter("v_str2"); // 거래처 명 
				String  str3	= req.getParameter("v_str3"); // 사업자등록번호 || 주민번호
				String  str4	= req.getParameter("v_str4"); // 사업자번호 주민번호 구분
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
				GauceRes.enableFirstRow(dSet);


				String[] strArrCN = new String[]{  "VEND_CD",	 "VEND_NM",   "VEND_ID", 
												    "VD_DIRECT", "POST_NO1",  "POST_NO2", "ADDRESS1", "ADDRESS2",
													"BSNS_CND",  "BSNS_KND",  "VD_TELNO", "VD_FAXNO", "COCOMYN",              
                                                    "WRDT",      "WRID",      "UPDT",     "UPID"
												 }; 

				int[] intArrCN = new int[]{ 13, 62, 13,
										     62, 10, 10, 132,  72,
											 62, 62, 32,  32,	1,
											  6, 13,  6,  13
													
				}; 
			
				int[] intArrCN2 = new int[]{-1, -1, -1,
											 -1, -1, -1, -1, -1, 
											 -1, -1, -1, -1, -1,	 	          
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
					sql.append( "  SELECT RTRIM(A.VEND_CD) VEND_CD,                                   \n");
					sql.append( "		  RTRIM(A.VEND_NM) VEND_NM, A.VEND_ID,  		              \n");
					sql.append( "		  A.VD_DIRECT, A.POST_NO1, A.POST_NO2, A.ADDRESS1, A.ADDRESS2,\n");
					sql.append( "		  A.BSNS_CND,  A.BSNS_KND, A.VD_TELNO, A.VD_FAXNO, A.COCOMYN, \n");
					sql.append( "		  A.WRDT,A.WRID,A.UPDT,A.UPID 								  \n");
					sql.append( "	 FROM ACCOUNT.GCZM_VENDER A     								  \n");
					sql.append( "   WHERE A.VEND_CD IS NOT NULL 									  \n");
					sql.append( "     AND A.USE_TAG='Y'         									  \n");
					if (!str1.equals("")) sql.append( " AND A.VEND_CD = '" + str1 + "'				  \n");
					if (!str2.equals("")) sql.append( " AND A.VEND_NM LIKE '%" + str2 + "%'			  \n");
					if (!str3.equals("")) sql.append( " AND A.VEND_ID LIKE '" + str3 + "%' 			  \n");
					if (str4.equals("1")) sql.append( " AND LENGTH(A.VEND_ID)=10 					  \n");
					if (str4.equals("2")) sql.append( " AND LENGTH(A.VEND_ID)=13 					  \n");

					//System.out.println("a010055_s0::"+sql.toString());

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