package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00302_t3 extends HttpServlet{

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
				String str3 = reqGauce.getParameter("v_str3");     // PRSN_NAME(운전자명)

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
					
				int idxACCESS_NO   = userSet.indexOfColumn("ACCESS_NO");
				int idxACCSECTION  = userSet.indexOfColumn("ACCSECTION");
				int idxSEQ_NO      = userSet.indexOfColumn("SEQ_NO");
				int idxCAR_NO      = userSet.indexOfColumn("CAR_NO");
				int idxCAR_SEQ_NO  = userSet.indexOfColumn("CAR_SEQ_NO");

				int idxCAR_TYPE    = userSet.indexOfColumn("CAR_TYPE");
				int idxPERSON_NO   = userSet.indexOfColumn("PERSON_NO");
				int idxLD_CARGO    = userSet.indexOfColumn("LD_CARGO");
				int idxLD_CARGONM  = userSet.indexOfColumn("LD_CARGONM");
				int idxOFF_CARGO   = userSet.indexOfColumn("OFF_CARGO");

				int idxOFF_CARGONM = userSet.indexOfColumn("OFF_CARGONM");
				int idxPURPOSE     = userSet.indexOfColumn("PURPOSE");
				int idxLEAD_FEE    = userSet.indexOfColumn("LEAD_FEE");
				int idxPERSON_CNT  = userSet.indexOfColumn("PERSON_CNT");
				int idxSTART_DATE  = userSet.indexOfColumn("START_DATE");

				int idxSTART_TIME  = userSet.indexOfColumn("START_TIME");
				int idxRTRN_DATE   = userSet.indexOfColumn("RTRN_DATE");
				int idxRTRN_TIME   = userSet.indexOfColumn("RTRN_TIME");
				int idxBAECHA_NO   = userSet.indexOfColumn("BAECHA_NO");
				int idxRDS_GOODS   = userSet.indexOfColumn("RDS_GOODS");

				int idxREMARK      = userSet.indexOfColumn("REMARK");
				int idxCREATE_DT   = userSet.indexOfColumn("CREATE_DT");
				int idxCREATE_USR  = userSet.indexOfColumn("CREATE_USR");
				int idxUPDATE_DT   = userSet.indexOfColumn("UPDATE_DT");
				int idxUPDATE_UST  = userSet.indexOfColumn("UPDATE_UST");
	
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer UpdateSqll = null;
				StringBuffer DeleteSql = null;
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO TRANSFER.LTACCPLCAR                        (  " );
				InsertSql.append( " ACCESS_NO, ACCSECTION, SEQ_NO, CAR_NO, CAR_SEQ_NO,        " );
				InsertSql.append( " CAR_TYPE, PERSON_NO, LD_CARGO, LD_CARGONM, OFF_CARGO,     " );
				InsertSql.append( " OFF_CARGONM, PURPOSE,  LEAD_FEE, PERSON_CNT, START_DATE,  " );
				InsertSql.append( " START_TIME, RTRN_DATE, RTRN_TIME, BAECHA_NO, RDS_GOODS,   " );
				InsertSql.append( "  REMARK, CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_UST )   " );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, " );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str1 + "'," );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str2 + "' ) " );


//logger.dbg.println(this,InsertSql.toString());

				UpdateSql = new StringBuffer();

				UpdateSql.append( " UPDATE TRANSFER.LTACCPLCAR SET " );
				UpdateSql.append( "        CAR_NO = ?, " );
				UpdateSql.append( "        CAR_SEQ_NO = ?, " );

				UpdateSql.append( "        CAR_TYPE = ?, " );
				UpdateSql.append( "        PERSON_NO = ?, " );
				UpdateSql.append( "        LD_CARGO = ?," );
				UpdateSql.append( "        LD_CARGONM = ?," );
				UpdateSql.append( "        OFF_CARGO = ?," );

				UpdateSql.append( "        OFF_CARGONM = ?," );
				UpdateSql.append( "        PURPOSE = ?," );
				UpdateSql.append( "        LEAD_FEE = ?," );
				UpdateSql.append( "        PERSON_CNT = ?," );
				UpdateSql.append( "        START_DATE = ?," );

				UpdateSql.append( "        START_TIME = ?," );
				UpdateSql.append( "        RTRN_DATE = ?," );
				UpdateSql.append( "        RTRN_TIME = ?," );
				UpdateSql.append( "        BAECHA_NO = ?," );
				UpdateSql.append( "        RDS_GOODS = ?," );

				UpdateSql.append( "        REMARK = ?," );
					
				UpdateSql.append( "        UPDATE_DT = CURRENT TIMESTAMP," );
				UpdateSql.append( "        UPDATE_UST  = '" + str1 + "'" );
				UpdateSql.append( " WHERE ACCESS_NO = ? " );
				UpdateSql.append( " AND   ACCSECTION = ?  " );
				UpdateSql.append( " AND   SEQ_NO = ?  " );

				
//logger.dbg.println(this,UpdateSql.toString());
//logger.dbg.println(this,"test1");					
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTACCPLCAR " );
				DeleteSql.append( " WHERE ACCESS_NO = ? " );
				DeleteSql.append( " AND   ACCSECTION = ?  " );
				DeleteSql.append( " AND   SEQ_NO = ?  " );
			
//logger.dbg.println(this,DeleteSql.toString());

				for (int j = 0; j < rows.length; j++){
//logger.dbg.println(this,"test3");
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
//logger.dbg.println(this,"111111111111111111");
//						String test1 = rows[j].getString(idxCAR_SEQ_NO);
//						String test2 = rows[j].getString(idxACCSECTION);
//						String test3 = rows[j].getString(idxCAR_NO);
//						String test4 = rows[j].getString(idxCAR_TYPE);

//						logger.dbg.println(this,test1 + ":"+ test2 +":"+test3+":"+test4);
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
//logger.dbg.println(this,"test5");
					
						gsmt.setGauceDataRow(rows[j]);

//logger.dbg.println(this,"test6");	
						gsmt.bindColumn(1,  idxACCESS_NO);
						gsmt.bindColumn(2,  idxACCSECTION);
						gsmt.bindColumn(3,  idxSEQ_NO);
						gsmt.bindColumn(4,  idxCAR_NO);
						gsmt.bindColumn(5,  idxCAR_SEQ_NO);

						gsmt.bindColumn(6,  idxCAR_TYPE);
						gsmt.bindColumn(7,  idxPERSON_NO);
						gsmt.bindColumn(8,  idxLD_CARGO);
						gsmt.bindColumn(9,  idxLD_CARGONM);
						gsmt.bindColumn(10, idxOFF_CARGO);

						gsmt.bindColumn(11, idxOFF_CARGONM);
						gsmt.bindColumn(12, idxPURPOSE);
						gsmt.bindColumn(13, idxLEAD_FEE);
						gsmt.bindColumn(14, idxPERSON_CNT);
						gsmt.bindColumn(15, idxSTART_DATE);

						gsmt.bindColumn(16, idxSTART_TIME);
						gsmt.bindColumn(17, idxRTRN_DATE);
						gsmt.bindColumn(18, idxRTRN_TIME);
						gsmt.bindColumn(19, idxBAECHA_NO);
						gsmt.bindColumn(20, idxRDS_GOODS);
						gsmt.bindColumn(21, idxREMARK);
						
						gsmt.executeUpdate();
						gsmt.close();
//logger.dbg.println(this,"test11112");
//logger.err.println(this,InsertSql.toString());
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
//logger.dbg.println(this,"test32323");
//logger.dbg.println(this,UpdateSql.toString());

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1,  idxCAR_NO);
						gsmt.bindColumn(2,  idxCAR_SEQ_NO);

						gsmt.bindColumn(3,  idxCAR_TYPE);
						gsmt.bindColumn(4,  idxPERSON_NO);
						gsmt.bindColumn(5,  idxLD_CARGO);

						gsmt.bindColumn(6,  idxLD_CARGONM);
						gsmt.bindColumn(7,  idxOFF_CARGO);
						gsmt.bindColumn(8,  idxOFF_CARGONM);
						gsmt.bindColumn(9,  idxPURPOSE);
						gsmt.bindColumn(10, idxLEAD_FEE);

						gsmt.bindColumn(11, idxPERSON_CNT);
						gsmt.bindColumn(12, idxSTART_DATE);
						gsmt.bindColumn(13, idxSTART_TIME);
						gsmt.bindColumn(14, idxRTRN_DATE);
						gsmt.bindColumn(15, idxRTRN_TIME);

						gsmt.bindColumn(16, idxBAECHA_NO);
						gsmt.bindColumn(17, idxRDS_GOODS);
						gsmt.bindColumn(18, idxREMARK);

						gsmt.bindColumn(19,  idxACCESS_NO);
						gsmt.bindColumn(20,  idxACCSECTION);
						gsmt.bindColumn(21,  idxSEQ_NO);

						/*String ls_value =  rows[j].getString(idxCAR_SEQ_NO) ; 

						logger.err.println(this,ls_value);	 
						ls_value =  rows[j].getString(idxACCSECTION) ; 

						logger.err.println(this,ls_value);	 
						ls_value =  rows[j].getString(idxCAR_NO) ; 

						logger.err.println(this,ls_value);	 */

						gsmt.executeUpdate(); 
						gsmt = null;         

					UpdateSqll = new StringBuffer();
					UpdateSqll.append( " UPDATE TRANSFER.LTPSRNACC SET \n" )
									//	.append( "        PRSN_NAME = '" + str3 + "', \n" )
										.append( "        PERSON_NO = '" + rows[j].getString(idxPERSON_NO) + "', \n" )
										.append( "        CAR_NO = '" + rows[j].getString(idxCAR_NO) + "', \n" )
										.append( "        RTRN_TIME = '" + rows[j].getString(idxRTRN_TIME)+ "' \n" )
										.append( " WHERE ACCESSNO = '" + rows[j].getString(idxACCESS_NO) + "' \n" )
										.append( " AND   ACCSECTION = '" + rows[j].getString(idxACCSECTION) + "'  \n" )
										.append( " AND   SEQ_NO = " + rows[j].getString(idxSEQ_NO) + "  \n" );

//logger.dbg.println(this,UpdateSqll.toString());

						GauceStatement gstmt = conn.getGauceStatement(UpdateSqll.toString());
						/*
						gstmt.setGauceDataRow(rows[j]);
						gstmt.bindColumn(1, idxPERSON_NO);
						logger.dbg.println(this,rows[j].getString(idxPERSON_NO));
						gstmt.bindColumn(2, idxCAR_NO);
						gstmt.bindColumn(3, idxSTART_TIME);
						gstmt.bindColumn(4, idxACCESS_NO);
						gstmt.bindColumn(5, idxACCSECTION);
						gstmt.bindColumn(6, idxSEQ_NO);
*/
						gstmt.executeUpdate(); 
						gstmt.close();         

					}    

						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxACCESS_NO);
						gsmt.bindColumn(2, idxACCSECTION);
						gsmt.bindColumn(3, idxSEQ_NO);
				
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