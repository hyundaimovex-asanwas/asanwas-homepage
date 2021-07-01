package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00119_t1 extends HttpServlet{

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

				String str1 = reqGauce.getParameter("v_str1");
				String str2 = reqGauce.getParameter("v_str2");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
					
				int idxMODIFY_NO   = userSet.indexOfColumn("MODIFY_NO");
				int idxORDER_NO    = userSet.indexOfColumn("ORDER_NO");
				int idxIN_OUT      = userSet.indexOfColumn("IN_OUT");
				int idxETD_DT      = userSet.indexOfColumn("ETD_DT");
				int idxLINE_PART   = userSet.indexOfColumn("LINE_PART");

				int idxMOD_STS     = userSet.indexOfColumn("MOD_STS");
				int idxREQ_DATE    = userSet.indexOfColumn("REQ_DATE");
				int idxAPP_DATE    = userSet.indexOfColumn("APP_DATE");
				int idxREQ_USER    = userSet.indexOfColumn("REQ_USER");
				int idxAPP_USER    = userSet.indexOfColumn("APP_USER");

				int idxMOD_REMARK  = userSet.indexOfColumn("MOD_REMARK");
				
			
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO TRANSFER.LTMODREQ                     (  " );
				InsertSql.append( " MODIFY_NO, ORDER_NO, IN_OUT, ETD_DT, LINE_PART,      " );
				InsertSql.append( " MOD_STS, REQ_DATE, APP_DATE, REQ_USER, APP_USER,     " );
				InsertSql.append( " MOD_REMARK									)		 " );
				InsertSql.append( " VALUES ( ?, ?, ?, ?, ?,      " );
				InsertSql.append( " ?, CURRENT TIMESTAMP, CURRENT TIMESTAMP, ?, ?,		 " );
				InsertSql.append( " ?									)	" );
				//InsertSql.append( " CURRENT TIMESTAMP, '"	+ str1 + "'," );
				//InsertSql.append( " CURRENT TIMESTAMP, '"	+ str2 + "' ) " );


//logger.dbg.println(this,InsertSql.toString());

				UpdateSql = new StringBuffer();

				UpdateSql.append( " UPDATE TRANSFER.LTMODREQ SET " );
				UpdateSql.append( "        MOD_STS = '" + str1 + "'," );
				UpdateSql.append( "        APP_DATE = CURRENT TIMESTAMP," );
				UpdateSql.append( "        APP_USER  = '" + str2 + "'" );
				UpdateSql.append( " WHERE MODIFY_NO = ? " );
				
				
logger.dbg.println(this,"test11");		


				
//logger.dbg.println(this,UpdateSql.toString());
//logger.dbg.println(this,"test1");					
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTMODREQ " );
				DeleteSql.append( " WHERE MODIFY_NO = ? " );
				
			
//logger.dbg.println(this,DeleteSql.toString());

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
//logger.dbg.println(this,"test5");
					
						gsmt.setGauceDataRow(rows[j]);

//logger.dbg.println(this,"test6");	
						gsmt.bindColumn(1,  idxMODIFY_NO);
						gsmt.bindColumn(2,  idxAPP_DATE);
						gsmt.bindColumn(3,  idxIN_OUT);
						gsmt.bindColumn(4,  idxETD_DT);
						gsmt.bindColumn(5,  idxLINE_PART);

						gsmt.bindColumn(6,  idxMOD_STS);
						gsmt.bindColumn(7,  idxREQ_DATE);
						gsmt.bindColumn(8,  idxAPP_DATE);
						gsmt.bindColumn(9,  idxREQ_USER);
						gsmt.bindColumn(10, idxAPP_USER);

						gsmt.bindColumn(11, idxMOD_REMARK);
												
						gsmt.executeUpdate();
						gsmt.close();
//logger.dbg.println(this,"test11112");
//logger.err.println(this,InsertSql.toString());
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
logger.dbg.println(this,"test32323");
//logger.dbg.println(this,UpdateSql.toString());

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1, idxMODIFY_NO);
						
logger.dbg.println(this,"test3");
						gsmt.executeUpdate(); 
						gsmt = null;         

					}    

			
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxMODIFY_NO);
								
						gsmt.executeUpdate();
						gsmt.close();
						logger.dbg.println(this,DeleteSql.toString());
					}
				}
			}
			catch(Exception e){
				logger.err.println(this,e.toString());	
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
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