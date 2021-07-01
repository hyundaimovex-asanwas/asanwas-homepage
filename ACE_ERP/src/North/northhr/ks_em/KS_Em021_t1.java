//**참고사항. delete,update할떼는 where절 이후에 primary key 컬럼을 꼭 추가해서 써준다***
package North.northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class KS_Em021_t1 extends HttpServlet{

	
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

				//파라메타 받아오는것 선언

				
				String  str1	= req.getParameter("v_str1");   //EMPNO

				if (str1==null) str1=""; 
				/*******************************************************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
         
				String[] strArrCN = new String[]{				                                
							                                          "ATT_DT", "DAY_CD","DAY_GB", "REMARK",   
							                                           
																	   "I_EMPNO","I_DATE","U_EMPNO","U_DATE"

																			  };

				int[] idx = new int[8]; //컬럼갯수를 넣어준다.

        		for (int i=0; i<strArrCN.length; i++) {
        	
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
						
				}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				
/******************************** **********************************************
* Update 처리
*********************************************************************************/
            
         	 if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {


    				StringBuffer UpdateSql = new StringBuffer();	
  				
					  UpdateSql.append( " UPDATE ATP.KST130						\n")
					  
											.append( " SET                      				\n")
											
											.append( " DAY_GB=?,    REMARK=?,    	\n")
											
							       			.append( " U_EMPNO=?,               		\n")
							       			
											.append( " U_DATE = sysdate 				\n")

											.append( " WHERE 1=1 						\n")
											
											.append( " AND ATT_DT = ? 					\n");


						rows[j].setString(idx[6],str1);
					
  						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
 						
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idx[2]);	
						gsmt.bindColumn(2,  idx[3]);	
						gsmt.bindColumn(3,  idx[6]);	
						gsmt.bindColumn(4,  idx[0]);	
						
						//logger.dbg.println(this,UpdateSql.toString());

	
						gsmt.executeUpdate();					
						gsmt.close();		


			   	}
				}
			}
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,e.getMessage());	
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
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
