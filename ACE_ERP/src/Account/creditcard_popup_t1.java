package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class creditcard_popup_t1 extends HttpServlet{
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

				int idxCANBR       = userSet.indexOfColumn("CANBR");
				int idxCADIV       = userSet.indexOfColumn("CADIV");
				int idxCACARDSPEC  = userSet.indexOfColumn("CACARDSPEC");
				int idxCADEPTCD    = userSet.indexOfColumn("CADEPTCD");			
				int idxCAEMPNO     = userSet.indexOfColumn("CAEMPNO");
				int idxCAISSYYMM   = userSet.indexOfColumn("CAISSYYMM");
				int idxCAUSEYYMM   = userSet.indexOfColumn("CAUSEYYMM");
				int idxCASTTDAT    = userSet.indexOfColumn("CASTTDAT");
				int idxCAACCBANK   = userSet.indexOfColumn("CAACCBANK");
				int idxCABANKNO    = userSet.indexOfColumn("CABANKNO");
				int idxCACUST      = userSet.indexOfColumn("CACUST");
				int idxDSUDT       = userSet.indexOfColumn("DSUDT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.CARDCODE (  " );
				InsertSql.append( " CANBR,  CADIV,  CACARDSPEC, CADEPTCD, CAEMPNO,  " );
				InsertSql.append( " CAISSYYMM, CAUSEYYMM, CASTTDAT, CAACCBANK, CABANKNO,  ");
				InsertSql.append( " CACUST, DSUDT )" );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,? ) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.CARDCODE SET " );
				UpdateSql.append( "        CADIV = ?," );
				UpdateSql.append( "        CACARDSPEC = ?," );
				UpdateSql.append( "        CADEPTCD = ?," );
				UpdateSql.append( "        CAEMPNO = ?," );				
				UpdateSql.append( "        CAISSYYMM = ?," );
				UpdateSql.append( "        CAUSEYYMM = ?," );
				UpdateSql.append( "        CASTTDAT = ?," );
				UpdateSql.append( "        CAACCBANK = ?," );
				UpdateSql.append( "        CABANKNO = ?," );
				UpdateSql.append( "        CACUST = ?," );
				UpdateSql.append( "        DSUDT = ? " );
				UpdateSql.append( " WHERE RTRIM(CANBR) = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.CARDCODE " );
				DeleteSql.append( "  WHERE RTRIM(CANBR) = ? "  );

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCANBR);
						gsmt.bindColumn(2, idxCADIV);
						gsmt.bindColumn(3, idxCACARDSPEC);
						gsmt.bindColumn(4, idxCADEPTCD);
						gsmt.bindColumn(5, idxCAEMPNO);
						gsmt.bindColumn(6, idxCAISSYYMM);
						gsmt.bindColumn(7, idxCAUSEYYMM);
						gsmt.bindColumn(8, idxCASTTDAT);
						gsmt.bindColumn(9, idxCAACCBANK);
						gsmt.bindColumn(10, idxCABANKNO);
						gsmt.bindColumn(11, idxCACUST);
						gsmt.bindColumn(12, idxDSUDT);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCADIV);
						gsmt.bindColumn(2, idxCACARDSPEC);
						gsmt.bindColumn(3, idxCADEPTCD);
						gsmt.bindColumn(4, idxCAEMPNO);
						gsmt.bindColumn(5, idxCAISSYYMM);
						gsmt.bindColumn(6, idxCAUSEYYMM);
						gsmt.bindColumn(7, idxCASTTDAT);
						gsmt.bindColumn(8, idxCAACCBANK);
						gsmt.bindColumn(9, idxCABANKNO);
						gsmt.bindColumn(10, idxCACUST);
						gsmt.bindColumn(11, idxDSUDT);
						gsmt.bindColumn(12, idxCANBR);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCANBR);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				logger.err.println(this,e.toString()); 
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