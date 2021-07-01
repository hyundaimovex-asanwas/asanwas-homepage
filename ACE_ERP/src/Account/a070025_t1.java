package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a070025_t1 extends HttpServlet{
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

				String strChgno = null;
    
		        /************************************************************************************
		         @ Master
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

			  //logger.err.println(this,"STEP1::");
			
				String str1 = reqGauce.getParameter("v_str1");  //사번 
				String str2 = reqGauce.getParameter("v_str2");  //A - 저장전 , B-저장후  
        				
				int idxFDCODE      = userSet.indexOfColumn("FDCODE");   // 1
				int idxTSDAT         = userSet.indexOfColumn("TSDAT");     // 1
				int idxTSNBR        = userSet.indexOfColumn("TSNBR");     // 1
				int idxTSSEQ        = userSet.indexOfColumn("TSSEQ");     // 1
				int idxATCODE      = userSet.indexOfColumn("ATCODE");   // 1
				int idxVENDCD      = userSet.indexOfColumn("VENDCD");   // 1
				int idxJANAMT      = userSet.indexOfColumn("JANAMT");    // 1
				int idxACTDAT      = userSet.indexOfColumn("ACTDAT");    // 1
				int idxPAYDAT      = userSet.indexOfColumn("PAYDAT");    // 1
				int idxREMARK     = userSet.indexOfColumn("REMARK");    // 1
				int idxCHKCASH   = userSet.indexOfColumn("CHKCASH");  // 1
				int idxCHKBILL     = userSet.indexOfColumn("CHKBILL");     // 1
				int idxFULDAT      = userSet.indexOfColumn("FULDAT");      // 1
				int idxFSREFCD    = userSet.indexOfColumn("FSREFCD");   // 1
				int idxFSREFVAL   = userSet.indexOfColumn("FSREFVAL");  // 1
				int idxFSDAT        = userSet.indexOfColumn("FSDAT");        // 1
				int idxFSNBR        = userSet.indexOfColumn("FSNBR");       // 1
				int idxFSSTAT      = userSet.indexOfColumn("FSSTAT");      // 1
						
				GauceDataRow[] rows = userSet.getDataRows();

				GauceStatement gsmt =null;

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.AETCPAY (  " );
				InsertSql.append( " FDCODE,	  TSDAT,	   TSNBR,	   TSSEQ,	      ATCODE,   " );
				InsertSql.append( " VENDCD,	  JANAMT,	ACTDAT,	PAYDAT,	  REMARK,   " );
			    InsertSql.append( " CHKCASH,  CHKBILL,	FULDAT,	FSREFCD,  FSREFVAL,	" );
				InsertSql.append( " FSDAT,	     FSNBR,	    FSSTAT,	I_EMPNO,  I_DATE        " );
				InsertSql.append( "  ) " );
				InsertSql.append( " VALUES ( " );	 
				InsertSql.append( "  ?,?,?,?,?, " );	 
				InsertSql.append( "  ?,?,?,?,?, " );	 
				InsertSql.append( "  ?,?,?,?,?, " );	 
				InsertSql.append( "  ?,?,?,'"+str1+"',sysdate ) " );	 


				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE  ACCOUNT.AETCPAY  SET  " );
				UpdateSql.append( "               CHKCASH =? " );
				UpdateSql.append( "              ,CHKBILL =? " );
				UpdateSql.append( "              ,FULDAT =? " );
				UpdateSql.append( "              ,REMARK =? " );
				UpdateSql.append( "              ,U_EMPNO ='"+str1+"' " );
				UpdateSql.append( "              ,U_DATE =sysdate " );
				UpdateSql.append( "  WHERE  FDCODE =? " );
				UpdateSql.append( "      AND  TSDAT = ?  " );
				UpdateSql.append( " 	  AND  TSNBR =?  " );
				UpdateSql.append( " 	  AND  TSSEQ=?   " );


				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE  FROM ACCOUNT.AETCPAY   " );
				DeleteSql.append( "  WHERE  FDCODE =? 	" );
				DeleteSql.append( "       AND  TSDAT = ?  	" );
				DeleteSql.append( " 	  AND  TSNBR =?  		" );
				DeleteSql.append( " 	  AND  TSSEQ=?   		" );
		
        //===================================================================================
				for (int j = 0; j < rows.length; j++){        	        
		
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						 
						if(str2.equals("A")){ //저장전 
							gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);
						
							gsmt.bindColumn(1,idxFDCODE); 
							gsmt.bindColumn(2,idxTSDAT); 
							gsmt.bindColumn(3,idxTSNBR); 
							gsmt.bindColumn(4,idxTSSEQ); 
							gsmt.bindColumn(5,idxATCODE); 
							gsmt.bindColumn(6,idxVENDCD); 
							gsmt.bindColumn(7,idxJANAMT); 
							gsmt.bindColumn(8,idxACTDAT); 
							gsmt.bindColumn(9,idxPAYDAT); 
							gsmt.bindColumn(10,idxREMARK); 
							gsmt.bindColumn(11,idxCHKCASH); 
							gsmt.bindColumn(12,idxCHKBILL); 
							gsmt.bindColumn(13,idxFULDAT); 
							gsmt.bindColumn(14,idxFSREFCD); 
							gsmt.bindColumn(15,idxFSREFVAL); 
							gsmt.bindColumn(16,idxFSDAT); 
							gsmt.bindColumn(17,idxFSNBR); 
							gsmt.bindColumn(18,idxFSSTAT); 
												
							gsmt.executeUpdate();
							gsmt.close();
						}
						
						if(str2.equals("B")){ //저장후 
							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1,idxCHKCASH); 
							gsmt.bindColumn(2,idxCHKBILL); 
							gsmt.bindColumn(3,idxFULDAT); 
							gsmt.bindColumn(4,idxREMARK);
							gsmt.bindColumn(5,idxFDCODE); 
							gsmt.bindColumn(6,idxTSDAT); 
							gsmt.bindColumn(7,idxTSNBR); 
							gsmt.bindColumn(8,idxTSSEQ); 
						
							gsmt.executeUpdate();
							gsmt.close();
						}
						
					} //if jobtype
					
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
												 
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,idxFDCODE); 
						gsmt.bindColumn(2,idxTSDAT); 
						gsmt.bindColumn(3,idxTSNBR); 
						gsmt.bindColumn(4,idxTSSEQ); 
											
						gsmt.executeUpdate();
						gsmt.close();
	
					} //if jobtype

				}  //for j 
			} //try
			catch(Exception e){
				conn.rollback();
				//logger.err.println(this,"errno::"+strErrorNo);
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