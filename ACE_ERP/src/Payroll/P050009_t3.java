package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class P050009_t3 extends HttpServlet{

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

				int idxSTDYM		= userSet.indexOfColumn("STDYM");
				int idxEMPNO		= userSet.indexOfColumn("EMPNO");
				int idxSTDAMT 	= userSet.indexOfColumn("STDAMT");
				int idxPWPENB1	= userSet.indexOfColumn("PWPENB1");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.PWPENBSW ");
				InsertSql.append( " ( STDYM, EMPNO, STDAMT, PWPENB1 " );
				InsertSql.append( " ) VALUES( " );
				InsertSql.append( " ?, ?, ?, ?) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.PWPENBSW SET " );
				UpdateSql.append( " STDYM = ?, " );
				UpdateSql.append( " EMPNO = ?, " );
				UpdateSql.append( " STDAMT = ?, " );
				UpdateSql.append( " PWPENB1 = ? " );
				UpdateSql.append( " WHERE STDYM = ? " );
				UpdateSql.append( " AND EMPNO = ? " );
 
				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PWPENBSW WHERE  STDYM = ? " );
				DeleteSql.append( " AND EMPNO = ? " );

				for (int j = 0; j < rows.length; j++){

			 //  logger.dbg.println(this, "idxSTDYM	::"+rows[j].getString(idxSTDYM));
			//	 logger.dbg.println(this, "idxEMPNO	::"+rows[j].getString(idxEMPNO));
			//	 logger.dbg.println(this, "idxSTDAMT::"+rows[j].getString(idxSTDAMT));
			//	 logger.dbg.println(this, "idxPWPENB1::"+rows[j].getString(idxPWPENB1));
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxSTDYM);		
						gsmt.bindColumn(2,  idxEMPNO);		
						gsmt.bindColumn(3,  idxSTDAMT);	
						gsmt.bindColumn(4,  idxPWPENB1);	
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxSTDYM);		
						gsmt.bindColumn(2, idxEMPNO);			
						gsmt.bindColumn(3, idxSTDAMT);		
						gsmt.bindColumn(4, idxPWPENB1);	
						gsmt.bindColumn(5, idxSTDYM);
						gsmt.bindColumn(6, idxEMPNO);	
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxSTDYM);
						gsmt.bindColumn(2, idxEMPNO);	
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","?????? ???????? ????????!!(Error Code :"+e.toString()+")");
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