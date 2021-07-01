package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090002_t1 extends HttpServlet{
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

				int idxFDCODE       = userSet.indexOfColumn("FDCODE");  
				int idxASNBR        = userSet.indexOfColumn("ASNBR");   
				int idxHISDAT       = userSet.indexOfColumn("HISDAT");   
				int idxHISNBR       = userSet.indexOfColumn("HISNBR");   
				int idxPRODIV       = userSet.indexOfColumn("PRODIV");
				int idxINOUTDIV     = userSet.indexOfColumn("INOUTDIV");  
				int idxASETBALAMT   = userSet.indexOfColumn("ASETBALAMT");  
				int idxMUSREPAMT    = userSet.indexOfColumn("MUSREPAMT");   
				int idxSALEAMT      = userSet.indexOfColumn("SALEAMT");  
				int idxSALEVAT      = userSet.indexOfColumn("SALEVAT"); 
				int idxVEND_CD      = userSet.indexOfColumn("VEND_CD");
				int idxBIGO         = userSet.indexOfColumn("BIGO");
				int idxWRDT         = userSet.indexOfColumn("WRDT");
				int idxWRID         = userSet.indexOfColumn("WRID"); 
				int idxUPDT         = userSet.indexOfColumn("UPDT"); 
				int idxUPID         = userSet.indexOfColumn("UPID"); 
				int idxASDSPSTS         = userSet.indexOfColumn("ASDSPSTS"); 

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer UpdateSqlM = null;
				StringBuffer DeleteSql = null;
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ASETHIS (  " );
				InsertSql.append( " FDCODE,	ASNBR,	HISDAT,	HISNBR,	PRODIV,  " );
				InsertSql.append( " INOUTDIV,	ASETBALAMT,	MUSREPAMT,	SALEAMT,  SALEVAT,  " );
				InsertSql.append( " VEND_CD,  BIGO,  WRDT,  WRID " );
				InsertSql.append( "  ) " );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?, '" + str1 + "','" + str2 + "' ) " );
		 
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ASETHIS SET " );
				UpdateSql.append( "        PRODIV = ?," );
				UpdateSql.append( "        INOUTDIV = ?," );
				UpdateSql.append( "        ASETBALAMT = ?," );
				UpdateSql.append( "        MUSREPAMT = ?," );
				UpdateSql.append( "        SALEAMT = ?," );
				UpdateSql.append( "        SALEVAT = ?," );
		        UpdateSql.append( "        VEND_CD = ?," );
				UpdateSql.append( "        BIGO = ?," );
				UpdateSql.append( "        UPDT = '" + str1 + "'," );
				UpdateSql.append( "        UPID = '" + str2 +"' " );
				UpdateSql.append( "  WHERE FDCODE =?" );
				UpdateSql.append( "    AND ASNBR =?" );
				UpdateSql.append( "    AND HISDAT =?" );
				UpdateSql.append( "    AND HISNBR =?" );

				UpdateSqlM = new StringBuffer();
				UpdateSqlM.append( " UPDATE ACCOUNT.ASETAQS SET " );
				UpdateSqlM.append( "        ASDSPSTS = '3' " );
				UpdateSqlM.append( " WHERE FDCODE =?" );
				UpdateSqlM.append( "   AND ASNBR = ?" );
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ASETHIS " );
				DeleteSql.append( "  WHERE FDCODE= ? "  );
				DeleteSql.append( "    AND ASNBR= ? "  );
				DeleteSql.append( "    AND HISDAT= ? "  );
				DeleteSql.append( "    AND HISNBR= ? "  );

	
			
        //===================================================================================
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxFDCODE);
						gsmt.bindColumn(2, idxASNBR);
						gsmt.bindColumn(3, idxHISDAT);
						gsmt.bindColumn(4, idxHISNBR);
						gsmt.bindColumn(5, idxPRODIV);

						gsmt.bindColumn(6, idxINOUTDIV);
						gsmt.bindColumn(7, idxASETBALAMT);
						gsmt.bindColumn(8, idxMUSREPAMT);
						gsmt.bindColumn(9, idxSALEAMT);
						gsmt.bindColumn(10, idxSALEVAT);

						gsmt.bindColumn(11, idxVEND_CD);
						gsmt.bindColumn(12, idxBIGO);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
										
						gsmt.bindColumn(1, idxPRODIV);

						gsmt.bindColumn(2, idxINOUTDIV);
						gsmt.bindColumn(3, idxASETBALAMT);
						gsmt.bindColumn(4, idxMUSREPAMT);
						gsmt.bindColumn(5, idxSALEAMT);

						gsmt.bindColumn(6, idxSALEVAT);
						gsmt.bindColumn(7, idxVEND_CD);
						gsmt.bindColumn(8, idxBIGO);
						gsmt.bindColumn(9, idxFDCODE);
						gsmt.bindColumn(10, idxASNBR);
						
						gsmt.bindColumn(11, idxHISDAT);
						gsmt.bindColumn(12, idxHISNBR);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
				
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmtm= conn.getGauceStatement(UpdateSqlM.toString());
						gsmtm.setGauceDataRow(rows[j]);
										
						gsmtm.bindColumn(1, idxFDCODE);
						gsmtm.bindColumn(2, idxASNBR);

						gsmtm.executeUpdate(); 
						gsmtm.close();         
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxFDCODE);
						gsmt.bindColumn(2, idxASNBR);
						gsmt.bindColumn(3, idxHISDAT);
						gsmt.bindColumn(4, idxHISNBR);
						gsmt.executeUpdate();
						gsmt.close();

						}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			conn.commit();
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