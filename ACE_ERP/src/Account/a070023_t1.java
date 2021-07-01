package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a070023_t1 extends HttpServlet{
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
        				
				int idxVEND_CD	   = userSet.indexOfColumn("VEND_CD");   // 1
				int idxVEND_SEQ	   = userSet.indexOfColumn("VEND_SEQ"); // 1
				int idxVEND_NM	   = userSet.indexOfColumn("VEND_NM");  // 1
				int idxVEND_ID	       = userSet.indexOfColumn("VEND_ID");    // 1
				int idxCREDITOR	   = userSet.indexOfColumn("CREDITOR"); // 1
				int idxDEMAMT	   = userSet.indexOfColumn("DEMAMT");    // 1
				int idxRECDAT	       = userSet.indexOfColumn("RECDAT");     // 1
				int idxDEPDAT        = userSet.indexOfColumn("DEPDAT");      // 1
				int idxCANDAT	       = userSet.indexOfColumn("CANDAT");     // 1
				int idxCREDGB	   = userSet.indexOfColumn("CREDGB");     // 1
				int idxREMARK	       = userSet.indexOfColumn("REMARK");     // 1
				int idxI_EMPNO       = userSet.indexOfColumn("I_EMPNO");    // 1
				int idxI_DATE           = userSet.indexOfColumn("I_DATE");       // 1
				int idxU_EMPNO      = userSet.indexOfColumn("U_EMPNO");  // 1
				int idxU_DATE         = userSet.indexOfColumn("U_DATE");      // 1
				
						
				GauceDataRow[] rows = userSet.getDataRows();

				GauceStatement gsmt =null;

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				InsertSql = new StringBuffer();
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.BOND_ATTACH (  " );
				InsertSql.append( " VEND_CD, VEND_SEQ, VEND_NM, VEND_ID, CREDITOR, DEMAMT,   " );
				InsertSql.append( " RECDAT,  DEPDAT,   CANDAT,  CREDGB,   REMARK,    " );
				InsertSql.append( " I_EMPNO, I_DATE 	" );
				InsertSql.append( "  ) " );
				InsertSql.append( " VALUES ( " );	 
				InsertSql.append( "  ?,?,?,?,?,?, " );	 	 
				InsertSql.append( "  ?,?,?,?,?, " );	 
				InsertSql.append( "  '"+str1+"',sysdate ) " );	 


				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE  ACCOUNT.BOND_ATTACH SET  " );
				UpdateSql.append( "               CREDITOR =?      " );
				UpdateSql.append( "              ,DEMAMT =?        " );
				UpdateSql.append( "              ,RECDAT =?        " );
				UpdateSql.append( "              ,DEPDAT =?        " );
				UpdateSql.append( "              ,CANDAT =?        " );
				UpdateSql.append( "              ,CREDGB =?        " );
				UpdateSql.append( "              ,REMARK =?        " );
				UpdateSql.append( "              ,U_EMPNO ='"+str1+"' " );
				UpdateSql.append( "              ,U_DATE =sysdate " );
				UpdateSql.append( "  WHERE  VEND_CD =?    " );
				UpdateSql.append( "       AND  VEND_SEQ = ?  " );



				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE  FROM ACCOUNT.BOND_ATTACH   " );
				DeleteSql.append( "  WHERE  VEND_CD =? " );
				DeleteSql.append( "       AND  VEND_SEQ = ?  " );

		
        //===================================================================================
				for (int j = 0; j < rows.length; j++){        	        
		
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
					     	strVendseq="";
						   
							Statement stmt = conn.createStatement();
							StringBuffer sql = new StringBuffer();
							sql.append( "  SELECT LPAD(TO_NUMBER(NVL(MAX(VEND_SEQ),0))+1,3,0) ");
							sql.append( "	  FROM ACCOUNT.BOND_ATTACH "); 
							sql.append( "	WHERE VEND_CD ='"+rows[j].getString(idxVEND_CD)+"'"); 
							
							ResultSet rs = stmt.executeQuery(sql.toString()); 
	
							if(rs.next()){
								 strVendseq=  rs.getString(1);
							}
							rs.close();
							stmt.close();
						
						    rows[j].setString(idxVEND_SEQ,strVendseq);
						 						 
							gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);
						
							gsmt.bindColumn(1,idxVEND_CD); 
							gsmt.bindColumn(2,idxVEND_SEQ); 
							gsmt.bindColumn(3,idxVEND_NM); 
							gsmt.bindColumn(4,idxVEND_ID); 
							gsmt.bindColumn(5,idxCREDITOR); 
							gsmt.bindColumn(6,idxDEMAMT); 
							gsmt.bindColumn(7,idxRECDAT); 
							gsmt.bindColumn(8,idxDEPDAT); 
							gsmt.bindColumn(9,idxCANDAT); 
							gsmt.bindColumn(10,idxCREDGB); 
							gsmt.bindColumn(11,idxREMARK); 

							gsmt.executeUpdate();
							gsmt.close();
					
												
					} //if jobtype
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						    gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1,idxCREDITOR); 
							gsmt.bindColumn(2,idxDEMAMT); 
							gsmt.bindColumn(3,idxRECDAT); 
							gsmt.bindColumn(4,idxDEPDAT); 
							gsmt.bindColumn(5,idxCANDAT); 
							gsmt.bindColumn(6,idxCREDGB); 
							gsmt.bindColumn(7,idxREMARK); 
							gsmt.bindColumn(8,idxVEND_CD); 
							gsmt.bindColumn(9,idxVEND_SEQ); 

							gsmt.executeUpdate();
							gsmt.close();

					}
					
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
												 
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,idxVEND_CD); 
						gsmt.bindColumn(2,idxVEND_SEQ); 
											
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