package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060002_t1 extends HttpServlet{

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
				int idxEMPNMK            = userSet.indexOfColumn("EMPNMK");
				int idxDEPTCD           = userSet.indexOfColumn("DEPTCD");
				int idxDEPTNM           = userSet.indexOfColumn("DEPTNM");
				int idxPAYGRD           = userSet.indexOfColumn("PAYGRD");
				int idxGRDNM           = userSet.indexOfColumn("GRDNM");
				int idxGRSTRTDT       = userSet.indexOfColumn("GRSTRTDT");
				int idxLRMDT             = userSet.indexOfColumn("LRMDT");
				int idxWRDT              = userSet.indexOfColumn("WRDT");
				int idxTOTAVG           = userSet.indexOfColumn("TOTAVG");
				int idxSCR1               = userSet.indexOfColumn("SCR1");
				int idxAVG1               = userSet.indexOfColumn("AVG1");
				int idxSCR2               = userSet.indexOfColumn("SCR2");
				int idxAVG2               = userSet.indexOfColumn("AVG2");
				int idxSCR3               = userSet.indexOfColumn("SCR3");
				int idxAVG3               = userSet.indexOfColumn("AVG3");
				int idxSCR4               = userSet.indexOfColumn("SCR4");
				int idxAVG4               = userSet.indexOfColumn("AVG4");


				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer DeleteSql = null;
			
				DeleteSql = new StringBuffer();
				DeleteSql.append( "delete from  PAYROLL.HVEMP " );
				DeleteSql.append( "  where  EVAYM = ?  " );
				DeleteSql.append( "      and  EMPNO = ?  " );
                
            /*    DeleteSql.append( "where EVAYM = " );  */

				for (int j = 0; j < rows.length; j++){
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEVAYM);
						gsmt.bindColumn(2, idxEMPNO);
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