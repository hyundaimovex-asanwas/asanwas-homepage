package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060002_t2 extends HttpServlet{

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

				int idxEVAYM             = userSet.indexOfColumn("EVAYM");
				int idxEMPNO             = userSet.indexOfColumn("EMPNO");
				int idxDEPTCD           = userSet.indexOfColumn("DEPTCD ");
				int idxPAYGRD           = userSet.indexOfColumn("PAYGRD");
				int idxGRSTRTDT       = userSet.indexOfColumn("GRSTRTDT");
				int idxLRMDT             = userSet.indexOfColumn("LRMDT");
				int idxWRDT              = userSet.indexOfColumn("WRDT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "insert into PAYROLL.HVEMP( EVAYM,	  EMPNO, DEPTCD,	PAYGRD,	GRSTRTDT," );
				InsertSql.append( "                                          LRMDT, WRDT )");
				InsertSql.append( "                                 values  (?,?,?,?,?,?,?)" );

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						String [] test = new String[7];

						test[0] = rows[j].getString(idxEVAYM);
						test[1] = rows[j].getString(idxEMPNO);
						test[2] = rows[j].getString(idxDEPTCD);
						test[3] = rows[j].getString(idxPAYGRD);
						test[4] = rows[j].getString(idxGRSTRTDT);
						test[5] = rows[j].getString(idxLRMDT);
						test[6] = rows[j].getString(idxWRDT);

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