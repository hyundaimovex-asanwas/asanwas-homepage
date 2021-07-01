package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010051_t2 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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

			String strSeq = "";
			String strVend_CD="";

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				String str1 = reqGauce.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxVEND_ID  	= userSet.indexOfColumn("VEND_ID");
				int idxVEND_CD  	= userSet.indexOfColumn("VEND_CD");
				int idxVEND_NM  	= userSet.indexOfColumn("VEND_NM");
				int idxVD_DIRECT	= userSet.indexOfColumn("VD_DIRECT");
				int idxBSNS_CND 	= userSet.indexOfColumn("BSNS_CND");
				int idxBSNS_KND 	= userSet.indexOfColumn("BSNS_KND");
				int idxVD_TELNO 	= userSet.indexOfColumn("VD_TELNO");
				int idxVD_FAXNO 	= userSet.indexOfColumn("VD_FAXNO");
				int idxPOST_NO1 	= userSet.indexOfColumn("POST_NO1");
				int idxPOST_NO2 	= userSet.indexOfColumn("POST_NO2");
				int idxADDRESS1 	= userSet.indexOfColumn("ADDRESS1");
				int idxADDRESS2 	= userSet.indexOfColumn("ADDRESS2");
				int idxCOCOMYN  	= userSet.indexOfColumn("COCOMYN");
				int idxUSE_TAG  	= userSet.indexOfColumn("USE_TAG");
				int idxREMARK   	= userSet.indexOfColumn("REMARK");
				int idxWRID     	    = userSet.indexOfColumn("WRID");
				int idxWRDT     	= userSet.indexOfColumn("WRDT");
				int idxSTATUS    	= userSet.indexOfColumn("STATUS");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
	
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.GCZM_VENDER_USER SET 	\n");				
				UpdateSql.append( "  STATUS = ? 													\n");
				UpdateSql.append( " ,BSID = '"+str1+"'												\n");
				UpdateSql.append( " ,BSDT = sysdate												\n");
				UpdateSql.append( "  WHERE  VEND_CD = ? 									\n");	
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1, idxSTATUS);	
						gsmt.bindColumn(2, idxVEND_CD);	

						gsmt.executeUpdate();
						gsmt.close();
					}
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						
					}    					
				}
			}
			catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
      
			conn.commit();
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