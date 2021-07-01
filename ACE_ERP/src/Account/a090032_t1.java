package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090032_t1 extends HttpServlet{
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
        				
                int idxFDCODE        = userSet.indexOfColumn("FDCODE");      // 1
				int idxAST2ND        = userSet.indexOfColumn("AST2ND");      // 2
				int idxAST2NDNM      = userSet.indexOfColumn("AST2NDNM");    // 3
				int idxASTYUSE       = userSet.indexOfColumn("ASTYUSE");     // 4
				int idxBEFAQAMT      = userSet.indexOfColumn("BEFAQAMT");    // 5
				int idxCURAQAMT      = userSet.indexOfColumn("CURAQAMT");    // 6
				int idxCLSAQAMT      = userSet.indexOfColumn("CLSAQAMT");    // 7
				int idxMOVAQAMT      = userSet.indexOfColumn("MOVAQAMT");    // 8
				int idxAQAMTSUM      = userSet.indexOfColumn("AQAMTSUM");    // 9
				int idxABDEPRAMT     = userSet.indexOfColumn("ABDEPRAMT");   // 10
				int idxACDEPRAMT     = userSet.indexOfColumn("ACDEPRAMT");   // 11
				int idxACDEPRSUM     = userSet.indexOfColumn("ACDEPRSUM");   // 12
				int idxREDUAMT       = userSet.indexOfColumn("REDUAMT");     // 13
				int idxDEAMTSUM      = userSet.indexOfColumn("DEAMTSUM");    // 14
				int idxJAAMTSUM      = userSet.indexOfColumn("JAAMTSUM");    // 15
			
				GauceDataRow[] rows = userSet.getDataRows();

				GauceStatement gsmt =null;

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ASTMMACHT (  										" );
				InsertSql.append( " FDCODE,   ASTYM,    AST2ND,   AST2NDNM, ASTYUSE,    				" );
				InsertSql.append( " BEFAQAMT, CURAQAMT, CLSAQAMT, MOVAQAMT, AQAMTSUM,   	" );
				InsertSql.append( " ABDEPRAMT,ACDEPRAMT,ACDEPRSUM,REDUAMT,  DEAMTSUM,   	" );
				InsertSql.append( " JAAMTSUM, WRDT,     WRID                            							" );
				InsertSql.append( "  ) 							" );
				InsertSql.append( " VALUES ( 				" );	 
				InsertSql.append( "  ?,'"+str1+ "',?,?,?, 	" );	 
				InsertSql.append( "  ?,?,?,?,?, 				" );	 
				InsertSql.append( "  ?,?,?,?,?, 				" );	 
				InsertSql.append( "  ?,sysdate,'"+str2+"' ) " );	 

                UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ASTMMACHT SET												 " ); 
				UpdateSql.append( " AQAMTSUM = BEFAQAMT+CURAQAMT+CLSAQAMT+MOVAQAMT 		" ); 
				UpdateSql.append( " ,DEAMTSUM = ABDEPRAMT+REDUAMT+ACDEPRAMT 						" ); 
				UpdateSql.append( " ,JAAMTSUM = (BEFAQAMT+CURAQAMT+CLSAQAMT+MOVAQAMT)-(ABDEPRAMT+REDUAMT+ACDEPRAMT) " ); 
				UpdateSql.append( " WHERE FDCODE = ? 			" );
				UpdateSql.append( "   AND ASTYM = '"+str1+ "' 		" );

        //===================================================================================
				for (int j = 0; j < rows.length; j++){        	        
		
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						 
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1,idxFDCODE); 
						gsmt.bindColumn(2,idxAST2ND); 
						gsmt.bindColumn(3,idxAST2NDNM); 
						gsmt.bindColumn(4,idxASTYUSE); 
						gsmt.bindColumn(5,idxBEFAQAMT); 
						gsmt.bindColumn(6,idxCURAQAMT); 
						gsmt.bindColumn(7,idxCLSAQAMT); 
						gsmt.bindColumn(8,idxMOVAQAMT); 
						gsmt.bindColumn(9,idxAQAMTSUM); 
						gsmt.bindColumn(10,idxABDEPRAMT); 
						gsmt.bindColumn(11,idxACDEPRAMT); 
						gsmt.bindColumn(12,idxACDEPRSUM); 
						gsmt.bindColumn(13,idxREDUAMT); 
						gsmt.bindColumn(14,idxDEAMTSUM); 
						gsmt.bindColumn(15,idxJAAMTSUM);
										
						//System.out.println("# idxFDCODE : " + rows[j].getString(idxFDCODE));			
						//System.out.println("# idxAST2ND : " + rows[j].getString(idxAST2ND));							
						
						gsmt.executeUpdate();
						gsmt.close();
						

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1,idxFDCODE); 
											
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