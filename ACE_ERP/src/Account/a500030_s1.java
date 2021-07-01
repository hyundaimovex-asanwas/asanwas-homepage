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
public class a500030_s1 extends HttpServlet {
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
				String  str3	= req.getParameter("v_str3"); //사업자등록번호 


				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";

	
					
				GauceRes.enableFirstRow(dSet);
	
				String[] strArrCN = new String[]{ 
												  "CHK",	   "VEND_CD",   "VEND_NM",  "VEND_ID",    
												  "SEQ",       "BANK_CD",   "BANK_NM",  "ACCT_NO", "ACCT_AUTH",
												  "REASON",    "GUBUN",		"STATUS",   "USEYN",   "D_DATE",
												  "REJECT_REASON",    
												  "I_EMPNO",  	"I_DATE",   "U_EMPNO",  	"U_DATE"
												}; 

				int[] intArrCN = new int[]{ 
											1,  13, 100, 15, 
											2, 	 5, 100,  40, 100,
											100, 1,	 1,   1,  8, 
											200,
											10,  10,  10, 10
											}; 

				int[] intArrCN2 = new int[]{  
											  -1, -1, -1, -1, 
											  0,  -1, -1, -1, -1,
											  -1, -1, -1, -1, -1,
											  -1,
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
					sql.append( " SELECT '' CHK, RTRIM(A.VEND_CD) VEND_CD, RTRIM(A.VEND_NM) VEND_NM, A.VEND_ID VEND_ID,   	\n");
					sql.append( "        A.SEQ, A.BANK_CD, A.BANK_NM, A.ACCT_NO, A.ACCT_AUTH,								\n");					
					sql.append( "		 A.REASON, A.GUBUN,	A.STATUS, A.USEYN, A.D_DATE, 									\n");
					sql.append( "		 A.REJECT_REASON,	 																\n");					
					sql.append( "		 ASNHR.SF_GET_ENONAME('01', A.I_EMPNO) AS I_EMPNO, A.I_DATE, 						\n");
					sql.append( "		 ASNHR.SF_GET_ENONAME('01', A.U_EMPNO) AS U_EMPNO, A.U_DATE							\n");						
					sql.append( " FROM ACCOUNT.ACCTNO A, ACCOUNT.GCZM_VENDER B 												\n");
					sql.append( " WHERE A.VEND_CD = B.VEND_CD 																\n");
					if (!str1.equals("")) sql.append( " AND A.VEND_CD LIKE '%" + str1 + "%'									\n");
					if (!str2.equals("")) sql.append( " AND A.VEND_NM LIKE '%" + str2 + "%'									\n");
					if (!str3.equals("")) sql.append( " AND A.VEND_ID LIKE '%" + str3 + "%'									\n");
					sql.append( " ORDER BY A.VEND_CD, A.SEQ 																\n");
					
					//System.out.println("# Query : " + sql);
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