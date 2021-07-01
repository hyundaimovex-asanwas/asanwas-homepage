package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040120_t2 extends HttpServlet{
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

			String strSeq = "";
			String strVend_CD="";

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				String str1 = reqGauce.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				
				int idxTAXNBR    	= userSet.indexOfColumn("TAXNBR");
				int idxREAL_FILE  	= userSet.indexOfColumn("REAL_FILE");
				int idxSYS_FILE  	= userSet.indexOfColumn("SYS_FILE");
				int idxREAL_FILE2  	= userSet.indexOfColumn("REAL_FILE2");
				int idxSYS_FILE2  	= userSet.indexOfColumn("SYS_FILE2");
				//int idxWRID         = userSet.indexOfColumn("WRID");
				//int idxWRDT     	= userSet.indexOfColumn("WRDT");
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
	
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ATTAXMST SET 	\n");								
				UpdateSql.append( "        REAL_FILE = ? 		  	\n");
				UpdateSql.append( "       ,SYS_FILE  = ? 			\n");
				UpdateSql.append( "       ,REAL_FILE2 = ? 		  	\n");
				UpdateSql.append( "       ,SYS_FILE2  = ? 			\n");
				UpdateSql.append( "  WHERE TAXNBR = ? 			    \n");	
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1, idxREAL_FILE);
						gsmt.bindColumn(2, idxSYS_FILE);
						gsmt.bindColumn(3, idxREAL_FILE2);
						gsmt.bindColumn(4, idxSYS_FILE2);
						gsmt.bindColumn(5, idxTAXNBR);	

						gsmt.executeUpdate();
						gsmt.close();
					}
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						
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