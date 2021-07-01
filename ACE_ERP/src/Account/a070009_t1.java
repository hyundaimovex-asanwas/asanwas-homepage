package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a070009_t1 extends HttpServlet{
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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxEMPNO       = userSet.indexOfColumn("EMPNO"); 	
				int idxLOANDAT     = userSet.indexOfColumn("LOANDAT");     
				int idxDEAMT       = userSet.indexOfColumn("DEAMT"); 		
				int idxCRAMT       = userSet.indexOfColumn("CRAMT");       
				int idxTOTAMT      = userSet.indexOfColumn("TOTAMT");      
				int idxDAYCNT      = userSet.indexOfColumn("DAYCNT");      
				int idxTOTCNT      = userSet.indexOfColumn("TOTCNT");       
				int idxINTEREST    = userSet.indexOfColumn("INTEREST");						

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.EMPLOAN (  " );
				InsertSql.append( "  EMPNO,  LOANDAT, DEAMT, CRAMT, TOTAMT, DAYCNT,   TOTCNT,  INTEREST  )" );
				InsertSql.append( " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?  ) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.EMPLOAN SET " );  		
				UpdateSql.append( "        EMPNO = ?,        " ); 
				UpdateSql.append( "        LOANDAT = ?,      " ); 
				UpdateSql.append( "        DEAMT = ?,       " ); 				
				UpdateSql.append( "        CRAMT = ?,         " ); 				
				UpdateSql.append( "        TOTAMT = ?,      " );    
				UpdateSql.append( "        DAYCNT = ?,     " );
				UpdateSql.append( "        TOTCNT= ?,       " );  
				UpdateSql.append( "        INTEREST = ?     " ); 													             
				UpdateSql.append( " WHERE   EMPNO = ?      " );
				UpdateSql.append( " AND     LOANDAT = ?   " );
			
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.EMPLOAN  " );
				DeleteSql.append( " WHERE   EMPNO = ?      " );
				DeleteSql.append( " AND     LOANDAT = ?   " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

                        gsmt.bindColumn(1, idxEMPNO);    
						gsmt.bindColumn(2, idxLOANDAT);  
						gsmt.bindColumn(3, idxDEAMT);     
						gsmt.bindColumn(4, idxCRAMT);     
						gsmt.bindColumn(5, idxTOTAMT);    
						gsmt.bindColumn(6, idxDAYCNT);    
						gsmt.bindColumn(7, idxTOTCNT);   
						gsmt.bindColumn(8, idxINTEREST);  

						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);	
						
                        gsmt.bindColumn(1, idxEMPNO);    
						gsmt.bindColumn(2, idxLOANDAT);  
						gsmt.bindColumn(3, idxDEAMT);     
						gsmt.bindColumn(4, idxCRAMT);     
						gsmt.bindColumn(5, idxTOTAMT);    
						gsmt.bindColumn(6, idxDAYCNT);    
						gsmt.bindColumn(7, idxTOTCNT);   
						gsmt.bindColumn(8, idxINTEREST); 
						gsmt.bindColumn(9,  idxEMPNO); 
						gsmt.bindColumn(10, idxLOANDAT); 	
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
                        gsmt.bindColumn(1, idxEMPNO);    
						gsmt.bindColumn(2, idxLOANDAT);       

						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				logger.err.println(this,e.toString()); //
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