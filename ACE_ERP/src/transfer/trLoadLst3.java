package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trLoadLst3 extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceDataSet dSetMstID = null;
		GauceStatement gsmt = null ; 

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
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				
//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 

				int idxCAR_SEQ_NO     =userSet.indexOfColumn("CAR_SEQ_NO");
				int idxORDER_NO       =userSet.indexOfColumn("ORDER_NO");
				int idxORDER_SEQ      =userSet.indexOfColumn("ORDER_SEQ");
				int idxARTC_CNT       =userSet.indexOfColumn("ARTC_CNT");
				int idxPUNIT_CNT      =userSet.indexOfColumn("PUNIT_CNT");
				int idxPUNIT_WEIGHT   =userSet.indexOfColumn("PUNIT_WEIGHT"); 
				int idxPKG_LNGTH      =userSet.indexOfColumn("PKG_LNGTH");
				int idxPKG_HEIGHT     =userSet.indexOfColumn("PKG_HEIGHT");
				int idxPKG_WIDTH      =userSet.indexOfColumn("PKG_WIDTH");
				int idxTOTAL_CBM      =userSet.indexOfColumn("TOTAL_CBM");
				int idxTOTAL_WEIGHT   =userSet.indexOfColumn("TOTAL_WEIGHT");
				int idxSTS_CODE       =userSet.indexOfColumn("STS_CODE");
				int idxUPEND_DT       =userSet.indexOfColumn("UPEND_DT");
				int idxUPEND_TIME     =userSet.indexOfColumn("UPEND_TIME");
				int idxREMARK         =userSet.indexOfColumn("REMARK");
				int idxBAECHA_NO      =userSet.indexOfColumn("BAECHA_NO");
				int idxENTER_NO       =userSet.indexOfColumn("ENTER_NO");
				int idxCAR_NO         =userSet.indexOfColumn("CAR_NO"); 
				int idxCREATE_DT			=userSet.indexOfColumn("CREATE_DT"); 
				int idxCREATE_USR     =userSet.indexOfColumn("CREATE_USR"); 
				int idxUPDATE_DT			=userSet.indexOfColumn("UPDATE_DT"); 
				int idxUPDATE_UST     =userSet.indexOfColumn("UPDATE_UST"); 
				int idxPKG_CNT				=userSet.indexOfColumn("PKG_CNT"); 
				int idxEDT_DATE				=userSet.indexOfColumn("EDT_DATE"); 
				int idxEDI_STS				=userSet.indexOfColumn("EDI_STS"); 
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  
				StringBuffer sql = null ; 

				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

            logger.dbg.println(this,"insert");
						//상차예정정보
						InsertSql = new StringBuffer();
						InsertSql.append(" INSERT INTO TRANSFER.LTLOADLST( \n ")
										 .append("		CAR_SEQ_NO,ORDER_NO,ORDER_SEQ,ARTC_CNT, \n ")
										 .append("		PUNIT_CNT,PUNIT_WEIGHT,PKG_LNGTH, \n ")
										 .append("		PKG_HEIGHT,PKG_WIDTH,TOTAL_CBM,TOTAL_WEIGHT, \n ")
										 .append("		STS_CODE,UPEND_DT,UPEND_TIME,REMARK,BAECHA_NO, \n ")
										 .append("		ENTER_NO,CAR_NO,CREATE_DT,CREATE_USR, \n ")
										 .append("		UPDATE_DT,UPDATE_UST,PKG_CNT,EDT_DATE, EDI_STS ) \n ")
										 .append(" VALUES( \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		?,?,?, \n ")
										 .append("		?,?,?,?, \n ")
										 .append("		?,substr(char(current date),1,4)|| substr(char(current date),6,2)|| substr(char(current date),9,2),substr(char(current time),1,2)||substr(char(current time),4,2),?,?, \n ")
										 .append("		?,?,CURRENT TIMESTAMP,?, \n ")
										 .append("		CURRENT TIMESTAMP,?,?,?,? )");

						gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows[j]); 
            
						/**
						logger.dbg.println(this, "idxCAR_SEQ_NO::"+rows[j].getString(idxCAR_SEQ_NO));
						logger.dbg.println(this, "idxORDER_NO::"+rows[j].getString(idxORDER_NO));
						logger.dbg.println(this, "idxORDER_SEQ::"+rows[j].getString(idxORDER_SEQ));
						logger.dbg.println(this, "idxARTC_CNT::"+rows[j].getString(idxARTC_CNT));
						logger.dbg.println(this, "idxPUNIT_CNT::"+rows[j].getString(idxPUNIT_CNT));
						logger.dbg.println(this, "idxPUNIT_WEIGHT::"+rows[j].getString(idxPUNIT_WEIGHT));
						logger.dbg.println(this, "idxPKG_LNGTH::"+rows[j].getString(idxPKG_LNGTH));
						logger.dbg.println(this, "idxPKG_HEIGHT::"+rows[j].getString(idxPKG_HEIGHT));
						logger.dbg.println(this, "idxPKG_WIDTH::"+rows[j].getString(idxPKG_WIDTH));
						logger.dbg.println(this, "idxTOTAL_CBM::"+rows[j].getString(idxTOTAL_CBM));
						logger.dbg.println(this, "idxTOTAL_WEIGHT::"+rows[j].getString(idxTOTAL_WEIGHT));
						logger.dbg.println(this, "idxSTS_CODE::"+rows[j].getString(idxSTS_CODE));
						logger.dbg.println(this, "idxREMARK::"+rows[j].getString(idxREMARK));
						logger.dbg.println(this, "idxBAECHA_NO::"+rows[j].getString(idxBAECHA_NO));
						logger.dbg.println(this, "idxENTER_NO::"+rows[j].getString(idxENTER_NO));
						logger.dbg.println(this, "idxCAR_NO::"+rows[j].getString(idxCAR_NO));
						logger.dbg.println(this, "idxCREATE_USR::"+rows[j].getString(idxCREATE_USR));
						logger.dbg.println(this, "idxUPDATE_UST::"+rows[j].getString(idxUPDATE_UST));
						logger.dbg.println(this, "idxPKG_CNT::"+rows[j].getString(idxPKG_CNT));
						logger.dbg.println(this, "idxEDT_DATE::"+rows[j].getString(idxEDT_DATE));
						logger.dbg.println(this, "idxEDI_STS::"+rows[j].getString(idxEDI_STS));
            **/

						gsmt.bindColumn(1, idxCAR_SEQ_NO  );
						gsmt.bindColumn(2, idxORDER_NO  );
						gsmt.bindColumn(3, idxORDER_SEQ  );
						gsmt.bindColumn(4, idxARTC_CNT  );
						gsmt.bindColumn(5, idxPUNIT_CNT  );
						gsmt.bindColumn(6, idxPUNIT_WEIGHT  );
						gsmt.bindColumn(7, idxPKG_LNGTH  );
						gsmt.bindColumn(8, idxPKG_HEIGHT );
						gsmt.bindColumn(9, idxPKG_WIDTH );						 
						gsmt.bindColumn(10, idxTOTAL_CBM );
						gsmt.bindColumn(11, idxTOTAL_WEIGHT );
						gsmt.bindColumn(12, idxSTS_CODE );
						gsmt.bindColumn(13, idxREMARK );
						gsmt.bindColumn(14, idxBAECHA_NO );
						gsmt.bindColumn(15, idxENTER_NO );
						gsmt.bindColumn(16, idxCAR_NO );
						gsmt.bindColumn(17, idxCREATE_USR );
						gsmt.bindColumn(18, idxUPDATE_UST );
						gsmt.bindColumn(19, idxPKG_CNT ); 
						gsmt.bindColumn(20, idxEDT_DATE ); 
						gsmt.bindColumn(21, idxEDI_STS ); 

						gsmt.executeUpdate(); 
						gsmt = null;
						InsertSql = null;


            ///////////////////////////////////////////////////////////////////////////////
						//입고 테이블에서 재고수량이 없을 경우 enter_sts='99'
						//입고 테이블에서 재고수량이 일부만 있을 경우 enter_sts='88'
						sql = new StringBuffer();
						sql.append(" SELECT SUM(A.ARTC_CNT) ARTC_CNT,                       \n")
							 .append("				(SELECT IFNULL(SUM(X.ARTC_CNT),0)               \n")
               .append("				   FROM TRANSFER.LTLOADLST X                    \n")
							 .append("				  WHERE X.ORDER_NO = A.ORDER_NO                 \n")
							 .append("				    AND X.ORDER_SEQ = A.ORDER_SEQ               \n")
							 .append("				    AND X.ENTER_NO = A.ENTER_NO) OUT_ARTC_CNT \n")
							 .append("   FROM TRANSFER.LTINWRHS A                             \n")
							 .append("  WHERE A.ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "'\n")
							 .append("    AND A.ORDER_SEQ= '" + rows[j].getString(idxORDER_SEQ) + "'\n")
						   .append("    AND A.ENTER_NO= '" + rows[j].getString(idxENTER_NO) + "'\n")
               .append("    GROUP BY A.ORDER_NO ,A.ORDER_SEQ, A.ENTER_NO \n");

						Statement stmt = null;
						ResultSet rs = null;
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());
						
						int icnt_1 = 0;
						int icnt_2 = 0;
						int icnt = 0;
            
						while (rs.next())	{
							icnt_1 = rs.getInt(1);
              icnt_2 = rs.getInt(2);
						}
						rs.close();

            icnt = icnt_1 - icnt_2;

						if(icnt==0){
							UpdateSql = new StringBuffer();
							UpdateSql.append(" UPDATE TRANSFER.LTINWRHS SET ENTER_STS ='99'  ")
											 .append("	WHERE ORDER_NO	= ? \n")
											 .append("		AND ORDER_SEQ	= ? ")
							         .append("		AND ENTER_NO	= ? ");

							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]); 
							
							gsmt.bindColumn(1, idxORDER_NO );
							gsmt.bindColumn(2, idxORDER_SEQ );
							gsmt.bindColumn(3, idxENTER_NO );

							gsmt.executeUpdate(); 
						  gsmt = null;
							UpdateSql=null;
						}else if(icnt>0&&icnt_2!=0){
							UpdateSql = new StringBuffer();
							UpdateSql.append(" UPDATE TRANSFER.LTINWRHS SET ENTER_STS ='88'  ")
											 .append("	WHERE ORDER_NO	= ? \n")
											 .append("		AND ORDER_SEQ	= ? ")
							         .append("		AND ENTER_NO	= ? ");

							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]); 
							
							gsmt.bindColumn(1, idxORDER_NO );
							gsmt.bindColumn(2, idxORDER_SEQ );
							gsmt.bindColumn(3, idxENTER_NO );

							gsmt.executeUpdate(); 
						  gsmt = null;
							UpdateSql=null;
						}
						///////////////////////////////////////////////////////////////////////////////
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTLOADLST  ")
										 .append("		SET ARTC_CNT			= ?, \n")
										 .append("				PUNIT_CNT			= ?, \n")
										 .append("				PUNIT_WEIGHT	= ?, \n")
										 .append("				PKG_LNGTH			= ?, \n")
										 .append("				PKG_HEIGHT		= ?, \n")
										 .append(" 				PKG_WIDTH			= ?, \n")
										 .append(" 				TOTAL_CBM			= ?, \n")
										 .append(" 				TOTAL_WEIGHT	= ?, \n")
										 .append("				STS_CODE			= ?, \n")
										 .append("				UPEND_DT			= substr(char(current date),1,4)|| substr(char(current date),6,2)|| substr(char(current date),9,2), \n")
										 .append("				UPEND_TIME		= substr(char(current time),1,2)||substr(char(current time),4,2), \n")
										 .append("				REMARK				= ?, \n")
										 .append("				BAECHA_NO			= ?, \n")
										 .append("				ENTER_NO			= ?, \n")
										 .append("				CAR_NO				= ?, \n")
										 .append("				UPDATE_DT			= CURRENT TIMESTAMP, \n")
										 .append("				UPDATE_UST		= ?, \n")
										 .append("				PKG_CNT				= ? \n")
										 .append("	WHERE CAR_SEQ_NO		= ? \n")
										 .append("		AND ORDER_NO			= ? \n")
										 .append("		AND ORDER_SEQ			= ? ") ; 

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]); 
						
						gsmt.bindColumn(1, idxARTC_CNT  );
						gsmt.bindColumn(2, idxPUNIT_CNT  );
						gsmt.bindColumn(3, idxPUNIT_WEIGHT  );
						gsmt.bindColumn(4, idxPKG_LNGTH  );
						gsmt.bindColumn(5, idxPKG_HEIGHT );
						gsmt.bindColumn(6, idxPKG_WIDTH );						 
						gsmt.bindColumn(7, idxTOTAL_CBM );
						gsmt.bindColumn(8, idxTOTAL_WEIGHT );
						gsmt.bindColumn(9, idxSTS_CODE );
						gsmt.bindColumn(10, idxREMARK );
						gsmt.bindColumn(11, idxBAECHA_NO );
						gsmt.bindColumn(12, idxENTER_NO );
						gsmt.bindColumn(13, idxCAR_NO ); 
						gsmt.bindColumn(14, idxUPDATE_UST );
						gsmt.bindColumn(15, idxPKG_CNT ); 
						gsmt.bindColumn(16, idxCAR_SEQ_NO  );
						gsmt.bindColumn(17, idxORDER_NO  );
						gsmt.bindColumn(18, idxORDER_SEQ  );
						gsmt.executeUpdate(); 
						gsmt.close();
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM TRANSFER.LTLOADLST \n")
										 .append( "	 WHERE CAR_SEQ_NO		= ? \n")
										 .append( "		 AND ORDER_NO			= ? \n")
										 .append( "		 AND ORDER_SEQ			= ? ")
						         .append("		 AND ENTER_NO	= ? ");

						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCAR_SEQ_NO  );
						gsmt.bindColumn(2, idxORDER_NO  );
						gsmt.bindColumn(3, idxORDER_SEQ  );
						gsmt.bindColumn(4, idxENTER_NO );

						gsmt.executeUpdate();
						gsmt.close();

            ///////////////////////////////////////////////////////////////////////////////
						//입고 테이블에서 재고수량이 없을 경우 enter_sts='99'
						//입고 테이블에서 재고수량이 일부만 있을 경우 enter_sts='88'
						sql = new StringBuffer();
						sql.append(" SELECT SUM(A.ARTC_CNT) ARTC_CNT,                              \n")
							 .append("				(SELECT IFNULL(SUM(X.ARTC_CNT),0)                      \n")
               .append("				   FROM TRANSFER.LTLOADLST X                           \n")
							 .append("				  WHERE X.ORDER_NO = A.ORDER_NO                        \n")
							 .append("				    AND X.ORDER_SEQ = A.ORDER_SEQ       \n")
							 .append("				    AND X.ENTER_NO = A.ENTER_NO) OUT_ARTC_CNT        \n")
							 .append("   FROM TRANSFER.LTINWRHS A                                    \n")
							 .append("  WHERE A.ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "'  \n")
							 .append("    AND A.ORDER_SEQ= '" + rows[j].getString(idxORDER_SEQ) + "'\n")
						   .append("    AND A.ENTER_NO= '" + rows[j].getString(idxENTER_NO) + "'\n")
               .append("    GROUP BY A.ORDER_NO ,A.ORDER_SEQ, A.ENTER_NO \n");

            logger.dbg.println(this,sql.toString());
						Statement stmt = null;
						ResultSet rs = null;
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());
						
						int icnt_1 = 0;
						int icnt_2 = 0;
						int icnt = 0;
            
						while (rs.next())	{
							icnt_1 = rs.getInt(1);
              icnt_2 = rs.getInt(2);
						}
						rs.close();
            icnt = icnt_1 - icnt_2;

						if(icnt==0){  //입고 = 상차 수량일 경우
							UpdateSql = new StringBuffer();
							UpdateSql.append(" UPDATE TRANSFER.LTINWRHS SET ENTER_STS ='99'  ")
											 .append("	WHERE ORDER_NO	= ? \n")
											 .append("		AND ORDER_SEQ	= ? ")
							         .append("		AND ENTER_NO	= ? ");

							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]); 
							
							gsmt.bindColumn(1, idxORDER_NO );
							gsmt.bindColumn(2, idxORDER_SEQ );
							gsmt.bindColumn(3, idxENTER_NO );

							gsmt.executeUpdate(); 
						  gsmt = null;
							UpdateSql=null;
						}else if(icnt>0&&icnt_2!=0){ //입고>0 && 상차>0  즉, 부분상차 된 경우
							UpdateSql = new StringBuffer();
							UpdateSql.append(" UPDATE TRANSFER.LTINWRHS SET ENTER_STS ='88'  ")
											 .append("	WHERE ORDER_NO	= ? \n")
											 .append("		AND ORDER_SEQ	= ? ")
							         .append("		AND ENTER_NO	= ? ");

							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]); 
							
							gsmt.bindColumn(1, idxORDER_NO );
							gsmt.bindColumn(2, idxORDER_SEQ );
							gsmt.bindColumn(3, idxENTER_NO );

							gsmt.executeUpdate(); 
						  gsmt = null;
							UpdateSql=null;
						}else if(icnt>0&&icnt_2==0){ //입고>0 && 상차=0
							UpdateSql = new StringBuffer();
							UpdateSql.append(" UPDATE TRANSFER.LTINWRHS SET ENTER_STS =''  ")
											 .append("	WHERE ORDER_NO	= ? \n")
											 .append("		AND ORDER_SEQ	= ? ")
							         .append("		AND ENTER_NO	= ? ");


							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]); 
							
							gsmt.bindColumn(1, idxORDER_NO );
							gsmt.bindColumn(2, idxORDER_SEQ );
							gsmt.bindColumn(3, idxENTER_NO );


							gsmt.executeUpdate(); 
						  gsmt = null;
							UpdateSql=null;
						}

						///////////////////////////////////////////////////////////////////////////////
            /*
						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTINWRHS SET ENTER_STS =''  ")
										 .append("	WHERE ORDER_NO	= ? \n")
										 .append("		AND ORDER_SEQ	= ? ");
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]); 
						
						gsmt.bindColumn(1, idxORDER_NO );
						gsmt.bindColumn(2, idxORDER_SEQ );

						gsmt.executeUpdate(); 
						gsmt = null;
						UpdateSql=null;
						*/
					}
				}
			}
			catch(SQLException se){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.err.println(this,se);
				//logger.dbg.println(this,se.toString());
			}

      conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (gsmt != null) {	try {	gsmt.close();	}	catch (Exception e) {}}
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}