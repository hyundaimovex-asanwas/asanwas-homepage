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
//import java.util.*;

public class KS_Em010_T1 extends HttpServlet{

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
				String str1 = reqGauce.getParameter("v_str1");
				String useid = reqGauce.getParameter("v_str2");

				String strEnd_dt=""; //계약만료일
				String strYyyymm=""; //입사년월
			
				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String[] strArrCN = new String[]{

					 "USESTS",
					 "EMPNMK",				
					 "EMPNO",
					 "SEX",					//4

					 "BIRTHDAY",
					 "RECOMMEND",								 
					 "START_DT",
					 "END_DT",			//8

					 "VEND_CD",						 
					 "DEPT_CD",
					 "JOB_CD",

					 "C_VEND_CD",
					 "SKILL_CD",									

					 "I_EMPNO",
					 "U_EMPNO",		//15


					 "ADDRESS",
					 "HEIGHT",
					 "WEIGHT",			
					 "BLOOD",			//19

					 "ATT_CD",
					 "SCH_NM",
					 "FAMILY",
					 "MARRIED",		//
					 "P_GB"		//
																			  }; 

				int[] idx = new int[24]; //컬럼갯수를 넣어준다.

    		    for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				StringBuffer InsertSql2 = null;
				StringBuffer UpdateSql2 = null;
				StringBuffer DeleteSql2 = null;

				StringBuffer InsertSql3 = null;

