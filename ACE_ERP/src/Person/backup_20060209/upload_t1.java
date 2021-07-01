package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class upload_t1 extends HttpServlet{

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

				int idxDEPTCD     = userSet.indexOfColumn("DEPTCD");
				int idxDEPTNM    = userSet.indexOfColumn("DEPTNM");
				int idxDEPTNMK   = userSet.indexOfColumn("DEPTNMK");
				int idxDEPTNME   = userSet.indexOfColumn("DEPTNME");
				int idxDEPTPRT   = userSet.indexOfColumn("DEPTPRT");
				int idxTREECD     = userSet.indexOfColumn("TREECD");
				int idxFRDT         = userSet.indexOfColumn("FRDT");
				int idxTODT         = userSet.indexOfColumn("TODT");
				int idxUSEYN      = userSet.indexOfColumn("USEYN");
				int idxREDTAXYN= userSet.indexOfColumn("REDTAXYN");
				int idxLEVEL        = userSet.indexOfColumn("LEVEL");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "insert into PAYROLL.HCDEPT( DEPTCD,	  DEPTNM,	DEPTNMK,	DEPTNME,	DEPTPRT, " );
				InsertSql.append( "                                            TREECD, FRDT,  TODT,	USEYN,	    REDTAXYN,	LEVEL ) " );
				InsertSql.append( "                                 values  (?,?,?,?,?,?,?,?,?,?,?)" );

				for (int j = 0; j < rows.length; j++){
				//	if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxDEPTCD     );
						gsmt.bindColumn(2,  idxDEPTNM     );
						gsmt.bindColumn(3,  idxDEPTNMK   );
						gsmt.bindColumn(4,  idxDEPTNME   );
						gsmt.bindColumn(5,  idxDEPTPRT    );
						gsmt.bindColumn(6,  idxTREECD    );
						gsmt.bindColumn(7,  idxFRDT        );
						gsmt.bindColumn(8,  idxTODT        );
						gsmt.bindColumn(9,  idxUSEYN       );
						gsmt.bindColumn(10, idxREDTAXYN );
						gsmt.bindColumn(11, idxLEVEL        );

						gsmt.executeUpdate();
						gsmt.close();
				//	}

	/*			
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
                */
				
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