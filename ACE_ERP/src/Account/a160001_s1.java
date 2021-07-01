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
public class a160001_s1 extends HttpServlet {
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
				str[2]	= req.getParameter("v_str3");		//            				
		
				GauceRes.enableFirstRow(dSet);
				
				dSet.addDataColumn(new GauceDataColumn("REMARK", GauceDataColumn.TB_STRING,255));
				dSet.addDataColumn(new GauceDataColumn("VEND_ID", GauceDataColumn.TB_STRING,13));
				dSet.addDataColumn(new GauceDataColumn("VEND_NM", GauceDataColumn.TB_STRING,32));
				dSet.addDataColumn(new GauceDataColumn("ACTDAT", GauceDataColumn.TB_STRING,8));
				dSet.addDataColumn(new GauceDataColumn("FSREFVAL", GauceDataColumn.TB_DECIMAL,13,0));
				dSet.addDataColumn(new GauceDataColumn("TEXRATE", GauceDataColumn.TB_STRING,13));
				dSet.addDataColumn(new GauceDataColumn("DEAMT", GauceDataColumn.TB_DECIMAL,13,0));
				
				dSet.addDataColumn(new GauceDataColumn("VEND_CD", GauceDataColumn.TB_STRING,13));
				dSet.addDataColumn(new GauceDataColumn("FSDAT", GauceDataColumn.TB_STRING,9));
				dSet.addDataColumn(new GauceDataColumn("FSNBR", GauceDataColumn.TB_STRING,6));
				

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					/*
					sql.append( "	SELECT																	   \n " );
					sql.append( "	D.REMARK,																   \n " );
					sql.append( "	C.VEND_ID,																   \n " );
					sql.append( "	C.VEND_NM,															   \n " );
					sql.append( "	A.ACTDAT,																   \n " );
					sql.append( "	TO_NUMBER( CASE WHEN TRIM(E.FSREFVAL) IS NULL THEN 0    WHEN  TRIM(E.FSREFVAL) = '' THEN 0    WHEN  TRIM(E.FSREFVAL) = '-' THEN 0 \n " );
					sql.append( "				  ELSE REPLACE(REPLACE(E.FSREFVAL,',',''),'\\','')END ) FSREFVAL,	\n");
					sql.append( "	'14%' AS TEXRATE,													   \n " );
					sql.append( "	A.DEAMT	,C.VEND_CD, A.FSDAT,A.FSNBR								       \n " );
					sql.append( "	FROM 																	       \n " );
					sql.append( "	ACCOUNT.GENENLED A,											   \n " );
					sql.append( "	ACCOUNT.GENENREF B,											   \n " );
					sql.append( "	ACCOUNT.GCZM_VENDER C,									   \n " );
					sql.append( "	ACCOUNT.FSLIPDTL D	LEFT JOIN ACCOUNT.GENENREF E ON A.FDCODE = E.FDCODE AND  A.FSDAT  = E.FSDAT \n");  //--//적요//
					sql.append("    AND     A.FSNBR  = E.FSNBR     AND    A.FSSEQ  = E.FSSEQ    \n");
					sql.append("    AND E.FSREFCD='1184'										       \n " );
					sql.append( "	WHERE  A.FDCODE LIKE '"+str[0]+"'||'%'   							       \n " );
					sql.append( "	AND    A.FSDAT BETWEEN 'A"+str[1]+"' AND 'A"+str[2]+"'      \n " );
					sql.append( "	AND    A.ATCODE = '1112400'									       \n " );
					sql.append( "	AND    A.FSDAT  = D.FSDAT  --//적요//					       \n " );
					sql.append( "	AND    A.FSNBR  = D.FSNBR 									       \n " );
					sql.append( "	AND    A.FSSEQ  = D.FSSEQ 									       \n " );
					sql.append( "	AND    A.FSDAT  = B.FSDAT  --//등록번호, 상호, 이자금   \n " );
					sql.append( "	AND    A.FSNBR  = B.FSNBR 										     \n " );
					sql.append( "	AND    A.FSSEQ  = B.FSSEQ 										     \n " );
                    sql.append( "	AND    A.FDCODE  = B.FDCODE 										     \n " );
					sql.append( "	AND    A.FDCODE  = D.FDCODE 										     \n " );
					sql.append( "	AND    ( B.FSREFCD ='0020')	 AND    B.FSREFVAL = C.VEND_CD \n " );
					 */
					
					sql.append( "	SELECT																	   \n " );
					sql.append( "	D.REMARK,																   \n " );
					sql.append( "	C.VEND_ID,																   \n " );
					sql.append( "	C.VEND_NM,															   \n " );
					sql.append( "	A.ACTDAT,																   \n " );
					sql.append( "	CASE WHEN TRIM(E.FSREFVAL) IS NULL THEN 0    WHEN  TRIM(E.FSREFVAL) = '' THEN 0    	\n " );
					sql.append( "			WHEN TRIM(E.FSREFVAL) = '-' THEN 0    																\n " );
					sql.append( "			ELSE TO_NUMBER(REPLACE(REPLACE(E.FSREFVAL,',',''),'\\','')) END FSREFVAL,  	\n " );
					sql.append( "	'14%' AS TEXRATE,													   	\n " );
					sql.append( "	A.DEAMT	,C.VEND_CD, A.FSDAT,A.FSNBR						\n " );
					sql.append( "	FROM 																	   	\n " );
					sql.append( "	ACCOUNT.GENENLED A											   	\n " );
					sql.append( "	LEFT JOIN ACCOUNT.GENENREF B ON A.FDCODE = B.FDCODE AND A.FSDAT  = B.FSDAT			\n");
					sql.append( "								AND A.FSNBR  = B.FSNBR  AND A.FSSEQ  = B.FSSEQ 			\n"); 
					sql.append( "	LEFT JOIN ACCOUNT.GCZM_VENDER C ON B.FSREFVAL = C.VEND_CD											\n");
					sql.append( "	LEFT JOIN ACCOUNT.FSLIPDTL D ON A.FDCODE = D.FDCODE AND A.FSDAT  = D.FSDAT 				\n"); 
					sql.append( "								AND A.FSNBR  = D.FSNBR  AND A.FSSEQ  = D.FSSEQ 			\n"); 
					sql.append( "	LEFT JOIN ACCOUNT.GENENREF E ON A.FDCODE = E.FDCODE AND A.FSDAT  = E.FSDAT \n"); 
					sql.append("                                AND A.FSNBR  = E.FSNBR  AND A.FSSEQ  = E.FSSEQ    		\n " );
					sql.append("                                AND E.FSREFCD='1184'										       					\n " );
					sql.append( "	WHERE  A.FDCODE LIKE '"+str[0]+"'||'%'   							       		\n " );
					sql.append( "	AND    A.ACTDAT BETWEEN '"+str[1]+"' AND '"+str[2]+"'      				\n " );
					sql.append( "	AND    A.ATCODE = '1112400'									       				\n " );
					sql.append( "	AND    B.FSREFCD ='0020'															\n " );					
					
					
					//System.out.println("# Query : \n" + sql);
					// logger.dbg.println(this,sql.toString());
					
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