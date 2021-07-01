package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class P050010_t2 extends HttpServlet{

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

			GauceStatement gsmt=null;

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1");
				

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxSEQID	    = userSet.indexOfColumn("SEQID");                
				int idxRESINO	    = userSet.indexOfColumn("RESINO");           		 
				int idxEMPNMK		  = userSet.indexOfColumn("EMPNMK");							 
				int idxCARDNO	    = userSet.indexOfColumn("CARDNO");							 
				int idxDIVNM	    = userSet.indexOfColumn("DIVNM");								 
				int idxAPPNO	    = userSet.indexOfColumn("APPNO");								 
				int idxAPPDT	    = userSet.indexOfColumn("APPDT");								 
				int idxSALEDT	    = userSet.indexOfColumn("SALEDT");							 
				int idxSETTDT	    = userSet.indexOfColumn("SETTDT");							 
				int idxSALAMT	    = userSet.indexOfColumn("SALAMT");							 
				int idxCANAMT	    = userSet.indexOfColumn("CANAMT");							 
				int idxREQAMT	    = userSet.indexOfColumn("REQAMT");							 
				int idxMBERNO	    = userSet.indexOfColumn("MBERNO");							 
				int idxMEMBER	    = userSet.indexOfColumn("MEMBER");							 
				int idxMBERRESINO = userSet.indexOfColumn("MBERRESINO");					 
				int idxMBERCD	    = userSet.indexOfColumn("MBERCD");							 
				int idxMBERNM	    = userSet.indexOfColumn("MBERNM");							 



       logger.dbg.println(this,str1);
	

				GauceDataRow[] rows = userSet.getDataRows();

			  StringBuffer DeleteSql = null;
			  StringBuffer InsertSql = null;

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PWCARDUP WHERE SETTDT = ? " );

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.PWCARDUP ( " );
				InsertSql.append( "SEQID,	RESINO,	EMPNMK,	CARDNO,	DIVNM, APPNO, " );
				InsertSql.append( "APPDT,	SALEDT,	SETTDT,	SALAMT,	CANAMT, " );
				InsertSql.append( "REQAMT,	MBERNO,	MEMBER,	MBERRESINO,	MBERCD, " );
				InsertSql.append( "MBERNM, CLOSEYN, " );
				InsertSql.append( "I_DATE,I_EMPNO " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( "?, ?, ?, ?, ?, ?,");
				InsertSql.append( "?, ?, ?, ?, ?,");
				InsertSql.append( "?, ?, ?, ?, ?,");
				InsertSql.append( "?, 'N', ");
				InsertSql.append( "CURRENT TIMESTAMP,'"+str1+"' ) " );


				for (int j = 0; j < 1; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxSETTDT  );
						gsmt.executeUpdate();							
						gsmt.close();  
					}
				}

				for (int j = 0; j < rows.length; j++){
					
/*
logger.dbg.println(this, "idxSEQID	 	::"+rows[j].getString(idxSEQID	 )); 
logger.dbg.println(this, "idxRESINO	 	::"+rows[j].getString(idxRESINO	 )); 
logger.dbg.println(this, "idxEMPNMK			::"+rows[j].getString(idxEMPNMK	)); 
logger.dbg.println(this, "idxCARDNO	 	::"+rows[j].getString(idxCARDNO	 )); 
logger.dbg.println(this, "idxDIVNM	 	::"+rows[j].getString(idxDIVNM	 )); 
logger.dbg.println(this, "idxAPPNO	 	::"+rows[j].getString(idxAPPNO	 )); 
logger.dbg.println(this, "idxAPPDT	 	::"+rows[j].getString(idxAPPDT	 )); 
logger.dbg.println(this, "idxSALEDT	 	::"+rows[j].getString(idxSALEDT	 )); 
logger.dbg.println(this, "idxSETTDT	 	::"+rows[j].getString(idxSETTDT	 )); 
logger.dbg.println(this, "idxSALAMT	 	::"+rows[j].getString(idxSALAMT	 )); 
logger.dbg.println(this, "idxCANAMT	 	::"+rows[j].getString(idxCANAMT	 )); 
logger.dbg.println(this, "idxREQAMT	 	::"+rows[j].getString(idxREQAMT	 )); 
logger.dbg.println(this, "idxMBERNO	 	::"+rows[j].getString(idxMBERNO	 )); 
logger.dbg.println(this, "idxMEMBER	 	::"+rows[j].getString(idxMEMBER	 )); 
logger.dbg.println(this, "idxMBERRESINO	::"+rows[j].getString(idxMBERRESINO)); 
logger.dbg.println(this, "idxMBERCD	 	::"+rows[j].getString(idxMBERCD	 )); 
logger.dbg.println(this, "idxMBERNM	 	::"+rows[j].getString(idxMBERNM	 )); 
*/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxSEQID	   );
						gsmt.bindColumn(2,  idxRESINO	   );
						gsmt.bindColumn(3,  idxEMPNMK		 );
						gsmt.bindColumn(4,  idxCARDNO	   );
						gsmt.bindColumn(5,  idxDIVNM	   );
						gsmt.bindColumn(6,  idxAPPNO	   );
						gsmt.bindColumn(7,  idxAPPDT	   );
						gsmt.bindColumn(8,  idxSALEDT	   );
						gsmt.bindColumn(9,  idxSETTDT	   );
						gsmt.bindColumn(10, idxSALAMT	   );
						gsmt.bindColumn(11, idxCANAMT	   );
						gsmt.bindColumn(12, idxREQAMT	   );
						gsmt.bindColumn(13, idxMBERNO	   );
						gsmt.bindColumn(14, idxMEMBER	   );
						gsmt.bindColumn(15, idxMBERRESINO);
						gsmt.bindColumn(16,	idxMBERCD	  );
						gsmt.bindColumn(17,	idxMBERNM	  );
						gsmt.executeUpdate();							
						gsmt.close();       
						}    									
				}				
			}
			catch(Exception e){
				conn.rollback();
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