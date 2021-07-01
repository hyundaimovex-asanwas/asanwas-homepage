package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010002_t3 extends HttpServlet{
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

				String str1 = reqGauce.getParameter("v_str1");
				String str2 = reqGauce.getParameter("v_str2");
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxATCODE   = userSet.indexOfColumn("ATCODE");
				int idxATPRTNAM = userSet.indexOfColumn("ATPRTNAM");
				int idxATUPCODE = userSet.indexOfColumn("ATUPCODE");
				int idxATPRTSEQ = userSet.indexOfColumn("ATPRTSEQ");
			  	int idxATUPCDNM   = userSet.indexOfColumn("ATUPCDNM");
				int idxWRDT = userSet.indexOfColumn("WRDT");
				int idxWRID = userSet.indexOfColumn("WRID");
				int idxUPDT = userSet.indexOfColumn("UPDT");
				int idxUPID = userSet.indexOfColumn("UPID");
				int idxDSUDT = userSet.indexOfColumn("DSUDT");
	
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ACTCODE SET 	\n");
				UpdateSql.append( "        ATPRTSEQ = ?,						\n");
				UpdateSql.append( "        UPDT = '" + str1 + "',					\n");
				UpdateSql.append( "        UPID = '" + str2 +"'					\n");
				UpdateSql.append( " WHERE ATCODE= ?							\n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxATPRTSEQ);
						gsmt.bindColumn(2, idxATCODE);

						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
					
					}
				}
			}
			catch(Exception e){
				logger.err.println(this,e);
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