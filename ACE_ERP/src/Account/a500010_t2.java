package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class a500010_t2 extends HttpServlet{
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


				int idxVEND_CD  	= userSet.indexOfColumn("VEND_CD");
				int idxVEND_NM  	= userSet.indexOfColumn("VEND_NM");
				int idxVEND_ID  	= userSet.indexOfColumn("VEND_ID");
				int idxSEQ 			= userSet.indexOfColumn("SEQ");				
				int idxBANK_CD 		= userSet.indexOfColumn("BANK_CD");
				int idxBANK_NM 		= userSet.indexOfColumn("BANK_NM");
				int idxACCT_NO 		= userSet.indexOfColumn("ACCT_NO");
				int idxACCT_AUTH 	= userSet.indexOfColumn("ACCT_AUTH");
				int idxREASON 		= userSet.indexOfColumn("REASON");
				int idxGUBUN 		= userSet.indexOfColumn("GUBUN");
				int idxSTATUS 		= userSet.indexOfColumn("STATUS");
				int idxATT_GB 		= userSet.indexOfColumn("ATT_GB");
				int idxATT_FILE_NAME= userSet.indexOfColumn("ATT_FILE_NAME");
				
				//int idxUSEYN 		= userSet.indexOfColumn("USEYN");				
				//int idxI_EMPNO 	= userSet.indexOfColumn("I_EMPNO");
				//int idxI_DATE  	= userSet.indexOfColumn("I_DATE");


				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

			
				
				UpdateSql = new StringBuffer();
				
				UpdateSql.append( " UPDATE ACCOUNT.ACCTNO SET 		\n");				
				UpdateSql.append( "        STATUS = ?				\n");
				UpdateSql.append( "  WHERE VEND_CD = ? 				\n");	
				UpdateSql.append( "    AND SEQ = ? 					\n");					
				
				for (int j = 0; j < rows.length; j++){

				
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1,  idxSTATUS);	
						gsmt.bindColumn(2, idxVEND_CD);	
						gsmt.bindColumn(3, idxSEQ);
						
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