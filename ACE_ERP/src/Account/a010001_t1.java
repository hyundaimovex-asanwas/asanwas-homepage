package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010001_t1 extends HttpServlet{

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

				int idxCMTYPE   = userSet.indexOfColumn("CMTYPE");
				int idxCMNAM    = userSet.indexOfColumn("CMNAM");
				int idxCMLEN    = userSet.indexOfColumn("CMLEN");
				int idxCMREMARK = userSet.indexOfColumn("CMREMARK");
				int idxWRDT     = userSet.indexOfColumn("WRDT");
				int idxWRID     = userSet.indexOfColumn("WRID");
				int idxUPDT     = userSet.indexOfColumn("UPDT");
				int idxUPID     = userSet.indexOfColumn("UPID");
				int idxDSUDT    = userSet.indexOfColumn("DSUDT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.COMMLIST (  												\n");
				InsertSql.append( " CMTYPE,	CMNAM,	CMLEN,	CMREMARK,	WRDT,	WRID,	DSUDT ) 	\n");
				InsertSql.append( " VALUES ( ?,?,?,?,'" + str1 + "','" +str2+"',? ) 										\n");

  
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.COMMLIST SET 				\n");
				UpdateSql.append( "        CMNAM = ?,											\n");;
				UpdateSql.append( "        CMLEN = ?,											\n");
				UpdateSql.append( "        CMREMARK = ?,									\n");
				UpdateSql.append( "        UPDT = '" + str1 + "',								\n");
				UpdateSql.append( "        UPID = '" + str2 +"',								\n");
				UpdateSql.append( "        DSUDT= ?											\n");
				UpdateSql.append( " WHERE CMTYPE= ?										\n");				


				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.COMMLIST 			\n");
				DeleteSql.append( "  WHERE CMTYPE= ?									\n");				


				//logger.dbg.println(this,InsertSql.toString());

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCMTYPE);
						gsmt.bindColumn(2, idxCMNAM);
						gsmt.bindColumn(3, idxCMLEN);
						gsmt.bindColumn(4, idxCMREMARK);
						gsmt.bindColumn(5, idxDSUDT);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCMNAM);
						gsmt.bindColumn(2, idxCMLEN);
						gsmt.bindColumn(3, idxCMREMARK);
						gsmt.bindColumn(4, idxDSUDT);
						gsmt.bindColumn(5, idxCMTYPE);
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCMTYPE);
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