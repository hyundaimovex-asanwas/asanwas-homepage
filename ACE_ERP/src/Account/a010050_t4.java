package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010050_t4 extends HttpServlet{
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
			String strVend_CD="";

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				String str1 = reqGauce.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				
				int idxVEND_CD  	= userSet.indexOfColumn("VEND_CD");
				int idxREAL_FILE4  	= userSet.indexOfColumn("REAL_FILE4");
				int idxSYS_FILE4  	= userSet.indexOfColumn("SYS_FILE4");
				int idxREAL_FILE3  	= userSet.indexOfColumn("REAL_FILE3");
				int idxSYS_FILE3  	= userSet.indexOfColumn("SYS_FILE3");
				int idxREAL_FILE2  	= userSet.indexOfColumn("REAL_FILE2");
				int idxSYS_FILE2  	= userSet.indexOfColumn("SYS_FILE2");
				int idxREAL_FILE1  	= userSet.indexOfColumn("REAL_FILE1");
				int idxSYS_FILE1  	= userSet.indexOfColumn("SYS_FILE1");
				int idxWRID         = userSet.indexOfColumn("WRID");
				int idxWRDT     	= userSet.indexOfColumn("WRDT");
				
				GauceDataRow[] rows = userSet.getDataRows();

				
				StringBuffer UpdateSql4 = null;
				StringBuffer UpdateSql3 = null;
				StringBuffer UpdateSql2 = null;
				StringBuffer UpdateSql1 = null;
				
				UpdateSql4 = new StringBuffer();
				UpdateSql4.append( " UPDATE ACCOUNT.GCZM_VENDER_USER SET 	\n");								
				UpdateSql4.append( "        REAL_FILE4 = ? 				    \n");
				UpdateSql4.append( "       ,SYS_FILE4  = ? 					\n");
				UpdateSql4.append( "  WHERE VEND_CD = ? 					\n");
				
				UpdateSql3 = new StringBuffer();
				UpdateSql3.append( " UPDATE ACCOUNT.GCZM_VENDER_USER SET 	\n");								
				UpdateSql3.append( "        REAL_FILE3 = ? 				    \n");
				UpdateSql3.append( "       ,SYS_FILE3  = ? 					\n");
				UpdateSql3.append( "  WHERE VEND_CD = ? 					\n");
				
				UpdateSql2 = new StringBuffer();
				UpdateSql2.append( " UPDATE ACCOUNT.GCZM_VENDER_USER SET 	\n");								
				UpdateSql2.append( "        REAL_FILE2 = ? 				    \n");
				UpdateSql2.append( "       ,SYS_FILE2  = ? 					\n");
				UpdateSql2.append( "  WHERE VEND_CD = ? 					\n");
				
				UpdateSql1 = new StringBuffer();
				UpdateSql1.append( " UPDATE ACCOUNT.GCZM_VENDER_USER SET 	\n");								
				UpdateSql1.append( "        REAL_FILE1 = ? 				    \n");
				UpdateSql1.append( "       ,SYS_FILE1  = ? 					\n");
				UpdateSql1.append( "  WHERE VEND_CD = ? 					\n");
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
						if(str1.equals("4")){
							GauceStatement gsmt = conn.getGauceStatement(UpdateSql4.toString());
							
							gsmt.setGauceDataRow(rows[j]);
								
							gsmt.bindColumn(1, idxREAL_FILE4);
							gsmt.bindColumn(2, idxSYS_FILE4);
							gsmt.bindColumn(3, idxVEND_CD);	

							gsmt.executeUpdate();
							gsmt.close();
	
						}else if (str1.equals("3")){
							GauceStatement gsmt = conn.getGauceStatement(UpdateSql3.toString());
							
							gsmt.setGauceDataRow(rows[j]);
								
							gsmt.bindColumn(1, idxREAL_FILE3);
							gsmt.bindColumn(2, idxSYS_FILE3);
							gsmt.bindColumn(3, idxVEND_CD);	

							gsmt.executeUpdate();
							gsmt.close();

						}else if (str1.equals("2")){
							GauceStatement gsmt = conn.getGauceStatement(UpdateSql2.toString());
							
							gsmt.setGauceDataRow(rows[j]);
								
							gsmt.bindColumn(1, idxREAL_FILE2);
							gsmt.bindColumn(2, idxSYS_FILE2);
							gsmt.bindColumn(3, idxVEND_CD);	

							gsmt.executeUpdate();
							gsmt.close();

						}else if (str1.equals("1")){		
							GauceStatement gsmt = conn.getGauceStatement(UpdateSql1.toString());
							
							gsmt.setGauceDataRow(rows[j]);
								
							gsmt.bindColumn(1, idxREAL_FILE1);
							gsmt.bindColumn(2, idxSYS_FILE1);
							gsmt.bindColumn(3, idxVEND_CD);	

							gsmt.executeUpdate();
							gsmt.close();
						}
					}
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						
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