package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400180_t1 extends HttpServlet{
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
	 		
	 		String strEmpid="";  //관리자ID
	 		
			try {
				
				conn = service.getDBConnection();	
				conn.setAutoCommit(false);
				
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String str1 = reqGauce.getParameter("v_str1");				//사용자
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxSIGNET_ID  = userSet.indexOfColumn("SIGNET_ID");
				int idxSEQ        = userSet.indexOfColumn("SEQ");
				int idxAP_TYPE    = userSet.indexOfColumn("AP_TYPE");
				int idxEMPNO      = userSet.indexOfColumn("EMPNO");
				int idxORG_SEQ        = userSet.indexOfColumn("ORG_SEQ");
				int idxWRID       = userSet.indexOfColumn("WRID");
				int idxUPID       = userSet.indexOfColumn("UPID");
				
								
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;
				
				GauceStatement gsmt= null;
				
				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.SIGNET_LINE (    \n" );
				InsertSql.append( " SIGNET_ID, SEQ, AP_TYPE, EMPNO,      \n" );
				InsertSql.append( " WRID, WRDT                           \n" );
				InsertSql.append( " )VALUES (                            \n" );
				InsertSql.append( " ?,?,?,?,                             \n" );
				InsertSql.append( " ?,CURRENT_TIMESTAMP                  \n" );
				InsertSql.append( " )                                    \n" );
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.SIGNET_LINE SET  \n" );
				UpdateSql.append( " SEQ = ?,         \n" );
				UpdateSql.append( " AP_TYPE = ?,         \n" );
				UpdateSql.append( " EMPNO   = ?,         \n" );
				UpdateSql.append( " UPID    = ?,         \n" );
				UpdateSql.append( " UPDT  = CURRENT_TIMESTAMP  \n" );
				UpdateSql.append( " WHERE SIGNET_ID  = ? \n" );
				UpdateSql.append( "   AND SEQ  = ?       \n" );
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.SIGNET_LINE \n" );
				DeleteSql.append( "  WHERE SIGNET_ID  = ? \n" );
				DeleteSql.append( "    AND SEQ        = ? \n" );
				
				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
				
						
						rows[j].setString(idxWRID, str1);	
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxSIGNET_ID);
						gsmt.bindColumn(2, idxSEQ);
						gsmt.bindColumn(3, idxAP_TYPE);
						gsmt.bindColumn(4, idxEMPNO);
						gsmt.bindColumn(5, idxWRID);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
					}else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
						
						rows[j].setString(idxUPID,str1);
												
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxSEQ);
						gsmt.bindColumn(2, idxAP_TYPE);
						gsmt.bindColumn(3, idxEMPNO);
						gsmt.bindColumn(4, idxUPID);
						gsmt.bindColumn(5, idxSIGNET_ID);
						gsmt.bindColumn(6, idxORG_SEQ);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
					
			 	   }else if (rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE){
					
						gsmt = conn.getGauceStatement(DeleteSql.toString());						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxSIGNET_ID);
						gsmt.bindColumn(2, idxSEQ);
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