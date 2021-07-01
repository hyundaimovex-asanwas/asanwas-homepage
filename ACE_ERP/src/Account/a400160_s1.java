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
public class a400160_s1 extends HttpServlet {
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
				String []  str	= new String [4];
				str[0] = req.getParameter("v_str1");	//인감구분
				str[1] = req.getParameter("v_str2");	//날인일자_fr
				str[2] = req.getParameter("v_str3");	//날인일자_to
				str[3] = req.getParameter("v_str4");	//결재상태
				
				for(int i=0;i<=3;i++) {
					if (str[i]==null) str[i] = "";
				}
				
				if(str[0].equals("1")){
					str[0]="210";
				}else if(str[0].equals("2")){
					str[0]="220";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"CHKBOX",        "SIGNET_ID",  "AP_M_SID",    "DOC_SID",      "CH_PARAM1",
						"DOC_GU",        "DOC_GU2",    "AP_STATUS_M", "APP_NO",       "SIGNET_USE",
						"SIGNET_SUBMIT", "APP_DATE",   "REMARK",      "SEAL_DATE",    "SIGNET_MGR_NO",
						"APP_TEAMCD",    "APP_TEAMNM", "APP_JOBCD",   "APP_JOBNM",  
						"APP_EMPNO",     "APP_EMPNM",  "DOC_GU2NM",   "AP_STATUS_M_NM",
						"SEND_DATE",     "RECEIVE_DATE",  "UPID",
						"SEAL_CNT",      "PLACE",      "SIGNET_CERTI_NO", "SEND_DATE_CONFIRM", "SIGNET_CERTI_NO"
				}; 
				
			
				int[] intArrCN = new int[] { 
					1,   4,  10, 10,  20,  
				    10, 10, 100,  13, 200,
				   100,  8, 100,   8,  50,
					10, 50,  10,  50,
					10, 50,  50,  50,
					 8, 20,  10,
					 3, 30,  30,  20,  30
					
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,   0,   0,  -1,	
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  
					-1,  -1,  -1,  -1,
					-1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT 'F' AS CHKBOX,   B.SIGNET_ID, A.AP_M_SID,      A.DOC_SID,   A.CH_PARAM1,                              \n");
						sql.append( "        A.DOC_GU,        A.DOC_GU2,   A.AP_STATUS_M,  B.APP_NO,     B.SIGNET_USE,                             \n");
						sql.append( "        B.SIGNET_SUBMIT, B.APP_DATE,  B.REMARK,       B.SEAL_DATE,  B.SIGNET_MGR_NO,                          \n");
						sql.append( "        B.APP_TEAMCD,    D.DPT_NM AS APP_TEAMNM,      B.APP_JOBCD,  E.COMM_NM AS APP_JOBNM,                   \n");
						sql.append( "        B.APP_EMPNO,     C.ENO_NM AS APP_EMPNM,       F.DETAIL_NM AS DOC_GU2NM, G.DETAIL_NM AS AP_STATUS_M_NM,\n");
						sql.append( "        '' SEND_DATE,    TO_CHAR('','YYYY-MM-DD HH:MM') RECEIVE_DATE, B.UPID,                                  \n");
						sql.append( "        B.SEAL_CNT,    D.DPT_NM AS PLACE , B.SIGNET_CERTI_NO, TO_CHAR('','YYYY-MM-DD HH:MM') SEND_DATE_CONFIRM,\n");
						sql.append( "        B.SIGNET_CERTI_NO \n");
						sql.append( "   FROM COMMON.APPROVE_MASTER A, ACCOUNT.SIGNET_COR B,                                                        \n");
						sql.append( "        ASNHR.T_CM_PERSON C,     ASNHR.T_CM_DEPT D,                                                           \n");
						sql.append( "        ASNHR.T_CM_COMMON E ,    SALES.TSY010 F,                                                              \n");
						sql.append( "        SALES.TSY010 G                                                                                        \n");
						sql.append( "  WHERE A.CH_PARAM1  = B.APP_NO                                                                               \n");
						sql.append( "    AND B.APP_EMPNO  = C.ENO_NO(+)                                                                            \n");
						sql.append( "    AND B.APP_TEAMCD = D.DPT_CD(+)                                                                            \n");
						sql.append( "    AND B.APP_JOBCD  = E.COMM_CD(+) AND E.CD_GBN(+) ='A2'                                                     \n");
						sql.append( "    AND A.DOC_GU2    = F.DETAIL(+)  AND F.HEAD(+) ='AP006'                                                    \n");
						sql.append( "    AND A.AP_STATUS_M= G.DETAIL(+)  AND G.HEAD(+) ='AP002'                                                    \n");
						sql.append( "    AND A.DOC_GU ='15'                                                                                        \n");
						if (!str[0].equals(""))sql.append( " AND A.DOC_GU2 = '"+str[0]+"'        \n");
						if (!str[1].equals("")&&!str[2].equals(""))sql.append( " AND B.SEAL_DATE BETWEEN '"+str[1]+"' AND '"+str[2]+"' \n");
						if (!str[3].equals(""))sql.append( " AND A.AP_STATUS_M = '"+str[3]+"'    \n");
						
						sql.append( " UNION ALL                                                               \n");
						
						sql.append( " SELECT ''CHKBOX,        B.SIGNET_ID, A.AP_M_SID,     A.DOC_SID,    A.CH_PARAM1,                              \n");
						sql.append( "        A.DOC_GU,        A.DOC_GU2,   A.AP_STATUS_M,  B.APP_NO,     B.SIGNET_USE,                             \n");
						sql.append( "        B.SIGNET_SUBMIT, B.APP_DATE,  B.REMARK,       B.SEAL_DATE,  B.SIGNET_MGR_NO,                          \n");
						sql.append( "        B.APP_TEAMCD,    D.DPT_NM AS APP_TEAMNM,      B.APP_JOBCD,  E.COMM_NM AS APP_JOBNM,                   \n");
						sql.append( "        B.APP_EMPNO,     C.ENO_NM AS APP_EMPNM,       F.DETAIL_NM AS DOC_GU2NM, G.DETAIL_NM AS AP_STATUS_M_NM,\n");
						sql.append( "        B.SEND_DATE,     TO_CHAR(B.RECEIVE_DATE,'YYYY-MM-DD HH:MM')RECEIVE_DATE, B.UPID,                                                                 \n");
						sql.append( "        B.SEAL_CNT,    D.DPT_NM AS PLACE , '' SIGNET_CERTI_NO , TO_CHAR(B.SEND_DATE_CONFIRM,'YYYY-MM-DD HH:MM')SEND_DATE_CONFIRM, ''SIGNET_CERTI_NO        \n");
						sql.append( "   FROM COMMON.APPROVE_MASTER A, ACCOUNT.SIGNET_USE B,                                                        \n");
						sql.append( "        ASNHR.T_CM_PERSON C,     ASNHR.T_CM_DEPT D,                                                           \n");
						sql.append( "        ASNHR.T_CM_COMMON E ,    SALES.TSY010 F,                                                              \n");
						sql.append( "        SALES.TSY010 G                                                                                        \n");
						sql.append( "  WHERE A.CH_PARAM1  = B.APP_NO                                                                               \n");
						sql.append( "    AND B.APP_EMPNO  = C.ENO_NO(+)                                                                            \n");
						sql.append( "    AND B.APP_TEAMCD = D.DPT_CD(+)                                                                            \n");
						sql.append( "    AND B.APP_JOBCD  = E.COMM_CD(+) AND E.CD_GBN(+) ='A2'                                                     \n");
						sql.append( "    AND A.DOC_GU2    = F.DETAIL(+)  AND F.HEAD(+) ='AP006'                                                    \n");
						sql.append( "    AND A.AP_STATUS_M= G.DETAIL(+)  AND G.HEAD(+) ='AP002'                                                    \n");
						sql.append( "    AND A.DOC_GU ='15'                                                                                        \n");
						
						if (!str[0].equals(""))sql.append( " AND A.DOC_GU2 = '"+str[0]+"'        \n");
						if (!str[1].equals("")&&!str[2].equals(""))sql.append( " AND B.SEAL_DATE BETWEEN '"+str[1]+"' AND '"+str[2]+"' \n");
						if (!str[3].equals(""))sql.append( " AND A.AP_STATUS_M = '"+str[3]+"'    \n");
					
						sql.append( "  ORDER BY APP_DATE DESC                                                                                \n");
						
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
						
						//System.out.println("# a400160_s1 Query : \n" + sql);
							
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