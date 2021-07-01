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

public class KS_Em024_t2 extends HttpServlet{

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
//				String  str3	= req.getParameter("v_str3");   // 직번
//				String  str4	= req.getParameter("v_str4");   // 이름
				




				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String[] strArrCN = new String[]{  "ATT_DT",  "EMPNO",     "VEND_CD",  "DEPT_CD",
					
					                                "JOB_CD",   "WORK_CD",  "C_VEND_CD",  "CLASS_CD", 

													"WEEK_GB", "WORK_GB",  "SAYU_GB", "MODI_YN", 

													"M_PAY",  "D_PAY",  "T_PAY",
					                                
                                          			"A_TM",  "L_TM",  "E_TM",  "G_TM",  "R_TM",  

													"FINI_GB",     "C_A_TM",     "C_L_TM",     "C_E_TM",    
													 
													"M_H",           "A_H",           "O_H",           "N1_H",          "N2_H",
													 
													"E_H",            "T_H",            "G_H",           
													
													"I_EMPNO",    "I_DATE",       "U_EMPNO",   "U_DATE" 
                                         					                               	
																			  };
																			  
				int[] idx = new int[36]; //컬럼갯수를 넣어준다.

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();					
				
				for (int j = 0; j < rows.length; j++){
				
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
				
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
								
					 StringBuffer InsertSql = new StringBuffer();

					 String str3 = rows[j].getString(idx[1]);
                    
					 InsertSql.append( " INSERT INTO SALES.KST100(																\n" )										
										 .append( "ATT_DT,  EMPNO,     VEND_CD,  DEPT_CD,									\n" )									
										 .append( "JOB_CD,   WORK_CD,  C_VEND_CD,  CLASS_CD,                         \n" ) 					
										 .append( "WEEK_GB, WORK_GB,  SAYU_GB, MODI_YN,                               \n" ) 					
										 .append( "M_PAY,  D_PAY,  T_PAY,                               								\n" )		//15										                                
										 .append( "A_TM,  L_TM,  E_TM,  G_TM,  R_TM,												\n" ) 	//20				
										 .append( "FINI_GB,     C_A_TM,     C_L_TM,     C_E_TM,                               \n" )    	//24				 
										 .append( "M_H,           A_H,           O_H,           N1_H,        N2_H,                 \n" )     //29 					 
										 .append( "E_H,            T_H,            G_H,														\n" )     //32
										 .append( "I_EMPNO,    I_DATE,       U_EMPNO,   U_DATE     )                          \n" )	//36
										 									
										.append( " VALUES																				\n" )
										.append( " ('"+str2+"',?,?,?,																	\n" )//4
										.append( " ?,?,?,?,																					\n" )//8
										.append( " ?,?,?,'N',																				\n" )//12
										.append( " ?,?,?,																					\n" )//15
										.append( " ?,?,?,?,?,																				\n" )//20										
										.append( " 'N',?,?,?,																				\n" )//24	
										.append( " ?,?,?,?,?,																				\n" )//29										
										.append( " ?,?,?,																					\n" )//32									
										.append( " ?,CURRENT TIMESTAMP,?,CURRENT TIMESTAMP)					\n" );//36		//물음표는 30개...ㅋ

/*										
						logger.dbg.println(this, InsertSql.toString()); 		
						logger.dbg.println(this,"EMPNO,				rows[j].getString(idx[1])::"+rows[j].getString(idx[1]));         	
						logger.dbg.println(this,"VEND_CD,               	rows[j].getString(idx[2])::"+rows[j].getString(idx[2]));         
						logger.dbg.println(this,"DEPT_CD,rows[j].getString(idx[3])::"+rows[j].getString(idx[3]));         
						logger.dbg.println(this,"JOB_CD,          	rows[j].getString(idx[4])::"+rows[j].getString(idx[4]));         
						logger.dbg.println(this,"WORK_CD,		rows[j].getString(idx[5])::"+rows[j].getString(idx[5]));         
						logger.dbg.println(this,"C_VEND_CD,          	rows[j].getString(idx[6])::"+rows[j].getString(idx[6]));         
						logger.dbg.println(this,"CLASS_CD,					rows[j].getString(idx[7])::"+rows[j].getString(idx[7]));         
						logger.dbg.println(this,"WEEK_GB,    	rows[j].getString(idx[8])::"+rows[j].getString(idx[8]));                   
						logger.dbg.println(this,"WORK_GB,    	rows[j].getString(idx[9])::"+rows[j].getString(idx[9]));     
						logger.dbg.println(this,"SAYU_GB,      	rows[j].getString(idx[10])::"+rows[j].getString(idx[10]));         
	//					logger.dbg.println(this,"MODI_YN,  	rows[j].getString(idx[11])::"+rows[j].getString(idx[11]));         
						logger.dbg.println(this,"M_PAY,	rows[j].getString(idx[12])::"+rows[j].getDouble(idx[12]));         
						logger.dbg.println(this,"D_PAY,    	rows[j].getString(idx[13])::"+rows[j].getDouble(idx[13]));      
						logger.dbg.println(this,"T_PAY,		rows[j].getString(idx[14])::"+rows[j].getDouble(idx[14]));	    
						logger.dbg.println(this,"A_TM,			rows[j].getString(idx[15])::"+rows[j].getString(idx[15]));     
						logger.dbg.println(this,"L_TM,               	rows[j].getString(idx[16])::"+rows[j].getString(idx[16]));     
						logger.dbg.println(this,"E_TM,					rows[j].getString(idx[17])::"+rows[j].getString(idx[17]));         
						logger.dbg.println(this,"G_TM,            	rows[j].getString(idx[18])::"+rows[j].getString(idx[18]));         
						logger.dbg.println(this,"R_TM,				rows[j].getString(idx[19])::"+rows[j].getString(idx[19]));         
		//				logger.dbg.println(this,"FINI_GB,           	rows[j].getString(idx[20])::"+rows[j].getString(idx[20]));         
						logger.dbg.println(this,"C_A_TM,              	rows[j].getString(idx[21])::"+rows[j].getString(idx[21]));         
						logger.dbg.println(this,"C_L_TM,					rows[j].getString(idx[22])::"+rows[j].getString(idx[22]));         
						logger.dbg.println(this,"C_E_TM,               	rows[j].getString(idx[23])::"+rows[j].getString(idx[23]));         
						logger.dbg.println(this,"M_H,             	rows[j].getString(idx[24])::"+rows[j].getDouble(idx[24]));                  
						logger.dbg.println(this,"A_H,            	rows[j].getString(idx[25])::"+rows[j].getDouble(idx[25]));
						logger.dbg.println(this,"O_H,					rows[j].getString(idx[26])::"+rows[j].getDouble(idx[26]));
						logger.dbg.println(this,"N_H,				rows[j].getString(idx[27])::"+rows[j].getDouble(idx[27]));		
						logger.dbg.println(this,"E_H,			rows[j].getString(idx[28])::"+rows[j].getDouble(idx[28]));     
						logger.dbg.println(this,"T_H,               	rows[j].getString(idx[29])::"+rows[j].getDouble(idx[29]));     
						logger.dbg.println(this,"G_H,					rows[j].getString(idx[30])::"+rows[j].getDouble(idx[30]));         
						logger.dbg.println(this,"I_EMPNO,            	rows[j].getString(idx[31])::"+rows[j].getString(idx[31]));         
						logger.dbg.println(this,"U_EMPNO,				rows[j].getString(idx[33])::"+rows[j].getString(idx[33])); 

*/

									  
								 
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); //로그남기는것						 					 				 
						gsmt.setGauceDataRow(rows[j]);
					 	
