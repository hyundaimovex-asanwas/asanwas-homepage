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


public class KS_Em023_t6 extends HttpServlet{

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
 *
*********************************************************************************/
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String[] strArrCN = new String[]{  "ATT_DT",  "EMPNO",     "VEND_CD",  "DEPT_CD",
					
					                                "JOB_CD",   "WORK_CD",  "C_VEND_CD",  "CLASS_CD", 

													"WEEK_GB", "WORK_GB",  "SAYU_GB", "MODI_YN",			//0~11

													"M_PAY",  "D_PAY",  "T_PAY",											//12~14
					                                
                                          			"A_TM",  "L_TM",  "E_TM",  "G_TM",  "R_TM",					//15~19

													"FINI_GB",     "C_A_TM",     "C_L_TM",     "C_E_TM",			//20~23
													 
													"M_H",           "A_H",           "O_H",           "N1_H",          "N2_H",	//24~28
													 
													"E_H",            "T_H",            "G_H",								//29~31
													
													"I_EMPNO",    "I_DATE",       "U_EMPNO",   "U_DATE"		//32~35
                                         					                               	
																			  };
																			  
				int[] idx = new int[36]; //컬럼갯수를 넣어준다.
				
				//logger.dbg.println(this,"뭥미?");//로그남기는것

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();					
		
				for (int j = 0; j < rows.length; j++){

/******************************************************************************
* Update 처리
*********************************************************************************/
    
        	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_INSERT) {

						StringBuffer UpdateSql = new StringBuffer();			

								UpdateSql.append( " UPDATE ATP.KST100																\n")
												.append( " SET																					\n")
												.append( " SAYU_GB = ?,																		\n")                  				
												.append( " A_TM = ?,																			\n")
												.append( " L_TM = ?,																			\n")
												.append( " M_H = ?,																				\n")
												.append( " A_H = ?,																				\n")
												.append( " O_H = ?,																				\n")
												.append( " N1_H = ?,																			\n")
												.append( " N2_H = ?,																			\n")							
												.append( " U_EMPNO = ?,																		\n")
												.append( " U_DATE= sysdate																	\n")
												.append( " WHERE EMPNO ='"+rows[j].getString(idx[1])+"'							\n")
												.append( "   AND ATT_DT ='"+rows[j].getString(idx[0])+"'							\n");


						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						//logger.dbg.println(this,UpdateSql.toString());//로그남기는것

						gsmt.setGauceDataRow(rows[j]);
											
						gsmt.bindColumn(1,  idx[10]);
						gsmt.bindColumn(2,  idx[15]);
						gsmt.bindColumn(3,  idx[16]);
						gsmt.bindColumn(4,  idx[24]);
						gsmt.bindColumn(5,  idx[25]);
						gsmt.bindColumn(6,  idx[26]);
						gsmt.bindColumn(7,  idx[27]);
						gsmt.bindColumn(8,  idx[28]);
						gsmt.bindColumn(9,  idx[34]);

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
