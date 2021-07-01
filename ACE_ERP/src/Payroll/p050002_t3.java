package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050002_t3 extends HttpServlet{

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
				Statement stmt2 = conn.createStatement();
				ResultSet rs2 = null;

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
        
				int idxAPPYM	= userSet.indexOfColumn("APPYM");
				int idxEMPNO	= userSet.indexOfColumn("EMPNO");
				int idxSTDAMT	= userSet.indexOfColumn("STDAMT");
				int idxINSAMT	= userSet.indexOfColumn("INSAMT");
				int idxMEDSNO	= userSet.indexOfColumn("MEDSNO");
				int idxREMARK	= userSet.indexOfColumn("REMARK");
			
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.PWINDIPN ( " );
				InsertSql.append( "  APPYM,EMPNO,STDAMT,INSAMT,MEDSNO,REMARK " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( " ?, ?, ?, ?, ?, ? ) " );
        
				/*
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.PWINDIPN SET  " );  
				UpdateSql.append( " INSAMT	= ?, " );
				UpdateSql.append( " REMARK	= ?  " );
				UpdateSql.append( " WHERE APPYM = ? " );
				UpdateSql.append( " AND EMPNO = ? " );
				*/

				//DeleteSql = new StringBuffer();
				//DeleteSql.append( "DELETE FROM PAYROLL.PWINDIPN_Y WHERE EMPNO = ? AND APPYM	= ? " );

				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxAPPYM);	   	
						gsmt.bindColumn(2, idxEMPNO);	   		
						gsmt.bindColumn(3, idxSTDAMT);	   		
						gsmt.bindColumn(4, idxINSAMT);	   		
						gsmt.bindColumn(5, idxMEDSNO);
						gsmt.bindColumn(6, idxREMARK);		   	
					
						gsmt.executeUpdate();
						gsmt.close();
					}

					/*

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxINSAMT);
						gsmt.bindColumn(2, idxREMARK);
						gsmt.bindColumn(3, idxAPPYM);
						gsmt.bindColumn(4, idxEMPNO);

						gsmt.executeUpdate(); 
						gsmt.close(); 

					} 
					*/
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxAPPYM);
						gsmt.executeUpdate();
						gsmt.close();
						//DeleteSql=null;
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