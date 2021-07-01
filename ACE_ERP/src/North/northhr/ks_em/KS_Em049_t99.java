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

public class KS_Em049_t99 extends HttpServlet{

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

				//�Ķ��Ÿ �޾ƿ��°� ����

				/******************************** **********************************************
				 * Insert ó��
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				//�Ķ��Ÿ �޾ƿ��°� ����
				String usrid = reqGauce.getParameter("v_str1");
			
				String[] strArrCN = new String[]{ "PAY_YM","PAY_DIV","I_EMPNO"                         
																			  };

				int[] idx = new int[3]; //�÷������� �־��ش�.

					for (int i=0; i<strArrCN.length; i++) {
									idx[i] = userSet.indexOfColumn(strArrCN[i]);
							}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				/******************************** **********************************************
				* INSERT ó��
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
            
            /*+++++++++++++++++++++++++++++++++++++++++++++++ 
              �޿� ��� ���� ����Ÿ
						  +++++++++++++++++++++++++++++++++++++++++++++++*/

							StringBuffer UpdateSql = new StringBuffer();		
							
							UpdateSql.append( " UPDATE SALES.TCM499		\n")
												.append( "   SET WRKSTS ='C',    \n")
												.append( "       U_DATE=CURRENT TIMESTAMP, \n")
												.append( "       U_EMPNO='"+usrid+"' \n") 
												.append( " WHERE APPDT='"+rows[j].getString(idx[0])+"'	\n")
												.append( "   AND PAYDIV='"+rows[j].getString(idx[1])+"' \n");

							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);
								
							gsmt.executeUpdate();					
							gsmt.close();									
						
					}
						/******************************** **********************************************
						* Update ó��
						*********************************************************************************/
            
					 if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

				   
							}
					
					/******************************** **********************************************
					 * DELETE ó��
					 *********************************************************************************/
         
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
           

			   	}
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
