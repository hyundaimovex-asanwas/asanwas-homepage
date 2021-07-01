package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090003_t2 extends HttpServlet{
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

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1");
				String str2 = reqGauce.getParameter("v_str2");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE     = userSet.indexOfColumn("FDCODE");
				int idxATCODE     = userSet.indexOfColumn("ATCODE");
				int idxAST1ST      = userSet.indexOfColumn("AST1ST");
				int idxAST2ND      = userSet.indexOfColumn("AST2ND");
				int idxAST3RD      = userSet.indexOfColumn("AST3RD");
				int idxASTSEQ      = userSet.indexOfColumn("ASTSEQ");
				int idxCHGNO        = userSet.indexOfColumn("CHGNO");
				int idxCHGDATE     = userSet.indexOfColumn("CHGDATE");   
				int idxCHGTYPE     = userSet.indexOfColumn("CHGTYPE");  
				int idxDECTYPE     = userSet.indexOfColumn("DECTYPE"); 
				int idxCHGWHAT    = userSet.indexOfColumn("CHGWHAT");
				int idxCHGQTY      = userSet.indexOfColumn("CHGQTY");
				int idxCHGAMT      = userSet.indexOfColumn("CHGAMT");
				int idxCHGAMT2    = userSet.indexOfColumn("CHGAMT2"); 
				int idxCHGAMT3    = userSet.indexOfColumn("CHGAMT3"); 
				int idxRELFIRM      = userSet.indexOfColumn("RELFIRM");
				int idxWRDT           = userSet.indexOfColumn("WRDT");    
				int idxWRID            = userSet.indexOfColumn("WRID");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer DeleteSql = null;								
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ASTCHG " );
				DeleteSql.append( " WHERE FDCODE = ? " );
				DeleteSql.append( "   AND ATCODE = ? " );
				DeleteSql.append( "   AND AST1ST = ? " );
				DeleteSql.append( "   AND AST2ND = ? " );
				DeleteSql.append( "   AND AST3RD = ? " );
				DeleteSql.append( "   AND ASTSEQ = ? " );
				DeleteSql.append( "   AND CHGNO = ? " );

				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxFDCODE);
						gsmt.bindColumn(2, idxATCODE);
						gsmt.bindColumn(3, idxAST1ST);
						gsmt.bindColumn(4, idxAST2ND);
						gsmt.bindColumn(5, idxAST3RD);
						gsmt.bindColumn(6, idxASTSEQ);
						gsmt.bindColumn(7, idxCHGNO);

						gsmt.executeUpdate();
						gsmt.close();
						
					}
				}
			}
			catch(Exception e){
				logger.err.println(this,e.toString());	
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