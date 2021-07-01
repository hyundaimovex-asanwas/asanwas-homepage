package sales.menu.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class KS_Em010_S6 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "EMPNO",  "YYYY",   "SEQ",    "CUST_SID", "VEND_CD",
																					"DEPT_CD","TEAM_CD","WORK_CD","START_DT",	"END_DT",//10
																					"H_DAY", 	"H_RES",	"H_YN",
																					"I_EMPNO","U_EMPNO","I_DATE", "U_DATE", "TEAM_NM"
																        }; 

				int[] intArrCN = new int[] {   10, 4,	2, 10, 10,
																				5, 5,	5,	8,	8,	//10
																				2,40,	1,	
																				10,10,10,10,30
		         												}; 
			
				int[] intArrCN2 = new int[]{	-1,	-1, 0,	0,	0,	
																			-1,	-1,-1, -1, -1,//10
																			 0,	-1,-1, 
																			-1, -1,-1, -1, -1	
						       									}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( "SELECT A.EMPNO, A.YYYY, A.SEQ, A.CUST_SID, A.VEND_CD,                                                         \n");
					sql.append( "       IFNULL(A.DEPT_CD,'') AS DEPT_CD, IFNULL(A.TEAM_CD,'') AS TEAM_CD,                                      \n");
					sql.append( "       IFNULL(A.WORK_CD,'') AS WORK_CD, A.START_DT, A.END_DT,                                                 \n");
					sql.append( "       IFNULL(A.H_DAY,0) AS H_DAY, A.H_RES, A.H_YN,                                                           \n");
					sql.append( "       A.I_EMPNO, A.U_EMPNO, A.I_DATE, A.U_DATE,                                                              \n");
					sql.append( "       RTRIM(H.DETAIL_NM)TEAM_NM                                                                              \n");
					sql.append( "  FROM SALES.TCM355 A                                                                                         \n");
					sql.append( "  LEFT JOIN SALES.TSY010 H ON RTRIM(H.DETAIL) = RTRIM(A.TEAM_CD)   AND H.HEAD='CM003' AND RTRIM(H.DETAIL)<>'' \n");
					sql.append( " WHERE A.EMPNO = '"+str1+"'				\n");
					sql.append( "   AND A.H_YN = 'Y'								\n");
					sql.append( " ORDER BY A.SEQ  				        	\n");

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