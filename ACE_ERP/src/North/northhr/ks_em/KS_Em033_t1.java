//**참고사항. delete,update할떼는 where절 이후에 primary key 컬럼을 꼭 추가해서 써준다***
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

public class KS_Em033_t1 extends HttpServlet{

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

				String useid = reqGauce.getParameter("v_str1");//파라메타 받아오는것 선언
				String yymm = reqGauce.getParameter("v_str2");//파라메타 받아오는것 선언	
							
				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");			
				String[] strArrCN = new String[]{
																		"EMPNO",		
																		"START_DT",
																		"END_DT",
																		"WORK_GB",
																		"DEPT_CD",																				 
																		"REMARK",		 
																		"I_EMPNO",		 
																		"I_DATE",			 
																		"U_EMPNO",		 
																		"U_DATE"
																			}; 				//7

				int[] idx = new int[10]; //컬럼갯수를 넣어준다.

        for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();


				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){

/******************************************************************************
* Update 처리
*********************************************************************************/

         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						 rows[j].setString(idx[8],useid);//데이터셋 setString으로 가져오기

						 UpdateSql = new StringBuffer();
						 UpdateSql.append( " UPDATE SALES.KST150      \n")
											.append( " SET                      \n")
											.append( " START_DT=?,               \n")
											.append( " END_DT=?,               \n")
											.append( " WORK_GB=?,               \n")
											.append( " DEPT_CD=?,               \n")
											.append( " REMARK=?,               \n")
											.append( " U_EMPNO= ?, 							\n")
											.append( " U_DATE=CURRENT TIMESTAMP \n")
											.append( " WHERE           					\n")
											.append( "  EMPNO= ?			            \n");

							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

/*
				logger.dbg.println(this,"				rows[j].getString(idx[0])::"+rows[j].getString(idx[0]));         
				logger.dbg.println(this,"				rows[j].getString(idx[1])::"+rows[j].getString(idx[1]));         	
				logger.dbg.println(this,"             	rows[j].getString(idx[2])::"+rows[j].getString(idx[2]));         
				logger.dbg.println(this,"				rows[j].getString(idx[3])::"+rows[j].getString(idx[3]));         
				logger.dbg.println(this,"          	rows[j].getString(idx[4])::"+rows[j].getString(idx[4]));         
				logger.dbg.println(this,"          	rows[j].getString(idx[5])::"+rows[j].getString(idx[5]));  
*/

							gsmt.setGauceDataRow(rows[j]);
							gsmt.bindColumn(1,  idx[1]);
							gsmt.bindColumn(2,  idx[2]);
							gsmt.bindColumn(3,  idx[3]);
							gsmt.bindColumn(4,  idx[4]);
							gsmt.bindColumn(5,  idx[5]);
							gsmt.bindColumn(6,  idx[8]);
							gsmt.bindColumn(7,  idx[0]);							
							
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
