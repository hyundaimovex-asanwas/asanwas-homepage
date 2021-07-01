package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060002_t2 extends HttpServlet{

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
        
				int idxEVAYM    = userSet.indexOfColumn("EVAYM");
				int idxEMPNO    = userSet.indexOfColumn("EMPNO");
				int idxDEPTCD   = userSet.indexOfColumn("DEPTCD");
				int idxPAYGRD   = userSet.indexOfColumn("PAYGRD");
				int idxGRSTRTDT = userSet.indexOfColumn("GRSTRTDT");
				int idxSTRTDT    = userSet.indexOfColumn("STRTDT");
				int idxWRDT     = userSet.indexOfColumn("WRDT");
				int idxLAMDT    = userSet.indexOfColumn("LAMDT");
				int idxRECDIV   = userSet.indexOfColumn("RECDIV");
				int idxJOBKIND  = userSet.indexOfColumn("JOBKIND");
				int idxDEPREF    = userSet.indexOfColumn("DEPREF");
				int idxGRSREF   = userSet.indexOfColumn("GRSREF");
				int idxJOBREF   = userSet.indexOfColumn("JOBREF");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
        
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.HVEMP( " );
				InsertSql.append( "  EVAYM,	EMPNO, DEPTCD,	PAYGRD,	GRSTRTDT,  " );
				InsertSql.append( "  STRTDT, WRDT,  LAMDT,   RECDIV, JOBKIND, " );
				InsertSql.append( "  DEPREF, GRSREF,  JOBREF )" );
				InsertSql.append( " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( " " );
      
				DeleteSql = new StringBuffer();
				DeleteSql.append( "  " );
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEVAYM);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.bindColumn(3, idxDEPTCD);
						gsmt.bindColumn(4, idxPAYGRD);
						gsmt.bindColumn(5, idxGRSTRTDT);
						gsmt.bindColumn(6, idxSTRTDT);
						gsmt.bindColumn(7, idxWRDT);
						gsmt.bindColumn(8, idxLAMDT);
						gsmt.bindColumn(9, idxRECDIV);
						gsmt.bindColumn(10,idxJOBKIND);
						gsmt.bindColumn(11,idxDEPREF);
						gsmt.bindColumn(12,idxGRSREF);
						gsmt.bindColumn(13,idxJOBREF);

						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						
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