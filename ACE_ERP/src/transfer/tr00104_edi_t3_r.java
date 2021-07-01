package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00104_edi_t3_r extends HttpServlet{

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

				int idxCAR_SEQ_NO	   = userSet.indexOfColumn("CAR_SEQ_NO"); //
				int idxACCSECTION	   = userSet.indexOfColumn("ACCSECTION"); //
				int idxCAR_NO	       = userSet.indexOfColumn("CAR_NO");     //
				int idxCAR_TYPE	     = userSet.indexOfColumn("CAR_TYPE");   //
				int idxPERSON_NO	   = userSet.indexOfColumn("PERSON_NO");  //
				int idxLD_CARGO	     = userSet.indexOfColumn("LD_CARGO");   //
				int idxLD_CARGONM	   = userSet.indexOfColumn("LD_CARGONM"); //
				int idxOFF_CARGO	   = userSet.indexOfColumn("OFF_CARGO");  //
				int idxOFF_CARGONM	 = userSet.indexOfColumn("OFF_CARGONM");//
				int idxPURPOSE	     = userSet.indexOfColumn("PURPOSE");    //
				int idxLEAD_FEE	     = userSet.indexOfColumn("LEAD_FEE");   //
				int idxPERSON_CNT	   = userSet.indexOfColumn("PERSON_CNT"); //
				int idxSTART_DATE	   = userSet.indexOfColumn("START_DATE"); //
				int idxSTART_TIME	   = userSet.indexOfColumn("START_TIME"); //
				int idxRTRN_DATE	   = userSet.indexOfColumn("RTRN_DATE");  //
				int idxRTRN_TIME	   = userSet.indexOfColumn("RTRN_TIME");  //
				int idxBAECHA_NO	   = userSet.indexOfColumn("BAECHA_NO");  //
				int idxACCESS_NO	   = userSet.indexOfColumn("ACCESS_NO");  //
				int idxRDS_GOODS	   = userSet.indexOfColumn("RDS_GOODS");  //
				int idxREMARK	       = userSet.indexOfColumn("REMARK");     //
				int idxCREATE_DT	   = userSet.indexOfColumn("CREATE_DT");  //
				int idxCREATE_USR	   = userSet.indexOfColumn("CREATE_USR"); //
				int idxUPDATE_DT	   = userSet.indexOfColumn("UPDATE_DT");  //
				int idxUPDATE_UST    = userSet.indexOfColumn("UPDATE_UST"); //		
				int idxEDI_STS       = userSet.indexOfColumn("EDI_STS");    //
				int idxING_STS       = userSet.indexOfColumn("ING_STS");    //
				int idxEDI_USR       = userSet.indexOfColumn("EDI_USR");    //
				int idxEDI_DT        = userSet.indexOfColumn("EDI_DT");     //
				int idxHL_EDI_STS    = userSet.indexOfColumn("HL_EDI_STS"); //
				int idxHL_ING_STS    = userSet.indexOfColumn("HL_ING_STS"); //
				int idxHL_EDI_USR    = userSet.indexOfColumn("HL_EDI_USR"); //
				int idxHL_EDI_DT     = userSet.indexOfColumn("HL_EDI_DT");  //


				GauceDataRow[] rows = userSet.getDataRows();
				StringBuffer UpdateSql = null;
				StringBuffer InsertSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer Sql = null;
				Statement stmt = null;
				ResultSet rs = null;
				String strcnt =""; 

				String strEDI_STS = "Y";
				String strTYPE="B";
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
            
						rows[j].setString(idxCREATE_USR,strUser);
						rows[j].setString(idxUPDATE_UST,strUser);
						rows[j].setString(idxHL_EDI_STS,"Y");
						/************************************************************8888
             1.기존 배차 정보 존재하는 확인 
						***************************************************************/
						logger.dbg.println(this,"STEP-::배차수신");

					 //2008.10.30 jys 막음.... ///////////////////////////////////////////////////////////////////////////////
					 //why - 처음 배차 수신 후 택배에서 갑자기 배차가 변경 될 경우가 발생함.
					 //이 경우 기존 받은 배차는 삭제하고 신규 배차를 다시 받아야함.
					 //키값에 반출입 구분과 ,차량 번호도 있으나, 배정 1개 = 배차 1개라고 생각하고 막음( 택배와 상의 - 송현주)
					 //따라서, 배정번호가 같고 차량이나 반출입구분이 틀린경우는 먼저 삭제한다.
					 /////////////////////////////////////////////////////////////////////////////////////////////////////////

		        DeleteSql = new StringBuffer();
						//배정 MST 
						DeleteSql.append( " DELETE FROM TRANSFER.LTCARACC " );
						DeleteSql.append( "  WHERE CAR_SEQ_NO = ? " );
						DeleteSql.append( "    AND (ACCSECTION <> ?  OR CAR_NO <> ? ) " );

						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxCAR_SEQ_NO);
						gsmt.bindColumn(2,  idxACCSECTION);
						gsmt.bindColumn(3,  idxCAR_NO);
						
						gsmt.executeUpdate(); 
						gsmt.close();          

						strcnt="";
      			Sql = new StringBuffer();
					  stmt = conn.createStatement();
						
						//공용DB 주문 MST 조회 ( 없으면 모두 INSERT , 존재하면 UPDATE )
					  Sql.append(" SELECT COUNT(CAR_SEQ_NO) FROM TRANSFER.LTCARACC           ") 
						   .append("  WHERE CAR_SEQ_NO = '"+rows[j].getString(idxCAR_SEQ_NO)+"'")
 						   .append("    AND ACCSECTION = '"+rows[j].getString(idxACCSECTION)+"'") 
						   .append("    AND CAR_NO = '"+rows[j].getString(idxCAR_NO)+"'"); 
						 						
						logger.dbg.println(this,Sql.toString());
        
						rs = stmt.executeQuery(Sql.toString()); 
						if(rs.next()){
							 strcnt= rs.getString(1);
						}
						rs.close();
 					  stmt.close();  

           	if(strcnt.equals("0")){ //신규 - 배차	

						  rows[j].setString(idxING_STS,"I");
							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO TRANSFER.LTCARACC (                                        \n" );
							InsertSql.append( "        CAR_SEQ_NO,  ACCSECTION,  CAR_NO,      CAR_TYPE,    PERSON_NO,  \n" );
							InsertSql.append( "        LD_CARGO,    LD_CARGONM,  OFF_CARGO,   OFF_CARGONM, PURPOSE,    \n" );
							InsertSql.append( "        LEAD_FEE,    PERSON_CNT,  START_DATE,  START_TIME,  RTRN_DATE,  \n" );
							InsertSql.append( "        RTRN_TIME,   BAECHA_NO,   ACCESS_NO,   RDS_GOODS,   REMARK,     \n" );
							InsertSql.append( "        CREATE_DT,   CREATE_USR  )           \n" );
							InsertSql.append( " SELECT CAR_SEQ_NO,  ACCSECTION,  CAR_NO,      CAR_TYPE,    PERSON_NO,  \n" );
							InsertSql.append( "        LD_CARGO,    LD_CARGONM,  OFF_CARGO,   OFF_CARGONM, PURPOSE,    \n" );
							InsertSql.append( "        LEAD_FEE,    PERSON_CNT,  START_DATE,  START_TIME,  RTRN_DATE,  \n" );
							InsertSql.append( "        RTRN_TIME,   BAECHA_NO,   ACCESS_NO,   RDS_GOODS,   REMARK,     \n" );
							InsertSql.append( "        CURRENT TIMESTAMP, '"+rows[j].getString(idxCREATE_USR)+"'       \n" );
							InsertSql.append( "   FROM HDASAN_EDI.ETCARACC                                             \n" );
							InsertSql.append( "  WHERE CAR_SEQ_NO = ? \n" );
							InsertSql.append( "    AND ACCSECTION = ? \n" );
							InsertSql.append( "    AND CAR_NO = ?     \n" );
							
							logger.dbg.println(this, InsertSql.toString());
							gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);
						
							gsmt.bindColumn(1, idxCAR_SEQ_NO);
							gsmt.bindColumn(2, idxACCSECTION);
							gsmt.bindColumn(3, idxCAR_NO);
							gsmt.executeUpdate();
							gsmt.close();     
						}else{                 //수정 - 배차
              if(rows[j].getString(idxHL_ING_STS).equals("C")){  //취소건
							  rows[j].setString(idxING_STS,"C");
								DeleteSql = new StringBuffer();
								//배정 MST 
								DeleteSql.append( " DELETE FROM TRANSFER.LTCARACC " );
								DeleteSql.append( "  WHERE CAR_SEQ_NO = ? " );
								DeleteSql.append( "    AND ACCSECTION = ? " );
								DeleteSql.append( "    AND CAR_NO = ? " );

								gsmt = conn.getGauceStatement(DeleteSql.toString());
								gsmt.setGauceDataRow(rows[j]);

								gsmt.bindColumn(1,  idxCAR_SEQ_NO);
								gsmt.bindColumn(2,  idxACCSECTION);
								gsmt.bindColumn(3,  idxCAR_NO);
								
								gsmt.executeUpdate(); 
								gsmt.close();          
              }else{
								rows[j].setString(idxING_STS,"U");

								UpdateSql = new StringBuffer();
								UpdateSql.append( " UPDATE TRANSFER.LTCARACC SET                                                  \n" );
								UpdateSql.append( "        CAR_TYPE=?,    PERSON_NO=?, LD_CARGO=?,  LD_CARGONM=?,   OFF_CARGO=?,  \n" );
								UpdateSql.append( "        OFF_CARGONM=?, PURPOSE=?,   LEAD_FEE=?,  PERSON_CNT=?,   START_DATE=?, \n" );
								UpdateSql.append( "        START_TIME=?,  RTRN_DATE=?, RTRN_TIME=?, BAECHA_NO=?,    ACCESS_NO=?,  \n" );
								UpdateSql.append( "        RDS_GOODS=?,   REMARK=?,    UPDATE_DT=CURRENT TIMESTAMP, UPDATE_UST=?  \n" );
								UpdateSql.append( "  WHERE CAR_SEQ_NO =?                                                          \n" );
								UpdateSql.append( "    AND ACCSECTION =?                                                          \n" );
								UpdateSql.append( "    AND CAR_NO=?                                                               \n" );

								gsmt = conn.getGauceStatement(UpdateSql.toString());
								gsmt.setGauceDataRow(rows[j]);
								gsmt.bindColumn(1, idxCAR_TYPE);
								gsmt.bindColumn(2, idxPERSON_NO);
								gsmt.bindColumn(3, idxLD_CARGO);
								gsmt.bindColumn(4, idxLD_CARGONM);
								gsmt.bindColumn(5, idxOFF_CARGO);
								gsmt.bindColumn(6, idxOFF_CARGONM);
								gsmt.bindColumn(7, idxPURPOSE);
								gsmt.bindColumn(8, idxLEAD_FEE);
								gsmt.bindColumn(9, idxPERSON_CNT);
								gsmt.bindColumn(10,idxSTART_DATE);
								gsmt.bindColumn(11,idxSTART_TIME);
								gsmt.bindColumn(12,idxRTRN_DATE);
								gsmt.bindColumn(13,idxRTRN_TIME);
								gsmt.bindColumn(14,idxBAECHA_NO);
								gsmt.bindColumn(15,idxACCESS_NO);
								gsmt.bindColumn(16,idxRDS_GOODS);
								gsmt.bindColumn(17,idxREMARK);					
								gsmt.bindColumn(18,idxUPDATE_UST);
								gsmt.bindColumn(19,idxCAR_SEQ_NO);
								gsmt.bindColumn(20,idxACCSECTION);
								gsmt.bindColumn(21,idxCAR_NO);

								gsmt.executeUpdate(); 
								gsmt.close();
							}
						}

            ///////////////////////////////////////////////////////////////////////////////////////////
						//EDI 공용 테이블 UPDATE 
						///////////////////////////////////////////////////////////////////////////////////////////
						////공용DB>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   
 						logger.dbg.println(this,"공용DB");
            UpdateSql = new StringBuffer();
						//배정 MST 
						UpdateSql.append( " UPDATE HDASAN_EDI.ETCARACC SET " );
						UpdateSql.append( "        HL_EDI_STS =?, " );
						UpdateSql.append( "        EDI_USR = ?, " );
						UpdateSql.append( "        EDI_DT = CURRENT TIMESTAMP " );
						UpdateSql.append( "  WHERE CAR_SEQ_NO = ? " );
						UpdateSql.append( "    AND ACCSECTION = ? " );
						UpdateSql.append( "    AND CAR_NO = ? " );

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxHL_EDI_STS);
						gsmt.bindColumn(2,  idxUPDATE_UST);
						gsmt.bindColumn(3,  idxCAR_SEQ_NO);
						gsmt.bindColumn(4,  idxACCSECTION);
						gsmt.bindColumn(5,  idxCAR_NO);
						
						gsmt.executeUpdate(); 
						gsmt.close();
						
						///////////////////////////////////////////////////////////////////////////////////////////
						//LOG 생성 
						///////////////////////////////////////////////////////////////////////////////////////////
						logger.dbg.println(this,"배차::LOG");
		
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO HDASAN_EDI.ETEDILOG ( \n" );
						InsertSql.append( " CAR_SEQ_NO, ACCSECTION, CAR_NO, TYPE, EDI_STS, ING_STS, EDI_DT, EDI_USR )  \n" );
						InsertSql.append( " VALUES ( ?, ?, ?, '"+strTYPE+"', '"+strEDI_STS+"',?, CURRENT TIMESTAMP, ? ) \n" );
				
						logger.dbg.println(this, InsertSql.toString());
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1, idxCAR_SEQ_NO);
						gsmt.bindColumn(2, idxACCSECTION);
						gsmt.bindColumn(3, idxCAR_NO);
						gsmt.bindColumn(4, idxING_STS);
						gsmt.bindColumn(5, idxCREATE_USR);
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