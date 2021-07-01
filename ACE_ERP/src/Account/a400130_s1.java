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
public class a400130_s1 extends HttpServlet {
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
				String []  str	= new String [3];
				str[0] = req.getParameter("v_str1");	//사번
				str[1] = req.getParameter("v_str2");	//사용
				
				for(int i=0;i<=2;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"SIGNET_ID",  "SIGNET_SEQ",     "WORK_GB",     "MGR_TEAMCD",   "MGR_TEAMNM",  
						"MAIN_EMPID", "MAIN_EMPNMK",    "SUB_EMPID",   "SUB_EMPNMK",   "SEND_DATE",
						"DISUSE_DATE", "DISUSE_REASON", "RECE_DATE",   "RECE_REASON",  "USEGB",
					    "USE_REMARK",  "ETC",           "WRID",        "WRDT",   "SEND_DATE_CONFIRM",  "RECEIVE_DATE"
					
				}; 
				


				int[] intArrCN = new int[] { 
				     4,   3,   1,   10,   50,   
				     5,  50,   5,   50,    8,
				     8, 100,   8,  100,    1,
				   100, 100,  10,   19,   20,  20
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,   0,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT  A.SIGNET_ID,A.SIGNET_SEQ, A.WORK_GB, A.MGR_TEAMCD,A.MGR_TEAMNM,                           \n");
						sql.append( "         A.MAIN_EMPID, D.ENO_NM AS  MAIN_EMPNMK, A.SUB_EMPID, E.ENO_NM AS SUB_EMPNMK, A.SEND_DATE, \n");
						sql.append( "         A.DISUSE_DATE, A.DISUSE_REASON,A.RECE_DATE,A.RECE_REASON,  A.USEGB,                       \n");
						sql.append( "         A.USE_REMARK, A.ETC, A.WRID, A.WRDT,                                                      \n");
						sql.append( "         TO_CHAR(A.SEND_DATE_CONFIRM,'YYYY/MM/SS HH:MM:SS') AS SEND_DATE_CONFIRM,                  \n");
						sql.append( "         TO_CHAR(A.RECEIVE_DATE,'YYYY/MM/SS HH:MM:SS') AS RECEIVE_DATE                             \n");
						sql.append( "   FROM ACCOUNT.SIGNET_HIS A, ACCOUNT.SIGNET_MGR B, ACCOUNT.SIGNET_MGR C, ACCOUNT.SIGNET_INFO D,   \n");
						sql.append( "        ASNHR.T_CM_PERSON D, ASNHR.T_CM_PERSON E                                                   \n");
						sql.append( "  WHERE A.MAIN_EMPID = B.EMPID(+)                                                                  \n");
						sql.append( "    AND A.SUB_EMPID = C.EMPID(+)                                                                   \n");
						sql.append( "    AND B.EMPNO = D.ENO_NO(+)                                                                      \n");
						sql.append( "    AND C.EMPNO = E.ENO_NO(+)                                                                      \n");
						sql.append( "    AND A.SIGNET_ID = D.SIGNET_ID(+)                                                               \n");
						
						if (!str[0].equals(""))sql.append( " AND D.SIGNET_GB ='"+str[0]+"' \n");
						if (!str[1].equals(""))sql.append( " AND A.USEGB = '"+str[1]+"'    \n");
						
						sql.append( "   ORDER BY A.SIGNET_ID, A.SIGNET_SEQ DESC            \n");
						
						//System.out.println("# a400130_s1 Query : \n" + sql);
							
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