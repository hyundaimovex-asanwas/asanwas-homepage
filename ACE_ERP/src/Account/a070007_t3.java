package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a070007_t3 extends HttpServlet{
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
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1");				//사용자
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxACDATE = userSet.indexOfColumn("ACDATE");
				int idxCPDATE = userSet.indexOfColumn("CPDATE");
				int idxUPID   = userSet.indexOfColumn("UPID");
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer DeleteSql  = null;
				
				GauceStatement gsmt= null;
				
				//delet statement
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ACASHSUR WHERE ACDATE =? ");

				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ACASHSUR   \n" );
				InsertSql.append( " SELECT FDCODE, ?, CASHUNIT, QUANTY, ACAMT, '', SYSDATE, ?   \n" );
				InsertSql.append( "   FROM ACCOUNT.ACASHSUR  \n" );
				InsertSql.append( "  WHERE ACDATE =?  \n" );
		
				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
				
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCPDATE);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
						
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCPDATE);
						gsmt.bindColumn(2, idxUPID);
						gsmt.bindColumn(3, idxACDATE);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
					}
				
				}
				
			}
			catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			conn.commit(); 
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