						gsmt.bindColumn(1, idx[1]);		//EMPNO
						gsmt.bindColumn(2, idx[2]); 		//
						gsmt.bindColumn(3, idx[3]);		//
						gsmt.bindColumn(4, idx[4]);		//
						gsmt.bindColumn(5, idx[5]);   	 	//
						gsmt.bindColumn(6, idx[6]);		//
						gsmt.bindColumn(7, idx[7]);		//						
						gsmt.bindColumn(8, idx[8]);		//
						gsmt.bindColumn(9, idx[9]);		//
						gsmt.bindColumn(10, idx[10]);  	//
						gsmt.bindColumn(11, idx[12]); 	//
						gsmt.bindColumn(12, idx[13]); 	//
						gsmt.bindColumn(13, idx[14]); 	//
						gsmt.bindColumn(14, idx[15]); 
						gsmt.bindColumn(15, idx[16]);
						gsmt.bindColumn(16, idx[17]); 
						gsmt.bindColumn(17, idx[18]); 	 //
						gsmt.bindColumn(18, idx[19]); 	//
						gsmt.bindColumn(19, idx[21]); 	//
						gsmt.bindColumn(20, idx[22]); 	//
						gsmt.bindColumn(21, idx[23]); 
						gsmt.bindColumn(22, idx[24]);
						gsmt.bindColumn(23, idx[25]); 
						gsmt.bindColumn(24, idx[26]); 	//
						gsmt.bindColumn(25, idx[27]); 
						gsmt.bindColumn(26, idx[28]);	//
						gsmt.bindColumn(27, idx[29]);
						gsmt.bindColumn(28, idx[30]); 
						gsmt.bindColumn(29, idx[31]); 	//
						gsmt.bindColumn(30, idx[33]); 
						gsmt.bindColumn(31, idx[34]); 

