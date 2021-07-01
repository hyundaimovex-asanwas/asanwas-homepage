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

				int idxEVAYM			= userSet.indexOfColumn("EVAYM");
				int idxEMPNO			= userSet.indexOfColumn("EMPNO");
				int idxEMPNMK			= userSet.indexOfColumn("EMPNMK");
				int idxDEPTCD			= userSet.indexOfColumn("DEPTCD");
				int idxDEPTNM			= userSet.indexOfColumn("DEPTNM");
				int idxPAYGRD			= userSet.indexOfColumn("PAYGRD");
				int idxGRDNM			= userSet.indexOfColumn("GRDNM");
				int idxGRSTRTDT		= userSet.indexOfColumn("GRSTRTDT");
				int idxSTRTDT			= userSet.indexOfColumn("STRTDT");
				int idxWRDT				= userSet.indexOfColumn("WRDT");
				int idxTOTAVG			= userSet.indexOfColumn("TOTAVG");
				int idxSCR1				= userSet.indexOfColumn("SCR1");
				int idxAVG1				= userSet.indexOfColumn("AVG1");
				int idxSCR2				= userSet.indexOfColumn("SCR2");
				int idxAVG2				= userSet.indexOfColumn("AVG2");
				int idxSCR3				= userSet.indexOfColumn("SCR3");
				int idxAVG3				= userSet.indexOfColumn("AVG3");
				int idxSCR4				= userSet.indexOfColumn("SCR4");
				int idxAVG4				= userSet.indexOfColumn("AVG4");
				int idxLAMDT			= userSet.indexOfColumn("LAMDT");
				int idxRECDIV			= userSet.indexOfColumn("RECDIV");
				int idxJOBKIND		= userSet.indexOfColumn("JOBKIND");
				int idxJOBREF     = userSet.indexOfColumn("JOBREF");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer DeleteSql2 = null;
				StringBuffer DeleteSql3 = null;

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.HVEMP SET " );
				UpdateSql.append( " JOBREF    = ? " );
				UpdateSql.append( " WHERE EVAYM = ? AND EMPNO = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HVEMP WHERE EVAYM = ? AND EMPNO = ? " );

				DeleteSql2 = new StringBuffer();
				DeleteSql2.append( "DELETE FROM PAYROLL.HVHEMP WHERE EVAYM = ? AND EMPNO = ? " );

				DeleteSql3 = new StringBuffer();
				DeleteSql3.append( "DELETE FROM PAYROLL.HVSCORE WHERE EVAYM = ? AND EMPNO = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxJOBREF);
						gsmt.bindColumn(2, idxEVAYM);
						gsmt.bindColumn(3, idxEMPNO);
						gsmt.executeUpdate(); 
						gsmt.close();         
					} 
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEVAYM);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.executeUpdate();
						gsmt.close();

						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.bindColumn(1, idxEVAYM);
						gsmt2.bindColumn(2, idxEMPNO);
						gsmt2.executeUpdate();
						gsmt2.close();

						GauceStatement gsmt3 = conn.getGauceStatement(DeleteSql3.toString());
						gsmt3.setGauceDataRow(rows[j]);
						gsmt3.bindColumn(1, idxEVAYM);
						gsmt3.bindColumn(2, idxEMPNO);
						gsmt3.executeUpdate();
						gsmt3.close();
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