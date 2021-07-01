package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090030_t2 extends HttpServlet{
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

				String strChgno = null;
    
				/************************************************************************************
         		@ Master
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String str1 = reqGauce.getParameter("v_str1");  //년월
				String str2 = reqGauce.getParameter("v_str2");  //사번
        				
                int idxFDCODE     = userSet.indexOfColumn("FDCODE");    // 1
				int idxRCOSTCD    = userSet.indexOfColumn("RCOSTCD");   // 2
				int idxCOSTCD     = userSet.indexOfColumn("COSTCD");    // 3
				int idxCOSTNM     = userSet.indexOfColumn("COSTNM");    // 4
				int idxATCODE     = userSet.indexOfColumn("ATCODE");    // 5
				int idxAST2ND     = userSet.indexOfColumn("AST2ND");    // 6
				int idxAST2NDNM   = userSet.indexOfColumn("AST2NDNM");  // 7
				int idxASTAQAMT   = userSet.indexOfColumn("ASTAQAMT");  // 8
				int idxABDEPRAMT  = userSet.indexOfColumn("ABDEPRAMT"); // 9
				int idxACDEPRAMT  = userSet.indexOfColumn("ACDEPRAMT"); // 10
				int idxACDEPRSUM  = userSet.indexOfColumn("ACDEPRSUM"); // 11
				int idxASTRMAMT   = userSet.indexOfColumn("ASTRMAMT");  // 12
				int idxREDUAMT    = userSet.indexOfColumn("REDUAMT");   // 13
			
				GauceDataRow[] rows = userSet.getDataRows();

				GauceStatement gsmt =null;
				GauceStatement gsmt2=null; 

				StringBuffer InsertSql = null;
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ASTMMCCHT (  										\n");
				InsertSql.append( " FDCODE,     ASTYM,  	  COSTCD,    COSTNM,      ATCODE,   		\n");
				InsertSql.append( " AST2ND,     AST2NDNM,	  ASTAQAMT,  ABDEPRAMT,   REDUAMT,   	\n");
			    InsertSql.append( " ACDEPRAMT,  ACDEPRSUM,  WRDT,      WRID  							\n");
				InsertSql.append( "  ) 											\n");
				InsertSql.append( " VALUES ( 								\n");	 
				InsertSql.append( "  ?,'"+str1+ "',?,?,?, 					\n");	 
				InsertSql.append( "  ?,?,?,?,?, 								\n");	 
				InsertSql.append( "  ?,?,sysdate,'"+str2+"' ) 				\n");	 
    
        //===================================================================================
				for (int j = 0; j < rows.length; j++){        	        
		
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						 
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1,idxFDCODE); 
						gsmt.bindColumn(2,idxCOSTCD); 
						gsmt.bindColumn(3,idxCOSTNM); 
						gsmt.bindColumn(4,idxATCODE); 
						gsmt.bindColumn(5,idxAST2ND); 
						gsmt.bindColumn(6,idxAST2NDNM); 
						gsmt.bindColumn(7,idxASTAQAMT); 
						gsmt.bindColumn(8,idxABDEPRAMT); 
						gsmt.bindColumn(9,idxREDUAMT); 
						gsmt.bindColumn(10,idxACDEPRAMT); 
						gsmt.bindColumn(11,idxACDEPRSUM); 
						
						//System.out.println("# Query : \n" + InsertSql);		
						//System.out.println("# idxFDCODE : " + rows[j].getString(idxFDCODE));		
						//System.out.println("# idxCOSTCD : " + rows[j].getString(idxCOSTCD));		
						//System.out.println("# idxATCODE : " + rows[j].getString(idxATCODE));		
						//System.out.println("# idxAST2ND : " + rows[j].getString(idxAST2ND));								
						
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