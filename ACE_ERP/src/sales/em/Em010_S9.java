package sales.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class Em010_S9 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "EMPNO",   "SEQ",   "CUST_SID",	"SUB_DT",	  "MAN_YY",
																					"MAN_SEX", "MAN_CD","SUP_NM",		"CLOTH_CD",	"CLOTH_SIZE",
																					"RTN_DT",  "RTN_RK","RTN_RE",		"I_EMPNO",	"U_EMPNO",
					                                "MAN_NM",  "CLOTH_NM"
																        }; 

				int[] intArrCN = new int[] {    10,	2, 10, 8,	4,	
																				 1,	3, 20, 1,	3,	
																				 8,20, 40,10,10,
					                              30,30 
															     }; 
			
				int[] intArrCN2 = new int[]{   -1, 0,	0,-1,-1,
																			 -1,-1,-1,-1,-1,
																			 -1,-1,-1,-1,-1,
					                             -1,-1
															     }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( "SELECT A.EMPNO,A.SEQ,A.CUST_SID, TRIM(A.SUB_DT) AS SUB_DT,                                                      \n");
					sql.append( "       A.MAN_YY,A.MAN_SEX,A.MAN_CD,A.SUP_NM,                                                                    \n");
					sql.append( "       A.CLOTH_CD,A.CLOTH_SIZE,TRIM(A.RTN_DT) AS RTN_DT,                                                        \n");
					sql.append( "       TRIM(A.RTN_RK)AS RTN_RK, TRIM(A.RTN_RE) AS RTN_RE,                                                       \n");
					sql.append( "       A.I_EMPNO, A.U_EMPNO,                                                                                    \n");
					sql.append( "       A.MAN_YY||':'||CASE WHEN A.MAN_SEX='M'THEN'남'ELSE'여'END||':'||RTRIM(E.DETAIL_NM) AS MAN_NM,            \n");
					sql.append( "       RTRIM(F.DETAIL_NM)||'-'||RTRIM(G.DETAIL_NM) AS CLOTH_NM                                                  \n");
					sql.append( "  FROM SALES.TCM330 A                                                                                           \n");
					sql.append( "  LEFT JOIN SALES.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.MAN_CD) AND E.HEAD='CM008' AND RTRIM(E.DETAIL)<>''      \n");
					sql.append( "  LEFT JOIN SALES.TSY010 F ON RTRIM(F.DETAIL) = RTRIM(A.CLOTH_CD) AND F.HEAD='CM009' AND RTRIM(F.DETAIL)<>''    \n");
					sql.append( "  LEFT JOIN SALES.TSY010 G ON RTRIM(G.DETAIL) = RTRIM(A.CLOTH_SIZE) AND G.HEAD='CM010' AND RTRIM(G.DETAIL)<>''  \n");
					sql.append( " WHERE EMPNO='"+str1+"'           \n");
					sql.append( " ORDER BY A.SEQ      						 \n");

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