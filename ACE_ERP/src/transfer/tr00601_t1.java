package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00601_t1 extends HttpServlet{

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
					
				int idxVEND_CD     = userSet.indexOfColumn("VEND_CD");
				int idxVEND_NM     = userSet.indexOfColumn("VEND_NM");
				int idxPROJECT_CD  = userSet.indexOfColumn("PROJECT_CD");
				int idxVEND_PRS    = userSet.indexOfColumn("VEND_PRS");
				int idxVEND_PST    = userSet.indexOfColumn("VEND_PST");

				int idxVEND_TEL    = userSet.indexOfColumn("VEND_TEL");
				int idxVEND_CPHN   = userSet.indexOfColumn("VEND_CPHN");
				int idxVEND_FAX    = userSet.indexOfColumn("VEND_FAX");
				int idxVEND_EMAIL  = userSet.indexOfColumn("VEND_EMAIL");
				int idxVEND_ADD1   = userSet.indexOfColumn("VEND_ADD1");

				int idxVEND_ADD2   = userSet.indexOfColumn("VEND_ADD2");
				int idxVEND_ADD3   = userSet.indexOfColumn("VEND_ADD3");
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
				InsertSql.append( " INSERT INTO TRANSFER.LTCUSTMST                         (  " );
				InsertSql.append( " VEND_CD, VEND_NM, PROJECT_CD, VEND_PRS, VEND_PST,         " );
				InsertSql.append( " VEND_TEL, VEND_CPHN, VEND_FAX, VEND_EMAIL, VEND_ADD1,     " );
				InsertSql.append( " VEND_ADD2, VEND_ADD3,  REMARK, CREATE_DT, CREATE_USR,     " );
				InsertSql.append( " UPDATE_DT, UPDATE_UST )   " );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?, " );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str1 + "'," );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str2 + "' ) " );


//logger.dbg.println(this,InsertSql.toString());

				UpdateSql = new StringBuffer();

				UpdateSql.append( " UPDATE TRANSFER.LTCUSTMST SET " );
				UpdateSql.append( "        VEND_NM = ?, " );
				UpdateSql.append( "        PROJECT_CD = ?, " );
				UpdateSql.append( "        VEND_PRS = ?, " );
				UpdateSql.append( "        VEND_PST = ?, " );

				UpdateSql.append( "        VEND_TEL = ?," );
				UpdateSql.append( "        VEND_CPHN = ?," );
				UpdateSql.append( "        VEND_FAX = ?," );
				UpdateSql.append( "        VEND_EMAIL = ?," );
				UpdateSql.append( "        VEND_ADD1 = ?," );

				UpdateSql.append( "        VEND_ADD2 = ?," );
				UpdateSql.append( "        VEND_ADD3 = ?," );
				UpdateSql.append( "        REMARK = ?," );
					
				UpdateSql.append( "        UPDATE_DT = CURRENT TIMESTAMP," );
				UpdateSql.append( "        UPDATE_UST  = '" + str1 + "'" );
				UpdateSql.append( " WHERE VEND_CD = ? " );
				
				
//logger.dbg.println(this,UpdateSql.toString());
//logger.err.println(this,"test1");					
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTCUSTMST " );
				DeleteSql.append( " WHERE VEND_CD = ? " );
			
//logger.dbg.println(this,DeleteSql.toString());

				for (int j = 0; j < rows.length; j++){
//logger.err.println(this,"test3");
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
//logger.err.println(this,"111111111111111111");
//						String test1 = rows[j].getString(idxCAR_SEQ_NO);
//						String test2 = rows[j].getString(idxACCSECTION);
//						String test3 = rows[j].getString(idxCAR_NO);
//						String test4 = rows[j].getString(idxCAR_TYPE);

//						logger.dbg.println(this,test1 + ":"+ test2 +":"+test3+":"+test4);
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
//logger.err.println(this,"test5");
					
						gsmt.setGauceDataRow(rows[j]);

//logger.err.println(this,"test6");	

						gsmt.bindColumn(1,  idxVEND_CD);
						gsmt.bindColumn(2,  idxVEND_NM);
						gsmt.bindColumn(3,  idxPROJECT_CD);
						gsmt.bindColumn(4,  idxVEND_PRS);
						gsmt.bindColumn(5,  idxVEND_PST);

						gsmt.bindColumn(6,  idxVEND_TEL);
						gsmt.bindColumn(7,  idxVEND_CPHN);
						gsmt.bindColumn(8,  idxVEND_FAX);
						gsmt.bindColumn(9,  idxVEND_EMAIL);
						gsmt.bindColumn(10, idxVEND_ADD1);

						gsmt.bindColumn(11, idxVEND_ADD2);
						gsmt.bindColumn(12, idxVEND_ADD3);
						gsmt.bindColumn(13, idxREMARK);
						
						
						gsmt.executeUpdate();
						gsmt.close();
//logger.err.println(this,"test11112");
//logger.err.println(this,InsertSql.toString());
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
//logger.err.println(this,"test32323");
//logger.err.println(this,UpdateSql.toString());

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1,  idxVEND_NM);
						gsmt.bindColumn(2,  idxPROJECT_CD);
						gsmt.bindColumn(3,  idxVEND_PRS);
						gsmt.bindColumn(4,  idxVEND_PST);

						gsmt.bindColumn(5,  idxVEND_TEL);
						gsmt.bindColumn(6,  idxVEND_CPHN);
						gsmt.bindColumn(7,  idxVEND_FAX);
						gsmt.bindColumn(8,  idxVEND_EMAIL);
						gsmt.bindColumn(9,  idxVEND_ADD1);
						gsmt.bindColumn(10, idxVEND_ADD2);

						gsmt.bindColumn(11, idxVEND_ADD3);
						gsmt.bindColumn(12, idxREMARK);
						gsmt.bindColumn(13, idxVEND_CD);
		

						/*String ls_value =  rows[j].getString(idxCAR_SEQ_NO) ; 

						logger.err.println(this,ls_value);	 
						ls_value =  rows[j].getString(idxACCSECTION) ; 

						logger.err.println(this,ls_value);	 
						ls_value =  rows[j].getString(idxCAR_NO) ; 

						logger.err.println(this,ls_value);	 */

						gsmt.executeUpdate(); 
						gsmt.close();         
       		//logger.err.println(this,"test255555555");	                            
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxVEND_CD);
					
				
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