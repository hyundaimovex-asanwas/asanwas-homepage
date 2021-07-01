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
public class a400140_approve_s0 extends HttpServlet {
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
				str[0] = req.getParameter("v_str1");	//신청번호
				
				for(int i=0;i<=0;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"APP_NO",    "SIGNET_ID",     "SIGNET_USE", "SIGNET_SUBMIT",   "PAPER_CNT",
						"SEAL_CNT",  "ATT_FILE_NAME", "ATT_GB",     "SIGNET_CERTI_NO", "SIGNET_CERTI_CNT",
						"REGI_CNT",  "CUR_CAN_GB",    "SEAL_DATE",  "SIGNET_MGR_NO",   "APP_TEAMCD",
						"APP_JOBCD", "APP_EMPNO",     "APP_DATE",   "REMARK",
						"WRID",      "WRDT",          "UPID",       "UPDT",
						"APP_TEAMNM", "APP_EMPNM"
					
				}; 
				


				int[] intArrCN = new int[] { 
					13,  4, 100, 100, 3,
					 3,100,   1,  30, 3,
					 3,  1,   8,  50,10,
					10, 10,   8, 100,
					10, 19,  10,  19,
					50, 10,
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,   0,
					 0,  -1,  -1,  -1,   0,
					 0,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,
					-1,  -1
					
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT  A.APP_NO,    A.SIGNET_ID,     A.SIGNET_USE,A.SIGNET_SUBMIT,   A.PAPER_CNT,        \n");
						sql.append( "         A.SEAL_CNT,  A.ATT_FILE_NAME, A.ATT_GB,    A.SIGNET_CERTI_NO, A.SIGNET_CERTI_CNT, \n");
						sql.append( "         A.REGI_CNT,  A.CUR_CAN_GB,    A.SEAL_DATE, A.SIGNET_MGR_NO,   A.APP_TEAMCD,       \n");
						sql.append( "         A.APP_JOBCD, A.APP_EMPNO,     A.APP_DATE,  A.REMARK,                              \n");
						sql.append( "         A.WRID,      A.WRDT,          A.UPID,      A.UPDT,                                \n");
						sql.append( "         C.DPT_NM AS APP_TEAMNM,       B.ENO_NM AS APP_EMPNM                               \n");
						sql.append( "   FROM ACCOUNT.SIGNET_COR A ,  ASNHR.T_CM_PERSON B , ASNHR.T_CM_DEPT C                    \n");
						sql.append( "  WHERE A.APP_EMPNO = B.ENO_NO(+)                                                          \n");
						sql.append( "    AND A.APP_TEAMCD = C.DPT_CD(+)                                                         \n");
						sql.append( "    AND A.APP_NO ='"+str[0]+"'                                                             \n");
						
						/*
						sql.append( "  WHERE A.MAIN_EMPID = B.EMPID(+)                                                          \n");
						sql.append( "    AND A.SUB_EMPID = C.EMPID(+)                                                           \n");
						sql.append( "    AND B.EMPNO = D.ENO_NO(+)                                                              \n");
						sql.append( "    AND C.EMPNO = E.ENO_NO(+)                                                              \n");
						sql.append( "    AND A.SIGNET_ID = D.SIGNET_ID(+)                                                       \n");
						
						if (!str[0].equals(""))sql.append( " AND D.SIGNET_GB ='"+str[0]+"' \n");
						if (!str[1].equals(""))sql.append( " AND A.USEGB = '"+str[1]+"'    \n");
						
						sql.append( "   ORDER BY A.SIGNET_ID, A.SIGNET_SEQ DESC            \n");
						*/
						
						//System.out.println("# a400140_approve_s0 Query : \n" + sql);
							
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