				for (int j = 0; j < rows.length; j++){
					
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/   

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {







            //사번생성 : 
						StringBuffer sql = new StringBuffer();
						Statement stmt= null;
						ResultSet rs = null;
						String strSeq = "0000";
						String strEmpno = "";

						sql.append( "SELECT nvl(MAX(SUBSTR(EMPNO,4,4)),0)+1 AS EMPNO				\n" )		//PK EMPNO
								.append( "FROM ATP.KST010													\n" )
								.append( "WHERE SUBSTR(EMPNO,1,2) ='"+str1+"'								\n" );

						//logger.dbg.println(this,sql.toString());

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while (rs.next())	{
							strSeq = rs.getString(1);
						}
						rs.close();
						stmt.close();

						int ichk = Integer.parseInt(strSeq);


						if (ichk<10) strEmpno =  str1 + "000" + ichk;
						else if (ichk<100 && ichk>9) strEmpno =   str1 + "00" + ichk;
						else if (ichk<1000 && ichk>99) strEmpno =   str1 + "0" + ichk;
						else if (ichk>999) strEmpno = ""+ str1 + ichk;

						//logger.dbg.println(this,strEmpno);


						//rows[j].setString(idx[0],strEmpno);//데이터셋 setString으로 가져오기
						rows[j].setString(idx[2],strEmpno);

						rows[j].setString(idx[13],useid);
						rows[j].setString(idx[14],useid);
						
						








						/*TABLE KST010---------------------------------------------------------------------------------------*/
					 InsertSql = new StringBuffer();
					 
					 InsertSql.append( " INSERT INTO ATP.KST010																\n" )
										 .append( " (USESTS,EMPNMK,EMPNO,SEX,   											\n" )	//4									 
										 .append( "BIRTHDAY,RECOMMEND,START_DT,END_DT,							\n" )	//8										 
										 .append( "VEND_CD,DEPT_CD,JOB_CD,													\n" )	//11										 
										 .append( "C_VEND_CD,SKILL_CD, CON_YEAR,	F_PAY,								\n" )	//13									 
										 .append( "I_DATE,U_DATE,I_EMPNO,U_EMPNO,										\n" )	//17										 
										 .append( "ADDRESS,HEIGHT,WEIGHT,BLOOD,										\n" )	//21								 
										 .append( "ATT_CD,SCH_NM,FAMILY,MARRIED, P_GB)								\n" )	//26								 								 								
										.append( " VALUES																				\n" )
										.append( " (?,?,?,?,																				\n" )//4
										.append( " ?,?,																					\n" )//6
										.append( " ?,?,?,																					\n" )//9
										.append( " ?,?,?,?,																				\n" )//13
										.append( " '1','0', sysdate,sysdate,?,?,													\n" )//
										.append( " ?,?,?,?,																				\n" )//
										.append( " ?,?,?,?,?)																			\n" );//

/*						
						logger.dbg.println(this,InsertSql.toString());
						
						logger.dbg.println(this,"USESTS,				rows[j].getString(idx[0])::"+rows[j].getString(idx[0]));         
						logger.dbg.println(this,"EMPNMK,				rows[j].getString(idx[1])::"+rows[j].getString(idx[1]));         	
						logger.dbg.println(this,"EMPNO,               	rows[j].getString(idx[2])::"+rows[j].getString(idx[2]));         
						logger.dbg.println(this,"SEX,						rows[j].getString(idx[3])::"+rows[j].getString(idx[3]));         
						logger.dbg.println(this,"BIRTHDAY,          	rows[j].getString(idx[4])::"+rows[j].getString(idx[4]));         
						logger.dbg.println(this,"RECOMMEND,		rows[j].getString(idx[5])::"+rows[j].getString(idx[5]));         
						logger.dbg.println(this,"START_DT,          	rows[j].getString(idx[6])::"+rows[j].getString(idx[6]));         
						logger.dbg.println(this,"END_DT,					rows[j].getString(idx[7])::"+rows[j].getString(idx[7]));         
						logger.dbg.println(this,"VEND_CD,    	rows[j].getString(idx[8])::"+rows[j].getString(idx[8]));                   
						logger.dbg.println(this,"DEPT_CD,    	rows[j].getString(idx[9])::"+rows[j].getString(idx[9]));     
						logger.dbg.println(this,"JOB_CD,      	rows[j].getString(idx[10])::"+rows[j].getString(idx[10]));         
						logger.dbg.println(this,"C_VEND_CD,	rows[j].getString(idx[11])::"+rows[j].getString(idx[11]));         
						logger.dbg.println(this,"SKILL_CD,    	rows[j].getString(idx[12])::"+rows[j].getString(idx[12]));      
						logger.dbg.println(this,"I_EMPNO,            	rows[j].getString(idx[13])::"+rows[j].getString(idx[13]));         
						logger.dbg.println(this,"U_EMPNO,				rows[j].getString(idx[14])::"+rows[j].getString(idx[14]));  						
						logger.dbg.println(this,"ADDRESS,           	rows[j].getString(idx[15])::"+rows[j].getString(idx[15]));         
						logger.dbg.println(this,"HEIGHT,              	rows[j].getString(idx[16])::"+rows[j].getInt(idx[16]));         
						logger.dbg.println(this,"WEIGHT,					rows[j].getString(idx[17])::"+rows[j].getInt(idx[17]));         
						logger.dbg.println(this,"BLOOD,               	rows[j].getString(idx[18])::"+rows[j].getString(idx[18]));         
						logger.dbg.println(this,"ATT_CD,             	rows[j].getString(idx[19])::"+rows[j].getString(idx[19]));                  
						logger.dbg.println(this,"SCH_NM,            	rows[j].getString(idx[20])::"+rows[j].getString(idx[20]));
						logger.dbg.println(this,"FAMILY,					rows[j].getString(idx[21])::"+rows[j].getInt(idx[21]));
						logger.dbg.println(this,"MARRIED,				rows[j].getString(idx[22])::"+rows[j].getString(idx[22]));		
						logger.dbg.println(this,"P_GB,						rows[j].getString(idx[23])::"+rows[j].getString(idx[23]));					
*/				

					/* 바인딩 시킬건 바인딩 안 시킬건 말고 */
		
							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idx[0]);		//USESTS				
							gsmt.bindColumn(2, idx[1]); 	//EMPNMK				
							gsmt.bindColumn(3, idx[2]);		//EMPNO				
							gsmt.bindColumn(4, idx[3]);		//SEX					
							gsmt.bindColumn(5, idx[4]);   	 //BIRTHDAY			
							gsmt.bindColumn(6, idx[5]);		//RECOMMEND		
							gsmt.bindColumn(7, idx[6]);		//START_DT			
							gsmt.bindColumn(8, idx[7]);		//END_DT				
							gsmt.bindColumn(9, idx[8]);		//VEND_CD			
							gsmt.bindColumn(10, idx[9]);  	//DEPT_CD			
							gsmt.bindColumn(11, idx[10]); 	//JOB_CD			
							gsmt.bindColumn(12, idx[11]); 	//C_VEND_CD	
							gsmt.bindColumn(13, idx[12]); 	//SKILL_CD		

							gsmt.bindColumn(14, idx[13]); 	//	I_EMPNO	
							gsmt.bindColumn(15, idx[14]);		//	U_EMPNO	

							gsmt.bindColumn(16, idx[15]); 	 //	ADDRESS		
							gsmt.bindColumn(17, idx[16]); 	//HEIGHT			
							gsmt.bindColumn(18, idx[17]); 	//WEIGHT			
							gsmt.bindColumn(19, idx[18]); 	//BLOOD			
							gsmt.bindColumn(20, idx[19]); 	//ATT_CD			
							gsmt.bindColumn(21, idx[20]); 	//SCH_NM		
							gsmt.bindColumn(22, idx[21]);		//FAMILY			
							gsmt.bindColumn(23, idx[22]); 	//MARRIED		
							gsmt.bindColumn(24, idx[23]);		//P_GB	
							
							gsmt.executeUpdate();
							gsmt.close();

						InsertSql2 = new StringBuffer();
						
						InsertSql2.append( "INSERT INTO ATP.KST015												\n" )
											.append( "(EMPNO, ORD_DT, SEQ, ORD_CD, VEND_CD,    		\n" )
											.append( "DEPT_CD,JOB_CD,												\n" )
											.append( "C_VEND_CD,					 										\n" )
											.append( "I_EMPNO, I_DATE, U_EMPNO,U_DATE)    					\n" )
											.append( "VALUES                                    							\n" )
											.append( "(?,?,'1','1',?,                             							\n" )
											.append( " ?,?,?,                              									\n" )
											.append( " ?,sysdate,?,sysdate) 											\n" );
											
											
						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						
						gsmt2.setGauceDataRow(rows[j]);

						gsmt2.bindColumn(1, idx[2]);		//EMPNO
						gsmt2.bindColumn(2, idx[6]);		//START_DT		
						gsmt2.bindColumn(3, idx[8]);		 //VEND_CD
						gsmt2.bindColumn(4, idx[9]);		 //DEPT_CD      
						gsmt2.bindColumn(5, idx[10]);	//JOB_CD       
						gsmt2.bindColumn(6, idx[11]);	//C_VEND_CD      
						gsmt2.bindColumn(7, idx[13]);	//I_EMPNO
						gsmt2.bindColumn(8, idx[14]);	//U_EMPNO
									
						gsmt2.executeUpdate();
						gsmt2.close();


					}

