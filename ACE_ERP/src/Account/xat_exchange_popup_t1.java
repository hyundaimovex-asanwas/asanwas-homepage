package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class xat_exchange_popup_t1 extends HttpServlet{
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

				//String str1 = reqGauce.getParameter("v_str1");
				
				System.out.println("test1");

				String str1 = reqGauce.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				int idxDFSCD             = userSet.indexOfColumn("DFSCD");
				int idxSALEDT            = userSet.indexOfColumn("SALEDT");
				int idxCNYER             = userSet.indexOfColumn("CNYER");
				int idxUSDER             = userSet.indexOfColumn("USDER");
				int idxCREATE_ID         = userSet.indexOfColumn("CREATE_ID");
				int idxCREATE_DATE       = userSet.indexOfColumn("CREATE_DATE");
				int idxUPDATE_ID         = userSet.indexOfColumn("UPDATE_ID");
				int idxUPDATE_DATE       = userSet.indexOfColumn("UPDATE_DATE");
				


				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.TBIF_POSEXG (  	   \n");
				InsertSql.append( " DFSCD,SALEDT,CNYER,USDER,  		   \n");
				InsertSql.append( " CREATE_ID,CREATE_DATE )  			       \n");
				InsertSql.append( " VALUES ( ?,?,?,?,?, CURRENT_TIMESTAMP )\n");


				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.TBIF_POSEXG SET 		   \n");
				UpdateSql.append( "        CNYER = ?,					   \n");
				UpdateSql.append( "        USDER = ?,					   \n");
				UpdateSql.append( "        UPDATE_ID = ?,				   \n");
				UpdateSql.append( "        UPDATE_DATE =CURRENT_TIMESTAMP  \n");				
				UpdateSql.append( " WHERE DFSCD = ? 					   \n");
				UpdateSql.append( "   AND SALEDT = ? 					   \n");
				

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.TBIF_POSEXG   	   \n");
				DeleteSql.append( "  WHERE DFSCD = ? 					   \n");
				DeleteSql.append( "    AND SALEDT = ? 					   \n");
			
				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
						
						
						
						rows[j].setString(idxCREATE_ID,str1);

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxDFSCD);
						gsmt.bindColumn(2, idxSALEDT);
						gsmt.bindColumn(3, idxCNYER);
						gsmt.bindColumn(4, idxUSDER);
						gsmt.bindColumn(5, idxCREATE_ID);
					
						gsmt.executeUpdate();
						gsmt.close();

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
						rows[j].setString(idxUPDATE_ID,str1);
						
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1, idxCNYER);
						gsmt.bindColumn(2, idxUSDER);
						gsmt.bindColumn(3, idxUPDATE_ID);
						gsmt.bindColumn(4, idxDFSCD);
						gsmt.bindColumn(5, idxSALEDT);
						gsmt.executeUpdate(); 
						gsmt.close();         
				
						            
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxDFSCD);
						gsmt.bindColumn(2, idxSALEDT);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e)
				{
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
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