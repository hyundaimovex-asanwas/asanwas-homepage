package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class sample_t2 extends HttpServlet{

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

				int idxUSERID      = userSet.indexOfColumn("USERID");
				int idxUSERPW      = userSet.indexOfColumn("USERPW");
				int idxUSERNM      = userSet.indexOfColumn("USERNM");
				int idxREGNO       = userSet.indexOfColumn("REGNO");
				int idxZIPCD       = userSet.indexOfColumn("ZIPCD");

				int idxADDR1       = userSet.indexOfColumn("ADDR1");
				int idxADDR2       = userSet.indexOfColumn("ADDR2");
				int idxREGNM       = userSet.indexOfColumn("REGNM");
				int idxTEL1        = userSet.indexOfColumn("TEL1");
				int idxTEL2        = userSet.indexOfColumn("TEL2");

				int idxTEL3        = userSet.indexOfColumn("TEL3");
				int idxFAX1        = userSet.indexOfColumn("FAX1");
				int idxFAX2        = userSet.indexOfColumn("FAX2");
				int idxFAX3        = userSet.indexOfColumn("FAX3");
				int idxMOBILE1     = userSet.indexOfColumn("MOBILE1");

				int idxMOBILE2     = userSet.indexOfColumn("MOBILE2");
				int idxMOBILE3     = userSet.indexOfColumn("MOBILE3");
				int idxEMAIL       = userSet.indexOfColumn("EMAIL");
				int idxRELPART     = userSet.indexOfColumn("RELPART");
				
				int idxCREATE_DT   = userSet.indexOfColumn("CREATE_DT");
				int idxCREATE_USR  = userSet.indexOfColumn("CREATE_USR");
				int idxUPDATE_DT   = userSet.indexOfColumn("UPDATE_DT");
				int idxUPDATE_UST  = userSet.indexOfColumn("UPDATE_UST");
	
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				InsertSql = new StringBuffer();
	
				InsertSql.append( " INSERT INTO TRANSFER.LTUSER                    (  " );
				InsertSql.append( " USERID,USERPW,USERNM,REGNO,ZIPCD,                 " );
				InsertSql.append( " ADDR1,ADDR2,REGNM,TEL1,TEL2,                      " );
				InsertSql.append( " TEL3,FAX1,FAX2,FAX3,MOBILE1,                      " );
				InsertSql.append( " MOBILE2,MOBILE3,EMAIL,RELPART,CREATE_DT,          " );
				InsertSql.append( " CREATE_USR,UPDATE_DT,UPDATE_UST                )  " );
			
				InsertSql.append( " VALUES (  " );
				InsertSql.append( " ?, ?, ?, ?, ?,                      " );
				InsertSql.append( " ?, ?, ?, ?, ?,                      " );
				InsertSql.append( " ?, ?, ?, ?, ?,                      " );
				InsertSql.append( " ?, ?, ?, ?,                         " );
			
			
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str1 + "'," );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str2 + "' ) " );


//logger.dbg.println(this,InsertSql.toString());

				UpdateSql = new StringBuffer();

				UpdateSql.append( " UPDATE TRANSFER.LTUSER SET " );
				
				UpdateSql.append( "        USERPW = ?, " );
				UpdateSql.append( "        USERNM = ?," );
				UpdateSql.append( "        REGNO = ?," );
				UpdateSql.append( "        ZIPCD = ?," );

				UpdateSql.append( "        ADDR1 = ?," );
				UpdateSql.append( "        ADDR2 = ?," );
				UpdateSql.append( "        REGNM = ?," );
				UpdateSql.append( "        TEL1 = ?," );
				UpdateSql.append( "        TEL2 = ?," );

				UpdateSql.append( "        TEL3 = ?," );
				UpdateSql.append( "        FAX1 = ?," );
				UpdateSql.append( "        FAX2 = ?," );
				UpdateSql.append( "        FAX3 = ?," );
				UpdateSql.append( "        MOBILE1 = ?," );

				UpdateSql.append( "        MOBILE2 = ?," );
				UpdateSql.append( "        MOBILE3 = ?," );
				UpdateSql.append( "        EMAIL = ?," );
				UpdateSql.append( "        RELPART = ?," );


				UpdateSql.append( "        UPDATE_DT = CURRENT TIMESTAMP," );
				UpdateSql.append( "        UPDATE_UST  = '" + str1 + "'" );
				UpdateSql.append( " WHERE USERID = ? " );
				
				
