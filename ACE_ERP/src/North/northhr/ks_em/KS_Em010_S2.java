package North.northhr.ks_em;

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

				String[] strArrCN = new String[]{ "EMPNO", "SEQ", "ORD_DT","ORD_CD", "ORD_NM", 
																					"DEPT_CD","DEPT_NM",
																					"VEND_CD", "VEND_NM",																	
																					"JOB_CD", "JOB_NM" 
																					
																}; 

				int[] intArrCN = new int[] { 
																				10, 2, 10, 5, 10,
																				5,  20,
																				5,  20,
                                        										5,  20

															}; 
			
				int[] intArrCN2 = new int[]{
																			-1,	-1,	-1,  -1, 	  -1, 
																			-1,    -1, 
																			-1,    -1, 	
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

						sql.append( "SELECT A.EMPNO, A.SEQ, A.ORD_DT, A.ORD_CD,  RTRIM(E.DETAIL_NM) ORD_NM,                       \n");
						sql.append( "       A.DEPT_CD,   RTRIM(G.DETAIL_NM) DEPT_NM,																	  \n");
						sql.append( "       A.VEND_CD,  RTRIM(F.DETAIL_NM) VEND_NM,                                                                      \n");
						sql.append( "       A.JOB_CD,    RTRIM(J.DETAIL_NM) JOB_NM																			\n");
						sql.append( "  FROM NORTHHR.KST015 A																											\n");
						sql.append( "  LEFT JOIN NORTHHR.KST010 B  ON A.EMPNO = B.EMPNO																\n");
						sql.append( "  LEFT JOIN NORTHHR.TSY010 E ON RTRIM(E.DETAIL) = RTRIM(A.ORD_CD)    AND E.HEAD='KS010' AND RTRIM(E.DETAIL)<>'' \n");
						sql.append( "  LEFT JOIN NORTHHR.TSY010 F ON RTRIM(F.DETAIL) = RTRIM(A.VEND_CD)   AND F.HEAD='KS007' AND RTRIM(F.DETAIL)<>'' \n");
						sql.append( "  LEFT JOIN NORTHHR.TSY010 G ON RTRIM(G.DETAIL) = RTRIM(A.DEPT_CD)   AND G.HEAD='KS006' AND RTRIM(G.DETAIL)<>'' \n");
						sql.append( "  LEFT JOIN NORTHHR.TSY010 J ON RTRIM(J.DETAIL) = RTRIM(A.JOB_CD)    AND J.HEAD='KS002' AND RTRIM(J.DETAIL)<>'' \n");
						sql.append( " WHERE A.EMPNO = '"+str1+"'     \n");
						sql.append( " ORDER BY A.SEQ					\n");

            	//		logger.dbg.println(this,sql.toString());
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