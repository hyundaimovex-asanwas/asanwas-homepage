package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a070023_t2 extends HttpServlet{
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

				String strVendseq = null;
    
		        /************************************************************************************
		         @ Master
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String str1 = reqGauce.getParameter("v_str1");  //사번   
        				
				int idxVEND_CD    	   = userSet.indexOfColumn("VEND_CD");    // 채권거래처      
				int idxHIS_SEQ    	   = userSet.indexOfColumn("HIS_SEQ");    // 히스토리순번    
				int idxCERTI_EMPNO	   = userSet.indexOfColumn("CERTI_EMPNO");// 인증 전표작성자 
				int idxCERTI_DATE 	   = userSet.indexOfColumn("CERTI_DATE"); // 인증 가능일자   
				int idxWRID       	   = userSet.indexOfColumn("WRID");       // 입력자          
				int idxWRDT       	   = userSet.indexOfColumn("WRDT");       // 입력일자        
				int idxUPID       	   = userSet.indexOfColumn("UPID");       // 수정자          
				int idxUPDT       	   = userSet.indexOfColumn("UPDT");       // 수정일자     
						
				GauceDataRow[] rows = userSet.getDataRows();

				GauceStatement gsmt =null;

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				InsertSql = new StringBuffer();
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.BOND_ATTACH_HIS (  " );
				InsertSql.append( " VEND_CD, HIS_SEQ, CERTI_EMPNO, CERTI_DATE,   " );
				InsertSql.append( " WRID, WRDT 	" );
				InsertSql.append( "  ) " );
				InsertSql.append( " VALUES ( " );	 
				InsertSql.append( "  ?,?,?,?," );	 	 	 
				InsertSql.append( "  '"+str1+"',sysdate ) " );	 


				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE  ACCOUNT.BOND_ATTACH_HIS SET  " );
				UpdateSql.append( "               CERTI_EMPNO =?         " );
				UpdateSql.append( "              ,CERTI_DATE =?          " );
				UpdateSql.append( "              ,UPID ='"+str1+"' " );
				UpdateSql.append( "              ,UPDT =sysdate " );
				UpdateSql.append( "  WHERE  VEND_CD = ?  " );
				UpdateSql.append( "    AND  HIS_SEQ = ?  " );


				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE  FROM ACCOUNT.BOND_ATTACH_HIS   " );
				DeleteSql.append( "  WHERE  VEND_CD =? " );
				DeleteSql.append( "    AND  HIS_SEQ = ?  " );

		
        //===================================================================================
				for (int j = 0; j < rows.length; j++){        	        
		
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						 						 
							gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);
						
							gsmt.bindColumn(1,idxVEND_CD); 
							gsmt.bindColumn(2,idxHIS_SEQ); 
							gsmt.bindColumn(3,idxCERTI_EMPNO);
							gsmt.bindColumn(4,idxCERTI_DATE);

							gsmt.executeUpdate();
							gsmt.close();
					
												
					} //if jobtype
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						    gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1,idxCERTI_EMPNO); 
							gsmt.bindColumn(2,idxCERTI_DATE); 
							gsmt.bindColumn(3,idxVEND_CD); 
							gsmt.bindColumn(4,idxHIS_SEQ); 

							gsmt.executeUpdate();
							gsmt.close();
					}
					
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
												 
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,idxVEND_CD); 
						gsmt.bindColumn(2,idxHIS_SEQ); 
											
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