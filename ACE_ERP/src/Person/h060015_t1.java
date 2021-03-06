package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060015_t1 extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				int idxTOTAVG	= userSet.indexOfColumn("TOTAVG");
				int idxEVAYM	= userSet.indexOfColumn("EVAYM");
				int idxEMPNO	= userSet.indexOfColumn("EMPNO");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.HVEMPS SET " );
				UpdateSql.append( " TOTAVG = ? " );
				UpdateSql.append( " WHERE EVAYM = ? and EMPNO = ?" );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxTOTAVG);
						gsmt.bindColumn(2, idxEVAYM);
						gsmt.bindColumn(3, idxEMPNO);
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