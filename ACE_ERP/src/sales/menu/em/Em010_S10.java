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
public class Em010_S10 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "EMPNO",  "SEQ",	  "CUST_SID",	"START_DT",		"END_DT",
																					"EDU_CD", "EDU_YN", "EDU_CO",
																					"I_EMPNO","U_EMPNO","I_DATE","U_DATE",
					                                "EDU_CD_NM","EDU_YN_NM"
																        }; 

				int[] intArrCN = new int[] {  	10,	2, 10,	8,	8,
																				 3,	1, 40, 
					                              10,10, 10, 10,
					                              30,30
														      	}; 
			
				int[] intArrCN2 = new int[]{ 	 -1,  0, 0,	-1,	-1,	
																			 -1, -1,-1,	
																			 -1, -1,-1,	-1,
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

						sql.append( "SELECT A.EMPNO, A.SEQ, A.CUST_SID, TRIM(A.START_DT) AS START_DT, TRIM(A.END_DT) AS END_DT,                \n");
						sql.append( "       A.EDU_CD,A.EDU_YN,  TRIM(A.EDU_CO)AS EDU_CO,                                                       \n");
						sql.append( "       A.I_EMPNO, A.U_EMPNO, A.I_DATE, A.U_DATE,                                                          \n");
						sql.append( "       RTRIM(E.DETAIL_NM)EDU_CD_NM,RTRIM(F.DETAIL_NM)EDU_YN_NM                                            \n");
						sql.append( "  FROM SALES.TCM335 A                                                                                     \n");
						sql.append( "  LEFT JOIN SALES.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.EDU_CD) AND E.HEAD='CM011' AND RTRIM(E.DETAIL)<>''\n");
						sql.append( "  LEFT JOIN SALES.TSY010 F ON RTRIM(F.DETAIL) = RTRIM(A.EDU_YN) AND F.HEAD='CM031' AND RTRIM(F.DETAIL)<>''\n");
						sql.append( " WHERE A.EMPNO='"+str1+"'						\n");
						sql.append( " ORDER BY A.SEQ							\n");

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