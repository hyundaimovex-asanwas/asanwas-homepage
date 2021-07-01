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
public class a160002_s2 extends HttpServlet {
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
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//지점구분                  
				str[1]	= req.getParameter("v_str2");		//회계년도            
				str[2]	= req.getParameter("v_str3");		//회계년도            
				
			
				
		
				GauceRes.enableFirstRow(dSet);
				dSet.addDataColumn(new GauceDataColumn("DEAMT_A", GauceDataColumn.TB_DECIMAL,15,0));
				dSet.addDataColumn(new GauceDataColumn("DEAMT_B", GauceDataColumn.TB_DECIMAL,15,0));
				

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					sql.append( "  -- #1                                                                                                                                                 \n " );
					sql.append( "  SELECT DEAMT_A ,DEAMT_B                                                                                                            \n " );
					sql.append( "  FROM (SELECT CASE WHEN sum(DEAMT) IS NULL THEN 0 ELSE SUM(DEAMT) END  DEAMT_A            \n " );
					sql.append( "  	 FROM ACCOUNT.GENENLED                                                                                                         \n " );
					sql.append( "  	 WHERE FDCODE LIKE '"+str[0]+"'||'%'                                                                                                              \n " );
					sql.append( "  	 AND   FSDAT BETWEEN 'A"+str[1]+"' AND 'A"+str[2]+"'	                                                               \n " );
					sql.append( "  	 AND   ATCODE >= '4331700' AND ATCODE <= '4331900') A,                                                               \n " );
					sql.append( "  	 (SELECT CASE WHEN sum(DEAMT) IS NULL THEN 0 ELSE SUM(DEAMT) END  DEAMT_B                 \n " );
					sql.append( "  	 FROM ACCOUNT.GENENLED                                                                                                         \n " );
					sql.append( "  	 WHERE FDCODE LIKE '"+str[0]+"'||'%'                                                                                                              \n " );
					sql.append( "  	 AND   FSDAT BETWEEN 'A"+str[1]+"' AND 'A"+str[2]+"'	                                   \n " );
					sql.append( "  	 AND   ATCODE >= '4402800' AND ATCODE <= '4403000') B                                                                \n " );
					sql.append( "  UNION ALL                                                                                                                                        \n " );
					sql.append( "  -- #3                                                                                                                                                 \n " );
					sql.append( "  SELECT DEAMT_A,DEAMT_B FROM (                                                                                                 \n " );
					sql.append( "  SELECT                                                                                                                                            \n " );
					sql.append( "  CASE WHEN sum(DEAMT) IS NULL THEN 0 ELSE SUM(DEAMT) END  DEAMT_A                                    \n " );
					sql.append( "  FROM                                                                                                                                               \n " );
					sql.append( "  ACCOUNT.GENENLED A,                                                                                                                   \n " );
					sql.append( "  ACCOUNT.GENENREF B                                                                                                                    \n " );
					sql.append( "  WHERE A.FDCODE LIKE '"+str[0]+"'||'%'                                                                                                                \n " );
					sql.append( "  AND   A.FSDAT BETWEEN 'A"+str[1]+"' AND 'A"+str[2]+"'                                                                        \n " );
					sql.append( "  AND   A.FSDAT  = B.FSDAT                                                                                                                 \n " );
					sql.append( "  AND   A.FSNBR  = B.FSNBR                                                                                                                \n " );
					sql.append( "  AND   A.FSSEQ  = B.FSSEQ                                                                                                                \n " );
					sql.append( "  AND   A.FDCODE  = B.FDCODE                                                                                                                \n " );
					sql.append( "  AND   A.ATCODE >= '4331700' AND A.ATCODE <= '4331900'                                                                   \n " );
					sql.append( "  AND   B.FSREFCD  = '1103'                                                                                                                 \n " );
					sql.append( "  AND   (  B.FSREFVAL  = '01' OR B.FSREFVAL  = '04' OR                                                                        \n " );
					sql.append( "           B.FSREFVAL  = '05' OR B.FSREFVAL  = '07' )) A,                                                                          \n " );
					sql.append( "  (SELECT                                                                                                                                           \n " );
					sql.append( "  CASE WHEN sum(DEAMT) IS NULL THEN 0 ELSE SUM(DEAMT) END  DEAMT_B                                    \n " );
					sql.append( "  FROM                                                                                                                                               \n " );
					sql.append( "  ACCOUNT.GENENLED A,                                                                                                                   \n " );
					sql.append( "  ACCOUNT.GENENREF B                                                                                                                    \n " );
					sql.append( "  WHERE A.FDCODE LIKE '"+str[0]+"'||'%'                                                                                                                \n " );
					sql.append( "  AND   A.FSDAT BETWEEN 'A"+str[1]+"' AND 'A"+str[2]+"'                                                                    \n " );
					sql.append( "  AND   A.FSDAT  = B.FSDAT                                                                                                                 \n " );
					sql.append( "  AND   A.FSNBR  = B.FSNBR                                                                                                                \n " );
					sql.append( "  AND   A.FSSEQ  = B.FSSEQ                                                                                                                \n " );
					sql.append( "  AND   A.FDCODE  = B.FDCODE                                                                                                                \n " );
					sql.append( "  AND   A.ATCODE >= '4402800' AND A.ATCODE <= '4403000'                                                                   \n " );
					sql.append( "  AND   B.FSREFCD  = '1103'                                                                                                                 \n " );
					sql.append( "  AND   ( B.FSREFVAL  = '01'  OR B.FSREFVAL  = '04' OR                                                                        \n " );
					sql.append( "         B.FSREFVAL  = '05'  OR B.FSREFVAL  = '07' )) B                                                                            \n " );
					sql.append( "  UNION ALL                                                                                                                                        \n " );
					sql.append( "  SELECT DEAMT_A ,DEAMT_B FROM(                                                                                                 \n " );
					sql.append( "  SELECT CASE WHEN sum(DEAMT) IS NULL THEN 0 ELSE SUM(DEAMT) END  DEAMT_A                       \n " );
					sql.append( "  FROM                                                                                                                                               \n " );
					sql.append( "  ACCOUNT.GENENLED                                                                                                                       \n " );
					sql.append( "  WHERE FDCODE LIKE '"+str[0]+"'||'%'                                                                                                                   \n " );
					sql.append( "  AND   FSDAT BETWEEN 'A"+str[1]+"' AND 'A"+str[2]+"'                                                                    \n " );
					sql.append( "  AND   ATCODE >= '4331700' AND ATCODE <= '4331900'                                                                         \n " );
					sql.append( "  AND   DEAMT  >= 50000) A,                                                                                                                 \n " );
					sql.append( "  (SELECT CASE WHEN sum(DEAMT) IS NULL THEN 0 ELSE SUM(DEAMT) END  DEAMT_B                      \n " );
					sql.append( "  FROM                                                                                                                                               \n " );
					sql.append( "  ACCOUNT.GENENLED                                                                                                                       \n " );
					sql.append( "  WHERE FDCODE LIKE '"+str[0]+"'||'%'                                                                                                                   \n " );
					sql.append( "  AND   FSDAT BETWEEN 'A"+str[1]+"' AND 'A"+str[2]+"'                                                   \n " );
					sql.append( "  AND   ATCODE >= '4402800' AND ATCODE <='4403000'                                                                          \n " );
					sql.append( "  AND   DEAMT  >= 50000  ) B                                                                                                                \n " );

					//System.out.println("# Query : \n" + sql);
					//System.out.println("# Query : " + sql);
					//logger.dbg.println(this,sql.toString());
					
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