package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class P010008_t1 extends HttpServlet{

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

				int idxPAYSEQ		= userSet.indexOfColumn("PAYSEQ");
				int idxEMPNO		= userSet.indexOfColumn("EMPNO");


				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;		

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.HIPERSON SET PAYSEQ = ?" );
				UpdateSql.append( "  WHERE EMPNO =?" );
		

				for (int j = 0; j < rows.length; j++){

    /*    UpdateSql.append( "UPDATE PAYROLL.YCPAYCOL SET " );
				UpdateSql.append( " SENDFLAG ='"+rows[j].getString(idxSENDFLAG)+"', " );
				UpdateSql.append( " WHERE EMPNO = '"+rows[j].getString(idxEMPNO)+"'  " );
				UpdateSql.append( " AND APPDT = '"+rows[j].getString(idxAPPDT)+"'  " ); 
*/
				if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

  /*      UpdateSql.append( "UPDATE PAYROLL.YCPAYCOL SET " );
				UpdateSql.append( " SENDFLAG ='"+rows[j].getString(idxSENDFLAG)+"', " );
				UpdateSql.append( " WHERE EMPNO = '"+rows[j].getString(idxEMPNO)+"'  " );
				UpdateSql.append( " AND APPDT = '"+rows[j].getString(idxAPPDT)+"'  " ); 
*/
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxPAYSEQ);		
						gsmt.bindColumn(2, idxEMPNO);			

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