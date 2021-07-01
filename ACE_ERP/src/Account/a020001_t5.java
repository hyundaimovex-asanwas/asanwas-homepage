package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020001_t5 extends HttpServlet{
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

				//String str1 = reqGauce.getParameter("v_str1");
				//String str2 = reqGauce.getParameter("v_str2");
				//String str3 = reqGauce.getParameter("v_str3");
    
				//logger.dbg.println(this,"step1");


				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFTSTAT     = userSet.indexOfColumn("FTSTAT");
				int idxFDCODE     = userSet.indexOfColumn("FDCODE");
				int idxTSDAT      = userSet.indexOfColumn("TSDAT");
				int idxTSNBR      = userSet.indexOfColumn("TSNBR");
				int idxTSSEQ      = userSet.indexOfColumn("TSSEQ");
				int idxBTSDAT     = userSet.indexOfColumn("BTSDAT");
				int idxBTSNBR     = userSet.indexOfColumn("BTSNBR");
				int idxBTSSEQ     = userSet.indexOfColumn("BTSSEQ");
				int idxBANJAEYN   = userSet.indexOfColumn("BANJAEYN");
				int idxWRDT       = userSet.indexOfColumn("WRDT");
				int idxWRID       = userSet.indexOfColumn("WRID");
				int idxUPDT       = userSet.indexOfColumn("UPDT");
				int idxUPID       = userSet.indexOfColumn("UPID");				
			

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.BANJAEREL (  " );
				InsertSql.append( " FTSTAT, FDCODE, TSDAT,  TSNBR,  TSSEQ, " );
				InsertSql.append( " BTSDAT, BTSNBR, BTSSEQ, BANJAEYN, " );
				InsertSql.append( " WRDT,   WRID ) " );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?) " );
  
				UpdateSql = new StringBuffer();
				/*UpdateSql.append( " UPDATE ACCOUNT.BANJAEREL SET " );
        		UpdateSql.append( "        CDNAM = ?," );
				UpdateSql.append( "        CDREMARK = ?," );
				UpdateSql.append( "        UPDT = '" + str1 + "'," );
				UpdateSql.append( "        UPID = '" + str2 +"'," );
				UpdateSql.append( "        DSUDT= ?" );
				UpdateSql.append( " WHERE CMTYPE= ?" );
				UpdateSql.append( "   AND CDCODE= ?" );
				 */
				DeleteSql = new StringBuffer();
				DeleteSql.append( "  " );
			
				//logger.dbg.println(this,DeleteSql.toString());
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,idxFTSTAT);
						gsmt.bindColumn(2,idxFDCODE);
						gsmt.bindColumn(3,idxTSDAT);
						gsmt.bindColumn(4,idxTSNBR);
						gsmt.bindColumn(5,idxTSSEQ);
						gsmt.bindColumn(6,idxBTSDAT);
						gsmt.bindColumn(7,idxBTSNBR);
						gsmt.bindColumn(8,idxBTSSEQ);
						gsmt.bindColumn(9,idxBANJAEYN);
						gsmt.bindColumn(10,idxWRDT);
						gsmt.bindColumn(11,idxWRID);
					
						gsmt.executeUpdate();
						gsmt.close();

						//logger.dbg.println(this,"step2");

						if (rows[j].getString(idxBANJAEYN).equals("Y")){ //반제완료 된건은 원전표번호가 같은 건에 대해서 모두 update 처리함.

							UpdateSql.append( " UPDATE ACCOUNT.BANJAEREL SET " );
							UpdateSql.append( "        BANJAEYN ='" + rows[j].getString(idxBANJAEYN) + "'," );
							UpdateSql.append( "        UPDT = '" + rows[j].getString(idxUPDT) + "'," );
							UpdateSql.append( "        UPID = '" + rows[j].getString(idxUPID) +"'"  );
							UpdateSql.append( " WHERE TSDAT=  '" + rows[j].getString(idxTSDAT) +"'" );
							UpdateSql.append( "   AND TSNBR=  '" + rows[j].getString(idxTSNBR) +"'" );
							UpdateSql.append( "   AND TSSEQ=  '" + rows[j].getString(idxTSSEQ) +"'" );

							GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql.toString());
							gsmt2.executeUpdate();
							gsmt2.close();
						}

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					/*	GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCDNAM);
						gsmt.bindColumn(2, idxCDREMARK);
						gsmt.bindColumn(3, idxDSUDT);
						gsmt.bindColumn(4, idxCMTYPE);
            			gsmt.bindColumn(5, idxCDCODE);
						gsmt.executeUpdate(); 
						gsmt.close();         
					 */                         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
					/*	GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCMTYPE);
						gsmt.bindColumn(2, idxCDCODE);
						gsmt.executeUpdate();
						gsmt.close();
					 */
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