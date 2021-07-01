package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00104_edi_t1_r extends HttpServlet{

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

				int idxCAR_SEQ_NO   = userSet.indexOfColumn("CAR_SEQ_NO");    //배정번호
				int idxORDER_NO     = userSet.indexOfColumn("ORDER_NO");      //주문번호
				int idxORDER_SEQ    = userSet.indexOfColumn("ORDER_SEQ");     //주문상세번호
				int idxLD_CARGO     = userSet.indexOfColumn("LD_CARGO");      //상차지
				int idxLD_CARGONM   = userSet.indexOfColumn("LD_CARGONM");    //상차상세
				int idxOFF_CARGO    = userSet.indexOfColumn("OFF_CARGO");     //하차지
				int idxOFF_CARGONM  = userSet.indexOfColumn("OFF_CARGONM");   //하차상세
				int idxSHIPPERTEL   = userSet.indexOfColumn("SHIPPERTEL");    //송하인 전화번호
				int idxSHIPPERHP    = userSet.indexOfColumn("SHIPPERHP");     //송하인 핸드폰번호
				int idxRECP_TEL     = userSet.indexOfColumn("RECP_TEL");      //수하인 전화번호
				int idxUPDATE_USR   = userSet.indexOfColumn("UPDATE_USR");    //수정자
        
				int idxHL_EDI_STS   = userSet.indexOfColumn("HL_EDI_STS");    //전송여부
				int idxHL_ING_STS   = userSet.indexOfColumn("HL_ING_STS");    //상태여부

//			"HL_EDI_STS", "HL_ING_STS",

				GauceDataRow[] rows = userSet.getDataRows();
				StringBuffer UpdateSql = null;
				StringBuffer InsertSql = null;
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						rows[j].setString(idxUPDATE_USR,strUser);
						rows[j].setString(idxHL_EDI_STS,"R");

						/************************************************************8888
             1.주문 등록 
               송하인 - 전화번호, 수하인 - 전화번호  UPDATE 함
						***************************************************************/
						logger.dbg.println(this,"STEP1");

						UpdateSql = new StringBuffer();
							//주문정보 MST 
						UpdateSql.append( " UPDATE TRANSFER.LTORDERMST SET " );
						UpdateSql.append( "        SHIPPERTEL = ?, " );
						UpdateSql.append( "        SHIPPERHP = ?, " );
						UpdateSql.append( "        RECP_TEL = ?    " );
						UpdateSql.append( "  WHERE ORDER_NO = ? " );

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxSHIPPERTEL);
						gsmt.bindColumn(2,  idxSHIPPERHP);
						gsmt.bindColumn(3,  idxRECP_TEL);
						gsmt.bindColumn(4,  idxORDER_NO);
						
						gsmt.executeUpdate(); 
						gsmt.close();

            UpdateSql = new StringBuffer();
							//주문정보 DTL 
						UpdateSql.append( " UPDATE TRANSFER.LTORDERDTL SET " );
						UpdateSql.append( "        EDI_STS = 'R' " );
						UpdateSql.append( "  WHERE ORDER_NO = ? " );
						UpdateSql.append( "    AND ORDER_SEQ = ? " );

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxORDER_NO);
						gsmt.bindColumn(2,  idxORDER_SEQ);
						
						gsmt.executeUpdate(); 
						gsmt.close();

 					  logger.dbg.println(this,"STEP2");

            ////공용DB>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  
						UpdateSql = new StringBuffer();
							//주문정보 MST 
						UpdateSql.append( " UPDATE HDASAN_EDI.ETORDERMST SET " );
						UpdateSql.append( "        HL_EDI_STS ='Y', " );
						UpdateSql.append( "        EDI_USR = ?, " );
						UpdateSql.append( "        EDI_DT = CURRENT TIMESTAMP " );
						UpdateSql.append( "  WHERE ORDER_NO = ? " );

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxUPDATE_USR);
						gsmt.bindColumn(2,  idxORDER_NO);
						
						gsmt.executeUpdate(); 
						gsmt.close();
            
						logger.dbg.println(this,"STEP3");		
						UpdateSql = new StringBuffer();
							//주문정보 MST 
						UpdateSql.append( " UPDATE HDASAN_EDI.ETORDERDTL SET " );
						UpdateSql.append( "        HL_EDI_STS ='Y', " );
						UpdateSql.append( "        EDI_USR = ?, " );
						UpdateSql.append( "        EDI_DT = CURRENT TIMESTAMP " );
						UpdateSql.append( "  WHERE ORDER_NO = ? " );
						UpdateSql.append( "    AND ORDER_SEQ = ? " );

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxUPDATE_USR);
						gsmt.bindColumn(2,  idxORDER_NO);
						gsmt.bindColumn(3,  idxORDER_SEQ);
						
						gsmt.executeUpdate(); 
						gsmt.close();
					  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
					  
						/************************************************************8888
             3.배정 
						   상차지, 상차지상세, 하차지, 하차지 상세
						***************************************************************/ 
						logger.dbg.println(this,"STEP4");
            UpdateSql = new StringBuffer();

						//배정 MST 
						UpdateSql.append( " UPDATE TRANSFER.LTORDCAR SET " );
						UpdateSql.append( "        LD_CARGO = ?, " );
						UpdateSql.append( "        LD_CARGONM = ?, " );
						UpdateSql.append( "        OFF_CARGO = ?, " );
						UpdateSql.append( "        OFF_CARGONM = ? " );
						UpdateSql.append( "  WHERE CAR_SEQ_NO = ? " );

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxLD_CARGO);
						gsmt.bindColumn(2,  idxLD_CARGONM);
						gsmt.bindColumn(3,  idxOFF_CARGO);
						gsmt.bindColumn(4,  idxOFF_CARGONM);
						gsmt.bindColumn(5,  idxCAR_SEQ_NO);
						
						gsmt.executeUpdate(); 
						gsmt.close();

            ////공용DB>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   
 						logger.dbg.println(this,"STEP5");
            UpdateSql = new StringBuffer();
						//배정 MST 
						UpdateSql.append( " UPDATE HDASAN_EDI.ETORDCAR SET " );
						UpdateSql.append( "        HL_EDI_STS ='Y', " );
						UpdateSql.append( "        EDI_USR = ?, " );
						UpdateSql.append( "        EDI_DT = CURRENT TIMESTAMP " );
						UpdateSql.append( "  WHERE CAR_SEQ_NO = ? " );

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxUPDATE_USR);
						gsmt.bindColumn(2,  idxCAR_SEQ_NO);
						
						gsmt.executeUpdate(); 
						gsmt.close();          

						logger.dbg.println(this,"STEP6");
            UpdateSql = new StringBuffer();
						//주문정보 MST 
						UpdateSql.append( " UPDATE HDASAN_EDI.ETCARGOODS SET " );
						UpdateSql.append( "        HL_EDI_STS ='Y', " );
						UpdateSql.append( "        EDI_USR = ?, " );
						UpdateSql.append( "        EDI_DT = CURRENT TIMESTAMP " );
						UpdateSql.append( "  WHERE CAR_SEQ_NO = ? " );
						UpdateSql.append( "    AND ORDER_NO = ? " );
						UpdateSql.append( "    AND ORDER_SEQ= ? " );

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxUPDATE_USR);
						gsmt.bindColumn(2,  idxCAR_SEQ_NO);
						gsmt.bindColumn(3,  idxORDER_NO);
						gsmt.bindColumn(4,  idxORDER_SEQ);
						
						gsmt.executeUpdate(); 
						gsmt.close();
						//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  					///////////////////////////////////////////////////////////////////////////////////////////
						//LOG 생성 START
						///////////////////////////////////////////////////////////////////////////////////////////

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO HDASAN_EDI.ETEDILOG ( \n" );
						InsertSql.append( " ORDER_NO, ORDER_SEQ, CAR_SEQ_NO, TYPE, EDI_STS, ING_STS, EDI_DT, EDI_USR )  \n" );
						InsertSql.append( " VALUES ( ?, ?, ?,'A','R','U', CURRENT TIMESTAMP, ? )  \n" );
				
						logger.dbg.println(this, InsertSql.toString());
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1, idxORDER_NO);
						gsmt.bindColumn(2, idxORDER_SEQ);
						gsmt.bindColumn(3, idxCAR_SEQ_NO);
						gsmt.bindColumn(4, idxUPDATE_USR);

						gsmt.executeUpdate();
						gsmt.close();     

						/*****
						//최초 ORDER_NO INSERT
						if(j==0){
								//주문, 주문상세, 배정, 배정상세를 동시에 전송하므로 주문 마스터 입력시 LOG도 생성함.
								InsertSql = new StringBuffer();
								InsertSql.append( " INSERT INTO HDASAN_EDI.ETEDILOG ( \n" );
								InsertSql.append( " ORDER_NO, TYPE, EDI_STS, ING_STS, EDI_DT, EDI_USR )  \n" );
								InsertSql.append( " VALUES ( ?, 'A', ?, ?, CURRENT TIMESTAMP, ? )  \n" );
						
								logger.dbg.println(this, InsertSql.toString());
								gsmt = conn.getGauceStatement(InsertSql.toString());
								gsmt.setGauceDataRow(rows[j]);
							
								gsmt.bindColumn(1, idxORDER_NO);
								gsmt.bindColumn(2, idxHL_EDI_STS);
								gsmt.bindColumn(3, idxHL_ING_STS);
								gsmt.bindColumn(4, idxUPDATE_USR);
								gsmt.executeUpdate();
								gsmt.close();     
						}else{
							
							//이전 ORDER_NO 와 비교해서 다를 경우만 INSERT
							if(!rows[j].getString(idxORDER_NO).equals(rows[j-1].getString(idxORDER_NO))){
							//주문, 주문상세, 배정, 배정상세를 동시에 전송하므로 주문 마스터 입력시 LOG도 생성함.
								InsertSql = new StringBuffer();
								InsertSql.append( " INSERT INTO HDASAN_EDI.ETEDILOG ( \n" );
								InsertSql.append( " ORDER_NO, TYPE, EDI_STS, ING_STS, EDI_DT, EDI_USR )  \n" );
								InsertSql.append( " VALUES ( ?, 'A', ?, ? , CURRENT TIMESTAMP, ? )  \n" );
						
								logger.dbg.println(this, InsertSql.toString());
								gsmt = conn.getGauceStatement(InsertSql.toString());
								gsmt.setGauceDataRow(rows[j]);
							
								gsmt.bindColumn(1, idxORDER_NO);
								gsmt.bindColumn(2, idxHL_EDI_STS);
								gsmt.bindColumn(3, idxHL_ING_STS);
								gsmt.bindColumn(4, idxUPDATE_USR);

								gsmt.executeUpdate();
								gsmt.close();     
							}
						}

						***/
						///////////////////////////////////////////////////////////////////////////////////////////
						//LOG 생성 END
						///////////////////////////////////////////////////////////////////////////////////////////

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