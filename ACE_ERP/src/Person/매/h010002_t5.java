package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h010002_t5 extends HttpServlet{

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

				String str1 = req.getParameter("v_str1");	//휴일 년도

				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxHOLDT		= userSet.indexOfColumn("HOLDT");	
				int idxWHATDAY	= userSet.indexOfColumn("WHATDAY");
				int idxHOLNM		= userSet.indexOfColumn("HOLNM");
				int idxHOLDIV		= userSet.indexOfColumn("HOLDIV");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.hcholday ( " );
				InsertSql.append( "HOLDT,WHATDAY,HOLNM,HOLDIV " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( " ?, ?, ?, ? ) " );
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.hcholday SET " );  
				UpdateSql.append( " WHATDAY	= ?, " );
				UpdateSql.append( " HOLNM	= ?, " );
				UpdateSql.append( " HOLDIV	= ?  " );
				UpdateSql.append( " WHERE HOLDT	= ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.hcholday WHERE HOLDT LIKE '"+str1+"%'" );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						logger.dbg.println(this,InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxHOLDT);    	
						gsmt.bindColumn(2, idxWHATDAY);	   	
						gsmt.bindColumn(3, idxHOLNM);	   	
						gsmt.bindColumn(4, idxHOLDIV);		
						
						gsmt.executeUpdate();
						gsmt.close(); 
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxWHATDAY);
						gsmt.bindColumn(2, idxHOLNM);
						gsmt.bindColumn(3, idxHOLDIV);
						gsmt.bindColumn(4, idxHOLDT);

						gsmt.executeUpdate(); 
						gsmt.close();         
						UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						//gsmt.bindColumn(1, idxHOLDT);
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