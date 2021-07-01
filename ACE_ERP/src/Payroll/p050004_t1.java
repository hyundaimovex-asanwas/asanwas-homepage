package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050004_t1 extends HttpServlet{

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

				int idxEMPNO	= userSet.indexOfColumn("EMPNO");
				int idxAPPYM	= userSet.indexOfColumn("APPYM");
				int idxRESINO	= userSet.indexOfColumn("RESINO");
				int idxSCHYEAR	= userSet.indexOfColumn("SCHYEAR");
				int idxSCHNM	= userSet.indexOfColumn("SCHNM");

				int idxAPPDT	= userSet.indexOfColumn("APPDT");
				int idxAPPAMT	= userSet.indexOfColumn("APPAMT");
				int idxREQREM	= userSet.indexOfColumn("REQREM");
				int idxPAYAMT	= userSet.indexOfColumn("PAYAMT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO PAYROLL.PWSCHREQ ( " );
						InsertSql.append( "EMPNO,APPYM,RESINO,SCHYEAR,SCHNM, APPDT,APPAMT,REQREM,PAYAMT " );
						InsertSql.append( ") VALUES( " );
						InsertSql.append( " ?,?,?,?,?, ?,?,?,? ) " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxEMPNO);	   	
						gsmt.bindColumn(2, idxAPPYM);	   		
						gsmt.bindColumn(3, idxRESINO);	   		
						gsmt.bindColumn(4, idxSCHYEAR);	   		
						gsmt.bindColumn(5, idxSCHNM);
						gsmt.bindColumn(6, idxAPPDT);		   	
						gsmt.bindColumn(7, idxAPPAMT);	   		
						gsmt.bindColumn(8, idxREQREM);
						gsmt.bindColumn(9, idxPAYAMT);	   		
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( "UPDATE PAYROLL.PWSCHREQ SET  " );  
						UpdateSql.append( " SCHYEAR	= ?, " );
						UpdateSql.append( " SCHNM	= ?, " );
						UpdateSql.append( " APPYM	= ?, " );
						UpdateSql.append( " APPAMT	= ?, " );
						UpdateSql.append( " REQREM	= ?, " );
						UpdateSql.append( " PAYAMT	= ?  " );
						UpdateSql.append( "  WHERE EMPNO = ? " );
						UpdateSql.append( " AND APPDT = ? " );
						UpdateSql.append( " AND RESINO = ? " );
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxSCHYEAR);
						gsmt.bindColumn(2, idxSCHNM);
						gsmt.bindColumn(3, idxAPPYM);
						gsmt.bindColumn(4, idxAPPAMT);
						gsmt.bindColumn(5, idxREQREM);
						gsmt.bindColumn(6, idxPAYAMT);
						gsmt.bindColumn(7, idxEMPNO);
						gsmt.bindColumn(8, idxAPPDT);
						gsmt.bindColumn(9, idxRESINO);

						gsmt.executeUpdate(); 
						gsmt.close(); 
						UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM PAYROLL.PWSCHREQ WHERE EMPNO = ? AND  APPDT	= ? AND RESINO	= ? " );

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxAPPDT);
						gsmt.bindColumn(3, idxRESINO);
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