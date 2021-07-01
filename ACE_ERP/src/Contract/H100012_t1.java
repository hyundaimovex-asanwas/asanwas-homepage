package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class H100012_t1 extends HttpServlet{

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
				String strCnt ="0";


				/**����**/

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxPAYSEQ		= userSet.indexOfColumn("PAYSEQ");
				int idxGRDDIV		= userSet.indexOfColumn("GRDDIV");
				int idxEMPNO		= userSet.indexOfColumn("EMPNO");


				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;		

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.T_HIPERSON SET " );
        UpdateSql.append( " PAYSEQ = ?, " );
        UpdateSql.append( " GRDDIV = ? " );
				UpdateSql.append( " WHERE EMPNO =?" );
		

				for (int j = 0; j < rows.length; j++){

				if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxPAYSEQ);	
						gsmt.bindColumn(2, idxGRDDIV);						
						gsmt.bindColumn(3, idxEMPNO);			

						gsmt.executeUpdate(); 
						gsmt.close();
					}

				}
			}

			catch(Exception e){
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