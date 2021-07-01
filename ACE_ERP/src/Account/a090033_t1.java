package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090033_t1 extends HttpServlet{
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
				
    
               /************************************************************************************
                 @   Master
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
        				
                int idxFDCODE    = userSet.indexOfColumn("FDCODE");    // 1
				int idxATCODE    = userSet.indexOfColumn("ATCODE");    // 2
				int idxAST1ST     = userSet.indexOfColumn("AST1ST");    // 3
				int idxAST2ND     = userSet.indexOfColumn("AST2ND");    // 4
				int idxAST3RD     = userSet.indexOfColumn("AST3RD");    // 5
				int idxASTSEQ     = userSet.indexOfColumn("ASTSEQ");   // 6
				int idxDDSTS       = userSet.indexOfColumn("DDSTS");     // 7
				int idxDDNOTE     = userSet.indexOfColumn("DDNOTE");   // 8
				
		
				GauceDataRow[] rows = userSet.getDataRows();

				GauceStatement gsmt =null;
				StringBuffer UpdateSql = null;
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ASTBASICN  SET  " );
				UpdateSql.append( " DDSTS = ? ,   " );
				UpdateSql.append( " DDNOTE = ? " );
				UpdateSql.append( "   WHERE FDCODE =? " );	 
				UpdateSql.append( "        AND ATCODE =? " );
				UpdateSql.append( "        AND AST1ST =? " );
				UpdateSql.append( "        AND AST2ND =? " );
				UpdateSql.append( "        AND AST3RD =? " );
				UpdateSql.append( "        AND ASTSEQ =? " );	 

        //===================================================================================
				for (int j = 0; j < rows.length; j++){        	        
		
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						 
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1,idxDDSTS); 
						gsmt.bindColumn(2,idxDDNOTE); 
						gsmt.bindColumn(3,idxFDCODE); 
						gsmt.bindColumn(4,idxATCODE); 
						gsmt.bindColumn(5,idxAST1ST); 
						gsmt.bindColumn(6,idxAST2ND); 
						gsmt.bindColumn(7,idxAST3RD); 
						gsmt.bindColumn(8,idxASTSEQ); 
						
						gsmt.executeUpdate();
						gsmt.close();
					} //if jobtype
				}  //for j 

			} //try
			catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
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