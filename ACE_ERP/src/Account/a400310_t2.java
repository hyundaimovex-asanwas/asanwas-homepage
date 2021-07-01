package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400310_t2 extends HttpServlet{
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

				int idxAPPNO       = userSet.indexOfColumn("APPNO");
				int idxAPPSEQ      = userSet.indexOfColumn("APPSEQ");
				int idxFDCODE      = userSet.indexOfColumn("FDCODE");
				int idxATCODE      = userSet.indexOfColumn("ATCODE");
				int idxCOSTGB      = userSet.indexOfColumn("COSTGB");
				int idxCOSTCT      = userSet.indexOfColumn("COSTCT");
				int idxSUPAMT      = userSet.indexOfColumn("SUPAMT");
				int idxFOUTAMT     = userSet.indexOfColumn("FOUTAMT");
				int idxWRID        = userSet.indexOfColumn("WRID");
				int idxWRDT        = userSet.indexOfColumn("WRDT");
				int idxUPID        = userSet.indexOfColumn("UPID");
				int idxUPDT        = userSet.indexOfColumn("UPDT");
								
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;
				
				GauceStatement gsmt= null;
				
				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ACAPPCOST (     \n" );
				InsertSql.append( " APPNO,APPSEQ,FDCODE,ATCODE,COSTGB,  \n" );
				InsertSql.append( " COSTCT,SUPAMT,FOUTAMT,              \n" );
				InsertSql.append( " WRID,WRDT            \n" );
				InsertSql.append( " )VALUES (            \n" );
				InsertSql.append( " ?,?,?,?,?,           \n" );
				InsertSql.append( " ?,?,?,               \n" );
				InsertSql.append( " ?,CURRENT_TIMESTAMP  \n" );
				InsertSql.append( " )                    \n" );
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ACAPPCOST SET  \n" );
				UpdateSql.append( " ATCODE = ?,      \n" );
				UpdateSql.append( " COSTGB = ?,      \n" );
				UpdateSql.append( " COSTCT = ?,      \n" );
				UpdateSql.append( " SUPAMT = ?,      \n" );
				UpdateSql.append( " FOUTAMT = ?,     \n" );
				UpdateSql.append( " UPID = ?,        \n" );
				UpdateSql.append( " UPDT = CURRENT_TIMESTAMP   \n" );
				UpdateSql.append( " WHERE APPNO  = ? \n" );
				UpdateSql.append( "   AND APPSEQ = ? \n" );
				UpdateSql.append( "   AND FDCODE = ? \n" );
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ACAPPCOST  \n" );
				DeleteSql.append( "  WHERE APPNO = ?  \n" );
				DeleteSql.append( "    AND APPSEQ = ?  \n" );
				DeleteSql.append( "    AND FDCODE = ?  \n" );
				
				
				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
				
						rows[j].setString(idxWRID,str1);
				
						gsmt = conn.getGauceStatement(InsertSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxAPPNO);
						gsmt.bindColumn(2, idxAPPSEQ);
						gsmt.bindColumn(3, idxFDCODE);
						gsmt.bindColumn(4, idxATCODE);
						gsmt.bindColumn(5, idxCOSTGB);
						gsmt.bindColumn(6, idxCOSTCT);
						gsmt.bindColumn(7, idxSUPAMT);
						gsmt.bindColumn(8, idxFOUTAMT);
						gsmt.bindColumn(9, idxWRID);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
					}else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
				
						rows[j].setString(idxUPID,str1);
						
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxATCODE);
						gsmt.bindColumn(2, idxCOSTGB);
						gsmt.bindColumn(3, idxCOSTCT);
						gsmt.bindColumn(4, idxSUPAMT);
						gsmt.bindColumn(5, idxFOUTAMT);
						gsmt.bindColumn(6, idxUPID);		
						gsmt.bindColumn(7, idxAPPNO);
						gsmt.bindColumn(8, idxAPPSEQ);
						gsmt.bindColumn(9, idxFDCODE);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
					}else if (rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE){
						
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,idxAPPNO);
						gsmt.bindColumn(2,idxAPPSEQ);
						gsmt.bindColumn(3,idxFDCODE);
					
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