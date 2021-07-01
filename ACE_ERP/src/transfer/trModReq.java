package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trModReq extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");

				int idxMODIFY_NO		= userSet.indexOfColumn("MODIFY_NO");
				int idxORDER_NO			= userSet.indexOfColumn("ORDER_NO");
				int idxIN_OUT				= userSet.indexOfColumn("IN_OUT");
				int idxETD_DT				= userSet.indexOfColumn("ETD_DT");
				int idxLINE_PART		= userSet.indexOfColumn("LINE_PART");
				int idxMOD_STS			= userSet.indexOfColumn("MOD_STS");
				int idxREQ_USER			= userSet.indexOfColumn("REQ_USER");
				int idxAPP_USER			= userSet.indexOfColumn("APP_USER");
				int idxMOD_REMARK		= userSet.indexOfColumn("MOD_REMARK");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT ) {

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO TRANSFER.LTMODREQ \n" )
										 .append( " ( \n")
										 .append( "			MODIFY_NO, ORDER_NO, IN_OUT, ETD_DT, LINE_PART, \n")
										 .append( "			MOD_STS, REQ_DATE, REQ_USER, MOD_REMARK \n")
										 .append( " ) VALUES ( \n")
										 .append( "     '" + rows[j].getString(idxMODIFY_NO) + "','" + rows[j].getString(idxORDER_NO) + "','" + rows[j].getString(idxIN_OUT) + "','" + rows[j].getString(idxETD_DT) + "','" + rows[j].getString(idxLINE_PART) + "', \n")
										 .append( "     '" + rows[j].getString(idxMOD_STS) + "', CURRENT TIMESTAMP,'" + rows[j].getString(idxREQ_USER) + "','" + rows[j].getString(idxMOD_REMARK) + "' \n")
										 .append( " ) ");

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE ) {

						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE TRANSFER.LTMODREQ \n" )
										 .append( "		 SET MOD_STS = '" + rows[j].getString(idxMOD_STS) + "', \n")
										 .append( "				 APP_USER = '" + rows[j].getString(idxAPP_USER) + "', \n")
										 .append( "				 APP_DATE = CURRENT TIMESTAMP \n")
										 .append( "  WHERE MODIFY_NO = ? ");

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxMODIFY_NO ); 
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM TRANSFER.LTMODREQ WHERE MODIFY_NO = ? " );

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxMODIFY_NO ); 
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