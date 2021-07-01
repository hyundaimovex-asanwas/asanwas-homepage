package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h100011_t2 extends HttpServlet{

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

				int idxAPPYM		= userSet.indexOfColumn("APPYM");
				int idxEMPNO		= userSet.indexOfColumn("EMPNO");
				int idxSUPAMT	= userSet.indexOfColumn("SUPAMT");
				int idxPERAMT	= userSet.indexOfColumn("PERAMT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.PWSURETY ( " );
				InsertSql.append( " APPYM, EMPNO, INSGB, SUPAMT, PERAMT " );
				InsertSql.append( " ) VALUES( " );
				InsertSql.append( " ?, ?, '5',?, ?) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.PWSURETY SET " );
				UpdateSql.append( " APPYM = ?, " );
				UpdateSql.append( " EMPNO = ?, " );
				UpdateSql.append( " SUPAMT = ?, " );
				UpdateSql.append( " PERAMT = ? " );
				UpdateSql.append( " WHERE APPYM = ? " );
				UpdateSql.append( " AND EMPNO = ? " );
 
				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PWSURETY WHERE  APPYM= ? " );
				DeleteSql.append( " AND EMPNO = ? " );

				for (int j = 0; j < rows.length; j++){

				// logger.dbg.println(this, "idxAPPYM	::"+rows[j].getString(idxAPPYM));
				// logger.dbg.println(this, "idxEMPNO	::"+rows[j].getString(idxEMPNO));
				// logger.dbg.println(this, "idxSUPAMT::"+rows[j].getString(idxSUPAMT));
				// logger.dbg.println(this, "idxPERAMT::"+rows[j].getString(idxPERAMT));

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxAPPYM);		
						gsmt.bindColumn(2,  idxEMPNO);		
						gsmt.bindColumn(3,  idxSUPAMT);	
						gsmt.bindColumn(4,  idxPERAMT);	
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxAPPYM);		
						gsmt.bindColumn(2, idxEMPNO);			
						gsmt.bindColumn(3, idxSUPAMT);		
						gsmt.bindColumn(4, idxPERAMT);
						gsmt.bindColumn(5, idxAPPYM);		
						gsmt.bindColumn(6, idxEMPNO);	
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxAPPYM);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				conn.rollback();
			}

      conn.commit();
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