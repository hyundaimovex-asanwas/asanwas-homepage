package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010055_t1 extends HttpServlet{
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

			Integer intSeq = 0;
			String strVend_CD="";

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				String str1 = reqGauce.getParameter("v_str1");
				
				//System.out.println("step1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxVEND_CD     	= userSet.indexOfColumn("VEND_CD");
				int idxVEND_ID     	= userSet.indexOfColumn("VEND_ID");
				int idxSEQ         	= userSet.indexOfColumn("SEQ");
				int idxB_VEND_NM   	= userSet.indexOfColumn("B_VEND_NM");
				int idxB_VD_DIRECT 	= userSet.indexOfColumn("B_VD_DIRECT");
				int idxB_POST_NO1  	= userSet.indexOfColumn("B_POST_NO1");
				int idxB_POST_NO2  	= userSet.indexOfColumn("B_POST_NO2");
				int idxB_ADDRESS1  	= userSet.indexOfColumn("B_ADDRESS1");
				int idxB_ADDRESS2  	= userSet.indexOfColumn("B_ADDRESS2");
				int idxB_COCOMYN  	= userSet.indexOfColumn("B_COCOMYN");
				int idxA_VEND_NM   	= userSet.indexOfColumn("A_VEND_NM");
				int idxA_VD_DIRECT 	= userSet.indexOfColumn("A_VD_DIRECT");
				int idxA_POST_NO1  	= userSet.indexOfColumn("A_POST_NO1");
				int idxA_POST_NO2  	= userSet.indexOfColumn("A_POST_NO2");
				int idxA_ADDRESS1  	= userSet.indexOfColumn("A_ADDRESS1");
				int idxA_ADDRESS2  	= userSet.indexOfColumn("A_ADDRESS2");
				int idxA_COCOMYN  	= userSet.indexOfColumn("A_COCOMYN");
				int idxSTATUS      	= userSet.indexOfColumn("STATUS");
				int idxWRID        	= userSet.indexOfColumn("WRID");
				int idxUPID        	= userSet.indexOfColumn("UPID");
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.GCZM_VENDER_MD ( 				               \n");
				InsertSql.append( " VEND_CD,VEND_ID,SEQ,  		                                       \n");
				InsertSql.append( " B_VEND_NM,B_VD_DIRECT,B_POST_NO1,B_POST_NO2,B_ADDRESS1,B_ADDRESS2,B_COCOMYN, \n");
				InsertSql.append( " A_VEND_NM,A_VD_DIRECT,A_POST_NO1,A_POST_NO2,A_ADDRESS1,A_ADDRESS2,A_COCOMYN, \n");
				InsertSql.append( " STATUS,WRID,WRDT                                                   \n");
				InsertSql.append( "	) VALUES( 	  													   \n");
				InsertSql.append( " ?, ?, ?,  														   \n");
				InsertSql.append( " ?, ?, ?, ?, ?, ?, ?,               								   \n");
				InsertSql.append( " ?, ?, ?, ?, ?, ?, ?,    										   \n");
				InsertSql.append( " ?, '"+str1+"', sysdate  ) 	    	                      		   \n");
				
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.GCZM_VENDER_MD SET 	                            \n");				
				/*
				UpdateSql.append( "  B_VEND_NM = ? 												    \n");
				UpdateSql.append( " ,B_VD_DIRECT = ? 												\n");
				UpdateSql.append( " ,B_POST_NO1 = ? 												\n");
				UpdateSql.append( " ,B_POST_NO2 = ? 												\n");
				UpdateSql.append( " ,B_ADDRESS1 = ? 												\n");
				UpdateSql.append( " ,B_ADDRESS2 = ? 												\n");
				UpdateSql.append( " ,A_VEND_NM = ? 												    \n");
				UpdateSql.append( " ,A_VD_DIRECT = ? 												\n");
				UpdateSql.append( " ,A_POST_NO1 = ? 												\n");
				UpdateSql.append( " ,A_POST_NO2 = ? 												\n");
				UpdateSql.append( " ,A_ADDRESS1 = ? 												\n");
				UpdateSql.append( " ,A_ADDRESS2 = ? 												\n");
				*/
				UpdateSql.append( "  STATUS = ? 													\n");
				UpdateSql.append( " ,UPID = '"+str1+"'											    \n");
				UpdateSql.append( " ,UPDT =	sysdate 											    \n");
				UpdateSql.append( "  WHERE  VEND_CD = ? 									        \n");	
				UpdateSql.append( "    AND  SEQ = ? 								             	\n");	
				
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.GCZM_VENDER_MD 		\n");				
				DeleteSql.append( "  WHERE  VEND_CD = ? 					\n");
				DeleteSql.append( "    AND  SEQ = ? 		    			\n");	

				
				

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
						//System.out.println("step2");


						Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						
						sql0.append( " SELECT NVL(MAX(SEQ),0)+1        \n"); 
						sql0.append( "   FROM ACCOUNT.GCZM_VENDER_MD   \n");
						sql0.append( "  WHERE VEND_CD = '"+rows[j].getString(idxVEND_CD)+"'   \n");
						
						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							intSeq= rs0.getInt(1);
						}
						rs0.close();
						stmt0.close();
						
						rows[j].setInt(idxSEQ,intSeq);
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
					
					 	//System.out.println("InsertSql.toString()::"+InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxVEND_CD);
						gsmt.bindColumn(2,  idxVEND_ID);
						gsmt.bindColumn(3,  idxSEQ);
						gsmt.bindColumn(4,  idxB_VEND_NM);
						gsmt.bindColumn(5,  idxB_VD_DIRECT);
						gsmt.bindColumn(6,  idxB_POST_NO1);
						gsmt.bindColumn(7,  idxB_POST_NO2);
						gsmt.bindColumn(8,  idxB_ADDRESS1);
						gsmt.bindColumn(9,  idxB_ADDRESS2);
						gsmt.bindColumn(10, idxB_COCOMYN);
						gsmt.bindColumn(11, idxA_VEND_NM);
						gsmt.bindColumn(12, idxA_VD_DIRECT);
						gsmt.bindColumn(13, idxA_POST_NO1);
						gsmt.bindColumn(14, idxA_POST_NO2);
						gsmt.bindColumn(15, idxA_ADDRESS1);
						gsmt.bindColumn(16, idxA_ADDRESS2);
						gsmt.bindColumn(17, idxA_COCOMYN);
						gsmt.bindColumn(18, idxSTATUS);
						
						//System.out.println("step...9999.");
		
						gsmt.executeUpdate();
						
						//System.out.println("step..end..");
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
						//System.out.println("UpdateSql.toString()::"+UpdateSql.toString());
					
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
						
						/*
						gsmt.bindColumn(1,  idxB_VEND_NM);
						gsmt.bindColumn(2,  idxB_VD_DIRECT);
						gsmt.bindColumn(3,  idxB_POST_NO1);
						gsmt.bindColumn(4,  idxB_POST_NO2);
						gsmt.bindColumn(5,  idxB_ADDRESS1);
						gsmt.bindColumn(6,  idxB_ADDRESS2);
						gsmt.bindColumn(7,  idxA_VEND_NM);
						gsmt.bindColumn(8,  idxA_VD_DIRECT);
						gsmt.bindColumn(9,  idxA_POST_NO1);
						gsmt.bindColumn(10, idxA_POST_NO2);
						gsmt.bindColumn(11, idxA_ADDRESS1);
						gsmt.bindColumn(12, idxA_ADDRESS2);
						*/
						gsmt.bindColumn(1, idxSTATUS);
						gsmt.bindColumn(2, idxVEND_CD);
						gsmt.bindColumn(3, idxSEQ);

						gsmt.executeUpdate();
						gsmt.close();
					
					}
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
	
						gsmt.bindColumn(1, idxVEND_CD);
						gsmt.bindColumn(2, idxSEQ);

						gsmt.executeUpdate();
						gsmt.close();
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