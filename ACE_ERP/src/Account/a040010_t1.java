package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040010_t1 extends HttpServlet{
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

				//String str1 = reqGauce.getParameter("v_str1");

				//USER Master

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE      = userSet.indexOfColumn("FDCODE");
				int idx1FS         = userSet.indexOfColumn("FS1");
				int idxFSDAT       = userSet.indexOfColumn("FSDAT");
				int idx1FSDAT      = userSet.indexOfColumn("FSDAT1");
				int idxFSNBR       = userSet.indexOfColumn("FSNBR");
				int idx2FSDAT      = userSet.indexOfColumn("FSDAT2");
				int idxFSKND       = userSet.indexOfColumn("FSKND");
				int idxFSWRTDAT    = userSet.indexOfColumn("FSWRTDAT");
				int idxCOCODE      = userSet.indexOfColumn("COCODE");
				int idxDEPTCD      = userSet.indexOfColumn("DEPTCD");
				int idxEMPNO       = userSet.indexOfColumn("EMPNO");
				int idxDIVCD       = userSet.indexOfColumn("DIVCD");
				int idxFSVAT       = userSet.indexOfColumn("FSVAT");
				int idxFSAMT       = userSet.indexOfColumn("FSAMT");
				int idxDETOT       = userSet.indexOfColumn("DETOT");
				int idxCRTOT       = userSet.indexOfColumn("CRTOT");
				int idxREMARK      = userSet.indexOfColumn("REMARK");
				int idxSGNDAT      = userSet.indexOfColumn("SGNDAT");
				int idxFSSTAT      = userSet.indexOfColumn("FSSTAT");
				int idxACTDAT      = userSet.indexOfColumn("ACTDAT");
				

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.MFSLIPMST ( " );
				InsertSql.append( " FDCODE, FSDAT, FSNBR, FSKND, FSWRTDAT, COCODE, DEPTCD, EMPNO, " );
				InsertSql.append( " DIVCD, FSVAT, FSAMT, DETOT, CRTOT, REMARK, SGNDAT, FSSTAT, ACTDAT  " );
				InsertSql.append( " )" );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? ) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.MFSLIPMST SET " );
				UpdateSql.append( "        FSKND = ?," );
				UpdateSql.append( "        FSWRTDAT = ?," );
				UpdateSql.append( "        COCODE = ?," );
				UpdateSql.append( "        DEPTCD = ?," );
				UpdateSql.append( "        EMPNO = ?," );
				UpdateSql.append( "        DIVCD = ?," );
				UpdateSql.append( "        FSVAT = ?," );
				UpdateSql.append( "        FSAMT = ?," );
				UpdateSql.append( "        DETOT = ?," );
				UpdateSql.append( "        CRTOT = ?," );
				UpdateSql.append( "        REMARK = ?," );
				UpdateSql.append( "        SGNDAT = ?," );
				UpdateSql.append( "        FSSTAT = ?," );
				UpdateSql.append( "        ACTDAT = ? " );
				UpdateSql.append( " WHERE FDCODE = ? AND FSDAT = ? AND FSNBR = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.MFSLIPMST " );
				DeleteSql.append( " WHERE FDCODE = ? AND FSDAT = ? AND FSNBR = ? "  );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxFDCODE);
						gsmt.bindColumn(2, idxFSDAT);
						gsmt.bindColumn(3, idxFSNBR);
						gsmt.bindColumn(4, idxFSKND);
						gsmt.bindColumn(5, idxFSWRTDAT);
						gsmt.bindColumn(6, idxCOCODE);
						gsmt.bindColumn(7, idxDEPTCD);
						gsmt.bindColumn(8, idxEMPNO);
						gsmt.bindColumn(9, idxDIVCD);
						gsmt.bindColumn(10, idxFSVAT);
						gsmt.bindColumn(11, idxFSAMT);
						gsmt.bindColumn(12, idxDETOT);
						gsmt.bindColumn(13, idxCRTOT);
						gsmt.bindColumn(14, idxREMARK);
						gsmt.bindColumn(15, idxSGNDAT);
						gsmt.bindColumn(16, idxFSSTAT);
						gsmt.bindColumn(17, idxACTDAT);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxFSKND);
						gsmt.bindColumn(2, idxFSWRTDAT);
						gsmt.bindColumn(3, idxCOCODE);
						gsmt.bindColumn(4, idxDEPTCD);
						gsmt.bindColumn(5, idxEMPNO);
						gsmt.bindColumn(6, idxDIVCD);
						gsmt.bindColumn(7, idxFSVAT);
						gsmt.bindColumn(8, idxFSAMT);
						gsmt.bindColumn(9, idxDETOT);
						gsmt.bindColumn(10, idxCRTOT);
						gsmt.bindColumn(11, idxREMARK);
						gsmt.bindColumn(12, idxSGNDAT);
						gsmt.bindColumn(13, idxFSSTAT);
						gsmt.bindColumn(14, idxACTDAT);
						gsmt.bindColumn(15, idxFDCODE);
						gsmt.bindColumn(16, idxFSDAT);
						gsmt.bindColumn(17, idxFSNBR);
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxFDCODE);
						gsmt.bindColumn(2, idxFSDAT);
						gsmt.bindColumn(3, idxFSNBR);
						gsmt.executeUpdate();
						gsmt.close();
					}

				}

				//USER2 Detail

				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");

				int idxFDCODE2      = userSet2.indexOfColumn("FDCODE");
				int idxFSDAT2       = userSet2.indexOfColumn("FSDAT");
				int idxFSNBR2       = userSet2.indexOfColumn("FSNBR");
				int idxFSSEQ2       = userSet2.indexOfColumn("FSSEQ");
				int idxATCODE2      = userSet2.indexOfColumn("ATCODE");
				int idxATKORNAM2    = userSet2.indexOfColumn("ATKORNAM");
				int idxATDECR2      = userSet2.indexOfColumn("ATDECR");
				int idxCHAAMT2      = userSet2.indexOfColumn("CHAAMT");
				int idxDAEAMT2      = userSet2.indexOfColumn("DAEAMT");
				int idxFSAMT2       = userSet2.indexOfColumn("FSAMT");
				int idxREMARK2      = userSet2.indexOfColumn("REMARK");			
				int idx1FSREFSEQ2   = userSet2.indexOfColumn("FSREFSEQ01");
				int idx1FSREFCD2    = userSet2.indexOfColumn("FSREFCD01");
				int idx1FSREFVAL2   = userSet2.indexOfColumn("FSREFVAL01");
				int idxFSREFVAL2    = userSet2.indexOfColumn("FSREFVAL");
				int idx1FSREFNM2    = userSet2.indexOfColumn("FSREFNM01");
				int idx1FSRVALNM2   = userSet2.indexOfColumn("FSRVALNM01");
				int idxWRDT2        = userSet2.indexOfColumn("WRDT");
				int idxWRID2        = userSet2.indexOfColumn("WRID");
				int idxUPDT2        = userSet2.indexOfColumn("UPDT");
				int idxUPID2        = userSet2.indexOfColumn("UPID");
				int idxFSNUM2       = userSet2.indexOfColumn("FSNUM");

				GauceDataRow[] rows2 = userSet2.getDataRows();

				StringBuffer InsertSql2 = null;
				StringBuffer UpdateSql2 = null;
				StringBuffer DeleteSql2 = null;

				InsertSql2 = new StringBuffer();
				InsertSql2.append( " INSERT INTO ACCOUNT.MFSLIPDTL (  " );
				InsertSql2.append( " FDCODE, FSDAT, FSNBR, FSSEQ, ATCODE, ATDECR, FSAMT, " );
				InsertSql2.append( " REMARK, PRIMCOST, " );
				InsertSql2.append( " WRDT, WRID, UPDT, UPID, FSNUM )" );
				InsertSql2.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,? ) " );

				UpdateSql2 = new StringBuffer();
				UpdateSql2.append( " UPDATE ACCOUNT.MFSLIPDTL SET " );
				UpdateSql2.append( "        ATCODE = ?," );
				UpdateSql2.append( "        ATDECR = ?," );
				UpdateSql2.append( "        FSAMT = ?," );
				UpdateSql2.append( "        REMARK = ?," );
				UpdateSql2.append( "        PRIMCOST = ?," );
				UpdateSql2.append( "        WRDT = ?, " );
				UpdateSql2.append( "        WRID = ?, " );
				UpdateSql2.append( "        UPDT = ?, " );
				UpdateSql2.append( "        UPID = ?, " );
				UpdateSql2.append( "        FSNUM = ? " );
				UpdateSql2.append( " WHERE FDCODE = ? AND FSDAT = ? AND FSNBR = ? AND FSSEQ = ? " );

				DeleteSql2 = new StringBuffer();
				DeleteSql2.append( " DELETE FROM ACCOUNT.MFSLIPDTL " );
				DeleteSql2.append( " WHERE FDCODE = ? AND FSDAT = ? AND FSNBR = ? AND FSSEQ = ? "  );

				for (int j = 0; j < rows2.length; j++){
					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());

						gsmt2.setGauceDataRow(rows2[j]);
						gsmt2.bindColumn(1,  idxFDCODE2);
						gsmt2.bindColumn(2,  idxFSDAT2);
						gsmt2.bindColumn(3,  idxFSNBR2);
						gsmt2.bindColumn(4,  idxFSSEQ2);
						gsmt2.bindColumn(5,  idxATCODE2);
						gsmt2.bindColumn(6,  idxATDECR2);
						gsmt2.bindColumn(7,  idxFSAMT2);
						gsmt2.bindColumn(8,  idxREMARK2);
						gsmt2.bindColumn(9,  idx1FSREFVAL2);
						gsmt2.bindColumn(10, idxWRDT2);
						gsmt2.bindColumn(11, idxWRID2);
						gsmt2.bindColumn(12, idxUPDT2);
						gsmt2.bindColumn(13, idxUPID2);	
						gsmt2.bindColumn(14, idxFSNUM2);
						gsmt2.executeUpdate();
						gsmt2.close();
					}

					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);
						gsmt2.bindColumn(1,  idxATCODE2);
						gsmt2.bindColumn(2,  idxATDECR2);
						gsmt2.bindColumn(3,  idxFSAMT2);
						gsmt2.bindColumn(4,  idxREMARK2);
						gsmt2.bindColumn(5,  idx1FSREFVAL2);
						gsmt2.bindColumn(6,  idxWRDT2);
						gsmt2.bindColumn(7,  idxWRID2);
						gsmt2.bindColumn(8,  idxUPDT2);
						gsmt2.bindColumn(9,  idxUPID2);
						gsmt2.bindColumn(10, idxFSNUM2);
						gsmt2.bindColumn(11, idxFDCODE2);
						gsmt2.bindColumn(12, idxFSDAT2);
						gsmt2.bindColumn(13, idxFSNBR2);
						gsmt2.bindColumn(14, idxFSSEQ2);
						gsmt2.executeUpdate(); 
						gsmt2.close();
					}    
						
					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);
						gsmt2.bindColumn(1, idxFDCODE2);
						gsmt2.bindColumn(2, idxFSDAT2);
						gsmt2.bindColumn(3, idxFSNBR2);
						gsmt2.bindColumn(4, idxFSSEQ2);
						gsmt2.executeUpdate();
						gsmt2.close();
					}
				}
			}	catch(Exception e){
				conn.rollback(); 
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				logger.err.println(this,e.toString());
			}
			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}	catch (Exception e) {
			logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}	finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}