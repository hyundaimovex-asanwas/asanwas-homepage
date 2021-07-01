package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00302_t2 extends HttpServlet{

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

				int idxACCESSNO    = userSet.indexOfColumn("ACCESSNO");
				int idxACCSECTION  = userSet.indexOfColumn("ACCSECTION");
				int idxSEQ_NO      = userSet.indexOfColumn("SEQ_NO");
				int idxPERSON_NO   = userSet.indexOfColumn("PERSON_NO");
				int idxCAR_NO      = userSet.indexOfColumn("CAR_NO");

				int idxPRSN_NAME   = userSet.indexOfColumn("PRSN_NAME");
				int idxPRSN_CMPY   = userSet.indexOfColumn("PRSN_CMPY");
				int idxJOB_DUTY    = userSet.indexOfColumn("JOB_DUTY");
				int idxGENDER      = userSet.indexOfColumn("GENDER");
				int idxPRSN_REGNO  = userSet.indexOfColumn("PRSN_REGNO");

				int idxADDRESS1    = userSet.indexOfColumn("ADDRESS1");
				int idxPURPOSE     = userSet.indexOfColumn("PURPOSE");
				int idxACC_AREA    = userSet.indexOfColumn("ACC_AREA");
				int idxDRIVE_DIV   = userSet.indexOfColumn("DRIVE_DIV");
				int idxSTART_DATE  = userSet.indexOfColumn("START_DATE");

				int idxSTART_TIME  = userSet.indexOfColumn("START_TIME");
				int idxRTRN_DATE   = userSet.indexOfColumn("RTRN_DATE");
				int idxRTRN_TIME   = userSet.indexOfColumn("RTRN_TIME");
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
				InsertSql.append( " INSERT INTO TRANSFER.LTPSRNACC                     (  " );
				InsertSql.append( " ACCESSNO, ACCSECTION, SEQ_NO, PERSON_NO,  CAR_NO,     " );
				InsertSql.append( " PRSN_NAME, PRSN_CMPY, JOB_DUTY, GENDER, PRSN_REGNO,   " );
				InsertSql.append( " ADDRESS1, PURPOSE, ACC_AREA, DRIVE_DIV, START_DATE,   " );
				InsertSql.append( " START_TIME, RTRN_DATE, RTRN_TIME, REMARK, CREATE_DT,  " );
				InsertSql.append( " CREATE_USR, UPDATE_DT, UPDATE_UST )                   " );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, " );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str1 + "'," );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str2 + "' ) " );


//logger.dbg.println(this,InsertSql.toString());

				UpdateSql = new StringBuffer();

				UpdateSql.append( " UPDATE TRANSFER.LTPSRNACC SET " );
				UpdateSql.append( "        PERSON_NO = ?, " );
				UpdateSql.append( "        CAR_NO = ?, " );

				UpdateSql.append( "        PRSN_NAME = ?, " );
				UpdateSql.append( "        PRSN_CMPY = ?," );
				UpdateSql.append( "        JOB_DUTY = ?," );
				UpdateSql.append( "        GENDER = ?," );
				UpdateSql.append( "        PRSN_REGNO = ?," );

				UpdateSql.append( "        ADDRESS1 = ?," );
				UpdateSql.append( "        PURPOSE = ?," );
				UpdateSql.append( "        ACC_AREA = ?," );
				UpdateSql.append( "        DRIVE_DIV = ?," );
				UpdateSql.append( "        START_DATE = ?," );

				UpdateSql.append( "        START_TIME = ?," );
				UpdateSql.append( "        RTRN_DATE = ?," );
				UpdateSql.append( "        RTRN_TIME = ?," );
				UpdateSql.append( "        REMARK = ?," );
			
					
				UpdateSql.append( "        UPDATE_DT = CURRENT TIMESTAMP," );
				UpdateSql.append( "        UPDATE_UST  = '" + str1 + "'" );
				UpdateSql.append( " WHERE ACCESSNO = ? " );
				//UpdateSql.append( " AND   ACCSECTION = ?  " );
				UpdateSql.append( " AND   SEQ_NO = ?  " );

				
