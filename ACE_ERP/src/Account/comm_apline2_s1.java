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
public class comm_apline2_s1 extends HttpServlet {
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
				String  str1	= req.getParameter("v_str1");
               
				if (str1 == null) str1 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "SEQ",	"AP_TYPE", "ENO_NO", "ENO_NM",
						                          "DPT_CD",	"DPT_NM", "JOB_CD", "JOB_NM", "AP_STATUS_D",
						                          "U_DATE", "AP_DESC"
			                                      }; 

				int[] intArrCN = new int[] {  1, 1, 10, 10, 
						                      10,30, 10, 10,  1,
						                      10,100 
						                     }; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,
						                      -1, -1, -1, -1, -1,
						                      -1, -1 
			                               	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					
					sql.append( " SELECT A.SEQ, A.AP_TYPE, A.EMPNO AS ENO_NO, B.ENO_NM,                            \n ");
					sql.append( "        B.DPT_CD, C.DPT_NM, B.JOB_CD, D.COMM_NM AS JOB_NM, '1' AS AP_STATUS_D,    \n ");
					sql.append( "        '' AS U_DATE, '' AS AP_DESC                                               \n ");
					sql.append( "   FROM ACCOUNT.SIGNET_LINE A, ASNHR.T_CM_PERSON B,                               \n ");
					sql.append( "        ASNHR.T_CM_DEPT C,  ASNHR.T_CM_COMMON D                                   \n ");
					sql.append( "  WHERE A.EMPNO = B.ENO_NO(+)                                                     \n ");
					sql.append( "    AND B.DPT_CD = C.DPT_CD(+)                                                    \n ");
					sql.append( "    AND B.JOB_CD = D.COMM_CD(+)                                                   \n ");
					sql.append( "    AND D.CD_GBN ='A2'                                                            \n ");
					sql.append( "    AND A.SIGNET_ID ='"+str1+"'                                                   \n ");
					sql.append( "  ORDER BY A.AP_TYPE DESC                                                         \n ");
					
					
					/*
					sql.append( "  SELECT  A.PSEQ AS SEQ,  RTRIM(A.GBCD) AP_TYPE , RTRIM(A.CDCODE) ENO_NO, B.ENO_NM ,        \n ");
					sql.append( "          B.DPT_CD, C.DPT_NM, B.JOB_CD, D.COMM_NM AS JOB_NM, '1' AS AP_STATUS_D,            \n ");
					sql.append( "          '' AS U_DATE, '' AS AP_DESC     \n ");
					sql.append( "    FROM ACCOUNT.COMMDTIL A, ASNHR.T_CM_PERSON B , ASNHR.T_CM_DEPT	C ,  ASNHR.T_CM_COMMON D \n ");
					sql.append( "   WHERE A.CDCODE = B.ENO_NO(+)                         \n ");
					sql.append( "     AND B.DPT_CD = C.DPT_CD(+)                         \n ");
					sql.append( "     AND B.JOB_CD = D.COMM_CD(+)                        \n ");
					sql.append( "     AND D.CD_GBN ='A2'                                 \n ");
					sql.append( "     AND (RTRIM(A.DSUDT) ='' OR RTRIM(A.DSUDT) IS NULL) \n ");
					sql.append( "     AND A.CMTYPE ='"+str1+"'                           \n ");
					*/

					//System.out.println("comm_apline2_s1::"+sql.toString());
					
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