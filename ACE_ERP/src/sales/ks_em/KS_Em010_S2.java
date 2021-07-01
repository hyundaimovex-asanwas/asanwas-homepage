package sales.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class KS_Em010_S2 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "EMPNO","ORD_DT","ORD_CD", "DEPT_CD",
																					"WORK_CD","JOB_CD","SEQ",
																					"CUST_SID",	"VEND_CD",
					                               			 						"ORD_NM", "VEND_NM","DEPT_NM",
					                                								"WORK_NM","JOB_NM"

					                                
																}; 

				int[] intArrCN = new int[] { 
																				10, 8, 3, 	5, 
																				5,	5,  2,
																				10,10,
                                        										30,30,30,
																				30,30

															}; 
			
				int[] intArrCN2 = new int[]{
																			-1,	-1,	-1, -1, 	
																			-1,	-1,	 0,
																			 0,  0,
                                      										-1,	-1,	-1,
																		  	-1,	-1

															}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "SELECT A.EMPNO, TRIM(A.ORD_DT) AS ORD_DT, A.ORD_CD,  A.DEPT_CD,                                    \n");
						sql.append( "       A.WORK_CD, A.JOB_CD,  A.SEQ,                                                    \n");
						sql.append( "       A.CUST_SID, A.VEND_CD,                                                                               \n");
						sql.append( "       RTRIM(E.DETAIL_NM) ORD_NM, RTRIM(F.DETAIL_NM) VEND_NM, RTRIM(G.DETAIL_NM) DEPT_NM,                       \n");
						sql.append( "       RTRIM(I.DETAIL_NM) WORK_NM, RTRIM(J.DETAIL_NM)JOB_NM                        \n");
						sql.append( "  FROM SALES.KST015 A                                                                                         \n");
						sql.append( "  LEFT JOIN SALES.KST010 B  ON A.EMPNO = B.EMPNO											 \n");
						sql.append( "  LEFT JOIN SALES.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.ORD_CD)    AND E.HEAD='KS010' AND RTRIM(E.DETAIL)<>'' \n");
						sql.append( "  LEFT JOIN SALES.TSY010 F ON RTRIM(F.DETAIL) = RTRIM(A.VEND_CD)   AND F.HEAD='KS007' AND RTRIM(F.DETAIL)<>'' \n");
						sql.append( "  LEFT JOIN SALES.TSY010 G ON RTRIM(G.DETAIL) = RTRIM(A.DEPT_CD)   AND G.HEAD='KS006' AND RTRIM(G.DETAIL)<>'' \n");
						sql.append( "  LEFT JOIN SALES.TSY010 I ON RTRIM(I.DETAIL) = RTRIM(A.WORK_CD)   AND I.HEAD='KS001' AND RTRIM(I.DETAIL)<>'' \n");
						sql.append( "  LEFT JOIN SALES.TSY010 J ON RTRIM(J.DETAIL) = RTRIM(A.JOB_CD)    AND J.HEAD='KS002' AND RTRIM(J.DETAIL)<>'' \n");
						sql.append( " WHERE A.EMPNO = '"+str1+"'     \n");
						sql.append( " ORDER BY A.SEQ					\n");

            			logger.dbg.println(this,sql.toString());
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