package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400020_t2 extends HttpServlet{
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
	 		
	 		
	 		String strAcctcd="";  //계좌코드
	 		
			try {
				
				conn = service.getDBConnection();	
				conn.setAutoCommit(false);
				
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String str1 = reqGauce.getParameter("v_str1");				//사용자
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxACCTNO          = userSet.indexOfColumn("ACCTNO");
				int idxDEALDT          = userSet.indexOfColumn("DEALDT");
				int idxACCTCD          = userSet.indexOfColumn("ACCTCD");
				int idxREMARK          = userSet.indexOfColumn("REMARK");
				int idxINAMT           = userSet.indexOfColumn("INAMT");
				int idxOUTAMT          = userSet.indexOfColumn("OUTAMT");
				int idxBALAMT          = userSet.indexOfColumn("BALAMT");
				int idxFINAMT          = userSet.indexOfColumn("FINAMT");
				int idxFOUTAMT         = userSet.indexOfColumn("FOUTAMT");
				int idxFBALAMT         = userSet.indexOfColumn("FBALAMT");
				int idxCURUNIT         = userSet.indexOfColumn("CURUNIT");
				int idxEXRATE          = userSet.indexOfColumn("EXRATE");
				int idxTRISSUE         = userSet.indexOfColumn("TRISSUE");
				int idxDEDATE          = userSet.indexOfColumn("DEDATE");
				int idxDETIME          = userSet.indexOfColumn("DETIME");
				int idxRESULT          = userSet.indexOfColumn("RESULT");
				int idxRSTREMARK       = userSet.indexOfColumn("RSTREMARK");
				int idxRSTSEQ          = userSet.indexOfColumn("RSTSEQ");
				int idxTEAM            = userSet.indexOfColumn("TEAM");
				int idxINRATE          = userSet.indexOfColumn("INRATE");
				int idxCOSTCD          = userSet.indexOfColumn("COSTCD");
				int idxWRID            = userSet.indexOfColumn("WRID");
							
								
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				
				GauceStatement gsmt= null;
				
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ACDEPOSIT SET  \n" );
				UpdateSql.append( " INAMT = ?,      \n" );
				UpdateSql.append( " OUTAMT = ?,      \n" );
				UpdateSql.append( " BALAMT = ?,      \n" );
				UpdateSql.append( " EXRATE = ?,      \n" );
				UpdateSql.append( " TRISSUE = ?,      \n" );
				UpdateSql.append( " RESULT = ?,      \n" );
				UpdateSql.append( " RSTREMARK = ?,   \n" );
				UpdateSql.append( " RSTSEQ = ?,      \n" );
				UpdateSql.append( " COSTCD = ?,      \n" );
				UpdateSql.append( " UPID = ?,        \n" );
				UpdateSql.append( " UPDT = CURRENT_TIMESTAMP   \n" );
				UpdateSql.append( " WHERE ACCTNO = ? \n" );
				UpdateSql.append( "   AND DEALDT = ? \n" );
				
				for (int j = 0; j < rows.length; j++){
					
					if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
						//gsmt.setString(idxUPID, str1);
						rows[j].setString(idxWRID,str1);
												
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxINAMT);
						gsmt.bindColumn(2, idxOUTAMT);
						gsmt.bindColumn(3, idxBALAMT);
						gsmt.bindColumn(4, idxEXRATE);
						gsmt.bindColumn(5, idxTRISSUE);
						gsmt.bindColumn(6, idxRESULT);
						gsmt.bindColumn(7, idxRSTREMARK);
						gsmt.bindColumn(8, idxRSTSEQ);
						gsmt.bindColumn(9, idxCOSTCD);
						gsmt.bindColumn(10, idxWRID);
						gsmt.bindColumn(11,idxACCTNO);
						gsmt.bindColumn(12,idxDEALDT);
						
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