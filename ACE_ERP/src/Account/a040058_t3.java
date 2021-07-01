package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040058_t3 extends HttpServlet{
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

				GauceStatement gsmt=null;
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				int idxTAXNBR    = userSet.indexOfColumn("TAXNBR");     //
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer DeleteSql = null;
				StringBuffer DeleteSql2 = null;
       
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM ACCOUNT.ATTAXMST    	\n" );
						DeleteSql.append( "  WHERE TAXNBR = ?               				\n" );

						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxTAXNBR );
						gsmt.executeUpdate();
						gsmt.close();
                        gsmt=null;    
						DeleteSql=null;

						DeleteSql2 = new StringBuffer();
						DeleteSql2.append( " DELETE FROM ACCOUNT.ATTAXDTL    	\n" );
						DeleteSql2.append( "  WHERE TAXNBR = ?               			\n" );

						gsmt = conn.getGauceStatement(DeleteSql2.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxTAXNBR );
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;    
						DeleteSql2=null;
						
					}//if
				}//for
			}
			catch(Exception e)
				{
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				logger.err.println(this,e.toString()); //
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