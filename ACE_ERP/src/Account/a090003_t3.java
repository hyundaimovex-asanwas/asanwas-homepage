package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090003_t3 extends HttpServlet{
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

				String str1 = reqGauce.getParameter("v_str1");
				String str2 = reqGauce.getParameter("v_str2");
				String str3 = reqGauce.getParameter("v_str3");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE          = userSet.indexOfColumn("FDCODE");
				int idxATCODE          = userSet.indexOfColumn("ATCODE");
				int idxAST1ST           = userSet.indexOfColumn("AST1ST");
				int idxAST2ND           = userSet.indexOfColumn("AST2ND");
				int idxAST3RD           = userSet.indexOfColumn("AST3RD");
				int idxASTSEQ          = userSet.indexOfColumn("ASTSEQ");
				int idxASTAQAMT     = userSet.indexOfColumn("ASTAQAMT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ASTBASIC SET " );
		        UpdateSql.append( "        ASTAQAMT = ? " );
				UpdateSql.append( " WHERE FDCODE = ? " );
				UpdateSql.append( "   AND ATCODE = ?" );
				UpdateSql.append( "   AND AST1ST = ?" );
				UpdateSql.append( "   AND AST2ND = ?" );
				UpdateSql.append( "   AND AST3RD = ?" );
				UpdateSql.append( "   AND ASTSEQ = ?" );

				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxASTAQAMT);
						gsmt.bindColumn(2, idxFDCODE);
						gsmt.bindColumn(3, idxATCODE);
						gsmt.bindColumn(4, idxAST1ST);
						gsmt.bindColumn(5, idxAST2ND);
						gsmt.bindColumn(6, idxAST3RD);
						gsmt.bindColumn(7, idxASTSEQ);
						
						gsmt.executeUpdate(); 
						gsmt.close();         

					}    

				}
			}
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