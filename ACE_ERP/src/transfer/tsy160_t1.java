package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tsy160_t1 extends HttpServlet{

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

				//String str1 = reqGauce.getParameter("v_str1");

				//logger.dbg.println(this,"str1:" + str1+ "str2:" + str2);
				logger.dbg.println(this,"1111");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
                      int idxJUMIN      = userSet.indexOfColumn("JUMIN");
                     int  idxLANK       = userSet.indexOfColumn("LANK");
		

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO ACCOUNT.TEST9999(");
				InsertSql.append( "JUMIN, LANK" );
                InsertSql.append( ")VALUES (");
			    InsertSql.append( "	? , ? )" );

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE  ACCOUNT.TEST9999  SET" );
			    UpdateSql.append( "LANK = ?" );
				UpdateSql.append( "WHERE RTRIM( JUMIN) = ?");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM SALES.TSY160 " );
				DeleteSql.append( " WHERE RTRIM(JUMIN) = ? " );

				logger.dbg.println(this,InsertSql.toString()); //�ΰ� �����
				logger.dbg.println(this,UpdateSql.toString());
				logger.dbg.println(this,DeleteSql.toString());

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxJUMIN);
						gsmt.bindColumn(2, idxLANK);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxJUMIN);
						gsmt.bindColumn(2, idxLANK);
				        gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxJUMIN);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
				logger.err.println(this,e.toString()); //
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