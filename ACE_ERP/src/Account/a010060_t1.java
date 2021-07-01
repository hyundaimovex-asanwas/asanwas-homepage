package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010060_t1 extends HttpServlet{
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

				int idxBATCODE  	= userSet.indexOfColumn("BATCODE");
				int idxATCODE  	= userSet.indexOfColumn("ATCODE");
				int idxFRYM  	    = userSet.indexOfColumn("FRYM");
				int idxTOYM     	= userSet.indexOfColumn("TOYM");		
				int idxWRID     	    = userSet.indexOfColumn("WRID");
				int idxWRDT     	= userSet.indexOfColumn("WRDT");
				int idxUPID     	    = userSet.indexOfColumn("UPID");
				int idxUPDT     	= userSet.indexOfColumn("UPDT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ACTMATCH ( 												\n");
				InsertSql.append( "BATCODE,ATCODE,FRYM,TOYM,  														\n");
				InsertSql.append( "WRID,WRDT,UPID,UPDT																	\n");
				InsertSql.append( "	) VALUES ( 																				\n");
				InsertSql.append( " ?, ?, ?, ?, 																					\n");
				InsertSql.append( " '"+str1+"', sysdate,'"+str1+"', sysdate ) 												\n");
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ACTMATCH SET  		\n");
				UpdateSql.append( " TOYM =?  											\n");
				UpdateSql.append( " ,UPID ='"+str1+"' 									\n");
				UpdateSql.append( " ,UPDT= sysdate 									\n");
				UpdateSql.append( " WHERE BATCODE =?  							\n");
				UpdateSql.append( "      AND ATCODE =? 							\n");
				UpdateSql.append( "      AND FRYM =? 								\n");
				
				DeleteSql = new StringBuffer();
				
				DeleteSql.append( " DELETE FROM ACCOUNT.ACTMATCH 		\n");
				DeleteSql.append( " WHERE BATCODE =?  							\n");
				DeleteSql.append( "      AND ATCODE =? 								\n");
				DeleteSql.append( "      AND FRYM =? 									\n");
	
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
                        GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxBATCODE);	
						gsmt.bindColumn(2,  idxATCODE);	
						gsmt.bindColumn(3,  idxFRYM);	
						gsmt.bindColumn(4,  idxTOYM);	
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
					    gsmt.setGauceDataRow(rows[j]);	
					    gsmt.bindColumn(1,  idxTOYM);	
					    gsmt.bindColumn(2,  idxBATCODE);	
					    gsmt.bindColumn(3,  idxATCODE);	
						gsmt.bindColumn(4,  idxFRYM);	
					    gsmt.executeUpdate();
					    gsmt.close();
					}
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);	
						gsmt.bindColumn(1,  idxBATCODE);	
						gsmt.bindColumn(2,  idxATCODE);	
						gsmt.bindColumn(3,  idxFRYM);	
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