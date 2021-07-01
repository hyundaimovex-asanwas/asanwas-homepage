package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060001_t1 extends HttpServlet{

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

				int idxEVAYM     = userSet.indexOfColumn("EVAYM");
				int idxGRPCD    = userSet.indexOfColumn("GRPCD");
				int idxDIVCD     = userSet.indexOfColumn("DIVCD");
				int idxJOBGRPH  = userSet.indexOfColumn("JOBGRPH");
				int idxPRTSEQ   = userSet.indexOfColumn("PRTSEQ");
				int idxGRPITEM  = userSet.indexOfColumn("GRPITEM");
				int idxASKITEM  = userSet.indexOfColumn("ASKITEM");
				int idxESCR       = userSet.indexOfColumn("ESCR");
				int idxGSCR      = userSet.indexOfColumn("GSCR");
				int idxMSCR      = userSet.indexOfColumn("MSCR");
				int idxLSCR       = userSet.indexOfColumn("LSCR");
				int idxPSCR       = userSet.indexOfColumn("PSCR");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "insert into PAYROLL.HVSHEET( EVAYM,	  GRPCD,	DIVCD,	JOBGRPH,	PRTSEQ, " );
				InsertSql.append( "                                            GRPITEM, ASKITEM,ESCR,	GSCR,	    MSCR,	LSCR,	PSCR ) " );
				InsertSql.append( "                                 values  (?,?,?,?,?,?,?,?,?,?,?,?)" );
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( " update PAYROLL.HVSHEET set GRPITEM=?,ASKITEM=?,ESCR=?,GSCR=?,MSCR=?," );
                UpdateSql.append( "                                             LSCR=?,PSCR=?");
			    UpdateSql.append( "  where  EVAYM = ?  " );
				UpdateSql.append( "      and  GRPCD = ?  " );
				UpdateSql.append( "      and  DIVCD = ?  " );
				UpdateSql.append( "      and  JOBGRPH = ?  " );
				UpdateSql.append( "      and  PRTSEQ = ?  " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "delete from  PAYROLL.HVSHEET " );
				DeleteSql.append( "  where  EVAYM = ?  " );
				DeleteSql.append( "      and  GRPCD = ?  " );
				DeleteSql.append( "      and  DIVCD = ?  " );
				DeleteSql.append( "      and  JOBGRPH = ?  " );
				DeleteSql.append( "      and  PRTSEQ = ?  " );

            /*    DeleteSql.append( "where EVAYM = " );  */

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxEVAYM);
						gsmt.bindColumn(2, idxGRPCD);
						gsmt.bindColumn(3, idxDIVCD);
						gsmt.bindColumn(4, idxJOBGRPH);
						gsmt.bindColumn(5, idxPRTSEQ);
						gsmt.bindColumn(6, idxGRPITEM);
						gsmt.bindColumn(7, idxASKITEM);
						gsmt.bindColumn(8, idxESCR);
						gsmt.bindColumn(9, idxGSCR);
						gsmt.bindColumn(10, idxMSCR);
						gsmt.bindColumn(11, idxLSCR);
						gsmt.bindColumn(12, idxPSCR);
						gsmt.executeUpdate();
						gsmt.close();
					}

				
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxGRPITEM);
						gsmt.bindColumn(2, idxASKITEM);
						gsmt.bindColumn(3, idxESCR);
						gsmt.bindColumn(4, idxGSCR);
						gsmt.bindColumn(5, idxMSCR);
						gsmt.bindColumn(6, idxLSCR);
						gsmt.bindColumn(7, idxPSCR);
						gsmt.bindColumn(8, idxEVAYM);
						gsmt.bindColumn(9, idxGRPCD);
						gsmt.bindColumn(10, idxDIVCD);
						gsmt.bindColumn(11, idxJOBGRPH);
						gsmt.bindColumn(12, idxPRTSEQ);
						gsmt.executeUpdate(); 
						gsmt.close();       
                                    
					}      
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEVAYM);
						gsmt.bindColumn(2, idxGRPCD);
						gsmt.bindColumn(3, idxDIVCD);
						gsmt.bindColumn(4, idxJOBGRPH);
						gsmt.bindColumn(5, idxPRTSEQ);
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