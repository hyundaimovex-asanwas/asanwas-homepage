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
public class a400180_s1 extends HttpServlet {
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
				String []  str	= new String [1];
				str[0] = req.getParameter("v_str1");	//사번
				
				for(int i=0;i<=0;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);
			
				String[] strArrCN = new String[]{ 
						"SIGNET_ID",  "SIGNET_GB",   "MGR_TEAMCD",    "MGR_TEAMNM",  "SIGNET_HEAD_NO",
						"MAIN_EMPID", "SUB_EMPID",   
						"SEQ",        "AP_TYPE",     "EMPNO",         "EMPNM",  
						"WRID",       "WRDT",        "UPID",           "UPDT",      "ORG_SEQ"
					
				}; 
				


				int[] intArrCN = new int[] { 
				     4,  1,  10,   50,   4,
				     5,  5,  
				     5, 10,  10,   20,   
				    10, 19,  10,   19,   5
				  
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1, 
					 0,  -1,  -1,  -1,  
					-1,  -1,  -1,  -1,   0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT A.SIGNET_ID, B.SIGNET_GB, B.MGR_TEAMCD, B.MGR_TEAMNM, B.SIGNET_HEAD_NO, \n");
						sql.append( "        B.MAIN_EMPID, B.SUB_EMPID,                                              \n");
						sql.append( "        A.SEQ, A.AP_TYPE, A.EMPNO, C.ENO_NM AS EMPNM,                           \n");
						sql.append( "        A.WRID,A.WRDT,A.UPID,A.UPDT , A.SEQ AS ORG_SEQ                          \n");
						sql.append( "   FROM ACCOUNT.SIGNET_LINE A, ACCOUNT.SIGNET_INFO B, ASNHR.T_CM_PERSON C       \n");
						sql.append( "  WHERE A.SIGNET_ID = B.SIGNET_ID(+)                                            \n");
						sql.append( "    AND A.EMPNO = C.ENO_NO                                                      \n");
						
						if (!str[0].equals(""))sql.append( " AND A.SIGNET_ID ='"+str[0]+"' \n");
						
						sql.append( "   ORDER BY  A.SIGNET_ID, A.SEQ DESC                   \n");
						
						//System.out.println("# a400180_s1 Query : \n" + sql);
							
/*********************************************************************************************/
					
					stmt = conn.getGauceStatement(sql.toString());
		 			stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	//logger.err.println(this,e);
		  	System.err.println(e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			//logger.err.println(this,e);
			System.err.println(e);
			//logger.dbg.println(this,e.toString());
			
		} finally {
			loader.restoreService(service);
  	}
	}
}