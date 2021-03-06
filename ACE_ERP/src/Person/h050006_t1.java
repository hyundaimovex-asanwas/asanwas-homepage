package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h050006_t1 extends HttpServlet{

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
				int idxATTDAY		= userSet.indexOfColumn("ATTDAY");
				int idxATTTIME	= userSet.indexOfColumn("ATTTIME");
				int idxCLODAY		= userSet.indexOfColumn("CLODAY");
				int idxCLOTIME	= userSet.indexOfColumn("CLOTIME");
				int idxDEPTCD		= userSet.indexOfColumn("DEPTCD");
				int idxETC			= userSet.indexOfColumn("ETC");		//OVERWK->ETC
				int idxETC2			= userSet.indexOfColumn("ETC2");	


				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.HLATTEND ( " );
				InsertSql.append( "EMPNO, ATTDAY, ATTTIME, CLODAY, CLOTIME, DEPTCD, ETC " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( "?, ?, ?, ?, ?, ?, ? ) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.HLATTEND SET " );
        UpdateSql.append( " ATTTIME = ?, " );
				UpdateSql.append( " CLODAY = ?, " );
				UpdateSql.append( " CLOTIME = ?, " );
				UpdateSql.append( " DEPTCD = ?, " );
				UpdateSql.append( " ETC = ? " );
				UpdateSql.append( " WHERE EMPNO = ? AND ATTDAY = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HLATTEND WHERE EMPNO = ? AND ATTDAY = ? AND ATTTIME = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxATTDAY);
						gsmt.bindColumn(3, idxATTTIME);
						gsmt.bindColumn(4, idxCLODAY);
						gsmt.bindColumn(5, idxCLOTIME);
						gsmt.bindColumn(6, idxDEPTCD);
						gsmt.bindColumn(7, idxETC2);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxATTTIME);
						gsmt.bindColumn(2, idxCLODAY);
						gsmt.bindColumn(3, idxCLOTIME);
						gsmt.bindColumn(4, idxDEPTCD);
						gsmt.bindColumn(5, idxETC2);
						gsmt.bindColumn(6, idxEMPNO);
						gsmt.bindColumn(7, idxATTDAY);
						//gsmt.bindColumn(7, idxATTTIME);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxATTDAY);
						gsmt.bindColumn(3, idxATTTIME);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","?????? ???????? ????????!!(Error Code :"+e.toString()+")");
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