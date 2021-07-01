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
public class a400140_s2 extends HttpServlet {
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
				String []  str	= new String [2];
				str[0] = req.getParameter("v_str1");	//사번
				str[1] = req.getParameter("v_str2");	//사번
				
				for(int i=0;i<=1;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"AP_SID",    "AP_M_SID",     "AP_GU",
						"SEQ",       "AP_TYPE",      "ENO_NO",       "ENO_NM",  "JOB_NM",
						"DPT_NM",  "AP_STATUS_D",    "AP_DESC",      "U_EMPNO", "U_DATE", "U_IP"  
				}; 
				


				int[] intArrCN = new int[] { 
					10,  10,  10, 
					10,  10,  10,  10, 10,
					50,  10, 100,  10, 20, 30
				}; 
					
				int[] intArrCN2 = new int[]{ 
					 0,   0,  -1, 
					 0,  -1,  -1,  -1,  -1,
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
						sql.append( " SELECT A.AP_SID,             A.AP_M_SID,    A.AP_GU,                            \n");
						sql.append( "        A.AP_SEQ AS SEQ,      A.AP_TYPE,     A.AP_EMPNO AS ENO_NO, B.ENO_NM, A.AP_JOBNM AS JOB_NM,   \n");
						sql.append( "        A.AP_DPTNM AS DPT_NM, A.AP_STATUS_D, A.AP_DESC,                \n");
						sql.append( "        A.U_EMPNO,  A.U_DATE,      A.U_IP                              \n");
						sql.append( "   FROM COMMON.APPROVE_DETAIL A, ASNHR.T_CM_PERSON B                   \n");
						sql.append( "  WHERE A.AP_EMPNO = B.ENO_NO(+)                                       \n");
						sql.append( "    AND A.AP_M_SID ='"+str[0]+"'                                       \n");
						sql.append( "    AND A.AP_GU ='"+str[1]+"'                                          \n");
						sql.append( "   ORDER BY  A.AP_SEQ  DESC                                            \n");
						
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
						
						//System.out.println("# a400140_approve_s1 Query : \n" + sql);
							
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