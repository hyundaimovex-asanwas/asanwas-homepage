package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class a500040_t1 extends HttpServlet{
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

			String strSeq = "";
			String strVend_SEQ="";


			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String str1 = reqGauce.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxBANK_CD   = userSet.indexOfColumn("BANK_CD");
				int idxBANK_NM   = userSet.indexOfColumn("BANK_NM");
				int idxVACCTNO   = userSet.indexOfColumn("VACCTNO");
				int idxSEQ       = userSet.indexOfColumn("SEQ");
				int idxVEND_CD   = userSet.indexOfColumn("VEND_CD");
				int idxVEND_NM   = userSet.indexOfColumn("VEND_NM");
				int idxVEND_ID   = userSet.indexOfColumn("VEND_ID");
				int idxUSE_YN    = userSet.indexOfColumn("USE_YN");
				int idxFR_DT     = userSet.indexOfColumn("FR_DT");
				int idxTO_DT     = userSet.indexOfColumn("TO_DT");
				int idxWRID      = userSet.indexOfColumn("WRID");
				int idxWRDT      = userSet.indexOfColumn("WRDT");
				int idxUPID      = userSet.indexOfColumn("UPID");
				int idxUPDT      = userSet.indexOfColumn("UPDT");


				GauceDataRow[] rows = userSet.getDataRows();
				
				StringBuffer UpdateSql = null;
				
				UpdateSql = new StringBuffer();
				
				UpdateSql.append( " UPDATE ACCOUNT.VACCTINFO SET  \n");		
				UpdateSql.append( "  VEND_CD = ? 				  \n");
				UpdateSql.append( " ,VEND_NM = ? 				  \n");
				UpdateSql.append( " ,USE_YN  = ? 				  \n");
				UpdateSql.append( " ,FR_DT = ? 					  \n");
				UpdateSql.append( " ,TO_DT = ? 				   	  \n");
				UpdateSql.append( " ,UPID  = ? 					  \n");
				UpdateSql.append( " ,UPDT  =Sysdate             \n");
				UpdateSql.append( "  WHERE VACCTNO = ? 			\n");	
				UpdateSql.append( "    AND SEQ  = ? 			\n");					
						
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						rows[j].setString(idxUPID, str1);
							
						gsmt.bindColumn(1,  idxVEND_CD);	
						gsmt.bindColumn(2,  idxVEND_NM);	
						gsmt.bindColumn(3,  idxUSE_YN);	
						gsmt.bindColumn(4,  idxFR_DT);	
						gsmt.bindColumn(5,  idxTO_DT);	
						gsmt.bindColumn(6,  idxUPID);	
						gsmt.bindColumn(7,  idxVACCTNO);	
						gsmt.bindColumn(8,  idxSEQ);	
					
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