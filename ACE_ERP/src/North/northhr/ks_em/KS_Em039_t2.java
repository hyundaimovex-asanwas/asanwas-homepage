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

public class KS_Em039_t2 extends HttpServlet{

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
				conn.setAutoCommit(false);

				// ������������ ���ǰ��� �Ѱܹ���
				String  str1	= req.getParameter("v_str1");   // ���屸��

/******************************** **********************************************
 *
*********************************************************************************/
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String[] strArrCN = new String[]{  "ATT_DT",  "EMPNO",    
													 
															"M_H",           "A_H",           "O_H",           "N1_H",          "N2_H"
													                                    					                               	
															 };
																			  
				int[] idx = new int[7]; //�÷������� �־��ش�.

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();					
		
				for (int j = 0; j < rows.length; j++){

/******************************************************************************
* Update ó��
*********************************************************************************/
    
        	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_INSERT) {

						StringBuffer UpdateSql = new StringBuffer();			

								UpdateSql.append( " UPDATE ATP.KST100																\n")
												.append( " SET																					\n")
												.append( " M_H = ?,																				\n")
												.append( " A_H = ?,																				\n")
												.append( " O_H = ?,																				\n")
												.append( " N1_H = ?,																			\n")
												.append( " N2_H = ?																				\n")							
												.append( " WHERE EMPNO ='"+rows[j].getString(idx[1])+"'							\n")
												.append( "   AND ATT_DT ='"+rows[j].getString(idx[0])+"'							\n");


						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

						gsmt.setGauceDataRow(rows[j]);
											
						gsmt.bindColumn(1,  idx[2]);
						gsmt.bindColumn(2,  idx[3]);
						gsmt.bindColumn(3,  idx[4]);
						gsmt.bindColumn(4,  idx[5]);
						gsmt.bindColumn(5,  idx[6]);

						gsmt.executeUpdate();					
						gsmt.close();									

					}
				
/******************************** **********************************************
 * 
 *********************************************************************************/

				}
			}
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,e.getMessage());	
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			}

			conn.commit();
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
