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

public class KS_Em023_t1 extends HttpServlet{

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
				 * Insert 처리
				 *********************************************************************************/
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String[] strArrCN = new String[]{  
													"ATT_DT",  "EMPNO",     "VEND_CD",  "DEPT_CD",
					
					                                "JOB_CD",   "C_VEND_CD",  

													"SAYU_GB",    "A_TM",  		"L_TM",  
													 
													"M_H",           "A_H",           "O_H",           "N1_H",        "N2_H",   
													
													"I_EMPNO",    "I_DATE",       "U_EMPNO",   "U_DATE" 
                                         					                               	
													};
																			  
				int[] idx = new int[18]; //컬럼갯수를 넣어준다.

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();					
				
				for (int j = 0; j < rows.length; j++){
				
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
				
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
								
					 StringBuffer InsertSql = new StringBuffer();

					 String str3 = rows[j].getString(idx[1]);


					 InsertSql.append( " INSERT INTO ATP.KST100(                                                      			\n" )										
										 .append( "ATT_DT,  EMPNO,     VEND_CD,  DEPT_CD,                                 	\n" )									
										 .append( "JOB_CD,   C_VEND_CD,                        										\n" ) 					
										 .append( "SAYU_GB,                               												\n" ) 					
										 .append( "A_TM,  L_TM, 																			\n" ) 	//
										 .append( "M_H,           A_H,           O_H,           N1_H,		N2_H,				\n" )		//				 
										 .append( "I_EMPNO,    I_DATE,       U_EMPNO,   U_DATE)                           	\n" )		//
										 									
										.append( " VALUES																				\n" )
										.append( " ('"+str2+"',?,?,?,																	\n" )//
										.append( " ?,?,																					\n" )//
										.append( " ?,																						\n" )//
										.append( " ?,?,																					\n" )//
										.append( " ?,?,?,?,?,																				\n" )//														
										.append( " ?,sysdate,?,sysdate)																\n" );//

										
						//logger.dbg.println(this, InsertSql.toString()); 
					  /*
						System.out.println("EMPNO,					rows[j].getString(idx[1])::"+rows[j].getString(idx[1]));         	
						System.out.println("VEND_CD,               	rows[j].getString(idx[2])::"+rows[j].getString(idx[2]));         
						System.out.println("DEPT_CD,					rows[j].getString(idx[3])::"+rows[j].getString(idx[3]));         
						System.out.println("JOB_CD,          		rows[j].getString(idx[4])::"+rows[j].getString(idx[4]));              
						System.out.println("C_VEND_CD,          	rows[j].getString(idx[5])::"+rows[j].getString(idx[5]));         
						System.out.println("SAYU_GB,      			rows[j].getString(idx[6])::"+rows[j].getString(idx[6]));         
  
						System.out.println("A_TM,						rows[j].getString(idx[7)::"+rows[j].getString(idx[7]));     
						System.out.println("L_TM,               		rows[j].getString(idx[8])::"+rows[j].getString(idx[8]));     
 
						System.out.println("M_H,             			rows[j].getInt(idx[9])::"+rows[j].getInt(idx[9]));                  
						System.out.println("A_H,            			rows[j].getInt(idx[10])::"+rows[j].getInt(idx[10]));
						System.out.println("O_H,						rows[j].getInt(idx[11])::"+rows[j].getInt(idx[11]));
						System.out.println("N1_H,						rows[j].getInt(idx[12])::"+rows[j].getInt(idx[12]));		
						System.out.println("N2_H,						rows[j].getInt(idx[13])::"+rows[j].getInt(idx[13]));     
						
						System.out.println("I_EMPNO,            		rows[j].getString(idx[14])::"+rows[j].getString(idx[14]));         
						System.out.println("U_EMPNO,            	rows[j].getString(idx[16])::"+rows[j].getString(idx[16]));     
					  */
									  
					 
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); //로그남기는것						 					 				 
						gsmt.setGauceDataRow(rows[j]);				 	
						gsmt.bindColumn(1, idx[1]);		//EMPNO
						gsmt.bindColumn(2, idx[2]); 		
						gsmt.bindColumn(3, idx[3]);		
						gsmt.bindColumn(4, idx[4]);		
						gsmt.bindColumn(5, idx[5]);   	 	
						gsmt.bindColumn(6, idx[6]);		
						gsmt.bindColumn(7, idx[7]);		
						gsmt.bindColumn(8, idx[8]);		
						gsmt.bindColumn(9, idx[9]);		
						gsmt.bindColumn(10, idx[10]);  	
						gsmt.bindColumn(11, idx[11]); 	
						gsmt.bindColumn(12, idx[12]); 	
						gsmt.bindColumn(13, idx[13]); 	
						gsmt.bindColumn(14, idx[14]); 
						gsmt.bindColumn(15, idx[16]);
					
						//System.out.println("KS_Em023_t1 \n" + InsertSql.toString());
						//logger.dbg.println(this,InsertSql.toString());//로그남기는것

						gsmt.executeUpdate();				
						gsmt.close();


					}


						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/
            
         				if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
	
						StringBuffer UpdateSql = new StringBuffer();			

						String str3 = rows[j].getString(idx[1]);
						String str4 = "Y";

						 UpdateSql.append( " UPDATE ATP.KST100				\n")
										.append( " SET									\n")		
										.append( " SAYU_GB=?,						\n")		//
										.append( " A_TM=?,								\n")		//									
										.append( " L_TM=?,								\n")		//	
										.append( " M_H=?,								\n")		//
										.append( " A_H=?,								\n")		//
										.append( " O_H=?,								\n")		//
										.append( " N1_H=?,								\n")		//						
										.append( " N2_H=?,								\n")		//			
										.append( " U_DATE = sysdate					\n")								
										.append( " WHERE EMPNO='"+str3+"'		\n");		

