package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a300010_t1 extends HttpServlet{
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
				System.out.println("step4");
				conn.setAutoCommit(false);
				System.out.println("step5");
				
				reqGauce = service.getGauceRequest();
				
				System.out.println("step6");
				resGauce = service.getGauceResponse();
				System.out.println("step7");
				
				System.out.println("step8");

				String str1 = reqGauce.getParameter("v_str1");				//사용자
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE = userSet.indexOfColumn("FDCODE");
				int idxFSDAT  = userSet.indexOfColumn("FSDAT");
				int idxFSNBR  = userSet.indexOfColumn("FSNBR");
				int idxFSSEQ  = userSet.indexOfColumn("FSSEQ");
				int idxATCODE = userSet.indexOfColumn("ATCODE");
				int idxPAYDT  = userSet.indexOfColumn("PAYDT");
				int idxENDDT  = userSet.indexOfColumn("ENDDT");
				int idxREMARK = userSet.indexOfColumn("REMARK");
				int idxDEAMT  = userSet.indexOfColumn("DEAMT");
				int idxCRAMT  = userSet.indexOfColumn("CRAMT");
				int idxSSDAT  = userSet.indexOfColumn("SSDAT");
				int idxSSNBR  = userSet.indexOfColumn("SSNBR");
				int idxVEND_CD = userSet.indexOfColumn("VEND_CD");
				int idxBILLSNO= userSet.indexOfColumn("BILLSNO");
				int idxWRID   = userSet.indexOfColumn("WRID");
				int idxUPID   = userSet.indexOfColumn("UPID");			
				int idxJOBDT   = userSet.indexOfColumn("JOBDT");			
								
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				
				GauceStatement gsmt= null;
				
				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ABILLSMST (        \n" );
				InsertSql.append( " FDCODE, FSDAT, FSNBR,  FSSEQ, ATCODE,  \n" );
				InsertSql.append( " PAYDT,  ENDDT, REMARK, DEAMT, CRAMT,   \n" );
				InsertSql.append( " SSDAT,  SSNBR, VENDCD, BILLSNO,        \n" );
				InsertSql.append( " WRID, WRDT, JOBDT                      \n" );
				InsertSql.append( " )VALUES (                               \n" );
				InsertSql.append( " ?,?,?,?,?,?,?,?,?,?,                   \n" );
				InsertSql.append( " ?,?,?,?,                               \n" );
				InsertSql.append( " ?,SYSDATE,?                            \n" );
				InsertSql.append( " )                                      \n" );
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ABILLSMST SET  \n" );
				UpdateSql.append( " BILLSNO = ?,     \n" );
				UpdateSql.append( " UPID = ?,        \n" );
				UpdateSql.append( " UPDT = SYSDATE   \n" );
				UpdateSql.append( " WHERE FDCODE = ? \n" );
				UpdateSql.append( "   AND FSDAT = ?  \n" );
				UpdateSql.append( "   AND FSNBR = ?  \n" );
				UpdateSql.append( "   AND FSSEQ = ?  \n" );
				
			
				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
				
						
						//gsmt.setString(idxWRID, str1);		
						System.out.println("InsertSql.toString()::"+InsertSql.toString());
						System.out.println("idxFDCODE ::"+rows[j].getString(idxFDCODE));
						System.out.println("idxFSDAT  ::"+rows[j].getString(idxFSDAT));
						System.out.println("idxFSNBR  ::"+rows[j].getString(idxFSNBR));
						System.out.println("idxFSSEQ  ::"+rows[j].getString(idxFSSEQ));
						System.out.println("idxATCODE ::"+rows[j].getString(idxATCODE));
						System.out.println("idxPAYDT  ::"+rows[j].getString(idxPAYDT));
						System.out.println("idxENDDT  ::"+rows[j].getString(idxENDDT));
						System.out.println("idxREMARK ::"+rows[j].getString(idxREMARK));
						System.out.println("idxDEAMT  ::"+rows[j].getString(idxDEAMT));
						System.out.println("idxCRAMT  ::"+rows[j].getString(idxCRAMT));
						System.out.println("idxSSDAT  ::"+rows[j].getString(idxSSDAT));
						System.out.println("idxSSNBR  ::"+rows[j].getString(idxSSNBR));
						System.out.println("idxVEND_CD::"+rows[j].getString(idxVEND_CD));
						System.out.println("idxBILLSNO::"+rows[j].getString(idxBILLSNO));
						System.out.println("idxWRID   ::"+rows[j].getString(idxWRID));
						System.out.println("idxUPID   ::"+rows[j].getString(idxUPID));
						
						
						//System.out.println(gsmt.getString())
						
						rows[j].setString(idxWRID,str1);
						
						System.out.println("idxWRID::"+rows[j].getString(idxWRID));
						
						gsmt = conn.getGauceStatement(InsertSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxFDCODE);
						gsmt.bindColumn(2, idxFSDAT);
						gsmt.bindColumn(3, idxFSNBR);
						gsmt.bindColumn(4, idxFSSEQ);
						gsmt.bindColumn(5, idxATCODE);
						gsmt.bindColumn(6, idxPAYDT);
						gsmt.bindColumn(7, idxENDDT);
						gsmt.bindColumn(8, idxREMARK);
						gsmt.bindColumn(9, idxDEAMT);
						gsmt.bindColumn(10, idxCRAMT);
						gsmt.bindColumn(11, idxSSDAT);
						gsmt.bindColumn(12, idxSSNBR);
						gsmt.bindColumn(13, idxVEND_CD);
						gsmt.bindColumn(14, idxBILLSNO);
						gsmt.bindColumn(15, idxWRID);
						gsmt.bindColumn(16, idxJOBDT);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
					}else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
						
						//gsmt.setString(idxUPID, str1);
						
						rows[j].setString(idxUPID,str1);
						
                        System.out.println("InsertSql.toString()::"+UpdateSql.toString());
						System.out.println("idxFDCODE::"+rows[j].getString(idxFDCODE));
						System.out.println("idxUPID::"+rows[j].getString(idxUPID));
						
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxBILLSNO);
						gsmt.bindColumn(2, idxUPID);
						gsmt.bindColumn(3, idxFDCODE);
						gsmt.bindColumn(4, idxFSDAT);
						gsmt.bindColumn(5, idxFSNBR);
						gsmt.bindColumn(6, idxFSSEQ);
						
						
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