					/******************************************************************************
					* Update 처리
					*********************************************************************************/
					if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						UpdateSql = new StringBuffer();

						
													 UpdateSql.append( " UPDATE ATP.KST010				\n")
																	.append( " SET									\n")		
																	.append( " EMPNMK=?,							\n")		//1
																	.append( " SEX=?,								\n")		//2
																	.append( " BIRTHDAY=?,						\n")		//3
																	.append( " RECOMMEND=?,					\n")		//4											
																	.append( " START_DT=?,						\n")		//5
																	.append( " END_DT=?,							\n")		//6
																	.append( " VEND_CD=?,							\n")		//7
																	.append( " DEPT_CD=?,						\n")		//8
																	.append( " JOB_CD=?,							\n")		//9
																	.append( " C_VEND_CD=?,						\n")		//10
																	.append( " SKILL_CD=?,						\n")		//11
																	.append( " U_DATE=sysdate,					\n")	
																	.append( " U_EMPNO=?,						\n")		//12	 
																	.append( " ADDRESS=?,						\n")		//13									
																	.append( " HEIGHT=?,							\n")		//14
																	.append( " WEIGHT=?,							\n")		//15
																	.append( " BLOOD=?,							\n")		//16									
																	.append( " ATT_CD=?,							\n")		//17
																	.append( " SCH_NM=?,							\n")		//18
																	.append( " FAMILY=?,							\n")		//19
																	.append( " MARRIED=?,							\n")		//20
																	.append( " P_GB=?								\n")		//21																
																	.append( " WHERE EMPNO=?					\n");		//22

/*						
						logger.dbg.println(this,InsertSql.toString());
						       
						logger.dbg.println(this,"EMPNMK,				rows[j].getString(idx[1])::"+rows[j].getString(idx[1]));         	     
						logger.dbg.println(this,"SEX,					rows[j].getString(idx[3])::"+rows[j].getString(idx[3]));         
						logger.dbg.println(this,"BIRTHDAY,          	rows[j].getString(idx[4])::"+rows[j].getString(idx[4]));         
						logger.dbg.println(this,"RECOMMEND,		rows[j].getString(idx[5])::"+rows[j].getString(idx[5]));         
						logger.dbg.println(this,"START_DT,          	rows[j].getString(idx[6])::"+rows[j].getString(idx[6]));         
						logger.dbg.println(this,"END_DT,				rows[j].getString(idx[7])::"+rows[j].getString(idx[7]));         
						logger.dbg.println(this,"VEND_CD,    		rows[j].getString(idx[8])::"+rows[j].getString(idx[8]));                   
						logger.dbg.println(this,"DEPT_CD,    		rows[j].getString(idx[9])::"+rows[j].getString(idx[9]));     
						logger.dbg.println(this,"JOB_CD,      		rows[j].getString(idx[10])::"+rows[j].getString(idx[10]));         
						logger.dbg.println(this,"C_VEND_CD,	r		ows[j].getString(idx[11])::"+rows[j].getString(idx[11]));         
						logger.dbg.println(this,"SKILL_CD,    		rows[j].getString(idx[12])::"+rows[j].getString(idx[12]));      
						logger.dbg.println(this,"I_EMPNO,            	rows[j].getString(idx[13])::"+rows[j].getString(idx[13]));         
						logger.dbg.println(this,"U_EMPNO,			rows[j].getString(idx[14])::"+rows[j].getString(idx[14]));  						
						logger.dbg.println(this,"ADDRESS,           	rows[j].getString(idx[15])::"+rows[j].getString(idx[15]));         
						logger.dbg.println(this,"HEIGHT,              	rows[j].getString(idx[16])::"+rows[j].getInt(idx[16]));         
						logger.dbg.println(this,"WEIGHT,				rows[j].getString(idx[17])::"+rows[j].getInt(idx[17]));         
						logger.dbg.println(this,"BLOOD,               rows[j].getString(idx[18])::"+rows[j].getString(idx[18]));         
						logger.dbg.println(this,"ATT_CD,             	rows[j].getString(idx[19])::"+rows[j].getString(idx[19]));                  
						logger.dbg.println(this,"SCH_NM,            	rows[j].getString(idx[20])::"+rows[j].getString(idx[20]));
						logger.dbg.println(this,"FAMILY,				rows[j].getString(idx[21])::"+rows[j].getInt(idx[21]));
						logger.dbg.println(this,"MARRIED,				rows[j].getString(idx[22])::"+rows[j].getString(idx[22]));		
						logger.dbg.println(this,"P_GB,					rows[j].getString(idx[23])::"+rows[j].getString(idx[23]));					
*/				
											
