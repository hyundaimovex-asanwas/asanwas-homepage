package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00104_edi_t5_r extends HttpServlet{

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
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				conn.setAutoCommit(false);

//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String strUser = reqGauce.getParameter("gstr1"); 
   			if ( strUser==null || strUser.trim().length()==0 ) { strUser=""; }
				//logger.dbg.println(this,"start");

//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

			GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxCAR_SEQ_NO    	   = userSet.indexOfColumn("CAR_SEQ_NO");   //
				int idxORDER_NO      	   = userSet.indexOfColumn("ORDER_NO");     //
				int idxORDER_SEQ     	   = userSet.indexOfColumn("ORDER_SEQ");    //
				int idxARTC_CNT      	   = userSet.indexOfColumn("ARTC_CNT");     //
				int idxPUNIT_CNT     	   = userSet.indexOfColumn("PUNIT_CNT");    //
				int idxPUNIT_WEIGHT  	   = userSet.indexOfColumn("PUNIT_WEIGHT"); //
				int idxPKG_LNGTH     	   = userSet.indexOfColumn("PKG_LNGTH");    //
				int idxPKG_HEIGHT    	   = userSet.indexOfColumn("PKG_HEIGHT");   //
				int idxPKG_WIDTH     	   = userSet.indexOfColumn("PKG_WIDTH");    //
				int idxTOTAL_CBM     	   = userSet.indexOfColumn("TOTAL_CBM");    //
				int idxTOTAL_WEIGHT  	   = userSet.indexOfColumn("TOTAL_WEIGHT"); //
				int idxSTS_CODE      	   = userSet.indexOfColumn("STS_CODE");     //
				int idxUPEND_DT      	   = userSet.indexOfColumn("UPEND_DT");     //
				int idxUPEND_TIME    	   = userSet.indexOfColumn("UPEND_TIME");   //
				int idxREMARK        	   = userSet.indexOfColumn("REMARK");       //
				int idxBAECHA_NO     	   = userSet.indexOfColumn("BAECHA_NO");    //
				int idxENTER_NO      	   = userSet.indexOfColumn("ENTER_NO");     //
				int idxCAR_NO        	   = userSet.indexOfColumn("CAR_NO");       //
				int idxPKG_CNT       	   = userSet.indexOfColumn("PKG_CNT");      //
				int idxEDT_DATE      	   = userSet.indexOfColumn("EDT_DATE");     //
				int idxLINE_PART     	   = userSet.indexOfColumn("LINE_PART");    //
				int idxCREATE_DT     	   = userSet.indexOfColumn("CREATE_DT");    //
				int idxCREATE_USR    	   = userSet.indexOfColumn("CREATE_USR");   //
				int idxUPDATE_DT     	   = userSet.indexOfColumn("UPDATE_DT");    //
				int idxUPDATE_UST    	   = userSet.indexOfColumn("UPDATE_UST");   //
				int idxEDI_STS       	   = userSet.indexOfColumn("EDI_STS");      //
				int idxING_STS       	   = userSet.indexOfColumn("ING_STS");      //
				int idxEDI_USR       	   = userSet.indexOfColumn("EDI_USR");      //
				int idxEDI_DT        	   = userSet.indexOfColumn("EDI_DT");       //
				int idxHL_EDI_STS    	   = userSet.indexOfColumn("HL_EDI_STS");   //
				int idxHL_ING_STS    	   = userSet.indexOfColumn("HL_ING_STS");   //
				int idxHL_EDI_USR    	   = userSet.indexOfColumn("HL_EDI_USR");   //
				int idxHL_EDI_DT     	   = userSet.indexOfColumn("HL_EDI_DT");    //

				GauceDataRow[] rows = userSet.getDataRows();
				StringBuffer UpdateSql = null;
				StringBuffer InsertSql = null;
				StringBuffer Sql = null;
				Statement stmt = null;
				ResultSet rs = null;
				String strcnt =""; 
				String strEDI_STS = "Y";
				String strTYPE="D";
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
            
						rows[j].setString(idxCREATE_USR,strUser);
						rows[j].setString(idxUPDATE_UST,strUser);
						rows[j].setString(idxHL_EDI_STS,"Y");
						/************************************************************8888
             1.기존 상차 정보 존재하는 확인 
						***************************************************************/
            
						logger.dbg.println(this,"STEP-::상차수신");
						strcnt="";
      			Sql = new StringBuffer();
					  stmt = conn.createStatement();
						
						//상차 조회 ( 없으면 모두 INSERT , 존재하면 UPDATE )
						 Sql.append(" SELECT COUNT(ENTER_NO) FROM TRANSFER.LTLOADLST  ") 
						    .append("  WHERE CAR_SEQ_NO = '"+rows[j].getString(idxCAR_SEQ_NO)+"'")
 						    .append("    AND ORDER_NO  = '"+rows[j].getString(idxORDER_NO)+"'") 
							  .append("    AND ORDER_SEQ = '"+rows[j].getString(idxORDER_SEQ)+"'") 
						    .append("    AND ENTER_NO = '"+rows[j].getString(idxENTER_NO)+"'"); 
						logger.dbg.println(this,Sql.toString());
        
						rs = stmt.executeQuery(Sql.toString()); 
						if(rs.next()){
							 strcnt= rs.getString(1);
						}
						rs.close();
 					  stmt.close();  

           	if(strcnt.equals("0")){ //신규 - 입고	
              rows[j].setString(idxING_STS,"I");
							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO TRANSFER.LTLOADLST (                                           \n" );
							InsertSql.append( "        CAR_SEQ_NO,    ORDER_NO,    ORDER_SEQ,   ARTC_CNT,    PUNIT_CNT,    \n" );
							InsertSql.append( "        PUNIT_WEIGHT,  PKG_LNGTH,   PKG_HEIGHT,  PKG_WIDTH,   TOTAL_CBM,    \n" );
							InsertSql.append( "        TOTAL_WEIGHT,  STS_CODE,    UPEND_DT,    UPEND_TIME,  REMARK,       \n" );
							InsertSql.append( "        BAECHA_NO,     ENTER_NO,    CAR_NO,      PKG_CNT,     EDT_DATE,     \n" );
							InsertSql.append( "        LINE_PART,     EDI_STS,        \n" ); 
							InsertSql.append( "        CREATE_DT,     CREATE_USR   )  \n" );
							InsertSql.append( " SELECT CAR_SEQ_NO,    ORDER_NO,    ORDER_SEQ,   ARTC_CNT,    PUNIT_CNT,    \n" );
							InsertSql.append( "        PUNIT_WEIGHT,  PKG_LNGTH,   PKG_HEIGHT,  PKG_WIDTH,   TOTAL_CBM,    \n" );
							InsertSql.append( "        TOTAL_WEIGHT,  STS_CODE,    UPEND_DT,    UPEND_TIME,  REMARK,       \n" );
							InsertSql.append( "        BAECHA_NO,     ENTER_NO,    CAR_NO,      PKG_CNT,     EDT_DATE,     \n" );
							InsertSql.append( "        LINE_PART,     ''EDI_STS,                                           \n" );
							InsertSql.append( "        CURRENT TIMESTAMP, '"+rows[j].getString(idxCREATE_USR)+"'           \n" );
							InsertSql.append( "   FROM HDASAN_EDI.ETLOADLST                                                \n" );
							InsertSql.append( "  WHERE CAR_SEQ_NO = ?    \n" );
							InsertSql.append( "    AND ORDER_NO = ?      \n" );
							InsertSql.append( "    AND ORDER_SEQ = ?     \n" );
							InsertSql.append( "    AND ENTER_NO = ?      \n" );
							
							logger.dbg.println(this, InsertSql.toString());
							gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);
						
							gsmt.bindColumn(1, idxCAR_SEQ_NO);
							gsmt.bindColumn(2, idxORDER_NO);
							gsmt.bindColumn(3, idxORDER_SEQ);
              gsmt.bindColumn(4, idxENTER_NO);
							gsmt.executeUpdate();
							gsmt.close();     

						}else{                 //수정 - 입고
						  rows[j].setString(idxING_STS,"U");
							UpdateSql = new StringBuffer();
							UpdateSql.append( " UPDATE TRANSFER.LTLOADLST SET                                                       \n" );
							UpdateSql.append( "        ARTC_CNT=?,   PUNIT_CNT=?,   PUNIT_WEIGHT=?,   PKG_LNGTH=?,    PKG_HEIGHT=?,  \n" );
							UpdateSql.append( "        PKG_WIDTH=?,  TOTAL_CBM=?,   TOTAL_WEIGHT=?,   STS_CODE=?,     UPEND_DT=?,    \n" );
							UpdateSql.append( "        UPEND_TIME=?, REMARK=?,      BAECHA_NO=?,      CAR_NO=?,       PKG_CNT=?,     \n" );
							UpdateSql.append( "        EDT_DATE=?,   LINE_PART=?,                                                    \n" );
							UpdateSql.append( "        UPDATE_DT=CURRENT TIMESTAMP, UPDATE_UST=?                                     \n" );
							UpdateSql.append( "  WHERE CAR_SEQ_NO = ?                                                                \n" );
							UpdateSql.append( "    AND ORDER_NO = ?                                                                  \n" );
							UpdateSql.append( "    AND ORDER_SEQ = ?                                                                 \n" );
							UpdateSql.append( "    AND ENTER_NO = ?                                                                  \n" );

							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);
														
							gsmt.bindColumn(1,	idxARTC_CNT);
							gsmt.bindColumn(2,	idxPUNIT_CNT);
              gsmt.bindColumn(3,	idxPUNIT_WEIGHT);
							gsmt.bindColumn(4,	idxPKG_LNGTH);
							gsmt.bindColumn(5,	idxPKG_HEIGHT);
							gsmt.bindColumn(6,	idxPKG_WIDTH);
              gsmt.bindColumn(7,	idxTOTAL_CBM);
							gsmt.bindColumn(8,	idxTOTAL_WEIGHT);
							gsmt.bindColumn(9,	idxSTS_CODE);
							gsmt.bindColumn(10,	idxUPEND_DT);
              gsmt.bindColumn(11,	idxUPEND_TIME);
							gsmt.bindColumn(12,	idxREMARK);
							gsmt.bindColumn(13,	idxBAECHA_NO);
              gsmt.bindColumn(14,	idxCAR_NO);
							gsmt.bindColumn(15,	idxPKG_CNT);
							gsmt.bindColumn(16,	idxEDT_DATE);
							gsmt.bindColumn(17,	idxLINE_PART);
							gsmt.bindColumn(18,	idxUPDATE_UST);
							gsmt.bindColumn(19,	idxCAR_SEQ_NO);
              gsmt.bindColumn(20,	idxORDER_NO);
							gsmt.bindColumn(21,	idxORDER_SEQ);
							gsmt.bindColumn(22,	idxENTER_NO);          

							gsmt.executeUpdate(); 
							gsmt.close();
						}

						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTINWRHS SET ENTER_STS ='99'  \n")
										 .append("	WHERE ORDER_NO	= '"+rows[j].getString(idxORDER_NO)+"' \n")
										 .append("		AND ORDER_SEQ	= '"+rows[j].getString(idxORDER_SEQ)+"' \n");
						
						logger.dbg.println(this,UpdateSql.toString());
						gsmt = conn.getGauceStatement(UpdateSql.toString());							
						gsmt.executeUpdate(); 

            ///////////////////////////////////////////////////////////////////////////////////////////
						//EDI 공용 테이블 UPDATE 
						///////////////////////////////////////////////////////////////////////////////////////////
						////공용DB>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   
 						logger.dbg.println(this,"공용DB");
            UpdateSql = new StringBuffer();
						//배정 MST 
						UpdateSql.append( " UPDATE HDASAN_EDI.ETLOADLST SET " );
						UpdateSql.append( "        HL_EDI_STS =?, " );
						UpdateSql.append( "        EDI_USR = ?, " );
						UpdateSql.append( "        EDI_DT = CURRENT TIMESTAMP " );
						UpdateSql.append( "  WHERE CAR_SEQ_NO = ? " );
						UpdateSql.append( "    AND ORDER_NO = ? " );
						UpdateSql.append( "    AND ORDER_SEQ = ? " );
						UpdateSql.append( "    AND ENTER_NO = ? " );

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxHL_EDI_STS);
						gsmt.bindColumn(2,  idxUPDATE_UST);
						gsmt.bindColumn(3,  idxCAR_SEQ_NO);
						gsmt.bindColumn(4,  idxORDER_NO);
						gsmt.bindColumn(5,  idxORDER_SEQ);
						gsmt.bindColumn(6,  idxENTER_NO);
						
						gsmt.executeUpdate(); 
						gsmt.close();          

            ///////////////////////////////////////////////////////////////////////////////////////////
						//LOG 생성 
						///////////////////////////////////////////////////////////////////////////////////////////

						logger.dbg.println(this,"상차::LOG");
            InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO HDASAN_EDI.ETEDILOG ( \n" );
						InsertSql.append( " CAR_SEQ_NO, ORDER_NO, ORDER_SEQ, ENTER_NO, TYPE, EDI_STS, ING_STS, EDI_DT, EDI_USR )  \n" );
						InsertSql.append( " VALUES ( ?,?,?,?, '"+strTYPE+"', '"+strEDI_STS+"',?, CURRENT TIMESTAMP, ? ) \n" );
				
						logger.dbg.println(this, InsertSql.toString());
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1, idxCAR_SEQ_NO);
						gsmt.bindColumn(2, idxORDER_NO);
						gsmt.bindColumn(3, idxORDER_SEQ);
						gsmt.bindColumn(4, idxENTER_NO);
						gsmt.bindColumn(5, idxING_STS);
						gsmt.bindColumn(6, idxCREATE_USR);
						gsmt.executeUpdate();
						gsmt.close();     

					}//if        
				}//for
			}
		catch(SQLException se){
			  conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.err.println(this,se.toString());
				
			}

      conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.err.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}