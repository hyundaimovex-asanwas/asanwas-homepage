package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h090001_t1 extends HttpServlet{

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
				int idxOVERWK		= userSet.indexOfColumn("OVERWK");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.T_HLATTEND ( " );
				InsertSql.append( "EMPNO, ATTDAY, ATTTIME, CLODAY, CLOTIME, DEPTCD, OVERWK " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( "?, ?, ?, ?, ?, ?, ? ) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.T_HLATTEND SET " );
				UpdateSql.append( " CLODAY = ?, " );
				UpdateSql.append( " CLOTIME = ?, " );
				UpdateSql.append( " DEPTCD = ?, " );
				UpdateSql.append( " OVERWK = ? " );
				UpdateSql.append( " WHERE EMPNO = ? AND ATTDAY = ? AND ATTTIME = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.T_HLATTEND WHERE EMPNO = ? AND ATTDAY = ? AND ATTTIME = ? " );

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
						gsmt.bindColumn(7, idxOVERWK);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxCLODAY);
						gsmt.bindColumn(2, idxCLOTIME);
						gsmt.bindColumn(3, idxDEPTCD);
						gsmt.bindColumn(4, idxOVERWK);
						gsmt.bindColumn(5, idxEMPNO);
						gsmt.bindColumn(6, idxATTDAY);
						gsmt.bindColumn(7, idxATTTIME);
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