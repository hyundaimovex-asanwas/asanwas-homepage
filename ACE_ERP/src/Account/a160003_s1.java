package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class a160003_s1 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// ���������� ���� ���۹���� Post Ÿ���� ���
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
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//��������                  
				str[1]	= req.getParameter("v_str2");		//ȸ��⵵            
				str[2]	= req.getParameter("v_str3");		//ȸ��⵵       
				
				GauceRes.enableFirstRow(dSet);
				dSet.addDataColumn(new GauceDataColumn("FSREFVAL", GauceDataColumn.TB_STRING,255));
				dSet.addDataColumn(new GauceDataColumn("ATCODE", GauceDataColumn.TB_STRING,13));
				dSet.addDataColumn(new GauceDataColumn("DEAMT", GauceDataColumn.TB_DECIMAL,15,0));
				dSet.addDataColumn(new GauceDataColumn("REMARK", GauceDataColumn.TB_STRING,255));
				dSet.addDataColumn(new GauceDataColumn("FSDAT", GauceDataColumn.TB_STRING,9));
				dSet.addDataColumn(new GauceDataColumn("FSNBR", GauceDataColumn.TB_STRING,6));
				dSet.addDataColumn(new GauceDataColumn("FSSEQ", GauceDataColumn.TB_DECIMAL,15,0));
				dSet.addDataColumn(new GauceDataColumn("ATKORNAM", GauceDataColumn.TB_STRING,66));
				dSet.addDataColumn(new GauceDataColumn("VEND_NM", GauceDataColumn.TB_STRING,62));
				dSet.addDataColumn(new GauceDataColumn("SSDAT", GauceDataColumn.TB_STRING,9));
				dSet.addDataColumn(new GauceDataColumn("SSNBR", GauceDataColumn.TB_STRING,6));
				dSet.addDataColumn(new GauceDataColumn("FDCODE", GauceDataColumn.TB_STRING,2));
				dSet.addDataColumn(new GauceDataColumn("VEND_CD", GauceDataColumn.TB_STRING,13));
				dSet.addDataColumn(new GauceDataColumn("FSDAT1", GauceDataColumn.TB_STRING,8));
				
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT B.FSREFVAL,                                                                  \n " );
					sql.append( "  A.ATCODE,                                                                                  \n " );
					sql.append( "  A.DEAMT,                                                                                    \n " );
					sql.append( "  D.REMARK,                                                                                  \n " );
					sql.append( "  A.FSDAT,                                                                                     \n " );
					sql.append( "  A.FSNBR,                                                                                     \n " );
					sql.append( "  A.FSSEQ,                                                                                      \n " );
					sql.append( "  E.ATKORNAM,																					\n " );
					sql.append( "	 C.VEND_NM,A.SSDAT,A.SSNBR,A.FDCODE	,C.VEND_CD,SUBSTR(A.FSDAT,2,8) AS FSDAT1			\n " );
					sql.append( "  FROM                                                                                          \n " );
					sql.append( "  ACCOUNT.GENENLED A,      															\n " );
					sql.append( "  ACCOUNT.GENENREF B,                                                              \n " );
					sql.append( "  ACCOUNT.GCZM_VENDER C,                                                       \n " );
					sql.append( "  ACCOUNT.FSLIPDTL D,                                                                  \n " );
					sql.append( "  ACCOUNT.ACTCODE E     																\n " );					
					sql.append( "  WHERE  A.FDCODE LIKE '"+str[0]+"'||'%'                                      \n " );
					sql.append( "  AND    A.FSDAT BETWEEN 'A"+str[1]+"' AND 'A"+str[2]+"'    				\n " );
					sql.append( "  AND    A.FSDAT  = D.FSDAT                                                          \n " );
					sql.append( "  AND    A.FSNBR  = D.FSNBR                                                          \n " );
					sql.append( "  AND    A.FSSEQ  = D.FSSEQ                                                          \n " );
					sql.append( "  AND    A.FSDAT  = B.FSDAT                                                          \n " );
					sql.append( "  AND    A.FDCODE  = D.FDCODE                                                          \n " );
					sql.append( "  AND    A.FDCODE  = B.FDCODE                                                          \n " );
					sql.append( "  AND    A.FSNBR  = B.FSNBR                                                          \n " );
					sql.append( "  AND    A.FSSEQ  = B.FSSEQ                                                          \n " );
					sql.append( "  AND    B.FSREFCD  = '0020'                                                           \n " );
					sql.append( "  AND    B.FSREFVAL = C.VEND_CD                                                 \n " );
					sql.append( "  AND    C.COCOMYN = 'S'                                                              \n " );
					sql.append( "  AND    A.ATCODE=E.ATCODE                                                             \n " );					
					sql.append( "  AND    E.ATUSEYN = 'Y'																	\n " );												   	
			
					//System.out.println("# Query : \n" + sql);
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