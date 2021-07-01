package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090029_t2 extends HttpServlet{
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
        
     
				/************************************************************************************
         		@ Master
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String strEmpno = reqGauce.getParameter("v_str1");  //사번
				String strStatus ="";

				int idxFDCODE           = userSet.indexOfColumn("FDCODE");     // 1
				int idxASTCIPCD         = userSet.indexOfColumn("ASTCIPCD");   // 1
				int idxASTYYMM          = userSet.indexOfColumn("ASTYYMM");    // 1
				int idxASAQSDAT         = userSet.indexOfColumn("ASAQSDAT");   // 1
				int idxASTNAME          = userSet.indexOfColumn("ASTNAME");    // 1
				int idxASTNBR           = userSet.indexOfColumn("ASTNBR");     // 1
				int idxASTRAMT          = userSet.indexOfColumn("ASTRAMT");    // 1
				int idxASTRAMTY         = userSet.indexOfColumn("ASTRAMTY");   // 1
				int idxREMARK           = userSet.indexOfColumn("REMARK");     // 1
				int idxATCODE           = userSet.indexOfColumn("ATCODE");     // 1

				GauceDataRow[] rows = userSet.getDataRows();

				GauceStatement gsmt =null;

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer UpdateSql2 = null;
				StringBuffer DeleteSql = null;
				StringBuffer Sql = null; 
								
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ASTCIPR (  															" );
				InsertSql.append( " FDCODE,	ASTCIPCD,	ASTYYMM,	ASAQSDAT,	ASTNAME,							" );
				InsertSql.append( " ASTNBR,	ASTRAMT,	ASTRAMTY,	REMARK,  	ATCODE,	 I_EMPNO,	I_DATE   " );
				InsertSql.append( "  ) 																										" );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,'"+strEmpno+"', sysdate ) 								" );	 

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ASTCIPR SET  	" );
				UpdateSql.append( "        ASAQSDAT = ?,     				");
				UpdateSql.append( "        ASTNAME  = ?,     				");
				UpdateSql.append( "        ASTNBR   = ?,    	 				");
				UpdateSql.append( "        ASTRAMT  = ?,     				");
				UpdateSql.append( "        ASTRAMTY = ?,     				");
				UpdateSql.append( "        REMARK   = ?,     				");
				UpdateSql.append( "        ATCODE   = ?,     				");
				UpdateSql.append( "        U_EMPNO  = '"+strEmpno+"',    ");
				UpdateSql.append( "        U_DATE   = sysdate  			");
				UpdateSql.append( "  WHERE FDCODE   = ?     			");
				UpdateSql.append( "    AND ASTCIPCD = ?     				");
				UpdateSql.append( "    AND ASTYYMM  = ?     				");
        
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ASTCIPR  " );
				DeleteSql.append( "  WHERE FDCODE   = ?     				" );
				DeleteSql.append( "    AND ASTCIPCD = ?     				" );
				DeleteSql.append( "    AND ASTYYMM  = ?     				" );
        				    
				//===================================================================================
				for (int j = 0; j < rows.length; j++){        	        
					//================================================================================<<<<
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1,idxFDCODE); 
						gsmt.bindColumn(2,idxASTCIPCD); 
						gsmt.bindColumn(3,idxASTYYMM); 
						gsmt.bindColumn(4,idxASAQSDAT); 
						gsmt.bindColumn(5,idxASTNAME); 
						gsmt.bindColumn(6,idxASTNBR); 
						gsmt.bindColumn(7,idxASTRAMT); 
						gsmt.bindColumn(8,idxASTRAMTY); 
						gsmt.bindColumn(9,idxREMARK); 
						gsmt.bindColumn(10,idxATCODE); 
						
						gsmt.executeUpdate();
						gsmt.close();	

						//신규취득등록 마감 처리함.
						strStatus ="1";
						UpdateSql2 = new StringBuffer();
						UpdateSql2.append( " UPDATE ACCOUNT.ASTCIP SET  		" );
						UpdateSql2.append( "        STATUS = '"+strStatus+"',     	");
						UpdateSql2.append( "        U_EMPNO  = '"+strEmpno+"',    ");
						UpdateSql2.append( "        U_DATE   = sysdate  				");
						UpdateSql2.append( "  WHERE FDCODE   = ?     				");
						UpdateSql2.append( "    AND ASTCIPCD = ?     					");
						gsmt = conn.getGauceStatement(UpdateSql2.toString());
						gsmt.setGauceDataRow(rows[j]);				
					
						gsmt.bindColumn(1,idxFDCODE); 
						gsmt.bindColumn(2,idxASTCIPCD); 

						gsmt.executeUpdate();
						gsmt.close();	
					}


					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE ){

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,idxASAQSDAT);
						gsmt.bindColumn(2,idxASTNAME);
						gsmt.bindColumn(3,idxASTNBR);
						gsmt.bindColumn(4,idxASTRAMT);
						gsmt.bindColumn(5,idxASTRAMTY);
						gsmt.bindColumn(6,idxREMARK);
						gsmt.bindColumn(7,idxATCODE);
						gsmt.bindColumn(8,idxFDCODE);
						gsmt.bindColumn(9,idxASTCIPCD);
						gsmt.bindColumn(10,idxASTYYMM);

						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,idxFDCODE); 
						gsmt.bindColumn(2,idxASTCIPCD);   			
						gsmt.bindColumn(3,idxASTYYMM);					
						
						gsmt.executeUpdate();
						gsmt.close();

						 //신규취득등록 마감 처리함.

						strStatus ="0";
						UpdateSql2 = new StringBuffer();
						UpdateSql2.append( " UPDATE ACCOUNT.ASTCIP SET  		" );
						UpdateSql2.append( "        STATUS = '"+strStatus+"',     	");
						UpdateSql2.append( "        U_EMPNO  = '"+strEmpno+"',    ");
						UpdateSql2.append( "        U_DATE   = sysdate  				");
						UpdateSql2.append( "  WHERE FDCODE   = ?     				");
						UpdateSql2.append( "    AND ASTCIPCD = ?     					");
					
						gsmt = conn.getGauceStatement(UpdateSql2.toString());
						gsmt.setGauceDataRow(rows[j]);			
					
						gsmt.bindColumn(1,idxFDCODE); 
						gsmt.bindColumn(2,idxASTCIPCD); 
						
						gsmt.executeUpdate();
						gsmt.close();	
											
					}
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