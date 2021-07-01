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
public class a400340_s1 extends HttpServlet {
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
				str[0] = req.getParameter("v_str1");	//신청일자fr
				str[1] = req.getParameter("v_str2");	//신청일자to
				str[2] = req.getParameter("v_str3");	//사번
				
				for(int i=0;i<=0;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"AP_M_SID",   "DOC_GU",      "DOC_GUNM",        "DOC_GU2", "DOC_GU2NM",    
						"DOC_SID",    "AP_STATUS_M",  "AP_STATUS_M_NM", "L_EMPNO", "APP_EMPNM", 
						"I_DATE",     "OUTAMT",   	 "CNT",             "AP_DESC_CNT"	
				}; 
				
			
				int[] intArrCN = new int[] { 
					10, 10, 100,  10, 100,
				    10, 10,  50,  10,  50,
					20, 15,   2,   2
					
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1, -1, -1, -1, -1,	
					 0, -1, -1, -1, -1,
					-1,  0,  0,  0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT A.AP_M_SID,  A.DOC_GU,    E.DETAIL_NM AS DOC_GUNM,  A.DOC_GU2,   F.DETAIL_NM AS DOC_GU2NM,  \n");
						sql.append( "        A.DOC_SID,   A.AP_STATUS_M,  G.DETAIL_NM AS AP_STATUS_M_NM ,                                \n");
						sql.append( "        A.L_EMPNO,   C.ENO_NM AS APP_EMPNM,                                                         \n");
						sql.append( "        TO_CHAR(A.I_DATE,'YYYY-MM-DD HH24:MI:SS') AS I_DATE,                                        \n");
						sql.append( "        X.OUTAMT, X.CNT, Y.AP_DESC_CNT                                                              \n");
						sql.append( "   FROM COMMON.APPROVE_MASTER A,                                                                    \n");
						sql.append( "        (  SELECT B.AP_M_SID, SUM(OUTAMT) OUTAMT, COUNT(VENDCD) CNT                                 \n");
						sql.append( "             FROM ACCOUNT.ACAPPFUND B                                                               \n");
						sql.append( "            WHERE B.APPDATE BETWEEN '"+str[0]+"' AND '"+str[1]+"'                                   \n");
						sql.append( "            GROUP BY B.AP_M_SID                                                                     \n");
						sql.append( "        )X,                                                                                         \n");
						sql.append( "        (  SELECT D.AP_M_SID, COUNT( D.AP_DESC) AP_DESC_CNT                                         \n");
						sql.append( "             FROM COMMON.APPROVE_DETAIL D                                                           \n");
						sql.append( "            WHERE 1=1                                                                               \n");
						sql.append( "            GROUP BY D.AP_M_SID ) Y                                                                 \n");
						sql.append( "        ,ASNHR.T_CM_PERSON C                                                                        \n");
						sql.append( "        ,SALES.TSY010 E                                                                             \n");
						sql.append( "        ,SALES.TSY010 F                                                                             \n");
						sql.append( "        ,SALES.TSY010 G                                                                             \n");
						sql.append( "  WHERE A.AP_M_SID =X.AP_M_SID                                                                      \n");
						sql.append( "  AND   A.AP_M_SID =Y.AP_M_SID                                                                      \n");
						sql.append( "  AND A.L_EMPNO  = C.ENO_NO(+)                                                                      \n");
						sql.append( "  AND A.DOC_GU     = E.DETAIL(+)  AND E.HEAD(+) ='AP001'                                            \n");
						sql.append( "  AND A.DOC_GU2    = F.DETAIL(+)  AND F.HEAD(+) ='AP006'                                            \n");
						sql.append( "  AND A.AP_STATUS_M= G.DETAIL(+)  AND G.HEAD(+) ='AP002'                                            \n");
						
						if (!str[2].equals(""))sql.append( " AND A.L_EMPNO = '"+str[2]+"'    \n");
						
						//System.out.println("# a400340_s1 Query : \n" + sql);
							
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