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
public class a160002_s1 extends HttpServlet {
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
				str[1]	= req.getParameter("v_str2");		//회계년도 from
				str[2]	= req.getParameter("v_str3");		//회계년도 to

				GauceRes.enableFirstRow(dSet);
				dSet.addDataColumn(new GauceDataColumn("ATCODE", GauceDataColumn.TB_STRING,13));
				dSet.addDataColumn(new GauceDataColumn("FSREFVAL", GauceDataColumn.TB_STRING,255));
				dSet.addDataColumn(new GauceDataColumn("DEAMT", GauceDataColumn.TB_DECIMAL,15,0));
				dSet.addDataColumn(new GauceDataColumn("REMARK", GauceDataColumn.TB_STRING,255));
				dSet.addDataColumn(new GauceDataColumn("FSDAT", GauceDataColumn.TB_STRING,8));
				dSet.addDataColumn(new GauceDataColumn("FSNBR", GauceDataColumn.TB_STRING,6));
				dSet.addDataColumn(new GauceDataColumn("FSSEQ", GauceDataColumn.TB_STRING,5));
				dSet.addDataColumn(new GauceDataColumn("ATKORNAM", GauceDataColumn.TB_STRING,66));
				dSet.addDataColumn(new GauceDataColumn("ACTDAT", GauceDataColumn.TB_STRING,8));
				dSet.addDataColumn(new GauceDataColumn("VEND_NM", GauceDataColumn.TB_STRING,62));

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT                                                                                                         \n " );
					sql.append( "  A.ATCODE,                                                                                                     \n " );
					sql.append( "  B.FSREFVAL,                                                                                                  \n " );
					sql.append( "  A.DEAMT,                                                                                                      \n " );
					sql.append( "  C.REMARK,                                                                                                    \n " );
					sql.append( "  A.FSDAT,                                                                                                       \n " );
					sql.append( "  A.FSNBR,                                                                                                       \n " );
					sql.append( "  A.FSSEQ,                                                                                                        \n " );
					sql.append( "	 D.ATKORNAM,																								\n " );
					sql.append( "	 A.ACTDAT,																									\n " );
					sql.append( "	 E.VEND_NM																								\n " );
					sql.append( "  FROM                                                                                                            \n " );
					sql.append( "  ACCOUNT.GENENLED A LEFT JOIN ACCOUNT.ACTCODE D ON A.ATCODE=D.ATCODE,            \n " );
					sql.append( "  ACCOUNT.GENENREF B LEFT JOIN ACCOUNT.GCZM_VENDER E ON B.FSREFVAL=E.VEND_CD,		\n " );
					sql.append( "  ACCOUNT.FSLIPDTL C                                                                                    \n " );
					sql.append( "  WHERE  A.FDCODE LIKE '"+str[0]+"'|| '%'															\n " );
					sql.append( "  AND    A.FSDAT BETWEEN 'A"+str[1]+"' AND 'A"+str[2]+"'										\n " );
					sql.append( "  AND    ( ( A.ATCODE >= '4331700' AND A.ATCODE <= '4331900') OR						 \n " );
					sql.append( "  ( A.ATCODE >= '4402800'  AND A.ATCODE <= '4403000'))						     			\n " );
					sql.append( "  AND    A.FSDAT  = C.FSDAT                                                                             \n " );
					sql.append( "  AND    A.FSNBR  = C.FSNBR                                                                            \n " );
					sql.append( "  AND    A.FSSEQ  = C.FSSEQ                                                                            \n " );
					sql.append( "  AND    A.FDCODE = C.FDCODE                                                                         \n " );
					sql.append( "  AND    A.FDCODE = B.FDCODE                                                                         \n " );
					sql.append( "  AND    A.FSDAT  = B.FSDAT                                                                             \n " );
					sql.append( "  AND    A.FSNBR  = B.FSNBR                                                                            \n " );
					sql.append( "  AND    A.FSSEQ  = B.FSSEQ                                                                            \n " );
					sql.append( "  AND    B.FSREFCD  = '0020'                                                                              \n " );
					sql.append( "  AND    D.ATUSEYN = 'Y'																																									\n " );

					//System.out.println("# Query : \n" + sql);
					//logger.dbg.println(this,"111111"+str[2]);
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