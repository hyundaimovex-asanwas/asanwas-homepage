package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400310_t1 extends HttpServlet{
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
				conn.setAutoCommit(false);
			
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
			
				String str1 = reqGauce.getParameter("v_str1");				//사용자
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPNO     = userSet.indexOfColumn("APPNO");
				int idxFDCODE    = userSet.indexOfColumn("FDCODE");
				int idxAPPDATE   = userSet.indexOfColumn("APPDATE");
				int idxREQDATE   = userSet.indexOfColumn("REQDATE");
				int idxPAYDATE   = userSet.indexOfColumn("PAYDATE");
				int idxATCODE    = userSet.indexOfColumn("ATCODE");
				int idxCOSTGB    = userSet.indexOfColumn("COSTGB");
				int idxCOSTBGT   = userSet.indexOfColumn("COSTBGT");
				int idxVENDCD    = userSet.indexOfColumn("VENDCD");
				int idxVENDNM    = userSet.indexOfColumn("VENDNM");
				int idxSUPAMT    = userSet.indexOfColumn("SUPAMT");
				int idxSUPVATAMT = userSet.indexOfColumn("SUPVATAMT");
				int idxREMARK    = userSet.indexOfColumn("REMARK");
				int idxPAYGB     = userSet.indexOfColumn("PAYGB");
				int idxPAYACCTNO = userSet.indexOfColumn("PAYACCTNO");
				int idxFOUTAMT   = userSet.indexOfColumn("FOUTAMT");
				int idxCURUNIT   = userSet.indexOfColumn("CURUNIT");
				int idxEXRATE    = userSet.indexOfColumn("EXRATE");
				int idxPURGB     = userSet.indexOfColumn("PURGB");
				int idxTAXNBR    = userSet.indexOfColumn("TAXNBR");
				int idxAPPFSDAT  = userSet.indexOfColumn("APPFSDAT");
				int idxAPPFSNBR  = userSet.indexOfColumn("APPFSNBR");
				int idxPAYSTAT   = userSet.indexOfColumn("PAYSTAT");
				int idxPAYFSDAT  = userSet.indexOfColumn("PAYFSDAT");
				int idxPAYFSNBR  = userSet.indexOfColumn("PAYFSNBR");
				int idxAPPEMPNO  = userSet.indexOfColumn("APPEMPNO");
				int idxPAYEMPNO  = userSet.indexOfColumn("PAYEMPNO");
				int idxWRID      = userSet.indexOfColumn("WRID");
				int idxWRDT      = userSet.indexOfColumn("WRDT");
				int idxUPID      = userSet.indexOfColumn("UPID");
				int idxUPDT      = userSet.indexOfColumn("UPDT");
				int idxPAYKND    = userSet.indexOfColumn("PAYKND");
				int idxCURUNITCD = userSet.indexOfColumn("CURUNITCD");
				int idxDOCUMCD   = userSet.indexOfColumn("DOCUMCD");
				int idxOUTAMT    = userSet.indexOfColumn("OUTAMT");
				int idxACCT_AUTH = userSet.indexOfColumn("ACCT_AUTH");
								
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;
				
				GauceStatement gsmt= null;
				
				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ACAPPFUND (               \n" );
				InsertSql.append( " APPNO,   FDCODE,   APPDATE,REQDATE, PAYDATE,  \n" );
				InsertSql.append( " ATCODE,  COSTGB,   COSTBGT,VENDCD,  VENDNM,   \n" );
				InsertSql.append( " SUPAMT,  SUPVATAMT,REMARK, PAYGB,   PAYACCTNO,\n" );
				InsertSql.append( " FOUTAMT, CURUNIT,  EXRATE, PURGB,   TAXNBR,   \n" );
				InsertSql.append( " APPFSDAT,APPFSNBR, PAYSTAT,PAYFSDAT,PAYFSNBR, \n" );
				InsertSql.append( " APPEMPNO,PAYEMPNO, PAYKND, CURUNITCD,DOCUMCD, OUTAMT, ACCT_AUTH, \n" );
				InsertSql.append( " WRID,WRDT            \n" );
				InsertSql.append( " )VALUES (            \n" );
				InsertSql.append( " SWS_ACAPPFUND_ID.nextval, \n" );
				InsertSql.append( " ?,?,?,?,             \n" );
				InsertSql.append( " ?,?,?,?,?,           \n" );
				InsertSql.append( " ?,?,?,?,?,           \n" );
				InsertSql.append( " ?,?,?,?,?,           \n" );
				InsertSql.append( " ?,?,?,?,?,           \n" );
				InsertSql.append( " ?,?,?,?,?,?,?,         \n" );
				InsertSql.append( " ?,CURRENT_TIMESTAMP  \n" );
				InsertSql.append( " )                    \n" );
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ACAPPFUND SET  \n" );
				UpdateSql.append( " APPDATE = ?,     \n" );
				UpdateSql.append( " REQDATE = ?,     \n" );
				UpdateSql.append( " ATCODE = ?,      \n" );
				UpdateSql.append( " COSTGB = ?,      \n" );
				UpdateSql.append( " COSTBGT = ?,     \n" );
				UpdateSql.append( " VENDCD = ?,      \n" );
				UpdateSql.append( " VENDNM = ?,      \n" );
				UpdateSql.append( " SUPAMT = ?,      \n" );
				UpdateSql.append( " SUPVATAMT = ?,   \n" );
				UpdateSql.append( " REMARK = ?,      \n" );
				UpdateSql.append( " PAYGB = ?,       \n" );
				UpdateSql.append( " PAYACCTNO = ?,   \n" );
				UpdateSql.append( " FOUTAMT = ?,     \n" );
				UpdateSql.append( " CURUNIT = ?,     \n" );
				UpdateSql.append( " EXRATE = ?,      \n" );
				UpdateSql.append( " PURGB = ?,       \n" );
				UpdateSql.append( " PAYKND = ?,      \n" );
				UpdateSql.append( " CURUNITCD = ?,   \n" );
				UpdateSql.append( " DOCUMCD = ?,     \n" );
				UpdateSql.append( " OUTAMT = ?,      \n" );
				UpdateSql.append( " ACCT_AUTH = ?,   \n" );
				UpdateSql.append( " UPID = ?,        \n" );
				UpdateSql.append( " UPDT = SYSDATE   \n" );
				UpdateSql.append( " WHERE APPNO = ?  \n" );
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ACAPPFUND  \n" );
				DeleteSql.append( "  WHERE APPNO = ?  \n" );
				
				
				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
						rows[j].setString(idxWRID,str1);
					
						gsmt = conn.getGauceStatement(InsertSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxFDCODE);
						gsmt.bindColumn(2, idxAPPDATE);
						gsmt.bindColumn(3, idxREQDATE);
						gsmt.bindColumn(4, idxPAYDATE);
						gsmt.bindColumn(5, idxATCODE);
						gsmt.bindColumn(6, idxCOSTGB);
						gsmt.bindColumn(7, idxCOSTBGT);
						gsmt.bindColumn(8, idxVENDCD);
						gsmt.bindColumn(9, idxVENDNM);
						gsmt.bindColumn(10,idxSUPAMT);
						gsmt.bindColumn(11,idxSUPVATAMT);
						gsmt.bindColumn(12,idxREMARK);
						gsmt.bindColumn(13,idxPAYGB);
						gsmt.bindColumn(14,idxPAYACCTNO);
						gsmt.bindColumn(15,idxFOUTAMT);
						gsmt.bindColumn(16,idxCURUNIT);
						gsmt.bindColumn(17,idxEXRATE);
						gsmt.bindColumn(18,idxPURGB);
						gsmt.bindColumn(19,idxTAXNBR);
						gsmt.bindColumn(20,idxAPPFSDAT);
						gsmt.bindColumn(21,idxAPPFSNBR);
						gsmt.bindColumn(22,idxPAYSTAT);
						gsmt.bindColumn(23,idxPAYFSDAT);
						gsmt.bindColumn(24,idxPAYFSNBR);
						gsmt.bindColumn(25,idxAPPEMPNO);
						gsmt.bindColumn(26,idxPAYEMPNO);
						gsmt.bindColumn(27,idxPAYKND);
						gsmt.bindColumn(28,idxCURUNITCD);
						gsmt.bindColumn(29,idxDOCUMCD);
						gsmt.bindColumn(30,idxOUTAMT);
						gsmt.bindColumn(31,idxACCT_AUTH);
						gsmt.bindColumn(32,idxWRID);
						
						
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
					}else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
				
						rows[j].setString(idxUPID,str1);
						
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxAPPDATE);
						gsmt.bindColumn(2, idxREQDATE);
						gsmt.bindColumn(3, idxATCODE);
						gsmt.bindColumn(4, idxCOSTGB);
						gsmt.bindColumn(5, idxCOSTBGT);
						gsmt.bindColumn(6, idxVENDCD);
						gsmt.bindColumn(7, idxVENDNM);
						gsmt.bindColumn(8, idxSUPAMT);
						gsmt.bindColumn(9, idxSUPVATAMT);
						gsmt.bindColumn(10,idxREMARK);
						gsmt.bindColumn(11,idxPAYGB);
						gsmt.bindColumn(12,idxPAYACCTNO);
						gsmt.bindColumn(13,idxFOUTAMT);
						gsmt.bindColumn(14,idxCURUNIT);
						gsmt.bindColumn(15,idxEXRATE);
						gsmt.bindColumn(16,idxPURGB);
						gsmt.bindColumn(17,idxPAYKND);
						gsmt.bindColumn(18,idxCURUNITCD);
						gsmt.bindColumn(19,idxDOCUMCD);
						gsmt.bindColumn(20,idxOUTAMT);
						gsmt.bindColumn(21,idxACCT_AUTH);
						gsmt.bindColumn(22,idxUPID);
						gsmt.bindColumn(23,idxAPPNO);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
					}else if (rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE){
						
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,idxAPPNO);
					
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
					}
				}
			}
			catch(Exception e){
				System.out.println("ERROR000::"+e);
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			conn.commit(); 
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			
			System.out.println("ERROR::"+e);
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}