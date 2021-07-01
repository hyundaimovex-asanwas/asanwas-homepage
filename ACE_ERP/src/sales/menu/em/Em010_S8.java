package sales.menu.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class Em010_S8 extends HttpServlet {

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

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO",	  "CUST_SID", "MEDI_DATE", "DISEASE_NAME", "TREAT_CONTENT",	
					                                "MEDI_FEE", "CALC_YN",
																					"I_EMPNO","U_EMPNO",   "I_DATE",	"U_DATE"
																        }; 

				int[] intArrCN = new int[] {   10, 10,	8,  20,	100, 	
					                              3, 10,
					                             10, 10, 10,	10
															     }; 
			
				int[] intArrCN2 = new int[]{	-1, 0,-1,-1,-1,			
					                             1,-1,
																		  -1,-1,-1,-1			
															     }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( "	SELECT B.EMPNO,A.CUST_SID, MEDI_DATE,                                 \n");
					sql.append( "	       RTRIM(A.DISEASE_NAME)  AS  DISEASE_NAME,                       \n");
					sql.append( "	       RTRIM(A.TREAT_CONTENT) AS  TREAT_CONTENT,                      \n");
					sql.append( "	       A.MEDI_FEE,                                                    \n");
					sql.append( "	       CASE WHEN A.CALC_YN='T' THEN '정산' ELSE '미정산' END CALC_YN, \n");
					sql.append( "	       A.I_EMPNO,A.U_EMPNO,A.I_DATE, A.U_DATE                         \n");
					sql.append( "	  FROM SALES.TCM110 A                                                 \n");
					sql.append( "	  LEFT JOIN SALES.TCM300 B ON A.CUST_SID = B.CUST_SID                 \n");
					sql.append( "	 WHERE  A.CUST_SID="+str1+"                                           \n");

					stmt = conn.getGauceStatement(sql.toString());
					stmt.executeQuery(dSet);
				}
				
/*********************************************************************************************/

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