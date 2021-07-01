package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00101_t1_d extends HttpServlet{

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

			  logger.dbg.println(this,"orderno:::::start");

				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");

        logger.dbg.println(this,"orderno4444:::::start");
				int idxORDER_NO	= userSet.indexOfColumn("ORDER_NO");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){

					logger.dbg.println(this,"idxORDER_NO::" + rows[j].getString(idxORDER_NO));

					//if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT ) {

						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM TRANSFER.LTORDERMST WHERE ORDER_NO = ? " );

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxORDER_NO);
						gsmt.executeUpdate();
						gsmt = null;
						DeleteSql = null;

						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM TRANSFER.LTORDERDTL WHERE ORDER_NO = ? " );

						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxORDER_NO);
						gsmt.executeUpdate();
						gsmt = null;
						DeleteSql = null;

						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM TRANSFER.LTCARGOODS WHERE ORDER_NO = ? " );

						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxORDER_NO);
						gsmt.executeUpdate();
						gsmt = null;
						DeleteSql = null;

						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM TRANSFER.LTORDCAR WHERE ORDER_NO = ? " );

						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxORDER_NO);
						gsmt.executeUpdate();
						gsmt.close();

					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
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