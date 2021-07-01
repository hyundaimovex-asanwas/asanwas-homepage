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
public class KS_Em010_S3 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "EMPNO",  "DEPT_CD",  "DEPT_NM",   "VEND_CD",   "VEND_NM",  
								
																	"HOL_DT",  "HOL_GB", "HOL_NM",  "HOL_SUM"

																        }; 

				int[] intArrCN = new int[] {   10, 5, 10, 5, 20, 
					
															8, 1, 10,  2		

		         												}; 
			
				int[] intArrCN2 = new int[]{	-1,	-1, 	-1,	-1,	-1,  
					
															-1, -1, -1,  0

						       									}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( "SELECT A.EMPNO,																											\n");
					sql.append( " B.DEPT_CD,   RTRIM(J.DETAIL_NM)	DEPT_NM,																\n");
					sql.append( " B.VEND_CD,   RTRIM(K.DETAIL_NM)	VEND_NM,															\n");
					sql.append( " A.HOL_DT, A.HOL_GB, RTRIM(L.DETAIL_NM)	HOL_NM,	A.HOL_SUM								\n");
					sql.append( "  FROM NORTHHR.KST160 A                                                                                         	\n");
					sql.append( "	LEFT JOIN NORTHHR.KST010 B ON RTRIM(B.EMPNO) = RTRIM(A.EMPNO)   				  	\n");
					sql.append( "	LEFT JOIN NORTHHR.TSY010 J ON RTRIM(J.DETAIL) = RTRIM(B.DEPT_CD)    	AND J.HEAD='KS006'   AND RTRIM(J.DETAIL)<>''   \n");
					sql.append( "	LEFT JOIN NORTHHR.TSY010 K ON RTRIM(K.DETAIL) = RTRIM(B.VEND_CD)    AND K.HEAD='KS007'   AND RTRIM(K.DETAIL)<>''   \n");
					sql.append( "	LEFT JOIN NORTHHR.TSY010 L ON RTRIM(L.DETAIL) = RTRIM(A.HOL_GB)    	AND L.HEAD='KS019'   AND RTRIM(L.DETAIL)<>''   \n");						



					sql.append( " WHERE A.EMPNO = '"+str1+"'				\n");

					//logger.dbg.println(this,sql.toString());
					
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