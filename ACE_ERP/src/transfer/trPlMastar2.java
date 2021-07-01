package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trPlMastar2 extends HttpServlet{

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
				
				int idxPL_NO		= userSet.indexOfColumn("PL_NO");
				int idxDCL_DATE = userSet.indexOfColumn("DCL_DATE");
				int idxDCL_NO   = userSet.indexOfColumn("DCL_NO");
	
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;

				for (int j = 0; j < rows.length; j++){
					UpdateSql = null;

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) { 
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTPCKLSCI SET \n")
										 .append("		DCL_NO = ?, DCL_DATE = ? \n")
										 .append(" WHERE PL_NO = ? ");
						
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]); 
					
						gsmt.bindColumn(1,idxDCL_NO);
						gsmt.bindColumn(2,idxDCL_DATE);
						gsmt.bindColumn(3,idxPL_NO);

						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

					}
				}
			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.err.println(this,se.toString());
				//logger.err.println(this,se);
				//logger.err.println(this,se.toString());
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			//logger.err.println(this,e);
			//logger.err.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}