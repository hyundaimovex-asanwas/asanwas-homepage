package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trAllocateCar extends HttpServlet{

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
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String ord_no = reqGauce.getParameter("gstr1"); 
   				if ( ord_no==null || ord_no.trim().length()==0 ) { ord_no=null; }
                
				//logger.err.println(this,"start");

//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				
				int idxCAR_SEQ_NO = userSet.indexOfColumn("CAR_SEQ_NO") ; 
				int idxACCSECTION = userSet.indexOfColumn("ACCSECTION") ; 
				int idxCAR_NO     = userSet.indexOfColumn("CAR_NO") ; 
				int idxCAR_TYPE   = userSet.indexOfColumn("CAR_TYPE") ; 
				int idxPERSON_NO  = userSet.indexOfColumn("PERSON_NO") ; 
				int idxLD_CARGO   = userSet.indexOfColumn("LD_CARGO") ; 
				int idxLD_CARGONM = userSet.indexOfColumn("LD_CARGONM") ; 
				int idxOFF_CARGO  = userSet.indexOfColumn("OFF_CARGO") ; 
				int idxOFF_CARGONM= userSet.indexOfColumn("OFF_CARGONM") ; 
				int idxPURPOSE    = userSet.indexOfColumn("PURPOSE") ; 
				int idxLEAD_FEE   = userSet.indexOfColumn("LEAD_FEE") ; 
				int idxPERSON_CNT = userSet.indexOfColumn("PERSON_CNT") ; 
				int idxSTART_DATE = userSet.indexOfColumn("START_DATE") ; 
				int idxSTART_TIME = userSet.indexOfColumn("START_TIME") ; 
				int idxRTRN_DATE  = userSet.indexOfColumn("RTRN_DATE") ; 
				int idxRTRN_TIME  = userSet.indexOfColumn("RTRN_TIME") ; 
				int idxBAECHA_NO  = userSet.indexOfColumn("BAECHA_NO") ; 
				int idxACCESS_NO  = userSet.indexOfColumn("ACCESS_NO") ; 
				int idxRDS_GOODS  = userSet.indexOfColumn("RDS_GOODS") ; 
				int idxREMARK     = userSet.indexOfColumn("REMARK") ; 
				int idxCREATE_DT  = userSet.indexOfColumn("CREATE_DT") ; 
				int idxCREATE_USR = userSet.indexOfColumn("CREATE_USR") ; 
				int idxUPDATE_DT  = userSet.indexOfColumn("UPDATE_DT") ; 
				int idxUPDATE_UST = userSet.indexOfColumn("UPDATE_UST") ; 
				//logger.err.println(this,"idxCANCLE_DATE ;" + idxCANCLE_DATE);
				 

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  

				//logger.err.println(this,"start2");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
 
						InsertSql = new StringBuffer();
                        InsertSql.append(" INSERT INTO TRANSFER.LTCARACC" ) ; 
                        InsertSql.append(" (CAR_SEQ_NO,ACCSECTION,CAR_NO,") ; 
                        InsertSql.append(" CAR_TYPE,PERSON_NO,LD_CARGO,") ; 
                        InsertSql.append(" LD_CARGONM,OFF_CARGO,OFF_CARGONM,") ; 
                        InsertSql.append(" PURPOSE,LEAD_FEE,PERSON_CNT,START_DATE,") ; 
                        InsertSql.append(" START_TIME,RTRN_DATE,RTRN_TIME,BAECHA_NO") ; 
                        InsertSql.append(",ACCESS_NO,RDS_GOODS,REMARK,") ; 
                        InsertSql.append(" CREATE_DT,CREATE_USR,UPDATE_DT,UPDATE_UST )");
                        InsertSql.append(" values " ) ; 
                        InsertSql.append(" (?,?,?,") ; 
                        InsertSql.append(" ?,?,?,") ; 
                        InsertSql.append(" ?,?,?,") ; 
                        InsertSql.append(" ?,?,?,?,") ; 
                        InsertSql.append(" ?,?,?,?") ; 
                        InsertSql.append(",?,?,?,") ; 
                        InsertSql.append(" CURRENT TIMESTAMP,?,CURRENT TIMESTAMP,? )");
						 
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows[j]); 
						
						gsmt.bindColumn(1,  idxCAR_SEQ_NO ) ; 
						gsmt.bindColumn(2,  idxACCSECTION ) ; 
						gsmt.bindColumn(3,  idxCAR_NO     ) ; 
						gsmt.bindColumn(4,  idxCAR_TYPE   ) ; 
						gsmt.bindColumn(5,  idxPERSON_NO  ) ; 
						gsmt.bindColumn(6,  idxLD_CARGO   ) ; 
						gsmt.bindColumn(7,  idxLD_CARGONM ) ; 
						gsmt.bindColumn(8,  idxOFF_CARGO  ) ; 
						gsmt.bindColumn(9,  idxOFF_CARGONM) ; 
						gsmt.bindColumn(10, idxPURPOSE    ) ; 
						gsmt.bindColumn(11, idxLEAD_FEE   ) ; 
						gsmt.bindColumn(12, idxPERSON_CNT ) ; 
						gsmt.bindColumn(13, idxSTART_DATE ) ; 
						gsmt.bindColumn(14, idxSTART_TIME ) ; 
						gsmt.bindColumn(15, idxRTRN_DATE  ) ; 
						gsmt.bindColumn(16, idxRTRN_TIME  ) ; 
						gsmt.bindColumn(17, idxBAECHA_NO  ) ; 
						gsmt.bindColumn(18, idxACCESS_NO  ) ; 
						gsmt.bindColumn(19, idxRDS_GOODS  ) ; 
						gsmt.bindColumn(20, idxREMARK     ) ; 
						gsmt.bindColumn(21, idxCREATE_USR ) ; 
						gsmt.bindColumn(22, idxUPDATE_UST ) ; 
 
						
	 					gsmt.executeUpdate(); 
						gsmt.close(); 


						 

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
					UpdateSql = new StringBuffer();
					UpdateSql.append(" UPDATE TRANSFER.LTCARACC" ) ; 
					UpdateSql.append(" SET ") ; 
					UpdateSql.append(" CAR_TYPE  = ?,PERSON_NO= ?,LD_CARGO= ?,") ; 
					UpdateSql.append(" LD_CARGONM = ?,OFF_CARGO = ?,OFF_CARGONM = ?,") ; 
					UpdateSql.append(" PURPOSE = ?,LEAD_FEE = ?,PERSON_CNT = ?,START_DATE = ?,") ; 
					UpdateSql.append(" START_TIME= ?,RTRN_DATE= ?,RTRN_TIME= ?,BAECHA_NO= ?") ; 
					UpdateSql.append(",ACCESS_NO= ?,RDS_GOODS= ?,REMARK= ?,") ; 
					UpdateSql.append(" UPDATE_DT =CURRENT DATE,UPDATE_UST = ?");
					UpdateSql.append(" WHERE  ") ; 
					UpdateSql.append(" CAR_SEQ_NO = ?AND ACCSECTION= ? AND CAR_NO = ?" ) ; 
				 
										   
						
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						////logger.err.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						
 						
						gsmt.bindColumn(1,  idxCAR_TYPE   ) ; 
						gsmt.bindColumn(2,  idxPERSON_NO  ) ; 
						gsmt.bindColumn(3,  idxLD_CARGO   ) ; 
						gsmt.bindColumn(4,  idxLD_CARGONM ) ; 
						gsmt.bindColumn(5,  idxOFF_CARGO  ) ; 
						gsmt.bindColumn(6,  idxOFF_CARGONM) ; 
						gsmt.bindColumn(7,  idxPURPOSE    ) ; 
						gsmt.bindColumn(8,  idxLEAD_FEE   ) ; 
						gsmt.bindColumn(9,  idxPERSON_CNT ) ; 
						gsmt.bindColumn(10, idxSTART_DATE ) ; 
						gsmt.bindColumn(11, idxSTART_TIME ) ; 
						gsmt.bindColumn(12, idxRTRN_DATE  ) ; 
						gsmt.bindColumn(13, idxRTRN_TIME  ) ; 
						gsmt.bindColumn(14, idxBAECHA_NO  ) ; 
						gsmt.bindColumn(15, idxACCESS_NO  ) ; 
						gsmt.bindColumn(16, idxRDS_GOODS  ) ; 
						gsmt.bindColumn(17, idxREMARK     ) ;  
						gsmt.bindColumn(18, idxUPDATE_UST ) ; 
						gsmt.bindColumn(19,  idxCAR_SEQ_NO ) ; 
						gsmt.bindColumn(20,  idxACCSECTION ) ; 
						gsmt.bindColumn(21,  idxCAR_NO     ) ; 
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						////logger.err.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						/*gsmt.bindColumn(1, idxCAR_TYPE);*/
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				//logger.err.println(this,se);
				//logger.err.println(this,se.toString());
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			//logger.err.println(this,e);
			//logger.err.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}