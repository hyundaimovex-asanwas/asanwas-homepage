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
public class Em010_S5 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "EMPNO","SEQ",    "CUST_SID","LCS_TYPE","LCS_CD",		
																					"LCS_NO","GET_DT","CHG_DT",	 "ISS_PART","APP_YN",		//10
																					"I_EMPNO","U_EMPNO","I_DATE",	"U_DATE",
																					"LCS_TYPE_NM", "LCS_CD_NM"
																        }; 

				int[] intArrCN = new int[] { 		10,	2, 10, 3,	3,
																				20,	8,	8,40,	1,//10
																				10,10, 10,10,
                                        30,30 
															     }; 
			
				int[] intArrCN2 = new int[]{   -1, 0,	0, -1, -1,
																			 -1,-1,-1, -1, -1,//10
																			 -1,-1,-1, -1,
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

						sql.append( "SELECT  A.EMPNO,    A.SEQ,    A.CUST_SID,                                                                   \n");
						sql.append( "        A.LCS_TYPE, A.LCS_CD, TRIM(A.LCS_NO) AS LCS_NO,                                                     \n");
						sql.append( "        TRIM(A.GET_DT) AS GET_DT, TRIM(A.CHG_DT) AS CHG_DT,                                                 \n");
						sql.append( "        TRIM(A.ISS_PART) AS ISS_PART, A.APP_YN,                                                             \n");
						sql.append( "        A.I_EMPNO,A.U_EMPNO,A.I_DATE, A.U_DATE,                                                             \n");
						sql.append( "        RTRIM(E.DETAIL_NM)LCS_TYPE_NM, RTRIM(F.DETAIL_NM)LCS_CD_NM                                          \n");
						sql.append( "  FROM SALES.TCM325 A                                                                                       \n");
						sql.append( "  LEFT JOIN SALES.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.LCS_TYPE) AND E.HEAD='CM029' AND RTRIM(E.DETAIL)<>''\n");
						sql.append( "  LEFT JOIN SALES.TSY010 F ON RTRIM(F.DETAIL) = RTRIM(A.LCS_CD) AND F.HEAD='CM030' AND RTRIM(F.DETAIL)<>''  \n");
						sql.append( " WHERE EMPNO = '"+str1+"'     \n");
						sql.append( " ORDER BY A.SEQ  				  \n");

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