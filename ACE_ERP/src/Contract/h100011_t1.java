package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h100011_t1 extends HttpServlet{

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
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxSTDYM		= userSet.indexOfColumn("STDYM");
				int idxEMPNO		= userSet.indexOfColumn("EMPNO");
				int idxSTDAMT	= userSet.indexOfColumn("STDAMT");
				int idxINSAMT1	= userSet.indexOfColumn("INSAMT1");
	

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.PWINSBSW ( " );
				InsertSql.append( " STDYM, EMPNO, STDAMT, INSAMT1 " );
				InsertSql.append( " ) VALUES( " );
				InsertSql.append( " ?, ?, ?, ?) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.PWINSBSW SET " );
				UpdateSql.append( " STDYM = ?, " );
				UpdateSql.append( " EMPNO = ?, " );
				UpdateSql.append( " STDAMT = ?, " );
				UpdateSql.append( " INSAMT1 = ? " );
				UpdateSql.append( " WHERE STDYM = ? " );
				UpdateSql.append( " AND EMPNO = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PWINSBSW ");
				DeleteSql.append( "WHERE STDYM = ? " );	
				DeleteSql.append( "AND EMPNO = ? " );

				for (int j = 0; j < rows.length; j++){

		/*		 logger.dbg.println(this, "idxSTDYM	::"+rows[j].getString(idxSTDYM));
				 logger.dbg.println(this, "idxEMPNO	::"+rows[j].getString(idxEMPNO));
				 logger.dbg.println(this, "idxSTDAMT::"+rows[j].getString(idxSTDAMT));
				 logger.dbg.println(this, "idxINSAMT1::"+rows[j].getString(idxINSAMT1));
				 logger.dbg.println(this, "idxSTDYM	::"+rows[j].getString(idxSTDYM));
  			  logger.dbg.println(this, "idxEMPNO	::"+rows[j].getString(idxEMPNO)); */


					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxSTDYM);		
						gsmt.bindColumn(2,  idxEMPNO);		
						gsmt.bindColumn(3,  idxSTDAMT);	
						gsmt.bindColumn(4,  idxINSAMT1);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
      /*  UpdateSql.append( "UPDATE PAYROLL.PWINSBSW SET " );
				UpdateSql.append( " STDYM ='"+rows[j].getString(idxSTDYM)+"', " );
				UpdateSql.append( " EMPNO = '"+rows[j].getString(idxSTDYM)+"',  " );
				UpdateSql.append( " STDAMT = '"+rows[j].getString(idxSTDYM)+"',  " );
				UpdateSql.append( " INSAMT1 = '"+rows[j].getString(idxINSAMT1)+"', " );
				UpdateSql.append( " WHERE STDYM = '"+rows[j].getString(idxSTDYM)+"'  " );
				UpdateSql.append( " AND EMPNO = '"+rows[j].getString(idxSTDYM)+"'  " ); */



						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxSTDYM);		
						gsmt.bindColumn(2, idxEMPNO);			
						gsmt.bindColumn(3, idxSTDAMT);		
						gsmt.bindColumn(4, idxINSAMT1);
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