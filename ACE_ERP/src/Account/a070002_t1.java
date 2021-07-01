package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a070002_t1 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;

			try {
				conn = service.getDBConnection();
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1");	//����
				String str2 = reqGauce.getParameter("v_str2");  //����
				String str3 = reqGauce.getParameter("v_str3");  //������ ������ұ���

				StringBuffer InsertSql  = null;
				StringBuffer DeleteSql  = null;

				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.AFUNDEND 				" );
				InsertSql.append( " SELECT DISTINCT FDCODE,ACDATE,'Y','','' 	" );
				InsertSql.append( " FROM ACCOUNT.AFUNDDAY 						" );
				InsertSql.append( " WHERE FDCODE = '" + str1 + "' AND ACDATE = '" + str2 + "' " );

				//delet statement
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.AFUNDEND 	" );
				DeleteSql.append( " WHERE FDCODE = '" + str1 + "'			" );
				DeleteSql.append( " AND ACDATE = '" + str2 + "'				" );

				if (str3.equals("A")) {
					GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
					gsmt.executeUpdate();
					gsmt.close();
				} else if(str3.equals("D")) {
					GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
					gsmt.executeUpdate();
					gsmt.close();
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}