//**�������. delete,update�Ҷ��� where�� ���Ŀ� primary key �÷��� �� �߰��ؼ� ���ش�***
package northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class KS_Em041_t1 extends HttpServlet{

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

				//�Ķ��Ÿ �޾ƿ��°� ����
				String useid = reqGauce.getParameter("v_str1");		
				//	logger.dbg.println(this,"�o��?");//�α׳���°�			
				/******************************** **********************************************
				 * Insert ó��
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				String[] strArrCN = new String[]{
																						"EMPNO",	"PAY_GB",	"ITEM_GB", "PAY_ITME",

																						"START_DT", 	"END_DT", 	"EX_PAY",

																						"I_EMPNO",   "I_DATE",

																						"U_EMPNO", "U_DATE"
                                        
																					}; //11

				int[] idx = new int[11]; //�÷������� �־��ش�.

        		for (int i=0; i<strArrCN.length; i++) {
        	
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
					}

				GauceDataRow[] rows = userSet.getDataRows();
				//logger.dbg.println(this,"�o��?");//�α׳���°�	
				for (int j = 0; j < rows.length; j++){

				/******************************** **********************************************
				* Update ó��
				*********************************************************************************/
				//logger.dbg.println(this,"�o��?");//�α׳���°�	
         			if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

	          		rows[j].setString(idx[9],useid);

					//	logger.dbg.println(this,"step_UPDATE");//�α׳���°�

						StringBuffer UpdateSql = new StringBuffer();


						 UpdateSql.append( " UPDATE NORTHHR.KST220                    \n")
											.append( " SET                                               \n")
											.append( " PAY_GB=?,                                	   \n")											
											.append( " ITEM_GB=?,						               \n")
											.append( " PAY_ITME=?,                                	   \n")											
											.append( " START_DT=?,						               \n")
											.append( " END_DT=?,                                	   \n")
											.append( " EX_PAY=?,                                	   \n")
											.append( " U_EMPNO=?,                                        \n")
											.append( " U_DATE = CURRENT TIMESTAMP            \n")
											.append( " WHERE EMPNO = ?                  \n");


						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						
				//		logger.dbg.println(this,UpdateSql.toString());//�α׳���°�
						
						gsmt.setGauceDataRow(rows[j]);


						gsmt.bindColumn(1, idx[1]);
						gsmt.bindColumn(2, idx[2]);
						gsmt.bindColumn(3, idx[3]);
						gsmt.bindColumn(4, idx[4]);
						gsmt.bindColumn(5, idx[5]);
						gsmt.bindColumn(6, idx[6]);		
						gsmt.bindColumn(7, idx[9]);
						gsmt.bindColumn(8, idx[0]);

																		
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