																	GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
																	gsmt.setGauceDataRow(rows[j]);
											
												
																	gsmt.bindColumn(1, idx[1]);			//EMPNMK       
																	gsmt.bindColumn(2, idx[3]); 		//SEX              
																	gsmt.bindColumn(3, idx[4]);			//BIRTHDAY     
																	gsmt.bindColumn(4, idx[5]);			//RECOMMEND
																	gsmt.bindColumn(5, idx[6]);   		//START_DT     
																	gsmt.bindColumn(6, idx[7]);			//END_DT        
																	gsmt.bindColumn(7, idx[8]);			//VEND_CD      
																	gsmt.bindColumn(8, idx[9]);			//DEPT_CD      
																	gsmt.bindColumn(9, idx[10]);			//JOB_CD        
																	gsmt.bindColumn(10, idx[11]);  	//C_VEND_CD 
																	gsmt.bindColumn(11, idx[12]); 	//SKILL_CD      
																	gsmt.bindColumn(12, idx[14]); 	//U_EMPNO

																	gsmt.bindColumn(13, idx[15]);		//ADDRESS
																	gsmt.bindColumn(14, idx[16]);		//HEIGHT	 
																	gsmt.bindColumn(15, idx[17]); 	 //WEIGHT 
																	gsmt.bindColumn(16, idx[18]); 	//BLOOD		 
																	gsmt.bindColumn(17, idx[19]); 	//ATT_CD		 
																	gsmt.bindColumn(18, idx[20]); 	//SCH_NM		    
																	gsmt.bindColumn(19, idx[21]); 	//FAMILY		    
																	gsmt.bindColumn(20, idx[22]);		//MARRIED	    
																	gsmt.bindColumn(21, idx[23]);		//P_GB		    
																	gsmt.bindColumn(22, idx[2]); 		//EMPNO	    
																				
																	gsmt.executeUpdate();
																	gsmt.close();



					}
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/

					/*TABLE KST010---------------------------------------------------------------------------------------*/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

						  	DeleteSql = new StringBuffer();
							DeleteSql.append( " DELETE  FROM ATP.KST010		\n")
											 .append( "	 WHERE  EMPNO=?								\n");
							
							GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
							gsmt.setGauceDataRow(rows[j]);
	  						gsmt.bindColumn(1, idx[0]);

							gsmt.executeUpdate();
							gsmt.close();

							//발령은 삭제하지 않음.

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





















