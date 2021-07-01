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

public class KS_Em023_t4 extends HttpServlet{

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

				// 웹페이지에서 조건값을 넘겨받음
				String  str1	= req.getParameter("v_str1");   // 직장구분
				String  str2	= req.getParameter("v_str2");   // 출근일자

/******************************** **********************************************

*********************************************************************************/
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String[] strArrCN = new String[]{  "FINI_GB"
					                                       					                               	
																			  };
																			  
				int[] idx = new int[1]; //컬럼갯수를 넣어준다.

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();					
				
				for (int j = 0; j < rows.length; j++){

/******************************************************************************
* Update 처리
*********************************************************************************/
           
         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
	
						StringBuffer UpdateSql = new StringBuffer();			

						rows[j].setString(idx[0], "N");			//1로 셋팅하기... N이면 마감 X, Y이면 마감 0

						 UpdateSql.append( " UPDATE SALES.KST100			\n")
											.append( " SET                      				\n")
											.append( " FINI_GB=?               			\n")
											.append( " WHERE 1=1							\n")
											.append( "   AND DEPT_CD ='"+str1+"' 	\n");
//											.append( "   AND ATT_DT ='"+str2+"' 	\n");


						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						logger.dbg.println(this,UpdateSql.toString());//로그남기는것

						gsmt.setGauceDataRow(rows[j]);
											
						gsmt.bindColumn(1,  idx[0]);	

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
