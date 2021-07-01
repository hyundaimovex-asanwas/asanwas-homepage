package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class commiface_t1 extends HttpServlet{
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
			String strErrorNo ="";

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				//String str1 = reqGauce.getParameter("v_str1");
				//String str2 = reqGauce.getParameter("v_str2");
				//logger.dbg.println(this,"str1:" + str1+ "str2:" + str2);
        /************************************************************************************
         @ Master
				*************************************************************************************/

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE       = userSet.indexOfColumn("FDCODE");
				int idxFSDAT        = userSet.indexOfColumn("FSDAT");
				int idxFSNBR        = userSet.indexOfColumn("FSNBR");
				int idxFSKND        = userSet.indexOfColumn("FSKND");
				int idxFSWRTDAT     = userSet.indexOfColumn("FSWRTDAT");

				int idxCOCODE       = userSet.indexOfColumn("COCODE");
				int idxDEPTCD       = userSet.indexOfColumn("DEPTCD");
				int idxEMPNO        = userSet.indexOfColumn("EMPNO");
				int idxFSAMT        = userSet.indexOfColumn("FSAMT");
				int idxFSVAT        = userSet.indexOfColumn("FSVAT");

				int idxREMARK       = userSet.indexOfColumn("REMARK");
				int idxFSSTAT       = userSet.indexOfColumn("FSSTAT");
				int idxFILDCD       = userSet.indexOfColumn("FILDCD");
				int idxWRDT         = userSet.indexOfColumn("WRDT");
				int idxWRID         = userSet.indexOfColumn("WRID");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.FSLIPMST (  " );
				InsertSql.append( " FDCODE,	FSDAT,	FSNBR,	FSKND,	FSWRTDAT,  " );
				InsertSql.append( " COCODE,	DEPTCD,	EMPNO,	FSAMT,  FSVAT," );
				InsertSql.append( " REMARK, FSSTAT, WRDT,	  WRID " );
				InsertSql.append( "  ) " );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,? ) " );
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.BFSLIPMST SET " );
				UpdateSql.append( "        FSSTAT = 'Y'" );
				UpdateSql.append( "  WHERE FDCODE=?" );
				UpdateSql.append( "    AND FSDAT=?" );
				UpdateSql.append( "    AND FSNBR=?" );

				/************************************************************************************
         		@ Master End
				*************************************************************************************/

    
				/************************************************************************************
         		@ Detail
				*************************************************************************************/
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");

				int idxFDCODE2       = userSet2.indexOfColumn("FDCODE");
				int idxFSDAT2        = userSet2.indexOfColumn("FSDAT");
				int idxFSNBR2        = userSet2.indexOfColumn("FSNBR");
				int idxFSSEQ2        = userSet2.indexOfColumn("FSSEQ");
				int idxATCODE2       = userSet2.indexOfColumn("ATCODE");
				int idxATDECR2       = userSet2.indexOfColumn("ATDECR");
				int idxFSAMT2        = userSet2.indexOfColumn("FSAMT");
				int idxACNNBR2       = userSet2.indexOfColumn("ACNNBR");
				int idxERCODE2       = userSet2.indexOfColumn("ERCODE");
				int idxERAMT2        = userSet2.indexOfColumn("ERAMT");
				int idxERCRORAT2     = userSet2.indexOfColumn("ERCRORAT");
				int idxREMARK2       = userSet2.indexOfColumn("REMARK");
				int idxGUBN2         = userSet2.indexOfColumn("GUBN");
				int idxWRDT2         = userSet2.indexOfColumn("WRDT");
				int idxWRID2         = userSet2.indexOfColumn("WRID");

				GauceDataRow[]rows2 = userSet2.getDataRows();
				
				StringBuffer InsertSql2 = null;
				InsertSql2 = new StringBuffer();

				InsertSql2.append( " INSERT INTO ACCOUNT.FSLIPDTL (  " );
				InsertSql2.append( " FDCODE,	FSDAT,	FSNBR,	FSSEQ,	ATCODE,   " );
				InsertSql2.append( " ATDECR,  FSAMT,  ACNNBR,	REMARK, WRDT,   WRID " );
				InsertSql2.append( "  ) " );
				InsertSql2.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,? ) " );
        
			    /************************************************************************************
	         	@ Detail End
				*************************************************************************************/

				for (int j = 0; j < rows.length; j++){
       
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						strErrorNo = rows[j].getString(idxFDCODE)+"-"+rows[j].getString(idxFSDAT)+"-"+rows[j].getString(idxFSNBR);
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
						gsmt.bindColumn(9, idxFSAMT);
						gsmt.bindColumn(10, idxFSVAT);
						gsmt.bindColumn(11, idxREMARK);
						gsmt.bindColumn(12, idxFSSTAT);
						gsmt.bindColumn(13, idxWRDT);
						gsmt.bindColumn(14, idxWRID);
						gsmt.executeUpdate();
						gsmt.close();

						for (int k=0;k<rows2.length; k++){
						
							if((rows[j].getString(idxFDCODE).equals(rows2[k].getString(idxFDCODE2)))
							 &&(rows[j].getString(idxFSDAT).equals(rows2[k].getString(idxFSDAT2)))
							 &&(rows[j].getString(idxFSNBR).equals(rows2[k].getString(idxFSNBR2)))){

								GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
								gsmt2.setGauceDataRow(rows2[k]);
								gsmt2.bindColumn(1, idxFDCODE2);
								gsmt2.bindColumn(2, idxFSDAT2);
								gsmt2.bindColumn(3, idxFSNBR2);
								gsmt2.bindColumn(4, idxFSSEQ2);
								gsmt2.bindColumn(5, idxGUBN2);
								gsmt2.bindColumn(6, idxATDECR2);
								gsmt2.bindColumn(7, idxFSAMT2);
								gsmt2.bindColumn(8, idxACNNBR2);
								gsmt2.bindColumn(9, idxREMARK2);
								gsmt2.bindColumn(10, idxWRDT2);
								gsmt2.bindColumn(11, idxWRID2);
							
								gsmt2.executeUpdate();
								gsmt2.close();
							}//if
						} //for k 
					
						GauceStatement gsmt9 = conn.getGauceStatement(UpdateSql.toString());
						gsmt9.setGauceDataRow(rows[j]);
						gsmt9.bindColumn(1, idxFDCODE);
						gsmt9.bindColumn(2, idxFSDAT);
						gsmt9.bindColumn(3, idxFSNBR);
						gsmt9.executeUpdate(); 
						gsmt9.close();         

					}

					/*

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCMNAM);
						gsmt.bindColumn(2, idxCMLEN);
						gsmt.bindColumn(3, idxCMREMARK);
						gsmt.bindColumn(4, idxDSUDT);
						gsmt.bindColumn(5, idxCMTYPE);
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCMTYPE);
						gsmt.executeUpdate();
						gsmt.close();
					}
					*/
				}
			}
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::"+strErrorNo);
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