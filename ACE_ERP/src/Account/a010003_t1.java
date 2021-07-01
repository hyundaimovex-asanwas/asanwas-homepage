package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010003_t1 extends HttpServlet{
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

				int idxFDCODE   = userSet.indexOfColumn("FDCODE");
				int idxFDNAME   = userSet.indexOfColumn("FDNAME");
				int idxFDREMARK = userSet.indexOfColumn("FDREMARK");
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
				InsertSql.append( " INSERT INTO ACCOUNT.FIELDCODE (  											\n");
				InsertSql.append( " FDCODE,	FDNAME,	FDREMARK,	WRDT,	WRID,	DSUDT ) 		\n");
				InsertSql.append( " VALUES ( ?,?,?,'" + str1 + "','" +str2+"',? ) 										\n");
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.FIELDCODE SET 											\n");
		        UpdateSql.append( "        FDNAME = ?,																	\n");
				UpdateSql.append( "        FDREMARK = ?,																\n");
				UpdateSql.append( "        UPDT = '" + str1 + "',															\n");
				UpdateSql.append( "        UPID = '" + str2 +"',															\n");
				UpdateSql.append( "        DSUDT= ?																		\n");
				UpdateSql.append( " WHERE FDCODE= ?																	\n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.FIELDCODE 											\n");
				DeleteSql.append( "  WHERE FDCODE= ?																	\n");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxFDCODE);
						gsmt.bindColumn(2, idxFDNAME);
						gsmt.bindColumn(3, idxFDREMARK);
						gsmt.bindColumn(4, idxDSUDT);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxFDNAME);
						gsmt.bindColumn(2, idxFDREMARK);
						gsmt.bindColumn(3, idxDSUDT);
						gsmt.bindColumn(4, idxFDCODE);
						
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxFDCODE);
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