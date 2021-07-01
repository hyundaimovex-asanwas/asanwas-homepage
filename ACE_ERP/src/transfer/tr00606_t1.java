package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00606_t1 extends HttpServlet{

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
				int idxCUSTID	= userSet.indexOfColumn("CUSTID");
				int idxUSERID	= userSet.indexOfColumn("USERID");
				int idxUSESTS	= userSet.indexOfColumn("USESTS");
				

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO TRANSFER.LTCUSTOMS ( " );
				InsertSql.append( "CUSTID,USERID,USESTS " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( "?, ?, ?  ) " );
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE TRANSFER.LTCUSTOMS SET " );
				UpdateSql.append( " USESTS = ? " );
//				UpdateSql.append( " SEQ = ?, " );
//				UpdateSql.append( " USEYN = ?, " );
//				UpdateSql.append( " MEMO = ? " );
				UpdateSql.append( " WHERE CUSTID = ? AND USERID = ?" );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM TRANSFER.LTCUSTOMS WHERE CUSTID = ? AND USERID = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						//logger.dbg.println(this,InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxCUSTID);
						gsmt.bindColumn(2, idxUSERID);
						gsmt.bindColumn(3, idxUSESTS);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxUSESTS);
						gsmt.bindColumn(2, idxCUSTID);
						gsmt.bindColumn(3, idxUSERID);
						//gsmt.bindColumn(4, idxMEMO);
						//gsmt.bindColumn(5, idxMAJORCD);
						//gsmt.bindColumn(6, idxMINORCD);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxCUSTID);
						gsmt.bindColumn(2, idxUSERID);
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