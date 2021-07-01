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
public class a500040_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1"); //거래처 코드 
				String  str2	= req.getParameter("v_str2"); //거래처명
				String  str3	= req.getParameter("v_str3"); //사업자등록번호//주민번호 
				String  str4	= req.getParameter("v_str4"); //은행코드 
				String  str5	= req.getParameter("v_str5"); //계좌번호 
				String  str6	= req.getParameter("v_str6"); //사용유무 

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6 == null) str6 = "";

	
					
				GauceRes.enableFirstRow(dSet);
	
				String[] strArrCN = new String[]{ 
												  "BANK_CD",   "BANK_NM",   "VACCTNO",  "SEQ",    
												  "VEND_CD",   "VEND_NM",   "VEND_ID",  "USE_YN", 
												  "FR_DT",     "TO_DT",
												  "WRID",      "WRDT",      "UPID",  	"UPDT"
												}; 

				int[] intArrCN = new int[]{ 
											3,   30,  30,  2, 
											13,	100,  15,  1, 
										  	 8,   8, 
											10,  10,  10, 10
											}; 

				int[] intArrCN2 = new int[]{  
											  -1,  -1, -1,  0, 
											  -1,  -1, -1, -1, 
											  -1,  -1,
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
					sql.append( " SELECT A.BANK_CD, A.BANK_NM, A.VACCTNO, A.SEQ,   	      \n");
					sql.append( "        A.VEND_CD, A.VEND_NM, B.VEND_ID, A.USE_YN, 	  \n");					
					sql.append( "		 A.FR_DT, A.TO_DT,  							  \n");
					sql.append( "		 A.WRID, A.WRDT, A.UPID, A.UPDT	 				  \n");					
					sql.append( "		 FROM ACCOUNT.VACCTINFO A, ACCOUNT.GCZM_VENDER B  \n");
					sql.append( "	WHERE A.VEND_CD = B.VEND_CD(+) 						  \n");						
					
					if (!str1.equals("")) sql.append( " AND A.VEND_CD ='" + str1 + "'		\n");
					if (!str2.equals("")) sql.append( " AND A.VEND_NM LIKE '%" + str2 + "%'	\n");
					if (!str3.equals("")) sql.append( " AND A.VEND_ID ='" + str3 + "'		\n");
					if (!str4.equals("")) sql.append( " AND A.BANK_CD ='" + str4 + "'		\n");
					if (!str5.equals("")) sql.append( " AND A.VACCTNO LIKE '%" + str5 + "%'	\n");
					if (!str6.equals("")) sql.append( " AND A.USE_YN = '" + str6 + "'		\n");
			
					sql.append( " ORDER BY A.VEND_CD, A.SEQ 								\n");
					
					//System.out.println("# a500040_s1 : " + sql.toString());
					//logger.dbg.println(this,sql.toString());
					
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