package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p010005_t1 extends HttpServlet{

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

				logger.err.println(this, "test - 1 ");

				int idxAPPYM		= userSet.indexOfColumn("APPYM");
				int idxFRAMT		= userSet.indexOfColumn("FRAMT");
				int idxTOAMT		= userSet.indexOfColumn("TOAMT");
				int idxFAMILY1		= userSet.indexOfColumn("FAMILY1");
				int idxFAMILY2		= userSet.indexOfColumn("FAMILY2");
				int idxFAMILY3		= userSet.indexOfColumn("FAMILY3");
				int idxFAMILY4		= userSet.indexOfColumn("FAMILY4");
				int idxFAMILY5		= userSet.indexOfColumn("FAMILY5");
				int idxFAMILY6		= userSet.indexOfColumn("FAMILY6");
				int idxFAMILY7		= userSet.indexOfColumn("FAMILY7");
				int idxFAMILY8		= userSet.indexOfColumn("FAMILY8");
				int idxFAMILY9		= userSet.indexOfColumn("FAMILY9");
				int idxFAMILY10		= userSet.indexOfColumn("FAMILY10");
				int idxFAMILY11		= userSet.indexOfColumn("FAMILY11");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				logger.err.println(this, "test - 2 ");


				logger.err.println(this, "test - D2 ");
 
				for (int j = 0; j < rows.length; j++) {

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO PAYROLL.PWTAXTBL ( " );
						InsertSql.append( " APPYM, FRAMT, TOAMT, FAMILY1, FAMILY2, ");
						InsertSql.append( " FAMILY3, FAMILY4, FAMILY5, FAMILY6, FAMILY7, ");
						InsertSql.append( " FAMILY8, FAMILY9, FAMILY10, FAMILY11 ");
						InsertSql.append( ") VALUES ( " );
						InsertSql.append( "?, ?, ?, ?, ?,  ?, ?, ?, ?, ? , ?, ?, ?, ? ) " );
  

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						logger.err.println(this,InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxAPPYM	);
						gsmt.bindColumn(2, idxFRAMT	);	
						gsmt.bindColumn(3, idxTOAMT	);
						gsmt.bindColumn(4, idxFAMILY1	);
						gsmt.bindColumn(5, idxFAMILY2	);	
						gsmt.bindColumn(6, idxFAMILY3	);	
						gsmt.bindColumn(7, idxFAMILY4	);	
						gsmt.bindColumn(8, idxFAMILY5	);	
						gsmt.bindColumn(9, idxFAMILY6	);	
						gsmt.bindColumn(10, idxFAMILY7	);	
						gsmt.bindColumn(11, idxFAMILY8	);	
						gsmt.bindColumn(12, idxFAMILY9	);	
						gsmt.bindColumn(13, idxFAMILY10);
						gsmt.bindColumn(14, idxFAMILY11);
						gsmt.executeUpdate();
						gsmt.close();
                        InsertSql = null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {


						UpdateSql = new StringBuffer();
						UpdateSql.append( "UPDATE PAYROLL.PWTAXTBL SET " );
						UpdateSql.append( " FRAMT = ?, " );
						UpdateSql.append( " TOAMT = ?,  " );
						UpdateSql.append( " FAMILY1 = ?,  " );
						UpdateSql.append( " FAMILY2 = ?, " );
						UpdateSql.append( " FAMILY3 = ?,  " );
						UpdateSql.append( " FAMILY4 = ?,  " );
						UpdateSql.append( " FAMILY5 = ?, " );
						UpdateSql.append( " FAMILY6 = ?,  " );
						UpdateSql.append( " FAMILY7 = ?,  " );
						UpdateSql.append( " FAMILY8 = ?, " );
						UpdateSql.append( " FAMILY9 = ?,  " );
						UpdateSql.append( " FAMILY10 = ?,  " );
						UpdateSql.append( " FAMILY11 = ? " );
						UpdateSql.append( " WHERE APPYM = ? " );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						logger.err.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						

						gsmt.bindColumn(1, idxFRAMT	);	
						gsmt.bindColumn(2, idxTOAMT	);
						gsmt.bindColumn(3, idxFAMILY1	);
						gsmt.bindColumn(4, idxFAMILY2	);	
						gsmt.bindColumn(5, idxFAMILY3	);	
						gsmt.bindColumn(6, idxFAMILY4	);	
						gsmt.bindColumn(7, idxFAMILY5	);	
						gsmt.bindColumn(8, idxFAMILY6	);	
						gsmt.bindColumn(9, idxFAMILY7	);	
						gsmt.bindColumn(10, idxFAMILY8	);	
						gsmt.bindColumn(11, idxFAMILY9	);	
						gsmt.bindColumn(12, idxFAMILY10);
						gsmt.bindColumn(13, idxFAMILY11);
						gsmt.bindColumn(14, idxAPPYM	);
						gsmt.executeUpdate(); 
						gsmt.close(); 
						UpdateSql = null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM PAYROLL.PWTAXTBL WHERE APPYM = ? " );
						
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						logger.err.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxAPPYM	);
						gsmt.executeUpdate();
						gsmt.close();
						DeleteSql = null;
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
			logger.err.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}