/*
						logger.dbg.println(this,"WEEK_GB,    		rows[j].getString(idx[8])::"+rows[j].getString(idx[8]));                   
						logger.dbg.println(this,"WORK_GB,    		rows[j].getString(idx[9])::"+rows[j].getString(idx[9]));     
						logger.dbg.println(this,"SAYU_GB,      		rows[j].getString(idx[10])::"+rows[j].getString(idx[10]));         
						logger.dbg.println(this,"MODI_YN,  			rows[j].getString(idx[11])::"+rows[j].getString(idx[11]));           
						logger.dbg.println(this,"A_TM,					rows[j].getString(idx[15])::"+rows[j].getString(idx[15]));     
						logger.dbg.println(this,"L_TM,               	rows[j].getString(idx[16])::"+rows[j].getString(idx[16]));     
						logger.dbg.println(this,"E_TM,					rows[j].getString(idx[17])::"+rows[j].getString(idx[17]));         
						logger.dbg.println(this,"G_TM,            		rows[j].getString(idx[18])::"+rows[j].getString(idx[18]));         
						logger.dbg.println(this,"R_TM,					rows[j].getString(idx[19])::"+rows[j].getString(idx[19]));         
						logger.dbg.println(this,"FINI_GB,           	rows[j].getString(idx[20])::"+rows[j].getString(idx[20]));         
						logger.dbg.println(this,"C_A_TM,            	rows[j].getString(idx[21])::"+rows[j].getString(idx[21]));         
						logger.dbg.println(this,"C_L_TM,				rows[j].getString(idx[22])::"+rows[j].getString(idx[22]));         
						logger.dbg.println(this,"C_E_TM,            	rows[j].getString(idx[23])::"+rows[j].getString(idx[23]));         
						logger.dbg.println(this,"M_H,             		rows[j].getInt(idx[24])::"+rows[j].getInt(idx[24]));                  
						logger.dbg.println(this,"A_H,            		rows[j].getInt(idx[25])::"+rows[j].getInt(idx[25]));
						logger.dbg.println(this,"O_H,					rows[j].getInt(idx[26])::"+rows[j].getInt(idx[26]));
						logger.dbg.println(this,"N_H,					rows[j].getInt(idx[27])::"+rows[j].getInt(idx[27]));		
						logger.dbg.println(this,"E_H,					rows[j].getInt(idx[28])::"+rows[j].getInt(idx[28]));     
						logger.dbg.println(this,"T_H,               		rows[j].getInt(idx[29])::"+rows[j].getInt(idx[29]));     
						logger.dbg.println(this,"G_H,					rows[j].getInt(idx[30])::"+rows[j].getInt(idx[30]));       
						  
						System.out.println("EMPNO,					rows[j].getString(idx[1])::"+rows[j].getString(idx[1]));         	
						System.out.println("VEND_CD,               	rows[j].getString(idx[2])::"+rows[j].getString(idx[2]));         
						System.out.println("DEPT_CD,					rows[j].getString(idx[3])::"+rows[j].getString(idx[3]));         
						System.out.println("JOB_CD,          		rows[j].getString(idx[4])::"+rows[j].getString(idx[4]));              
						System.out.println("C_VEND_CD,          	rows[j].getString(idx[5])::"+rows[j].getString(idx[5]));         
						System.out.println("SAYU_GB,      			rows[j].getString(idx[6])::"+rows[j].getString(idx[6]));         
						System.out.println("A_TM,						rows[j].getString(idx[7)::"+rows[j].getString(idx[7]));     
						System.out.println("L_TM,               		rows[j].getString(idx[8])::"+rows[j].getString(idx[8]));     
						System.out.println("M_H,             			rows[j].getInt(idx[9])::"+rows[j].getInt(idx[9]));                  
						System.out.println("A_H,            			rows[j].getInt(idx[10])::"+rows[j].getInt(idx[10]));
						System.out.println("O_H,						rows[j].getInt(idx[11])::"+rows[j].getInt(idx[11]));
						System.out.println("N1_H,						rows[j].getInt(idx[12])::"+rows[j].getInt(idx[12]));		
						System.out.println("N2_H,						rows[j].getInt(idx[13])::"+rows[j].getInt(idx[13]));     
						System.out.println("I_EMPNO,            		rows[j].getString(idx[14])::"+rows[j].getString(idx[14]));         
						System.out.println("U_EMPNO,            	rows[j].getString(idx[16])::"+rows[j].getString(idx[16]));     						  
*/
										
										GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
										gsmt.setGauceDataRow(rows[j]);										
										
										gsmt.bindColumn(1, idx[6]);		//
										gsmt.bindColumn(2, idx[7]); 		//
										gsmt.bindColumn(3, idx[8]);		//
										gsmt.bindColumn(4, idx[9]);   	//
										gsmt.bindColumn(5, idx[10]);		//
										gsmt.bindColumn(6, idx[11]);		//
										gsmt.bindColumn(7, idx[12]);		//
										gsmt.bindColumn(8, idx[13]);		//
	
										//logger.dbg.println(this,"UpdateSql.toString()::" + UpdateSql.toString());																								

										gsmt.executeUpdate();
										gsmt.close();

					}



						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/
			
					/******************************** **********************************************
					 * DELETE 처리
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
