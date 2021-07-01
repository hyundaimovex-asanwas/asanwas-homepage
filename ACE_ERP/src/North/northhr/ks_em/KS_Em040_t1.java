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

public class KS_Em040_t1 extends HttpServlet{

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
				String str2 = reqGauce.getParameter("v_str2");			
				
				/******************************** **********************************************
				 * Insert ó��
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				String[] strArrCN = new String[]{

										  "ATT_YM",	"P_GB",	"D_PAY", "T_PAY",  "START_DT", 	"END_DT",                                 

                                          "I_EMPNO",	"I_DATE", 		"U_EMPNO",		"U_DATE"
                                          
																					}; //10

				int[] idx = new int[10]; //�÷������� �־��ش�.

        		for (int i=0; i<strArrCN.length; i++) {
        	
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
					}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){

				/******************************** **********************************************
				* Update ó��
				*********************************************************************************/

         			if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

	          		rows[j].setString(idx[8],useid);

					//	logger.dbg.println(this,"step_UPDATE");//�α׳���°�

						StringBuffer UpdateSql = new StringBuffer();


						 UpdateSql.append( " UPDATE ATP.KST210                    					\n")
											.append( " SET                                               			\n")
											.append( " D_PAY=?,						               			\n")
											.append( " T_PAY=?,                                	   				\n")
											.append( " U_EMPNO=?,                                        	\n")
											.append( " U_DATE = sysdate            							\n")
											.append( " WHERE ATT_YM =  '"+str2+"'                   	\n")
											.append( " AND P_GB = ?                  						\n");

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						
					//	logger.dbg.println(this,UpdateSql.toString());//�α׳���°�
						
						gsmt.setGauceDataRow(rows[j]);


                      gsmt.bindColumn(1, idx[2]);
                      gsmt.bindColumn(2, idx[3]);
                      gsmt.bindColumn(3, idx[8]);
					  gsmt.bindColumn(4, idx[1]);

																		
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
