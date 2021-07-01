package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h010001_t1 extends HttpServlet{

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
				int idxMAJORCD	= userSet.indexOfColumn("MAJORCD");
				int idxMINORCD	= userSet.indexOfColumn("MINORCD");
				int idxMINORNM	= userSet.indexOfColumn("MINORNM");
				int idxSEQ		= userSet.indexOfColumn("SEQ");
				int idxUSEYN	= userSet.indexOfColumn("USEYN");
				int idxMEMO		= userSet.indexOfColumn("MEMO");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.HCLCODE ( " );
				InsertSql.append( "MAJORCD,MINORCD,MINORNM,SEQ,USEYN,MEMO " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( "?, ?, ?, ?, ?, ? ) " );
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.HCLCODE SET " );
				UpdateSql.append( " MINORNM = ?, " );
				UpdateSql.append( " SEQ = ?, " );
				UpdateSql.append( " USEYN = ?, " );
				UpdateSql.append( " MEMO = ? " );
				UpdateSql.append( " WHERE MAJORCD = ? and MINORCD = ?" );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HCLCODE WHERE MAJORCD = ? AND MINORCD = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						//logger.dbg.println(this,InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxMAJORCD);
						gsmt.bindColumn(2, idxMINORCD);
						gsmt.bindColumn(3, idxMINORNM);
						gsmt.bindColumn(4, idxSEQ);
						gsmt.bindColumn(5, idxUSEYN);
						gsmt.bindColumn(6, idxMEMO);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxMINORNM);
						gsmt.bindColumn(2, idxSEQ);
						gsmt.bindColumn(3, idxUSEYN);
						gsmt.bindColumn(4, idxMEMO);
						gsmt.bindColumn(5, idxMAJORCD);
						gsmt.bindColumn(6, idxMINORCD);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxMAJORCD);
						gsmt.bindColumn(2, idxMINORCD);
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