package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h100001_t1 extends HttpServlet{

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

				int idxPAYDIV		= userSet.indexOfColumn("PAYDIV");
				int idxPBDIV		= userSet.indexOfColumn("PBDIV");
				int idxPAYCD		= userSet.indexOfColumn("PAYCD");
				int idxPAYCDNM	= userSet.indexOfColumn("PAYCDNM");
				int idxCALDIV		= userSet.indexOfColumn("CALDIV");
				//int idxRATEAMT	= userSet.indexOfColumn("RATEAMT");
				int idxPGMID		= userSet.indexOfColumn("PGMID");
				int idxAUTOYN		= userSet.indexOfColumn("AUTOYN");
				int idxTAX		= userSet.indexOfColumn("TAX");
				int idxFRDT			= userSet.indexOfColumn("FRDT");
				int idxTODT			= userSet.indexOfColumn("TODT");
				int idxMEMO			= userSet.indexOfColumn("MEMO");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.PCPAYCD ( " );
				InsertSql.append( "PAYDIV,PBDIV,	PAYCD,	PAYCDNM,CALDIV, " );
				InsertSql.append( "PGMID,	AUTOYN,	TAX,	FRDT,		TODT,		MEMO " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( "?, ?, ?, ?, ?, " );
				InsertSql.append( "?, ?, ?, ?, ?, ? ) " );
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.PCPAYCD SET " );
				UpdateSql.append( " PAYCDNM = ?, " );
				UpdateSql.append( " CALDIV = ?, " );
				UpdateSql.append( " PGMID = ?, " );
				UpdateSql.append( " AUTOYN = ?, " );
				UpdateSql.append( " TAX = ?, " );
				UpdateSql.append( " FRDT = ?, " );
				UpdateSql.append( " TODT = ?, " );
				UpdateSql.append( " MEMO = ? " );
				UpdateSql.append( " WHERE PAYDIV = ? AND PBDIV = ? AND PAYCD = ?" );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PCPAYCD WHERE PAYDIV = ? AND PBDIV = ? AND PAYCD = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						//logger.dbg.println(this,InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxPAYDIV);
						gsmt.bindColumn(2, idxPBDIV);
						gsmt.bindColumn(3, idxPAYCD);
						gsmt.bindColumn(4, idxPAYCDNM);
						gsmt.bindColumn(5, idxCALDIV);
						gsmt.bindColumn(6, idxPGMID);
						gsmt.bindColumn(7, idxAUTOYN);
						gsmt.bindColumn(8, idxTAX);
						gsmt.bindColumn(9, idxFRDT);
						gsmt.bindColumn(10, idxTODT);
						gsmt.bindColumn(11, idxMEMO);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxPAYCDNM);
						gsmt.bindColumn(2, idxCALDIV);
						gsmt.bindColumn(3, idxPGMID);
						gsmt.bindColumn(4, idxAUTOYN);
						gsmt.bindColumn(5, idxTAX);
						gsmt.bindColumn(6, idxFRDT);
						gsmt.bindColumn(7, idxTODT);
						gsmt.bindColumn(8, idxMEMO);
						gsmt.bindColumn(9, idxPAYDIV);
						gsmt.bindColumn(10, idxPBDIV);
						gsmt.bindColumn(11, idxPAYCD);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxPAYDIV);
						gsmt.bindColumn(2, idxPBDIV);
						gsmt.bindColumn(3, idxPAYCD);
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