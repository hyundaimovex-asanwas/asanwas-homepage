//**�������. delete,update�Ҷ��� where�� ���Ŀ� primary key �÷��� �� �߰��ؼ� ���ش�***
package North.northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
//import java.util.*;

public class KS_Em019_t1 extends HttpServlet{

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

				/******************************** **********************************************
				 * Insert ó��
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				String[] strArrCN = new String[]{"HEAD",
															"DETAIL",
															"DETAIL_NM",																					
															"ITEM1"
																			}; //4

				int[] idx = new int[4]; //�÷������� �־��ش�.

        		for (int i=0; i<strArrCN.length; i++) {
        	
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
					}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){

				/******************************** **********************************************
				* INSERT ó��
				*********************************************************************************/

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {


						 StringBuffer InsertSql = new StringBuffer();

						 InsertSql.append( " INSERT INTO ATP.TSY010(                                                      		\n" )										
											 .append( "HEAD,  DETAIL,     DETAIL_NM,  ITEM1)                           			\n" )				
											.append( " VALUES																				\n" )
											.append( " (?,?,?,?)																				\n" );

						 
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);
						gsmt.bindColumn(4, idx[3]);

						System.out.println("KS_Em019_t1 \n" + InsertSql.toString());						
						gsmt.executeUpdate();
						gsmt.close();
						
					}
					
					
					/******************************** **********************************************
					* * Update ó�� ó��
					*********************************************************************************/

						if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

		    				StringBuffer UpdateSql = new StringBuffer();	
		      				
							  UpdateSql.append( " UPDATE ATP.TSY010						\n")
													.append( " SET                      				\n")
													.append( " DETAIL_NM=?,        				\n")
									       			.append( " ITEM1=?              				\n")
													.append( " WHERE 1=1 						\n")
													.append( " AND HEAD = ? 						\n")
													.append( " AND DETAIL = ? 					\n");
							
		  						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
		 						
								gsmt.setGauceDataRow(rows[j]);

								gsmt.bindColumn(1,  idx[2]);	
								gsmt.bindColumn(2,  idx[3]);	
								gsmt.bindColumn(3,  idx[0]);	
								gsmt.bindColumn(4,  idx[1]);	
								
								//System.out.println("KS_Em019_t1 \n" + UpdateSql.toString());											
								//logger.dbg.println(this,UpdateSql.toString());

								gsmt.executeUpdate();					
								gsmt.close();		

						}					
					
					
				}
			}
			catch(Exception e){
				logger.err.println(this,e.getMessage());	
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			}
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e.getMessage());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}
