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
public class a010055_s1 extends HttpServlet {
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

				//String  str1	= req.getParameter("v_str1"); // 사용자
				String  str2	= req.getParameter("v_str2"); // 거래처 명 
				String  str3	= req.getParameter("v_str3"); // 사업자등록번호 || 주민번호
				String  str4	= req.getParameter("v_str4"); // 사업자번호 주민번호 구분
				String  str5	= req.getParameter("v_str5"); // 상태

				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				
				
				GauceRes.enableFirstRow(dSet);


				String[] strArrCN = new String[]{  "CHK",        "VEND_CD",	"VEND_ID", "SEQ", 
												    "B_VEND_NM", "B_VD_DIRECT",    "B_POST_NO1",  "B_POST_NO2", "B_ADDRESS1", "B_ADDRESS2", "B_COCOMYN",
												    "A_VEND_NM", "A_VD_DIRECT",    "A_POST_NO1",  "A_POST_NO2", "A_ADDRESS1", "A_ADDRESS2", "A_COCOMYN",            
                                                    "STATUS",    "WRID",   "WRDT", "UPDT",     "UPID"
												 }; 

				int[] intArrCN = new int[]{ 1,  13, 15, 2,
										     62, 62, 10, 10,  132, 72, 1,
										     62, 62, 10, 10,  132, 72, 1,
											  1, 10, 10, 10,  10
													
				}; 
			
				int[] intArrCN2 = new int[]{-1, -1, -1,  0,
											 -1, -1, -1, -1, -1, -1, -1, 
											 -1, -1, -1, -1, -1, -1, -1, 	 	          
					                         -1, -1, -1, -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT 'F' AS CHK, RTRIM(A.VEND_CD) VEND_CD,  A.VEND_ID, A.SEQ,   \n");
					sql.append( "		  A.B_VEND_NM, A.B_VD_DIRECT, A.B_POST_NO1, A.B_POST_NO2, A.B_ADDRESS1, A.B_ADDRESS2, A.B_COCOMYN, \n");
					sql.append( "		  A.A_VEND_NM, A.A_VD_DIRECT, A.A_POST_NO1, A.A_POST_NO2, A.A_ADDRESS1, A.A_ADDRESS2, A.A_COCOMYN, \n");
					sql.append( "		  A.STATUS, A.WRDT,A.WRID,A.UPDT,A.UPID 	   			     \n");
					sql.append( "	 FROM ACCOUNT.GCZM_VENDER_MD A     								  \n");
					sql.append( "   WHERE A.VEND_CD IS NOT NULL 									  \n");
					if (!str2.equals("")) sql.append( " AND A.B_VEND_NM LIKE '%" + str2 + "%'   	  \n");
					if (!str3.equals("")) sql.append( " AND A.VEND_ID LIKE '" + str3 + "%' 			  \n");
					if (str4.equals("1")) sql.append( " AND LENGTH(A.VEND_ID)=10 					  \n");
					if (str4.equals("2")) sql.append( " AND LENGTH(A.VEND_ID)=13 					  \n");
					if (str5.equals("C")) sql.append( " AND STATUS IN ('N','R') 					  \n");
					
					if (str5.equals("N")||str5.equals("R")||str5.equals("Y")) sql.append( " AND STATUS ='"+str5+"'  \n");
					sql.append( "   ORDER BY A.SEQ DESC									  \n");
					
					//System.out.println("a010055_s1::"+sql.toString());

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