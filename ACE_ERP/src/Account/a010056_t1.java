package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010056_t1 extends HttpServlet{
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
				String str2 = reqGauce.getParameter("v_str2");
				String strGB = "";
				String strCnt = "";

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

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				StringBuffer UpdateSql2 = null;
				StringBuffer DeleteSql  = null;
								
	
				//상태값 UPDATE  
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.GCZM_VENDER_MD SET 	\n");				
				UpdateSql.append( "  STATUS = ? 						\n");
				UpdateSql.append( " ,UPID = '"+str1+"'					\n");
				UpdateSql.append( " ,UPDT = sysdate						\n");
				UpdateSql.append( "  WHERE  VEND_CD = ? 				\n");
				UpdateSql.append( "    AND  SEQ = ? 			    	\n");
				
				
				
				//상태값 UPDATE  
				UpdateSql2 = new StringBuffer();
				UpdateSql2.append( " UPDATE ACCOUNT.GCZM_VENDER SET     \n");				
				UpdateSql2.append( "  VEND_NM   = ? 					\n");
				UpdateSql2.append( " ,VD_DIRECT = ? 					\n");
				UpdateSql2.append( " ,POST_NO1  = ? 					\n");
				UpdateSql2.append( " ,POST_NO2  = ? 					\n");
				UpdateSql2.append( " ,ADDRESS1  = ? 					\n");
				UpdateSql2.append( " ,ADDRESS2  = ? 					\n");
				UpdateSql2.append( " ,COCOMYN   = ? 		 			\n");
				UpdateSql2.append( " ,UPID = '"+str1+"'					\n");
				UpdateSql2.append( " ,UPDT = sysdate					\n");
				UpdateSql2.append( " WHERE  VEND_CD = ? 				\n");
				
				
				//COMMDTIL도 UPDATE 
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1, idxSTATUS);	
						gsmt.bindColumn(2, idxVEND_CD);	
						gsmt.bindColumn(3, idxSEQ);	

						gsmt.executeUpdate();
						gsmt.close();
						
						gsmt=null;
						
						
						gsmt = conn.getGauceStatement(UpdateSql2.toString());
					
						//	logger.dbg.println(this,InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
					
						gsmt.bindColumn(1,  idxA_VEND_NM);	
						gsmt.bindColumn(2,  idxA_VD_DIRECT);	
						gsmt.bindColumn(3,  idxA_POST_NO1);	
						gsmt.bindColumn(4,  idxA_POST_NO2);	
						gsmt.bindColumn(5,  idxA_ADDRESS1);	
						gsmt.bindColumn(6,  idxA_ADDRESS2);	
						gsmt.bindColumn(7,  idxA_COCOMYN);	
						gsmt.bindColumn(8,  idxVEND_CD);	
											
						gsmt.executeUpdate();
						gsmt.close();
						
						
						
						//	거래처 조회
						  Statement stmt0 = conn.createStatement();
						  String sql0 = " SELECT COUNT(CDCODE) CNT  FROM ACCOUNT.COMMDTIL "
											+ " WHERE CMTYPE='0020'"
											+ "	  AND CDCODE ='"+rows[j].getString(idxVEND_CD)+"'";
							
						  ResultSet rs0 = stmt0.executeQuery(sql0); 
	
						  if(rs0.next()){
							   strGB=rs0.getString(1);
						  }else{
							   strGB="0";
						  }
						  
						  if(strGB.equals("0")){
							
							String  sql0_1 = " INSERT INTO ACCOUNT.COMMDTIL( "
														+ "   CMTYPE, CDCODE, CDNAM, WRID, WRDT	 "
														+ "  ) VALUES ( "
														+ "  '0020',?,?,"
												    	+ "  '"+str1+"',"
														+ "  '"+str2+"')";

							GauceStatement gsmt0_1= conn.getGauceStatement(sql0_1);
							gsmt0_1.setGauceDataRow(rows[j]);
							gsmt0_1.bindColumn(1, idxVEND_CD);
						    gsmt0_1.bindColumn(2, idxA_VEND_NM);
							gsmt0_1.executeUpdate();
							gsmt0_1.close();
						  }else{
		
							String  sql0_2 = " UPDATE ACCOUNT.COMMDTIL SET  "
					                        	  + "         CDNAM = ?, "
												  + "         UPID= '"+str1+"',"
												  + "         UPDT= '"+str2+"'"  
												  + "  WHERE CMTYPE = '0020'"
												  + "    AND CDCODE = '"+rows[j].getString(idxVEND_CD)+"'";
									
							GauceStatement gsmt0_2 = conn.getGauceStatement(sql0_2);
							gsmt0_2.setGauceDataRow(rows[j]);
						    gsmt0_2.bindColumn(1, idxA_VEND_NM);
							gsmt0_2.executeUpdate();
							gsmt0_2.close();
						}
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