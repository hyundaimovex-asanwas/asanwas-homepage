package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p040007_t1 extends HttpServlet{

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

				int idxEMPNO		= userSet.indexOfColumn("EMPNO");		/*사번*/
				int idxAPPDT		= userSet.indexOfColumn("APPDT");		/*년월*/
				int idxPRGTOT		= userSet.indexOfColumn("PRGTOT");	/*충당금연말잔액*/

				//logger.dbg.println(this, "t1 - " + idxEMPNO);
				//logger.dbg.println(this, "t2 - " + idxAPPDT);
				//logger.dbg.println(this, "t3 - " + idxPRGTOT);

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "UPDATE PAYROLL.PRDEVPAY SET " );
				InsertSql.append( "PRGTOT = ? " );
				InsertSql.append( "WHERE EMPNO = ? AND APPDT = ? " );
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.PRDEVPAY SET " );
				UpdateSql.append( " PRGTOT = ? " );
				UpdateSql.append( " WHERE EMPNO = ? AND APPDT = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( " UPDATE PAYROLL.PRDEVPAY SET " );
				DeleteSql.append( " PRGTOT = ? " );
				DeleteSql.append( " WHERE EMPNO = ? AND APPDT = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxPRGTOT);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.bindColumn(3, idxAPPDT);

						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxPRGTOT);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.bindColumn(3, idxAPPDT);

						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxPRGTOT);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.bindColumn(3, idxAPPDT);

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