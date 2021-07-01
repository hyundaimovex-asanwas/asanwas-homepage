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
public class tr00104_edi_t11 extends HttpServlet{

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
				String ls_inggb = null ; 		
                
				dSetMstID = new GauceDataSet(); 
//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 

				int idxINGGB       = userSet.indexOfColumn("INGGB") ; 
				int idxORDER_NO    = userSet.indexOfColumn("ORDER_NO") ; 
				int idxCAR_SEQ_NO  = userSet.indexOfColumn("CAR_SEQ_NO") ; 
				GauceDataRow[] rows = userSet.getDataRows();
		
				StringBuffer  Sql = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) { // 항상수정건
						ls_inggb= rows[j].getString(idxINGGB); //체크된건
						
						if(ls_inggb.equals("1")){ //주문 취소
							Sql = new StringBuffer();
							Sql.append(" UPDATE HDASAN_EDI.ETORDERMST  \n")
								 .append("		SET ING_STS  = 'C' \n") 
								 .append("		   ,EDI_STS  = 'A' \n") 
								 .append("  WHERE ORDER_NO = ? \n");
							GauceStatement gsmt1 = conn.getGauceStatement(Sql.toString()); 
							gsmt1.setGauceDataRow(rows[j]); 
							gsmt1.bindColumn(1, idxORDER_NO); 
							gsmt1.executeUpdate(); 
							gsmt1.close();
							Sql = null ; 

							Sql = new StringBuffer();
							Sql.append(" UPDATE HDASAN_EDI.ETORDERDTL  \n")
								 .append("		SET ING_STS  = 'C' \n") 
								 .append("		   ,EDI_STS  = 'A' \n") 
								 .append("  WHERE ORDER_NO = ? \n");

							GauceStatement gsmt = conn.getGauceStatement(Sql.toString()); 
							gsmt.setGauceDataRow(rows[j]); 
							gsmt.bindColumn(1, idxORDER_NO); 
							gsmt.executeUpdate(); 
							gsmt.close();
							Sql = null ; 

						}else if (ls_inggb.equals("2")){ //배정취소
							Sql = new StringBuffer();
							Sql.append(" UPDATE HDASAN_EDI.ETORDCAR  \n")
								 .append("		SET ING_STS  = 'C' \n") 
								 .append("		   ,EDI_STS  = 'A' \n") 
								 .append("  WHERE CAR_SEQ_NO = ? \n");
							GauceStatement gsmt1 = conn.getGauceStatement(Sql.toString()); 
							gsmt1.setGauceDataRow(rows[j]); 
							gsmt1.bindColumn(1, idxCAR_SEQ_NO); 
							gsmt1.executeUpdate(); 
							gsmt1.close();
							Sql = null ; 

							Sql = new StringBuffer();
							Sql.append(" UPDATE HDASAN_EDI.ETCARGOODS  \n")
								 .append("		SET ING_STS  = 'C' \n") 
								 .append("		   ,EDI_STS  = 'A' \n") 
								 .append("  WHERE CAR_SEQ_NO = ? \n");

							GauceStatement gsmt = conn.getGauceStatement(Sql.toString()); 
							gsmt.setGauceDataRow(rows[j]); 
							gsmt.bindColumn(1, idxCAR_SEQ_NO); 
							gsmt.executeUpdate(); 
							gsmt.close();
							Sql = null ; 
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