package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h010002_t1 extends HttpServlet{

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

				int idxZIPSEQ	= userSet.indexOfColumn("ZIPSEQ");
				int idxZIPCD	= userSet.indexOfColumn("ZIPCD");
				int idxSIDO		= userSet.indexOfColumn("SIDO");
				int idxGUGUN	= userSet.indexOfColumn("GUGUN");
				int idxDONG		= userSet.indexOfColumn("DONG");
				int idxBUNJI	= userSet.indexOfColumn("BUNJI");

				GauceDataRow[] rows = userSet.getDataRows();

				Statement stmt2 = conn.createStatement();
				String sql2 = " SELECT MAX(ZIPSEQ) + 1 ZIPSEQ FROM PAYROLL.HCPOSTNO ";
				ResultSet rs2 = stmt2.executeQuery(sql2);

				int dbl_zipseq = 0;
				if(rs2.next()){ 
					dbl_zipseq = rs2.getInt(1);
				}

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.HCPOSTNO SET " );  
				UpdateSql.append( " ZIPCD	= ?, " );
				UpdateSql.append( " SIDO	= ?, " );
				UpdateSql.append( " GUGUN	= ?, " );
				UpdateSql.append( " DONG	= ?, " );
				UpdateSql.append( " BUNJI	= ?  " );
				UpdateSql.append( " WHERE ZIPSEQ = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HCPOSTNO WHERE ZIPSEQ = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						InsertSql.append( "INSERT INTO PAYROLL.HCPOSTNO ( " );
						InsertSql.append( "ZIPSEQ,ZIPCD,SIDO,GUGUN,DONG,BUNJI " );
						InsertSql.append( ") VALUES( " );
						InsertSql.append( "" + dbl_zipseq + ", ?, ?, ?, ?, ? ) " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						//logger.dbg.println(this, InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxZIPCD);	   	
						gsmt.bindColumn(2, idxSIDO);	   		
						gsmt.bindColumn(3, idxGUGUN);		   	
						gsmt.bindColumn(4, idxDONG);	   		
						gsmt.bindColumn(5, idxBUNJI);
						
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxZIPCD);
						gsmt.bindColumn(2, idxSIDO);
						gsmt.bindColumn(3, idxGUGUN);
						gsmt.bindColumn(4, idxDONG);
						gsmt.bindColumn(5, idxBUNJI);
						gsmt.bindColumn(6, idxZIPSEQ);

						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxZIPSEQ);
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