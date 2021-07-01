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

public class KS_Em029_t1 extends HttpServlet{

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
				String str1 = reqGauce.getParameter("v_str1");						//휴가자 직번
				String str2 = reqGauce.getParameter("v_str2");						//근무한 휴일
				String str3 = reqGauce.getParameter("v_str3");						//대체휴가일 == 평일

				if(str1==null) str1="";
				if(str2==null) str2="";
				if(str3==null) str3="";

				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
         
				String[] strArrCN = new String[]{ "HOL_DT", "EMPNO",  "DAY_CD",  	  //3
					
			   		                                  				"DEPT_CD", "HOL_GB",                                      //5
			                                          
													  				"I_EMPNO","I_DATE","U_EMPNO","U_DATE"        // 9
																					
																			  };
																			  
			

				int[] idx = new int[9]; //컬럼갯수를 넣어준다.

       			for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						StringBuffer UpdateSql = new StringBuffer();

						UpdateSql.append( " UPDATE NORTHHR.KST100    									\n");				  						   			
			   			UpdateSql.append( " SET                      												\n");
						UpdateSql.append( " WEEK_GB= '1'										            \n");
						UpdateSql.append( " WHERE EMPNO='"+ str1 +"'  								\n");
						UpdateSql.append( " AND ATT_DT='"+ str2 +"'  									\n");
						
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						
			//			logger.dbg.println(this,UpdateSql.toString());//로그남기는것

						gsmt.executeUpdate();					
						gsmt.close();		

						StringBuffer InsertSql = new StringBuffer();

						InsertSql.append( " 		 INSERT INTO NORTHHR.KST100(													\n" )                                       										
									.append( "		ATT_DT,  EMPNO,     VEND_CD,  DEPT_CD,                        		\n" )       									
									.append( "		JOB_CD,   WORK_CD,  C_VEND_CD,  CLASS_CD,              		\n" )              					
									.append( "		WEEK_GB                )																\n" )
									.append( "		SELECT  '"+str3+"' AS ATT_DT, '"+str1+"' AS EMPNO,				\n" )
									.append( "		A.VEND_CD,  A.DEPT_CD,														\n" )
									.append( "		A.JOB_CD,   A.WORK_CD,  A.C_VEND_CD,  A.CLASS_CD,			\n" )
									.append( "		'5' AS WEEK_GB																		\n" )
									.append( "		FROM NORTHHR.KST010 A															\n" )
									.append( "		WHERE A.EMPNO =   '"+str1+"'													\n" );

						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql.toString()); //로그남기는것
			//			logger.dbg.println(this,InsertSql.toString());//로그남기는것
						gsmt2.executeUpdate();					
						gsmt2.close();	

			//			logger.dbg.println(this,"뭐밍?");	
			
						
					}
					

					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/
         
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						
						//삭제시 휴가 년월의 ORIGINAL로 복구할까??? 흠 우선 두고....나중에 필요하면 반영하지... 
						            
						StringBuffer DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM NORTHHR.TCM355		\n")
										       .append( " WHERE EMPNO=?							        \n")
							             .append( "	   AND YYYY=?							            \n")
				  					       .append( "      AND SEQ=?							              \n");
            	
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);

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
