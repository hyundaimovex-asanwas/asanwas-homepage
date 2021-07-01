package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

//-----------------------------------------------------------------------------
//	Description : EDI 전송 후 주문 취소
//-----------------------------------------------------------------------------			
public class trOrderCancel extends HttpServlet{

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
			GauceDataSet dSetMstID = null;
			GauceStatement gstmt = null;

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String ls_check = null ; 		
                
				dSetMstID = new GauceDataSet(); 
//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 

				int idxCHECK      = userSet.indexOfColumn("CHECK") ; 
				int idxORDER_NO   = userSet.indexOfColumn("ORDER_NO") ; 
				int idxORDER_STS  = userSet.indexOfColumn("ORDER_STS") ; 
				int idxETD_DT     = userSet.indexOfColumn("ETD_DT") ; 
				int idxLINE_PART  = userSet.indexOfColumn("LINE_PART") ; 
				int idxCDNAM      = userSet.indexOfColumn("CDNAM") ; 
				int idxCUST       = userSet.indexOfColumn("CUST") ; 
				int idxSHIPPER    = userSet.indexOfColumn("SHIPPER") ; 
				int idxCARGO_TYPE = userSet.indexOfColumn("CARGO_TYPE") ; 
				int idxPROJECT    = userSet.indexOfColumn("PROJECT") ; 
				int idxCAR_SEQ_NO = userSet.indexOfColumn("CAR_SEQ_NO") ; 
				int idxCARTYPENO  = userSet.indexOfColumn("CARTYPENO") ; 
				int idxCAR_CNT    = userSet.indexOfColumn("CAR_CNT") ; 
				int idxLD_DATE    = userSet.indexOfColumn("LD_DATE") ; 
				int idxEDT_DATE   = userSet.indexOfColumn("EDT_DATE") ; 
				int idxARTC_NM    = userSet.indexOfColumn("ARTC_NM") ; 
				int idxARTC_CNT   = userSet.indexOfColumn("ARTC_CNT") ; 
				int idxPKG_CNT    = userSet.indexOfColumn("PKG_CNT") ; 
				int idxPKG_CBM    = userSet.indexOfColumn("PKG_CBM") ; 
				int idxPKG_WGHT   = userSet.indexOfColumn("PKG_WGHT") ; 
				int idxORDER_SEQ  = userSet.indexOfColumn("ORDER_SEQ") ; 
				int idxCARINFO    = userSet.indexOfColumn("CARINFO") ; 
        int idxEDI_STS    = userSet.indexOfColumn("EDI_STS") ; 
				GauceDataRow[] rows = userSet.getDataRows();
				
				StringBuffer  Sql = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) { // 항상수정건
						ls_check= rows[j].getString(idxCHECK); //체크된건
						
						if(ls_check.equals("T")){
							Sql = new StringBuffer();
							Sql.append(" UPDATE TRANSFER.LTORDERMST  \n")
								 .append("		SET ING_STS  = 'C' \n") 
								 .append("  WHERE ORDER_NO = ? \n");
							GauceStatement gsmt1 = conn.getGauceStatement(Sql.toString()); 
							gsmt1.setGauceDataRow(rows[j]); 
							gsmt1.bindColumn(1, idxORDER_NO); 
							gsmt1.executeUpdate(); 
							gsmt1.close();
							Sql = null ; 

							Sql = new StringBuffer();
							Sql.append(" UPDATE TRANSFER.LTORDERDTL  \n")
								 .append("		SET ING_STS  = 'C' \n") 
								 .append("  WHERE ORDER_NO = ? \n")
								 .append("		AND ORDER_SEQ  = ? ");

							GauceStatement gsmt = conn.getGauceStatement(Sql.toString()); 
							gsmt.setGauceDataRow(rows[j]); 
							gsmt.bindColumn(1, idxORDER_NO); 
							gsmt.bindColumn(2, idxORDER_SEQ );
							gsmt.executeUpdate(); 
							gsmt.close();
							Sql = null ; 


							/******************************************
              logger.dbg.println(this,"A4");
							// 접수 && EDI미전송 시  ==> ORDER_STS ='0001' 제출 
							if(rows[j].getString(idxORDER_STS).equals("0002")&&rows[j].getString(idxEDI_STS).equals("")){
							  logger.dbg.println(this,"A5");
								//주문 MST
								Sql = new StringBuffer();
								Sql.append(" UPDATE TRANSFER.LTORDERMST  \n")
									 .append("		SET ORDER_STS  = '0001' \n") 
									 .append("  WHERE ORDER_NO = ? \n");
								GauceStatement gsmt1 = conn.getGauceStatement(Sql.toString()); 
								gsmt1.setGauceDataRow(rows[j]); 
								gsmt1.bindColumn(1, idxORDER_NO); 
								gsmt1.executeUpdate(); 
								gsmt1.close();
								Sql = null ; 
							 
							 logger.dbg.println(this,"A6");
								//주문 DTL
								Sql = new StringBuffer();
								Sql.append(" UPDATE TRANSFER.LTORDERDTL  \n")
									 .append("		SET ORDER_STS  = '0001', \n") 
									 .append("		    ING_STS  = 'X' \n") 
									 .append("  WHERE ORDER_NO = ? \n")
									 .append("		AND ORDER_SEQ  = ? ");

								GauceStatement gsmt = conn.getGauceStatement(Sql.toString()); 
								gsmt.setGauceDataRow(rows[j]); 
								gsmt.bindColumn(1, idxORDER_NO); 
								gsmt.bindColumn(2, idxORDER_SEQ );
								gsmt.executeUpdate(); 
								gsmt.close();
								Sql = null ; 
								logger.dbg.println(this,"A7");

							}else if(rows[j].getString(idxORDER_STS).equals("0002")&&!rows[j].getString(idxEDI_STS).equals("")){

								//접수 && EDI전송 시  ==> ORDER_STS ='0001' 제출 
								//주문 MST
							 
								//주문 DTL

								logger.dbg.println(this,"A8");
								Sql = new StringBuffer();
								Sql.append(" UPDATE TRANSFER.LTORDERDTL  \n")
									 .append("		SET ING_STS  = 'C' \n") 
									 .append("  WHERE ORDER_NO = ? \n")
									 .append("		AND ORDER_SEQ  = ? ");

								GauceStatement gsmt = conn.getGauceStatement(Sql.toString()); 
								gsmt.setGauceDataRow(rows[j]); 
								gsmt.bindColumn(1, idxORDER_NO); 
								gsmt.bindColumn(2, idxORDER_SEQ );
								gsmt.executeUpdate(); 
								gsmt.close();
								Sql = null ; 
								logger.dbg.println(this,"A9");
							}

							*******/
						} //if(ls_check.equals("T")){
					} //if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
				} //Loop While 
			}
			catch(SQLException se){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.err.println(this,se);
			}

      conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}