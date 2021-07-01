package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010003_t6 extends HttpServlet{
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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxBGTDPT    = userSet.indexOfColumn("BGTDPT");
				int idxBGTDIV    = userSet.indexOfColumn("BGTDIV");
				int idxBGTDIVNM  = userSet.indexOfColumn("BGTDIVNM");
				int idxBGTFRYM   = userSet.indexOfColumn("BGTFRYM");
				int idxBGTTOYM   = userSet.indexOfColumn("BGTTOYM");
				int idxORGBGTDPT = userSet.indexOfColumn("ORGBGTDPT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.BGTMATCH ( 								\n");
				InsertSql.append( " BGTDPT, BGTDIV, BGTDIVNM, BGTFRYM, BGTTOYM,					\n");
				InsertSql.append( " WRID, WRDT, UPID, UPDT )									\n");
				InsertSql.append( " VALUES ( ?,?,?,?,?,'"+str1+"',sysdate,'"+str1+"',sysdate )  \n");
			
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.BGTMATCH SET 			            \n");
				UpdateSql.append( "        BGTDPT = ?,   								\n");
				UpdateSql.append( "        BGTDIV = ?,   								\n");
				UpdateSql.append( "        BGTDIVNM = ?, 								\n");
				UpdateSql.append( "        BGTTOYM = ?,  								\n");
				UpdateSql.append( "        UPID = '"+str1+"', 							\n");
				UpdateSql.append( "        UPDT = sysdate  								\n");
				UpdateSql.append( "  WHERE BGTDPT = ? AND BGTFRYM = ? 	\n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.BGTMATCH  		\n");
				DeleteSql.append( "  WHERE BGTDPT = ? AND BGTFRYM = ? 	\n");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxBGTDPT);
						gsmt.bindColumn(2, idxBGTDIV);
						gsmt.bindColumn(3, idxBGTDIVNM);
						gsmt.bindColumn(4, idxBGTFRYM);
						gsmt.bindColumn(5, idxBGTTOYM);
						
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxBGTDPT);
						gsmt.bindColumn(2, idxBGTDIV);
						gsmt.bindColumn(3, idxBGTDIVNM);
						gsmt.bindColumn(4, idxBGTTOYM);
						gsmt.bindColumn(5, idxORGBGTDPT);
						gsmt.bindColumn(6, idxBGTFRYM);

						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxORGBGTDPT);
						gsmt.bindColumn(2, idxBGTFRYM);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
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