//logger.dbg.println(this,UpdateSql.toString());
//logger.dbg.println(this,"test1");					
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTPSRNACC " );
				DeleteSql.append( " WHERE ACCESSNO = ? " );
				DeleteSql.append( " AND   ACCSECTION = ?  " );
				DeleteSql.append( " AND   SEQ_NO = ?  " );

//logger.dbg.println(this,DeleteSql.toString());

				for (int j = 0; j < rows.length; j++){
//logger.err.println(this,"test");
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
//logger.dbg.println(this,"111111111111111111");
						//String test1 = rows[j].getString(idxSETTLE_CD);
						//String test2 = rows[j].getString(idxSETTLE_NM);
						//String test3 = rows[j].getString(idxACC_CODE);
						//String test4 = rows[j].getString(idxSELL_TYPE);

						//logger.dbg.println(this,test1 + ":"+ test2 +":"+test3+":"+test4);
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
//logger.dbg.println(this,"test2");	

						gsmt.bindColumn(1,  idxACCESSNO);
						gsmt.bindColumn(2,  idxACCSECTION);
						gsmt.bindColumn(3,  idxSEQ_NO);
						gsmt.bindColumn(4,  idxPERSON_NO);
						gsmt.bindColumn(5,  idxCAR_NO);

						gsmt.bindColumn(6,  idxPRSN_NAME);
						gsmt.bindColumn(7,  idxPRSN_CMPY);
						gsmt.bindColumn(8,  idxJOB_DUTY);
						gsmt.bindColumn(9,  idxGENDER);
						gsmt.bindColumn(10, idxPRSN_REGNO);

						gsmt.bindColumn(11, idxADDRESS1);
						gsmt.bindColumn(12, idxPURPOSE);
						gsmt.bindColumn(13, idxACC_AREA);
						gsmt.bindColumn(14, idxDRIVE_DIV);
						gsmt.bindColumn(15, idxSTART_DATE);

						gsmt.bindColumn(16, idxSTART_TIME);
						gsmt.bindColumn(17,  idxRTRN_DATE);
						gsmt.bindColumn(18,  idxRTRN_TIME);
						gsmt.bindColumn(19,  idxREMARK);
							
						gsmt.executeUpdate();
						gsmt.close();

//logger.dbg.println(this,InsertSql.toString());
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
//logger.dbg.println(this,"test3");
//logger.dbg.println(this,UpdateSql.toString());

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxPERSON_NO);
						gsmt.bindColumn(2,  idxCAR_NO);

						gsmt.bindColumn(3,  idxPRSN_NAME);
						gsmt.bindColumn(4,  idxPRSN_CMPY);
						gsmt.bindColumn(5,  idxJOB_DUTY);
						gsmt.bindColumn(6,  idxGENDER);
						gsmt.bindColumn(7,  idxPRSN_REGNO);

						gsmt.bindColumn(8,  idxADDRESS1);
						gsmt.bindColumn(9,  idxPURPOSE);
						gsmt.bindColumn(10,  idxACC_AREA);
						gsmt.bindColumn(11, idxDRIVE_DIV);
						gsmt.bindColumn(12, idxSTART_DATE);

						gsmt.bindColumn(13, idxSTART_TIME);
						gsmt.bindColumn(14, idxRTRN_DATE);
						gsmt.bindColumn(15, idxRTRN_TIME);
						gsmt.bindColumn(16, idxREMARK);
						gsmt.bindColumn(17, idxACCESSNO);

						//gsmt.bindColumn(18,  idxACCSECTION);
						gsmt.bindColumn(18,  idxSEQ_NO);

						gsmt.executeUpdate(); 
						gsmt.close();         
//logger.dbg.println(this,"test4");                                   
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxACCESSNO);
						gsmt.bindColumn(2,  idxACCSECTION);
						gsmt.bindColumn(3,  idxSEQ_NO);

//logger.dbg.println(this,"testdfkjskdfjkjf");				
						gsmt.executeUpdate();
						gsmt.close();
//logger.dbg.println(this,DeleteSql.toString());
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