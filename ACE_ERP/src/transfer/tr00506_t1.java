package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00506_t1 extends HttpServlet{

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
		
				int idxCAR_NO      = userSet.indexOfColumn("CAR_NO");
				int idxPERSON_NO   = userSet.indexOfColumn("PERSON_NO");
				int idxCARTYPENO   = userSet.indexOfColumn("CARTYPENO");
				int idxCAR_YEAR    = userSet.indexOfColumn("CAR_YEAR");
				int idxCOMPANY     = userSet.indexOfColumn("COMPANY");

				int idxLEAD_CLASS  = userSet.indexOfColumn("LEAD_CLASS");
				int idxLEADCHARGE  = userSet.indexOfColumn("LEADCHARGE");
				int idxREMARK      = userSet.indexOfColumn("REMARK");
				
				int idxCREATE_DT   = userSet.indexOfColumn("CREATE_DT");
				int idxCREATE_USR  = userSet.indexOfColumn("CREATE_USR");
				int idxUPDATE_DT   = userSet.indexOfColumn("UPDATE_DT");
				int idxUPDATE_UST  = userSet.indexOfColumn("UPDATE_UST");
	
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO TRANSFER.LTCARINFO                          (  " );
				InsertSql.append( " CAR_NO, PERSON_NO, CARTYPENO, CAR_YEAR, COMPANY,        \n " );
				InsertSql.append( " LEAD_CLASS, LEADCHARGE, REMARK, CREATE_DT, CREATE_USR,  \n " );
				
				InsertSql.append( " UPDATE_DT, UPDATE_UST   )    " );
			
				InsertSql.append( " VALUES (                     " );
				InsertSql.append( " ?, ?, ?, ?, ?,            \n " );
				InsertSql.append( " ?, ?, ?,                  \n " );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str1 + "'," );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str2 + "' ) " );

				

logger.dbg.println(this,InsertSql.toString());

				UpdateSql = new StringBuffer();

				UpdateSql.append( " UPDATE TRANSFER.LTCARINFO SET " );
				UpdateSql.append( "        PERSON_NO = ?, " );
				UpdateSql.append( "        CARTYPENO = ?, " );
				UpdateSql.append( "        CAR_YEAR = ?," );
				UpdateSql.append( "        COMPANY = ?," );

				UpdateSql.append( "        LEAD_CLASS = ?," );
				UpdateSql.append( "        LEADCHARGE = ?," );
				UpdateSql.append( "        REMARK = ?," );
						
				UpdateSql.append( "        UPDATE_DT = CURRENT TIMESTAMP," );
				UpdateSql.append( "        UPDATE_UST  = '" + str1 + "'" );
				UpdateSql.append( " WHERE CAR_NO = ? " );
				
				
//logger.dbg.println(this,UpdateSql.toString());
logger.err.println(this,"test1");					
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTCARINFO " );
				DeleteSql.append( " WHERE CAR_NO = ? " );
			
logger.dbg.println(this,DeleteSql.toString());

				for (int j = 0; j < rows.length; j++){
//logger.err.println(this,"test3");
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
logger.err.println(this,"test4");
//						String test1 = rows[j].getString(idxCAR_SEQ_NO);
//						String test2 = rows[j].getString(idxACCSECTION);
//						String test3 = rows[j].getString(idxCAR_NO);
//						String test4 = rows[j].getString(idxCAR_TYPE);

//						logger.dbg.println(this,test1 + ":"+ test2 +":"+test3+":"+test4);
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
//logger.err.println(this,"test5");
					
						gsmt.setGauceDataRow(rows[j]);

logger.err.println(this,"test6");	

						gsmt.bindColumn(1,  idxCAR_NO);
						gsmt.bindColumn(2,  idxPERSON_NO);
						gsmt.bindColumn(3,  idxCARTYPENO);
						gsmt.bindColumn(4,  idxCAR_YEAR);
						gsmt.bindColumn(5,  idxCOMPANY);

						gsmt.bindColumn(6,  idxLEAD_CLASS);
						gsmt.bindColumn(7,  idxLEADCHARGE);
						gsmt.bindColumn(8,  idxREMARK);
						
						gsmt.executeUpdate();
						gsmt.close();
//logger.err.println(this,"test11112");
//logger.err.println(this,InsertSql.toString());n
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
//logger.err.println(this,"test32323");
//logger.err.println(this,UpdateSql.toString());

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
		
						gsmt.bindColumn(1,  idxPERSON_NO);
						gsmt.bindColumn(2,  idxCARTYPENO);
						gsmt.bindColumn(3,  idxCAR_YEAR);
						gsmt.bindColumn(4,  idxCOMPANY);
						gsmt.bindColumn(5,  idxLEAD_CLASS);

						gsmt.bindColumn(6,  idxLEADCHARGE);
						gsmt.bindColumn(7,  idxREMARK);
						gsmt.bindColumn(8,  idxCAR_NO);
					

						gsmt.executeUpdate(); 
						gsmt.close();         
       		//logger.err.println(this,"test255555555");	                            
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCAR_NO);
					
						gsmt.executeUpdate();
						gsmt.close();
						logger.err.println(this,DeleteSql.toString());
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