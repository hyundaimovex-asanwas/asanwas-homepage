package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020004_t4 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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

        		GauceStatement gsmt=null;
        		
				/************************************************************************************

				*************************************************************************************/        		
        		
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				//logger.dbg.println(this,"step_start");
				
				
				int idxFDCODE           = userSet.indexOfColumn("FDCODE");          //�����ڵ�
				int idxFSDAT    		= userSet.indexOfColumn("FSDAT");   		//������ȣ
				int idxFSNBR         	= userSet.indexOfColumn("FSNBR");        	//������ȣ-����
				int idxFSLOCK   			= userSet.indexOfColumn("FSLOCK");  			//LOCK


				GauceDataRow[] rows = userSet.getDataRows();


				StringBuffer UpdateSql = null;

        		UpdateSql = new StringBuffer();
				UpdateSql.append( "  UPDATE ACCOUNT.FSLIPMST 			" );
				UpdateSql.append( "     SET FSLOCK = ?            		" );
				UpdateSql.append( "   WHERE FDCODE=?                	" );
				UpdateSql.append( "     AND FSDAT=?                     " );
				UpdateSql.append( "     AND FSNBR=?                  	" );       


				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxFSLOCK);
						gsmt.bindColumn(2, idxFDCODE);
						gsmt.bindColumn(3, idxFSDAT);
						gsmt.bindColumn(4, idxFSNBR);

						//logger.dbg.println(this,UpdateSql.toString());;
						
						             
						gsmt.executeUpdate();
						gsmt.close();
            			gsmt=null;         

					}//if

				}//for
			}

			/************************************************************************************

			*************************************************************************************/   			
			
			
			catch(Exception e)
				{
				conn.rollback();
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
				logger.err.println(this,e.toString()); //
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