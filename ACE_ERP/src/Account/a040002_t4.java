package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040002_t4 extends HttpServlet{
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
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"CHK","TAXNBR","GUBUN"
				};

				int[] idx = new int[3];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql   = null;
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						UpdateSql = new StringBuffer();
					  
						UpdateSql.append( " UPDATE ACCOUNT.ATTAXMST SET GUBUN = ? ");
						UpdateSql.append( "  WHERE TAXNBR = ? ");
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[2]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.executeUpdate(); 
						gsmt.close();						
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

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