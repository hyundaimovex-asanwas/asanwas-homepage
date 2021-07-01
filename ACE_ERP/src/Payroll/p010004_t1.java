package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p010004_t1 extends HttpServlet{

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

				int idxSTRDT		= userSet.indexOfColumn("STRDT");
				int idxEMPNO		= userSet.indexOfColumn("EMPNO");
				int idxCURYEAR	= userSet.indexOfColumn("CURYEAR");
				int idxUSEYEAR	= userSet.indexOfColumn("USEYEAR");
				int idxPAYYEAR	= userSet.indexOfColumn("PAYYEAR");
				int idxCURMON		= userSet.indexOfColumn("CURMON");
				int idxUSEMON		= userSet.indexOfColumn("USEMON");
				int idxPAYMON		= userSet.indexOfColumn("PAYMON");
				int idxNOTQTY		= userSet.indexOfColumn("NOTQTY");
				int idxRESQTY		= userSet.indexOfColumn("RESQTY");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.PCMONPAY ( " );
				InsertSql.append( "STRDT, EMPNO, CURYEAR,USEYEAR,PAYYEAR, " );
				InsertSql.append( "CURMON,USEMON,PAYMON, NOTQTY, RESQTY " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( "?, ?, ?, ?, ?, " );
				InsertSql.append( "?, ?, ?, ?, ?  ) " );
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.PCMONPAY SET " );
				UpdateSql.append( " CURYEAR = ?, " );
				UpdateSql.append( " USEYEAR = ?, " );
				UpdateSql.append( " PAYYEAR = ?, " );
				UpdateSql.append( " CURMON = ?, " );
				UpdateSql.append( " USEMON = ?, " );
				UpdateSql.append( " PAYMON = ?, " );
				UpdateSql.append( " NOTQTY = ?, " );
				UpdateSql.append( " RESQTY = ? " );
				UpdateSql.append( " WHERE STRDT = ? AND EMPNO = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PCMONPAY WHERE STRDT = ? AND EMPNO = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						//logger.dbg.println(this,InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,	idxSTRDT);
						gsmt.bindColumn(2,	idxEMPNO);
						gsmt.bindColumn(3,	idxCURYEAR);
						gsmt.bindColumn(4,	idxUSEYEAR);
						gsmt.bindColumn(5,	idxPAYYEAR);
						gsmt.bindColumn(6,	idxCURMON);
						gsmt.bindColumn(7,	idxUSEMON);
						gsmt.bindColumn(8,	idxPAYMON);
						gsmt.bindColumn(9,	idxNOTQTY);
						gsmt.bindColumn(10, idxRESQTY);

						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,	idxCURYEAR);
						gsmt.bindColumn(2,	idxUSEYEAR);
						gsmt.bindColumn(3,	idxPAYYEAR);
						gsmt.bindColumn(4,	idxCURMON);
						gsmt.bindColumn(5,	idxUSEMON);
						gsmt.bindColumn(6,	idxPAYMON);
						gsmt.bindColumn(7,	idxNOTQTY);
						gsmt.bindColumn(8,	idxRESQTY);
						gsmt.bindColumn(9,	idxSTRDT);
						gsmt.bindColumn(10, idxEMPNO);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxSTRDT);
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