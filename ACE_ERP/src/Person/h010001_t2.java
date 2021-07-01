package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h010001_t2 extends HttpServlet{

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
				int idxMAJORNM	= userSet.indexOfColumn("MAJORNM");
				int idxUSEYN	= userSet.indexOfColumn("USEYN");
				int idxMEMO		= userSet.indexOfColumn("MEMO");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer DeleteSql2 = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.HCHCODE ( " );
				InsertSql.append( "MAJORCD,MAJORNM,USEYN,MEMO " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( "?, ?, ?, ? ) " );
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.HCHCODE SET " );
				UpdateSql.append( " MAJORNM = ?, " );
				UpdateSql.append( " USEYN = ?, " );
				UpdateSql.append( " MEMO = ? " );
				UpdateSql.append( " WHERE MAJORCD = ? " );
				

				DeleteSql = new StringBuffer();
				DeleteSql2 = new StringBuffer();
				
				DeleteSql.append( " DELETE FROM PAYROLL.HCHCODE WHERE MAJORCD = ? " );
				DeleteSql2.append( " DELETE FROM PAYROLL.HCLCODE WHERE MAJORCD = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxMAJORCD);
						gsmt.bindColumn(2, idxMAJORNM);
						gsmt.bindColumn(3, idxUSEYN);
						gsmt.bindColumn(4, idxMEMO);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxMAJORNM);
						gsmt.bindColumn(2, idxUSEYN);
						gsmt.bindColumn(3, idxMEMO);
						gsmt.bindColumn(4, idxMAJORCD);
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxMAJORCD);
						gsmt.executeUpdate();
						gsmt.close();

						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.bindColumn(1, idxMAJORCD);
						gsmt2.executeUpdate();
						gsmt2.close();

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