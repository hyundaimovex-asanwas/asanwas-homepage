package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h040002_t1 extends HttpServlet{

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

				int idxEMPNO		= userSet.indexOfColumn("EMPNO");
				int idxORDDT		= userSet.indexOfColumn("ORDDT");
				int idxSEQ			= userSet.indexOfColumn("SEQ");
				//int idxORDCD		= userSet.indexOfColumn("ORDCD");
				//int idxDEPTCD		= userSet.indexOfColumn("DEPTCD");
				//int idxPAYGRD		= userSet.indexOfColumn("PAYGRD");
				//int idxPAYSEQ		= userSet.indexOfColumn("PAYSEQ");
				//int idxENDDT		= userSet.indexOfColumn("ENDDT");
				//int idxAPPDT		= userSet.indexOfColumn("APPDT");
				//int idxREGDAT		= userSet.indexOfColumn("REGDAT");
				//int idxDEPTGB		= userSet.indexOfColumn("DEPTGB");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer DeleteSql = null;

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HOORDER WHERE EMPNO = ? AND ORDDT = ? AND SEQ = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						      
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxORDDT);
						gsmt.bindColumn(3, idxSEQ);
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