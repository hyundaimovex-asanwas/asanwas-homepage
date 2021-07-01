package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050001_t3 extends HttpServlet{

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

				int idxAPPYM	= userSet.indexOfColumn("APPYM");
				int idxINSGB	= userSet.indexOfColumn("INSGB");
				int idxINSRATE1	= userSet.indexOfColumn("INSRATE1");
				int idxINSRATE2	= userSet.indexOfColumn("INSRATE2");


				GauceDataRow[] rows = userSet.getDataRows();

				/*Statement stmt2 = conn.createStatement();
				String sql2 = " SELECT MAX(ZIPSEQ) + 1 ZIPSEQ FROM PAYROLL.HCPOSTNO ";
				ResultSet rs2 = stmt2.executeQuery(sql2);

				int dbl_zipseq = 0;
				if(rs2.next()){ 
					dbl_zipseq = rs2.getInt(1);
				}*/

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;




				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO PAYROLL.PWRATE ( " );
						InsertSql.append( "APPYM,INSGB,INSRATE1,INSRATE2 " );
						InsertSql.append( ") VALUES( " );
						InsertSql.append( " ?, ?, ?, ?) " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxAPPYM);	   	
						gsmt.bindColumn(2, idxINSGB);	   		
						gsmt.bindColumn(3, idxINSRATE1);		   	
						gsmt.bindColumn(4, idxINSRATE2);	   		
						
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( "UPDATE PAYROLL.PWRATE SET " );  
						UpdateSql.append( " INSRATE1	= ?, " );
						UpdateSql.append( " INSRATE2	= ? " );
						UpdateSql.append( " WHERE APPYM = ? " );
						UpdateSql.append( " AND INSGB = ? " );
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxINSRATE1);
						gsmt.bindColumn(2, idxINSRATE2);
						gsmt.bindColumn(3, idxAPPYM);
						gsmt.bindColumn(4, idxINSGB);
	
						gsmt.executeUpdate(); 
						gsmt.close(); 
						UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM PAYROLL.PWRATE WHERE APPYM = ? AND INSGB	= ? " );

						logger.dbg.println(this,"DeleteSql :"+ DeleteSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxAPPYM);
						gsmt.bindColumn(2, idxINSGB);
						gsmt.executeUpdate();
						gsmt.close();
						DeleteSql=null;
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