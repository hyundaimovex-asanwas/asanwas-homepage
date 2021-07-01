package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010002_t4 extends HttpServlet{
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

				int idxATCODE   = userSet.indexOfColumn("ATCODE");
				int idxBUDDTL = userSet.indexOfColumn("BUDDTL");
				int idxBUDNAM = userSet.indexOfColumn("BUDNAM");
				int idxREMARK = userSet.indexOfColumn("REMARK");
        		int idxWRDT = userSet.indexOfColumn("WRDT");
				int idxWRID = userSet.indexOfColumn("WRID");
				int idxUPDT = userSet.indexOfColumn("UPDT");
				int idxUPID = userSet.indexOfColumn("UPID");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ATBUDACT ( 								\n");
				InsertSql.append( " ATCODE,	BUDDTL,	BUDNAM, REMARK,	WRDT, WRID ) 	\n");
				InsertSql.append( " VALUES ( ?,?,?,?,'" + str1 + "','" +str2+"' ) 							\n");

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ATBUDACT SET 	\n");
				UpdateSql.append( "        BUDDTL = ?,							\n");
				UpdateSql.append( "        BUDNAM = ?,							\n");
				UpdateSql.append( "        REMARK = ?,							\n");
				UpdateSql.append( "        WRDT = '" + str1 + "',				\n");
				UpdateSql.append( "        WRID = '" + str2 +"'					\n");
				UpdateSql.append( " WHERE ATCODE= ?							\n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ATBUDACT 		\n");
				DeleteSql.append( " WHERE ATCODE= ?								\n");


				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxATCODE);
						gsmt.bindColumn(2, idxBUDDTL);
						gsmt.bindColumn(3, idxBUDNAM);
						gsmt.bindColumn(4, idxREMARK);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxBUDDTL);
						gsmt.bindColumn(2, idxBUDNAM);
						gsmt.bindColumn(3, idxREMARK);
						gsmt.bindColumn(4, idxATCODE);
						gsmt.executeUpdate();
						gsmt.close();
					}
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxATCODE);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
				logger.err.println(this,e);
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