						gsmt.executeUpdate();				
						gsmt.close();


					}


						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/
/*            
         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
	
						StringBuffer UpdateSql = new StringBuffer();			

						 UpdateSql.append( " UPDATE SALES.TCM350			\n")
											.append( " SET                      \n")
											.append( " WORK_GB=?,               \n")
											.append( " W_TIME=?,                \n")
											.append( " W2_TIME=?,               \n")
											.append( " W_TIME_TOT=?,            \n")
											.append( " W_REMARK=?,              \n")
							        		.append( " O_TIME=?,                \n")
											.append( " O2_TIME=?,               \n")
											.append( " O_TIME_TOT=?,            \n")
											.append( " O_DTIME=?,               \n")
											.append( " O_NTIME=?,               \n")
							        		.append( " O_REMARK=?,              \n")
											.append( " REMARK=?,                \n")
											.append( " U_EMPNO=?,               \n")
											.append( " U_DATE=CURRENT TIMESTAMP, \n")
				              				.append( " O3_TIME=?,               \n")
				              				.append( " O4_TIME=?               \n")
											.append( " WHERE EMPNO=?						\n")
											.append( "   AND ATT_DT =?          \n");


						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						logger.dbg.println(this,UpdateSql.toString());//로그남기는것

						gsmt.setGauceDataRow(rows[j]);

						rows[j].setString(idx[22],strEmpno);
						
						gsmt.bindColumn(1,  idx[7]);	
						gsmt.bindColumn(2,  idx[8]);	
						gsmt.bindColumn(3,  idx[9]);	
						gsmt.bindColumn(4,  idx[10]);	
						gsmt.bindColumn(5,  idx[11]);	
						gsmt.bindColumn(6,  idx[12]);	
						gsmt.bindColumn(7,  idx[13]);	
						gsmt.bindColumn(8,  idx[14]);		
						gsmt.bindColumn(9,  idx[15]);	
						gsmt.bindColumn(10, idx[16]);	
						gsmt.bindColumn(11, idx[17]);	
						gsmt.bindColumn(12, idx[18]);	
						gsmt.bindColumn(13, idx[22]);
				    	gsmt.bindColumn(14, idx[24]);	
						gsmt.bindColumn(15, idx[25]);
						gsmt.bindColumn(16, idx[0]);	
						gsmt.bindColumn(17, idx[1]);	
						gsmt.executeUpdate();					
						gsmt.close();									

						//DLSDFDSF
					}
	*/				
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/
     /*     
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

						StringBuffer DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM SALES.TCM350		\n")
										 .append( "  WHERE EMPNO=?							\n")
							       .append( "	   AND ATT_DT=?							\n");
            	
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);

						gsmt.executeUpdate();
						gsmt.close();
			   	}
				*/
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
