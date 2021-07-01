package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010006_t3 extends HttpServlet{
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

				int idxERCODE      = userSet.indexOfColumn("ERCODE");
				int idxERSTDDAT    = userSet.indexOfColumn("ERSTDDAT");
				int idxERSED       = userSet.indexOfColumn("ERSED");
				int idxERREV       = userSet.indexOfColumn("ERREV");			
				int idxERSTD       = userSet.indexOfColumn("ERSTD");
				int idxERCASED     = userSet.indexOfColumn("ERCASED");
				int idxERCAREV     = userSet.indexOfColumn("ERCAREV");
				int idxERCRORAT    = userSet.indexOfColumn("ERCRORAT");
				int idxERMMLAST    = userSet.indexOfColumn("ERMMLAST");
				int idxERAVG       = userSet.indexOfColumn("ERAVG");
				int idxERHIS       = userSet.indexOfColumn("ERHIS");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.EXCRATE (  										\n");
				InsertSql.append( " ERCODE, ERSTDDAT, ERSED, ERREV, ERSTD, 						\n");
				InsertSql.append( " ERCASED, ERCAREV, ERCRORAT, ERMMLAST, ERAVG, 			\n");
				InsertSql.append( " ERHIS ) 																			\n");
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,? ) 											\n");

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.EXCRATE SET 										\n");
				UpdateSql.append( "        ERSED = ?,																\n");
				UpdateSql.append( "        ERREV = ?,																\n");
				UpdateSql.append( "        ERSTD = ?,																\n");
				UpdateSql.append( "        ERCASED = ?,															\n");				
				UpdateSql.append( "        ERCAREV = ?,															\n");
				UpdateSql.append( "        ERCRORAT = ?,														\n");
				UpdateSql.append( "        ERMMLAST = ?,														\n");
				UpdateSql.append( "        ERAVG = ?,																\n");
				UpdateSql.append( "        ERHIS = ? 																\n");
				UpdateSql.append( " WHERE RTRIM(ERCODE) = ? AND RTRIM(ERSTDDAT) = ? 		\n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.EXCRATE 									\n");
				DeleteSql.append( "  WHERE RTRIM(ERCODE) = ? AND RTRIM(ERSTDDAT) = ? 		\n");

				//logger.dbg.println(this,DeleteSql.toString());

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxERCODE);
						gsmt.bindColumn(2, idxERSTDDAT);
						gsmt.bindColumn(3, idxERSED);
						gsmt.bindColumn(4, idxERREV);
						gsmt.bindColumn(5, idxERSTD);
						gsmt.bindColumn(6, idxERCASED);
						gsmt.bindColumn(7, idxERCAREV);
						gsmt.bindColumn(8, idxERCRORAT);
						gsmt.bindColumn(9, idxERMMLAST);
						gsmt.bindColumn(10, idxERAVG);
						gsmt.bindColumn(11, idxERHIS);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1, idxERSED);
						gsmt.bindColumn(2, idxERREV);
						gsmt.bindColumn(3, idxERSTD);
						gsmt.bindColumn(4, idxERCASED);
						gsmt.bindColumn(5, idxERCAREV);
						gsmt.bindColumn(6, idxERCRORAT);
						gsmt.bindColumn(7, idxERMMLAST);
						gsmt.bindColumn(8, idxERAVG);
						gsmt.bindColumn(9, idxERHIS);
						gsmt.bindColumn(10, idxERCODE);
						gsmt.bindColumn(11, idxERSTDDAT);
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxERCODE);
						gsmt.bindColumn(2, idxERSTDDAT);
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