package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trOrderRegCarGoods extends HttpServlet{

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
				String ord_seq = reqGauce.getParameter("gstr2"); 
   				if ( ord_seq==null || ord_seq.trim().length()==0 ) { ord_seq=null; }
				String ls_check = null ; 
                
				 //logger.dbg.println(this,"start");

//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 
				
				int idxCHECK         =  userSet.indexOfColumn("CHECK") ;
				int idxARTC_NM       = userSet.indexOfColumn("ARTC_NM") ;
				int idxORDER_NO      = userSet.indexOfColumn("ORDER_NO") ;
				int idxORDER_SEQ     = userSet.indexOfColumn("ORDER_SEQ") ;
				int idxARTC_CNT      = userSet.indexOfColumn("ARTC_CNT") ;
				int idxARTC_UNIT     = userSet.indexOfColumn("ARTC_UNIT") ;
				int idxPUNIT_CNT     = userSet.indexOfColumn("PUNIT_CNT") ;
				int idxPUNIT_UNIT    = userSet.indexOfColumn("PUNIT_UNIT") ;
				int idxPUNIT_WGHT    = userSet.indexOfColumn("PUNIT_WGHT") ;
				int idxPKG_LNGTH     = userSet.indexOfColumn("PKG_LNGTH") ;
				int idxPKG_HEIGHT    = userSet.indexOfColumn("PKG_HEIGHT") ;
				int idxPKG_WIDTH     = userSet.indexOfColumn("PKG_WIDTH") ;
				int idxPKG_CBM       = userSet.indexOfColumn("PKG_CBM") ;
				int idxPKG_CNT       = userSet.indexOfColumn("PKG_CNT") ;
				int idxSAMEAS        = userSet.indexOfColumn("SAMEAS") ;
				int idxCAR_SEQ_NO    = userSet.indexOfColumn("CAR_SEQ_NO") ;
				int idxLD_ARTC_CNT   = userSet.indexOfColumn("LD_ARTC_CNT") ;
				int idxLD_ARTC_UNIT  = userSet.indexOfColumn("LD_ARTC_UNIT") ;
				int idxLD_PKG_CNT    = userSet.indexOfColumn("LD_PKG_CNT") ;
				int idxLD_PKG_UNIT   = userSet.indexOfColumn("LD_PKG_UNIT") ;
				int idxLD_PKG_WGHT   = userSet.indexOfColumn("LD_PKG_WGHT") ;
				int idxLD_PKG_CBM    = userSet.indexOfColumn("LD_PKG_CBM") ;
				int idxEXT_ARTC_CNT  = userSet.indexOfColumn("EXT_ARTC_CNT") ;
				int idxEXT_PKG_CNT   = userSet.indexOfColumn("EXT_PKG_CNT") ;
				int IDXEXT_PKG_CBM   = userSet.indexOfColumn("EXT_PKG_CBM") ;


				GauceDataRow[] rows = userSet.getDataRows();
				
				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  
				GauceStatement gsmt = null ; 

				 //logger.dbg.println(this,"start2");
/**********************************************************************************
  전체 Data삭제
**********************************************************************************/
				DeleteSql = new StringBuffer();
				
				DeleteSql.append("DELETE FROM TRANSFER.LTCARGOODS ") ; 
				DeleteSql.append("WHERE ORDER_NO='" +ord_no +"' AND CAR_SEQ_NO = '"+ ord_seq + "'") ; 
				gsmt = conn.getGauceStatement(DeleteSql.toString()); 
				gsmt.executeUpdate();
				gsmt.close();
				//gsmt = null ; 

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						ls_check= rows[j].getString(idxCHECK);//   상차여부
						String ls_check1= rows[j].getString(idxORDER_SEQ);//   상차여부
						
						if(ls_check.equals("T")) {  
							 
							InsertSql = new StringBuffer();
							InsertSql.append(" INSERT INTO TRANSFER.LTCARGOODS ( ") ; 
							InsertSql.append(" ORDER_NO,CAR_SEQ_NO,ORDER_SEQ, ") ; 
							InsertSql.append(" ARTC_CNT,ARTC_UNIT,PKG_CNT, ") ; 
							InsertSql.append(" PKG_UNIT,PKG_WGHT,PKG_CBM, ") ; 
							InsertSql.append(" CREATE_DT,CREATE_USR,UPDATE_DT,UPDATE_USR ) ") ; 
							InsertSql.append(" VALUES( ") ; 
							InsertSql.append(" ?,?,?,?,?,?,?,?,?, ") ; 
							InsertSql.append(" CURRENT TIMESTAMP,?,CURRENT TIMESTAMP, ") ; 
							InsertSql.append(" ? ) ") ;  
							gsmt = conn.getGauceStatement(InsertSql.toString()); 
							gsmt.setGauceDataRow(rows[j]); 
							gsmt.setString(1, ord_no); 
							gsmt.setString(2,ord_seq);
							gsmt.bindColumn(3,idxORDER_SEQ);
							gsmt.bindColumn(4,idxLD_ARTC_CNT);
							gsmt.bindColumn(5,idxLD_ARTC_UNIT);
							gsmt.bindColumn(6,idxLD_PKG_CNT);
							gsmt.bindColumn(7,idxLD_PKG_UNIT);
							gsmt.bindColumn(8,idxLD_PKG_WGHT);
							gsmt.bindColumn(9,idxLD_PKG_CBM);
							//gsmt.bindColumn(10,idxPKG_CBM); 
							gsmt.setString(10,"");
							gsmt.setString(11,""); 
							gsmt.executeUpdate(); 
							gsmt.close(); 
							InsertSql = null ;
							} 

					}
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
							 
					}   
						
					 
				}
			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.dbg.println(this,se);
				logger.err.println(this,se);
				//logger.dbg.println(this,se.toString());
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}