package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010006_t4 extends HttpServlet{
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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxBANCOD      = userSet.indexOfColumn("BANCOD");
				int idxBANNAM      = userSet.indexOfColumn("BANNAM");
				int idxBANNA1      = userSet.indexOfColumn("BANNA1");
				int idxBANNUM      = userSet.indexOfColumn("BANNUM");
				int idxCOMCOD      = userSet.indexOfColumn("COMCOD");
				int idxDNSID1      = userSet.indexOfColumn("DNSID1");
				int idxGUBUN1      = userSet.indexOfColumn("GUBUN1");
				int idxGUBUN2      = userSet.indexOfColumn("GUBUN2");
				int idxFILERR      = userSet.indexOfColumn("FILERR");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.BANKCODE (  						\n");
				InsertSql.append( " BANCOD,  BANNAM,  BANNA1, BANNUM, COMCOD,  	\n");
				InsertSql.append( " DNSID1, GUBUN1, GUBUN2, FILERR )						\n");
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,? ) 									\n");

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.BANKCODE SET 						\n");
				UpdateSql.append( "        BANNAM = ?,												\n");
				UpdateSql.append( "        BANNA1 = ?,												\n");
				UpdateSql.append( "        BANNUM = ?,												\n");
				UpdateSql.append( "        COMCOD = ?,												\n");
				UpdateSql.append( "        DNSID1 = ?,													\n");
				UpdateSql.append( "        GUBUN1 = ?,												\n");
				UpdateSql.append( "        GUBUN2 = ?,												\n");
				UpdateSql.append( "        FILERR = ? 													\n");
				UpdateSql.append( " WHERE RTRIM(BANCOD) = ? 								\n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.BANKCODE 						\n");
				DeleteSql.append( "  WHERE RTRIM(BANCOD) = ? 								\n");

				//logger.dbg.println(this,InsertSql.toString()); //로고 남기기
				//logger.dbg.println(this,UpdateSql.toString());
				//logger.dbg.println(this,DeleteSql.toString());

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxBANCOD);
						gsmt.bindColumn(2, idxBANNAM);
						gsmt.bindColumn(3, idxBANNA1);
						gsmt.bindColumn(4, idxBANNUM);
						gsmt.bindColumn(5, idxCOMCOD);
						gsmt.bindColumn(6, idxDNSID1);
						gsmt.bindColumn(7, idxGUBUN1);
						gsmt.bindColumn(8, idxGUBUN2);
						gsmt.bindColumn(9, idxFILERR);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1, idxBANNAM);
						gsmt.bindColumn(2, idxBANNA1);
						gsmt.bindColumn(3, idxBANNUM);
						gsmt.bindColumn(4, idxCOMCOD);
						gsmt.bindColumn(5, idxDNSID1);
						gsmt.bindColumn(6, idxGUBUN1);
						gsmt.bindColumn(7, idxGUBUN2);
						gsmt.bindColumn(8, idxFILERR);
						gsmt.bindColumn(9, idxBANCOD);
						
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxBANCOD);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				logger.err.println(this,e.toString()); //
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