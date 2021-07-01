package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00104_edi_t4_r extends HttpServlet{

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

				int idxENTER_DATE  	   = userSet.indexOfColumn("ENTER_DATE");   //
				int idxENTER_NO    	   = userSet.indexOfColumn("ENTER_NO");     //
				int idxWAREHOUSE   	   = userSet.indexOfColumn("WAREHOUSE");    //
				int idxGOODS_SEQ   	   = userSet.indexOfColumn("GOODS_SEQ");    //
				int idxARTC_NM     	   = userSet.indexOfColumn("ARTC_NM");      //
				int idxARTC_CNT    	   = userSet.indexOfColumn("ARTC_CNT");     //
				int idxPUNIT_CNT   	   = userSet.indexOfColumn("PUNIT_CNT");    //
				int idxPUNIT_WEIGHT	   = userSet.indexOfColumn("PUNIT_WEIGHT"); //
				int idxPKG_LNGTH   	   = userSet.indexOfColumn("PKG_LNGTH");    //
				int idxPKG_HEIGHT  	   = userSet.indexOfColumn("PKG_HEIGHT");   //
				int idxPKG_WIDTH   	   = userSet.indexOfColumn("PKG_WIDTH");    //
				int idxPKG_CBM     	   = userSet.indexOfColumn("PKG_CBM");      //
				int idxTOTAL_CBM   	   = userSet.indexOfColumn("TOTAL_CBM");    //
				int idxTOTAL_WEIGHT	   = userSet.indexOfColumn("TOTAL_WEIGHT"); //
				int idxENTER_STS   	   = userSet.indexOfColumn("ENTER_STS");    //
				int idxEXTRA_STS   	   = userSet.indexOfColumn("EXTRA_STS");    //
				int idxORDER_NO    	   = userSet.indexOfColumn("ORDER_NO");     //
				int idxORDER_SEQ   	   = userSet.indexOfColumn("ORDER_SEQ");    //
				int idxPKG_CNT     	   = userSet.indexOfColumn("PKG_CNT");      //
				int idxCREATE_DT   	   = userSet.indexOfColumn("CREATE_DT");    //
				int idxCREATE_USR  	   = userSet.indexOfColumn("CREATE_USR");   //
				int idxUPDATE_DT   	   = userSet.indexOfColumn("UPDATE_DT");    //
				int idxUPDATE_UST  	   = userSet.indexOfColumn("UPDATE_UST");   //
				int idxEDI_STS     	   = userSet.indexOfColumn("EDI_STS");      //
				int idxING_STS     	   = userSet.indexOfColumn("ING_STS");      //
				int idxEDI_USR     	   = userSet.indexOfColumn("EDI_USR");      //
				int idxEDI_DT      	   = userSet.indexOfColumn("EDI_DT");       //
				int idxHL_EDI_STS  	   = userSet.indexOfColumn("HL_EDI_STS");   //
				int idxHL_ING_STS  	   = userSet.indexOfColumn("HL_ING_STS");   //
				int idxHL_EDI_USR  	   = userSet.indexOfColumn("HL_EDI_USR");   //
				int idxHL_EDI_DT   	   = userSet.indexOfColumn("HL_EDI_DT");    //	

				GauceDataRow[] rows = userSet.getDataRows();
				StringBuffer UpdateSql = null;
				StringBuffer InsertSql = null;
				StringBuffer Sql = null;
				Statement stmt = null;
				ResultSet rs = null;
				String strcnt =""; 
				String strEDI_STS = "Y";
				String strTYPE="C";
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
            
						rows[j].setString(idxCREATE_USR,strUser);
						rows[j].setString(idxUPDATE_UST,strUser);
						rows[j].setString(idxHL_EDI_STS,"Y");
						/************************************************************8888
             1.기존 입고 정보 존재하는 확인 
						***************************************************************/
            
						logger.dbg.println(this,"STEP-::입고수신");
						strcnt="";
      			Sql = new StringBuffer();
					  stmt = conn.createStatement();
						
						//입고 조회 ( 없으면 모두 INSERT , 존재하면 UPDATE )
						 Sql.append(" SELECT COUNT(ENTER_NO) FROM TRANSFER.LTINWRHS  ") 
						    .append("  WHERE ENTER_DATE = '"+rows[j].getString(idxENTER_DATE)+"'")
 						    .append("    AND ENTER_NO  = '"+rows[j].getString(idxENTER_NO)+"'") 
							  .append("    AND WAREHOUSE = '"+rows[j].getString(idxWAREHOUSE)+"'") 
						    .append("    AND GOODS_SEQ = '"+rows[j].getString(idxGOODS_SEQ)+"'"); 
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
							InsertSql.append( " INSERT INTO TRANSFER.LTINWRHS (                                                 \n" );
							InsertSql.append( "        ENTER_DATE,  ENTER_NO,    WAREHOUSE,       GOODS_SEQ,       ARTC_NM,     \n" );
							InsertSql.append( "        ARTC_CNT,    PUNIT_CNT,   PUNIT_WEIGHT,    PKG_LNGTH,       PKG_HEIGHT,  \n" );
							InsertSql.append( "        PKG_WIDTH,   PKG_CBM,     TOTAL_CBM,       TOTAL_WEIGHT,    ENTER_STS,   \n" );
							InsertSql.append( "        EXTRA_STS,   ORDER_NO,    ORDER_SEQ,       PKG_CNT,                      \n" );
							InsertSql.append( "        CREATE_DT,   CREATE_USR )                                                \n" );
							InsertSql.append( " SELECT ENTER_DATE,  ENTER_NO,    WAREHOUSE,       GOODS_SEQ,       ARTC_NM,     \n" );
							InsertSql.append( "        ARTC_CNT,    PUNIT_CNT,   PUNIT_WEIGHT,    PKG_LNGTH,       PKG_HEIGHT,  \n" );
							InsertSql.append( "        PKG_WIDTH,   PKG_CBM,     TOTAL_CBM,       TOTAL_WEIGHT,    ENTER_STS,   \n" );
							InsertSql.append( "        EXTRA_STS,   ORDER_NO,    ORDER_SEQ,       PKG_CNT,                      \n" );
							InsertSql.append( "        CURRENT TIMESTAMP, '"+rows[j].getString(idxCREATE_USR)+"'       \n" );
							InsertSql.append( "   FROM HDASAN_EDI.ETINWRHS                                             \n" );
							InsertSql.append( "  WHERE ENTER_DATE = ?    \n" );
							InsertSql.append( "    AND ENTER_NO = ?      \n" );
							InsertSql.append( "    AND WAREHOUSE = ?     \n" );
							InsertSql.append( "    AND GOODS_SEQ = ?     \n" );
							
							logger.dbg.println(this, InsertSql.toString());
							gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);
						
							gsmt.bindColumn(1, idxENTER_DATE);
							gsmt.bindColumn(2, idxENTER_NO);
							gsmt.bindColumn(3, idxWAREHOUSE);
              gsmt.bindColumn(4, idxGOODS_SEQ);
							gsmt.executeUpdate();
							gsmt.close();     
						}else{                 //수정 - 입고
              rows[j].setString(idxING_STS,"U");

							UpdateSql = new StringBuffer();
							UpdateSql.append( " UPDATE TRANSFER.LTINWRHS SET                                                         \n" );
							UpdateSql.append( "        ARTC_NM = ?,  ARTC_CNT=?,   PUNIT_CNT=?,   PUNIT_WEIGHT=?,   PKG_LNGTH=?,     \n" );
							UpdateSql.append( "        PKG_HEIGHT=?, PKG_WIDTH=?,  PKG_CBM=?,     TOTAL_CBM=?,      TOTAL_WEIGHT=?,  \n" );
							UpdateSql.append( "        ENTER_STS=?,  EXTRA_STS=?,  ORDER_NO=?,    ORDER_SEQ=?,      PKG_CNT=?,       \n" );
							UpdateSql.append( "        UPDATE_DT=CURRENT TIMESTAMP, UPDATE_UST=?                                     \n" );
							UpdateSql.append( "  WHERE ENTER_DATE =?                                                                 \n" );
							UpdateSql.append( "    AND ENTER_NO =?                                                                   \n" );
							UpdateSql.append( "    AND WAREHOUSE=?                                                                   \n" );
							UpdateSql.append( "    AND GOODS_SEQ=?                                                                   \n" );

							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);
							
							gsmt.bindColumn(1,	idxARTC_NM);
							gsmt.bindColumn(2,	idxARTC_CNT);
							gsmt.bindColumn(3,	idxPUNIT_CNT);
							gsmt.bindColumn(4,	idxPUNIT_WEIGHT);
							gsmt.bindColumn(5,	idxPKG_LNGTH);
							gsmt.bindColumn(6,	idxPKG_HEIGHT);
							gsmt.bindColumn(7,	idxPKG_WIDTH);
							gsmt.bindColumn(8,	idxPKG_CBM);
							gsmt.bindColumn(9,	idxTOTAL_CBM);
							gsmt.bindColumn(10,	idxTOTAL_WEIGHT);
							gsmt.bindColumn(11,	idxENTER_STS);
							gsmt.bindColumn(12,	idxEXTRA_STS);
							gsmt.bindColumn(13,	idxORDER_NO);
							gsmt.bindColumn(14,	idxORDER_SEQ);
							gsmt.bindColumn(15,	idxPKG_CNT);
							gsmt.bindColumn(16,	idxUPDATE_UST);
							gsmt.bindColumn(17, idxENTER_DATE);
							gsmt.bindColumn(18, idxENTER_NO);
							gsmt.bindColumn(19, idxWAREHOUSE);
							gsmt.bindColumn(20, idxGOODS_SEQ);
							
							gsmt.executeUpdate(); 
							gsmt.close();
						}

            ///////////////////////////////////////////////////////////////////////////////////////////
						//EDI 공용 테이블 UPDATE 
						///////////////////////////////////////////////////////////////////////////////////////////
						////공용DB>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   
 						logger.dbg.println(this,"공용DB");
            UpdateSql = new StringBuffer();
						//배정 MST 
						UpdateSql.append( " UPDATE HDASAN_EDI.ETINWRHS SET " );
						UpdateSql.append( "        HL_EDI_STS =?, " );
						UpdateSql.append( "        EDI_USR = ?, " );
						UpdateSql.append( "        EDI_DT = CURRENT TIMESTAMP " );
						UpdateSql.append( "  WHERE ENTER_DATE = ? " );
						UpdateSql.append( "    AND ENTER_NO = ? " );
						UpdateSql.append( "    AND WAREHOUSE = ? " );
						UpdateSql.append( "    AND GOODS_SEQ = ? " );

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxHL_EDI_STS);
						gsmt.bindColumn(2,  idxUPDATE_UST);
						gsmt.bindColumn(3,  idxENTER_DATE);
						gsmt.bindColumn(4,  idxENTER_NO);
						gsmt.bindColumn(5,  idxWAREHOUSE);
						gsmt.bindColumn(6,  idxGOODS_SEQ);
						
						gsmt.executeUpdate(); 
						gsmt.close();          

            ///////////////////////////////////////////////////////////////////////////////////////////
						//LOG 생성 
						///////////////////////////////////////////////////////////////////////////////////////////
						logger.dbg.println(this,"입고::LOG");

            InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO HDASAN_EDI.ETEDILOG ( \n" );
						InsertSql.append( " ENTER_DATE, ENTER_NO, WAREHOUSE, GOODS_SEQ, \n" );
						InsertSql.append( " ORDER_NO, ORDER_SEQ, TYPE, EDI_STS, ING_STS, EDI_DT, EDI_USR )  \n" );
						InsertSql.append( " VALUES ( ?, ?, ?, ?,  \n" );
						InsertSql.append( " ?, ?, '"+strTYPE+"', '"+strEDI_STS+"',?, CURRENT TIMESTAMP, ? ) \n" );
				
						logger.dbg.println(this, InsertSql.toString());
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1, idxENTER_DATE);
						gsmt.bindColumn(2, idxENTER_NO);
						gsmt.bindColumn(3, idxWAREHOUSE);
						gsmt.bindColumn(4, idxGOODS_SEQ);
						gsmt.bindColumn(5, idxORDER_NO);
						gsmt.bindColumn(6, idxORDER_SEQ);
						gsmt.bindColumn(7, idxING_STS);
						gsmt.bindColumn(8, idxCREATE_USR);
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