package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class a040060_t3 extends HttpServlet{
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

			GauceStatement gsmt=null;

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1"); //사번
				String str2 = reqGauce.getParameter("v_str2"); //날짜

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 

				int idxFDCODE	    = userSet.indexOfColumn("FDCODE");                
				int idxTAXNBR	    = userSet.indexOfColumn("TAXNBR");           		 
				int idxVEND_ID		  = userSet.indexOfColumn("VEND_ID");							 
				int idxVEND_CD	    = userSet.indexOfColumn("VEND_CD");							 
				int idxVEND_NM	    = userSet.indexOfColumn("VEND_NM");								 
				int idxEMPNM	    = userSet.indexOfColumn("EMPNM");								 
				int idxEMAIL	    = userSet.indexOfColumn("EMAIL");								 
				int idxREMARK	    = userSet.indexOfColumn("REMARK");							 
				int idxTAXTOT	    = userSet.indexOfColumn("TAXTOT");							 
				int idxSEQ	    = userSet.indexOfColumn("SEQ");							 
				int idxUPDT	    = userSet.indexOfColumn("UPDT");							 
				int idxUPID	    = userSet.indexOfColumn("UPID");						 
	
				GauceDataRow[] rows = userSet.getDataRows();
				
				StringBuffer UpdateSql = null;
							

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ATTAXMST SET 					" );
				UpdateSql.append( " SEQ =?,    UPDT = '"+str2+"' ,   UPID = '"+str1+"' 	");
				UpdateSql.append( " WHERE TAXNBR = ? 										" );


				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxSEQ		);			
						gsmt.bindColumn(2,  idxTAXNBR	);				
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