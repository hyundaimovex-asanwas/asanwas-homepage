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
public class a090001_s15 extends HttpServlet {
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

				String  str1	= req.getParameter("v_str1");    //�����ڵ�     
				String  str3	= req.getParameter("v_str3");    //�ڻ��ߺз�  �ʼ�
				String  str4	= req.getParameter("v_str4");    //�ڻ�Һз�  �ʼ�  
				String  str5	= req.getParameter("v_str5");    //�����ڵ�   �ʼ�
				String  str11	= req.getParameter("v_str11");    //ast1st     

				if (str1 == null) str1 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str11 == null) str11 = "";

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "ASTSEQ" }; 
 
				int[] intArrCN = new int[]{ 5}; 
					
				int[] intArrCN2 = new int[]{ -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT  MAX(ASTSEQ) as ASTSEQ   ");
					sql.append( " FROM ACCOUNT.ASTMST  				");	 					
					sql.append( " WHERE	FDCODE IS NOT NULL					");	 
			        if (!str1.equals(""))  sql.append( "  AND  FDCODE = '"+str1+"'  ");
 					if (!str3.equals(""))  sql.append( "  AND   AST2ND = '"+str3+"'   "); 					 
 					if (!str4.equals(""))  sql.append( "  AND   AST3RD = '"+str4+"'   ");
			        if (!str5.equals(""))  sql.append( "  AND   ATCODE = '"+str5+"'  ");					
 					if (!str11.equals(""))   sql.append( "  AND	AST1ST  = '"+str11+"'  ");

					//logger.dbg.println( this, sql.toString() );
 					
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