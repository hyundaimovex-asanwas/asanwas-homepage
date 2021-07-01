package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010050_t3 extends HttpServlet{
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

				
				int idxVEND_CD  	= userSet.indexOfColumn("VEND_CD");
				int idxREAL_FILE4  	= userSet.indexOfColumn("REAL_FILE4");
				int idxSYS_FILE4  	= userSet.indexOfColumn("SYS_FILE4");
				int idxREAL_FILE3  	= userSet.indexOfColumn("REAL_FILE3");
				int idxSYS_FILE3  	= userSet.indexOfColumn("SYS_FILE3");
				int idxREAL_FILE2  	= userSet.indexOfColumn("REAL_FILE2");
				int idxSYS_FILE2  	= userSet.indexOfColumn("SYS_FILE2");
				int idxREAL_FILE1  	= userSet.indexOfColumn("REAL_FILE1");
				int idxSYS_FILE1  	= userSet.indexOfColumn("SYS_FILE1");
				int idxWRID         = userSet.indexOfColumn("WRID");
				int idxWRDT     	= userSet.indexOfColumn("WRDT");
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
	
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.GCZM_VENDER_USER SET 	\n");								
				UpdateSql.append( "   REAL_FILE4 = ? 				    	\n");
				UpdateSql.append( "  ,SYS_FILE4  = ? 						\n");
				UpdateSql.append( "  ,REAL_FILE3 = ? 						\n");
				UpdateSql.append( "  ,SYS_FILE3  = ? 						\n");
				UpdateSql.append( "  ,REAL_FILE2 = ? 						\n");
				UpdateSql.append( "  ,SYS_FILE2  = ? 						\n");
				UpdateSql.append( "  ,REAL_FILE1 = ? 						\n");
				UpdateSql.append( "  ,SYS_FILE1  = ? 						\n");
				UpdateSql.append( "  WHERE  VEND_CD = ? 					\n");	
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1, idxREAL_FILE4);
						gsmt.bindColumn(2, idxSYS_FILE4);
						gsmt.bindColumn(3, idxREAL_FILE3);
						gsmt.bindColumn(4, idxSYS_FILE3);
						gsmt.bindColumn(5, idxREAL_FILE2);
						gsmt.bindColumn(6, idxSYS_FILE2);
						gsmt.bindColumn(7, idxREAL_FILE1);
						gsmt.bindColumn(8, idxSYS_FILE1);
						gsmt.bindColumn(9, idxVEND_CD);	

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