//logger.dbg.println(this,UpdateSql.toString());
//logger.err.println(this,"test1");					
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTUSER " );
				DeleteSql.append( " WHERE USERID = ? " );
		
			
//logger.dbg.println(this,DeleteSql.toString());

				for (int j = 0; j < rows.length; j++){
logger.dbg.println(this,"test3");
logger.dbg.println(this,""+rows[j].getJobType());
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
//logger.err.println(this,"test4");
//						String test1 = rows[j].getString(idxCAR_SEQ_NO);
//						String test2 = rows[j].getString(idxACCSECTION);
//						String test3 = rows[j].getString(idxCAR_NO);
//						String test4 = rows[j].getString(idxCAR_TYPE);

//						logger.dbg.println(this,test1 + ":"+ test2 +":"+test3+":"+test4);
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
//logger.err.println(this,"test5");
					
						gsmt.setGauceDataRow(rows[j]);

//logger.err.println(this,"test6");	
						gsmt.bindColumn(1,  idxUSERID);
						gsmt.bindColumn(2,  idxUSERPW);
						gsmt.bindColumn(3,  idxUSERNM);
						gsmt.bindColumn(4,  idxREGNO);
						gsmt.bindColumn(5,  idxZIPCD);

						gsmt.bindColumn(6,  idxADDR1);
						gsmt.bindColumn(7,  idxADDR2);
						gsmt.bindColumn(8,  idxREGNM);
						gsmt.bindColumn(9,  idxTEL1);
						gsmt.bindColumn(10, idxTEL2);

						gsmt.bindColumn(11,  idxTEL3);
						gsmt.bindColumn(12,  idxFAX1);
						gsmt.bindColumn(13,  idxFAX2);
						gsmt.bindColumn(14,  idxFAX3);
						gsmt.bindColumn(15,  idxMOBILE1);

						gsmt.bindColumn(16,  idxMOBILE2);
						gsmt.bindColumn(17,  idxMOBILE3);
						gsmt.bindColumn(18,  idxEMAIL);
						gsmt.bindColumn(19,  idxRELPART);
						
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
						
						gsmt.bindColumn(1,  idxUSERPW);
						gsmt.bindColumn(2,  idxUSERNM);
						gsmt.bindColumn(3,  idxREGNO);
						gsmt.bindColumn(4,  idxZIPCD);

						gsmt.bindColumn(5,  idxADDR1);
						gsmt.bindColumn(6,  idxADDR2);
						gsmt.bindColumn(7,  idxREGNM);
						gsmt.bindColumn(8,  idxTEL1);
						gsmt.bindColumn(9, idxTEL2);

						gsmt.bindColumn(10,  idxTEL3);
						gsmt.bindColumn(11,  idxFAX1);
						gsmt.bindColumn(12,  idxFAX2);
						gsmt.bindColumn(13,  idxFAX3);
						gsmt.bindColumn(14,  idxMOBILE1);

						gsmt.bindColumn(15,  idxMOBILE2);
						gsmt.bindColumn(16,  idxMOBILE3);
						gsmt.bindColumn(17,  idxEMAIL);
						gsmt.bindColumn(18,  idxRELPART);
						gsmt.bindColumn(19,  idxUSERID);
						

						gsmt.executeUpdate(); 
						gsmt.close();         
//logger.err.println(this,"test255555555");	                            
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						logger.dbg.println(this,DeleteSql.toString());gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxUSERID);
						
					
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