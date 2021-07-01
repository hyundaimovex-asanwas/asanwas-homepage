package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400140_t2 extends HttpServlet{
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
	 		
	 		String strApp_no ="";  //관리자ID
	 		
			try {
				
				conn = service.getDBConnection();	
				conn.setAutoCommit(false);  //Transaction 
				
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String str1 = reqGauce.getParameter("v_str1");				//사용자
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPP_NO                    = userSet.indexOfColumn("APP_NO");
				int idxATT_FILE_NAME             = userSet.indexOfColumn("ATT_FILE_NAME");
				int idxATT_GB                    = userSet.indexOfColumn("ATT_GB");
				int idxUPID                      = userSet.indexOfColumn("UPID");
				int idxUPDT                      = userSet.indexOfColumn("UPDT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;
				
				GauceStatement gsmt= null;
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.SIGNET_COR SET  \n" );
				UpdateSql.append( " ATT_FILE_NAME= ?,   \n" );
				UpdateSql.append( " ATT_GB= ?,          \n" );
				UpdateSql.append( " UPID = ?,           \n" );
				UpdateSql.append( " UPDT = CURRENT_TIMESTAMP  \n" );
				UpdateSql.append( " WHERE APP_NO  = ?   \n" );
				
				//
				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
						//System.out.println("a400140_t2 UpdateSql::"+UpdateSql.toString());
						
					    gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
								
		        		gsmt.bindColumn(1, idxATT_FILE_NAME);
						gsmt.bindColumn(2, idxATT_GB);
						gsmt.bindColumn(3, idxUPID);
						gsmt.bindColumn(4, idxAPP_NO);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
					
				   }else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
						
					
						
			 	   }else if (rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE){
					
					}//if
					
				}//for	
				
			}//inner try
			catch(Exception e){
				System.out.println("ERROR000::"+e);
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			conn.commit(); 
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}//outer try
		catch (Exception e) {
			
			System.out.println("ERROR::"+e);
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}//public void
	
}//classes