//**참고사항. delete,update할떼는 where절 이후에 primary key 컬럼을 꼭 추가해서 써준다***

package sales.menu.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class KS_Em010_T1 extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

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
					 "WORK_CD",	//12

					 "C_VEND_CD",
					 "SKILL_CD",									
					 "CLASS_CD",
					 "CON_YEAR",		//16

					 "I_DATE",
					 "U_DATE",
					 "I_EMPNO",
					 "U_EMPNO",		//20


					 "ADDRESS",
					 "HEIGHT",
					 "WEIGHT",			
					 "BLOOD",			//24

					 "ATT_CD",
					 "SCH_NM",
					 "FAMILY",
					 "MARRIED"			//28
																			  }; 

				int[] idx = new int[28]; //컬럼갯수를 넣어준다.

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

						sql.append( "SELECT IFNULL(MAX(SUBSTR(EMPNO,4,4)),0)+1 AS EMPNO	\n" )		//PK EMPNO
								.append( "FROM SALES.KST010															\n" )
								.append( "WHERE SUBSTR(EMPNO,2,2) ='"+str1+"'								\n" );

						logger.dbg.println(this,sql.toString());

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while (rs.next())	{
							strSeq = rs.getString(1);
						}
						rs.close();
						stmt.close();

						int ichk = Integer.parseInt(strSeq);


						if (ichk<10) strEmpno = "8"+ str1 + "000" + ichk;
						else if (ichk<100 && ichk>9) strEmpno = "8"+  str1 + "00" + ichk;
						else if (ichk<1000 && ichk>99) strEmpno = "8"+  str1 + "0" + ichk;
						else if (ichk>999) strEmpno ="8"+ ""+ str1 + ichk;

						logger.dbg.println(this,strEmpno);


//						rows[j].setString(idx[0],strEmpno);//데이터셋 setString으로 가져오기
						rows[j].setString(idx[2],strEmpno);
						rows[j].setString(idx[18],useid);
						rows[j].setString(idx[19],useid);
						
						
						/*TABLE KST010---------------------------------------------------------------------------------------*/
					 InsertSql = new StringBuffer();
					 

					 
					 InsertSql.append( " INSERT INTO SALES.KST010													\n" )
										 .append( " (USESTS,EMPNMK,EMPNO,SEX,   									\n" )	//4									 
										 .append( "BIRTHDAY,RECOMMEND,START_DT,END_DT,						\n" )	//8										 
										 .append( "VEND_CD,DEPT_CD,JOB_CD,WORK_CD,							\n" )	//12										 
										 .append( "C_VEND_CD,SKILL_CD,CLASS_CD,CON_YEAR,					\n" )	//16									 
										 .append( "I_DATE,U_DATE,I_EMPNO,U_EMPNO,									\n" )	//20										 
										 .append( "ADDRESS,HEIGHT,WEIGHT,BLOOD,									\n" )	//24								 
										 .append( "ATT_CD,SCH_NM,FAMILY,MARRIED)									\n" )	//28								 								 								
										.append( " VALUES																				\n" )
										.append( " (?,?,?,?,																				\n" )//4
										.append( " ?,?,?,?,																				\n" )//8
										.append( " ?,?,?,?,																				\n" )//12
										.append( " ?,?,?,?,																				\n" )//16
										.append( " CURRENT TIMESTAMP,CURRENT TIMESTAMP,?,?,				\n" )//20
										.append( " ?,?,?,?,																				\n" )//24
										.append( " ?,?,?,?)																				\n" );//28
							
						//logger.dbg.println(this,InsertSql.toString());
						
/*						
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
						logger.dbg.println(this,"WORK_CD,  	rows[j].getString(idx[11])::"+rows[j].getString(idx[11]));         
						logger.dbg.println(this,"C_VEND_CD,	rows[j].getString(idx[12])::"+rows[j].getString(idx[12]));         
						logger.dbg.println(this,"SKILL_CD,    	rows[j].getString(idx[13])::"+rows[j].getString(idx[13]));      
						logger.dbg.println(this,"CLASS_CD,		rows[j].getString(idx[14])::"+rows[j].getString(idx[14]));	    
						logger.dbg.println(this,"CON_YEAR,			rows[j].getString(idx[15])::"+rows[j].getInt(idx[15]));     

						logger.dbg.println(this,"I_DATE,               	rows[j].getString(idx[16])::"+rows[j].getString(idx[16]));     
						logger.dbg.println(this,"U_DATE,					rows[j].getString(idx[17])::"+rows[j].getString(idx[17]));         

						logger.dbg.println(this,"I_EMPNO,            	rows[j].getString(idx[18])::"+rows[j].getString(idx[18]));         
						logger.dbg.println(this,"U_EMPNO,				rows[j].getString(idx[19])::"+rows[j].getString(idx[19]));         
						logger.dbg.println(this,"ADDRESS,           	rows[j].getString(idx[20])::"+rows[j].getString(idx[20]));         
						logger.dbg.println(this,"HEIGHT,              	rows[j].getString(idx[21])::"+rows[j].getInt(idx[21]));         
						logger.dbg.println(this,"WEIGHT,					rows[j].getString(idx[22])::"+rows[j].getInt(idx[22]));         
						logger.dbg.println(this,"BLOOD,               	rows[j].getString(idx[23])::"+rows[j].getString(idx[23]));         
						logger.dbg.println(this,"ATT_CD,             	rows[j].getString(idx[24])::"+rows[j].getString(idx[24]));                  
						logger.dbg.println(this,"SCH_NM,            	rows[j].getString(idx[25])::"+rows[j].getString(idx[25]));
						logger.dbg.println(this,"FAMILY,					rows[j].getString(idx[26])::"+rows[j].getInt(idx[26]));
						logger.dbg.println(this,"MARRIED,				rows[j].getString(idx[27])::"+rows[j].getString(idx[27]));		*/
						
					
/*
						InsertSql.append( " INSERT INTO SALES.KST010													\n" )
														.append( " (USESTS,EMPNMK,EMPNO,SEX,   									\n" )	//4									 
														.append( "BIRTHDAY,RECOMMEND,START_DT,END_DT,						\n" )	//8										 
														.append( "VEND_CD,DEPT_CD,JOB_CD,WORK_CD,							\n" )	//12										 
														.append( "C_VEND_CD,SKILL_CD,CLASS_CD,CON_YEAR,					\n" )	//16									 
														.append( "I_DATE,U_DATE,I_EMPNO,U_EMPNO,									\n" )	//20										 
														.append( "ADDRESS,HEIGHT,WEIGHT,BLOOD,									\n" )	//24								 
														.append( "ATT_CD,SCH_NM,FAMILY,MARRIED)									\n" )	//28								 								 								
													   .append( " VALUES																				\n" )
													   .append( " ('"+rows[j].getString(idx[0])+"','"+rows[j].getString(idx[1])+"','"+rows[j].getString(idx[2])+"','"+rows[j].getString(idx[3])+"',\n" )										
													   .append( " '"+rows[j].getString(idx[4])+"','"+rows[j].getString(idx[5])+"','"+rows[j].getString(idx[6])+"','"+rows[j].getString(idx[7])+"',	\n" )																				
													   .append( " '"+rows[j].getString(idx[8])+"','"+rows[j].getString(idx[9])+"','"+rows[j].getString(idx[10])+"','"+rows[j].getString(idx[11])+"',														\n" )						
													   .append( " '"+rows[j].getString(idx[12])+"','"+rows[j].getString(idx[13])+"','"+rows[j].getString(idx[14])+"','"+rows[j].getString(idx[15])+"',		\n" )																		
													   .append( " CURRENT TIMESTAMP,CURRENT TIMESTAMP,'"+rows[j].getString(idx[18])+"','"+rows[j].getString(idx[19])+"',				\n" )
													   .append( " '"+rows[j].getString(idx[20])+"','"+rows[j].getString(idx[21])+"','"+rows[j].getString(idx[22])+"','"+rows[j].getString(idx[23])+"',						\n" )														
													   .append( " '"+rows[j].getString(idx[24])+"','"+rows[j].getString(idx[25])+"','"+rows[j].getString(idx[26])+"','"+rows[j].getString(idx[27])+"')		 \n" );
								   
*/


					/* 바인딩 시킬건 바인딩 안 시킬건 말고 */
		
							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idx[0]);		//USESTS
							gsmt.bindColumn(2, idx[1]); 		//EMPNMK
							gsmt.bindColumn(3, idx[2]);		//EMPNO
							gsmt.bindColumn(4, idx[3]);		//SEX
							gsmt.bindColumn(5, idx[4]);   	 	//BIRTHDAY
							gsmt.bindColumn(6, idx[5]);		//RECOMMEND
							gsmt.bindColumn(7, idx[6]);		//START_DT
							gsmt.bindColumn(8, idx[7]);		//
							gsmt.bindColumn(9, idx[8]);		//
							gsmt.bindColumn(10, idx[9]);  	//
							gsmt.bindColumn(11, idx[10]); 	//
							gsmt.bindColumn(12, idx[11]); 	//
							gsmt.bindColumn(13, idx[12]); 	//
							gsmt.bindColumn(14, idx[13]); 
							gsmt.bindColumn(15, idx[14]);
							gsmt.bindColumn(16, idx[15]); 
							gsmt.bindColumn(17, idx[18]); 	 //
							gsmt.bindColumn(18, idx[19]); 	//
							gsmt.bindColumn(19, idx[20]); 	//
							gsmt.bindColumn(20, idx[21]); 	//
							gsmt.bindColumn(21, idx[22]); 
							gsmt.bindColumn(22, idx[23]);
							gsmt.bindColumn(23, idx[24]); 
							gsmt.bindColumn(24, idx[25]); 	//
							gsmt.bindColumn(25, idx[26]); 
							gsmt.bindColumn(26, idx[27]);	//MARRIED

							gsmt.executeUpdate();
							gsmt.close();

							/*TABLE TCM345(계약관리)---------------------------------------------------------------------------------------*/
							//계약관리의 만기일자 생성
							
							
			//			StringBuffer DeleteSql1_1 = null;
						
			//			logger.dbg.println(this,"insert222");
			           /*
							
						DeleteSql1_1 = new StringBuffer();
						DeleteSql1_1.append( " DELETE  FROM SALES.TCM345		\n")
											          .append( "	 WHERE  EMPNO=?								\n");
						GauceStatement gsmt1_1 = conn.getGauceStatement(DeleteSql1_1.toString());
						gsmt1_1.setGauceDataRow(rows[j]);
						gsmt1_1.bindColumn(1, idx[0]);

						gsmt1_1.executeUpdate();
						gsmt1_1.close();
	
							
							StringBuffer sql_1 = new StringBuffer();
							Statement stmt_1= null;
							ResultSet rs_1 = null;
							
							sql_1.append( " SELECT REPLACE(CHAR((CAST(SUBSTR(START_DT,1,4)||'-'||SUBSTR(START_DT,5,2)||'-'||SUBSTR(START_DT,7,2)AS DATE) + 1 YEAR) - 1 DAY ,ISO),'-','')	\n" )
								  	  .append( "   FROM SALES.KST010														\n" )
								  	  .append( "  WHERE EMPNO ='"+rows[j].getString(idx[0])+"'	\n" );
							stmt_1 = conn.createStatement();
							rs_1 = stmt_1.executeQuery(sql_1.toString());

							while (rs_1.next())	{
								strEnd_dt = rs_1.getString(1);  //입사일(계약시작일 + 1년 -1일로 자동 생성함)
							}
							rs_1.close();
							stmt_1.close();

							rows[j].setString(idx[0],strEmpno);
							rows[j].setString(idx[16],useid);
							rows[j].setString(idx[17],useid);
							
							logger.dbg.println(this,"insert333");

							InsertSql2 = new StringBuffer();
							InsertSql2.append( "INSERT INTO SALES.TCM345									\n" )
												.append( "(EMPNO, SEQ, CUST_SID, JOB_CD,VEND_CD,    \n" )
												.append( "DEPT_CD,TEAM_CD,WORK_CD,START_DT,I_EMPNO, \n" )
												.append( "U_EMPNO,CONT_GB,I_DATE,U_DATE, END_DT, CON_YEAR, CLOSE_YN)    \n" )
												.append( "VALUES                                    \n" )
												.append( "(?,'1',?,?,?,                             \n" )
												.append( " ?,?,?,?,?,                               \n" )
												.append( " ?,'001',CURRENT TIMESTAMP,CURRENT TIMESTAMP,'"+strEnd_dt+"',1,'') \n" );
							GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
							gsmt2.setGauceDataRow(rows[j]);

							gsmt2.bindColumn(1, idx[0]);
							gsmt2.bindColumn(2, idx[15]);
							gsmt2.bindColumn(3, idx[5]);
							gsmt2.bindColumn(4, idx[7]);
							gsmt2.bindColumn(5, idx[8]);
							gsmt2.bindColumn(6, idx[9]);
							gsmt2.bindColumn(7, idx[10]);
							gsmt2.bindColumn(8, idx[4]);
							gsmt2.bindColumn(9, idx[16]);
							gsmt2.bindColumn(10, idx[17]);
							gsmt2.executeUpdate();
							gsmt2.close();
							strEnd_dt="";
							*/

							/*TABLE TCM305(사내경력)---------------------------------------------------------------------------------------*/
							//입사일이 발령일자이다.

						/*
							
						StringBuffer DeleteSql3_1 = null;
							
						DeleteSql3_1 = new StringBuffer();
						DeleteSql3_1.append( " DELETE  FROM SALES.TCM305		\n")
																.append( "	 WHERE  EMPNO=?								\n");
						GauceStatement gsmt3_1 = conn.getGauceStatement(DeleteSql3_1.toString());
						gsmt3_1.setGauceDataRow(rows[j]);
						gsmt3_1.bindColumn(1, idx[0]);

						gsmt3_1.executeUpdate();
						gsmt3_1.close();
							
							
						logger.dbg.println(this,"insert555");
							
							InsertSql3 = new StringBuffer();
							InsertSql3.append( "INSERT INTO SALES.TCM305									  \n" )
												.append( "( EMPNO, ORD_DT, SEQ, CUST_SID, ORD_CD,     \n" )
												.append( "  VEND_CD, DEPT_CD, TEAM_CD, WORK_CD,JOB_CD,\n" )
												.append( "  SKILL_CD, I_EMPNO, U_EMPNO, I_DATE,U_DATE \n" )
												.append( " )    \n" )
												.append( "VALUES                                      \n" )
												.append( "(?,?,1,?,?,                                \n" )
												.append( " ?,?,?,?,?,                                 \n" )
												.append( " ?,?,?,CURRENT TIMESTAMP,CURRENT TIMESTAMP) \n" );
						 
							GauceStatement gsmt3 = conn.getGauceStatement(InsertSql3.toString());
							gsmt3.setGauceDataRow(rows[j]);

							gsmt3.bindColumn(1, idx[0]);
							gsmt3.bindColumn(2, idx[4]);
							gsmt3.bindColumn(3, idx[15]);
							gsmt3.bindColumn(4, idx[34]);
							gsmt3.bindColumn(5, idx[7]);
							gsmt3.bindColumn(6, idx[8]);
							gsmt3.bindColumn(7, idx[9]);
							gsmt3.bindColumn(8, idx[10]);
							gsmt3.bindColumn(9, idx[5]);
							gsmt3.bindColumn(10, idx[11]);
							gsmt3.bindColumn(11, idx[16]);
							gsmt3.bindColumn(12, idx[17]);
							
							gsmt3.executeUpdate();
							gsmt3.close();
							
							*/

					}

					/******************************************************************************
					* Update 처리
					*********************************************************************************/
					if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						UpdateSql = new StringBuffer();

						
						
																	UpdateSql.append( " UPDATE SALES.KST010	\n")
																	.append( " SET									\n")		
																	.append( " USESTS=?,							\n")		//1
																	.append( " EMPNMK=?,						\n")		//2
																	.append( " SEX=?,								\n")		//3
																	.append( " BIRTHDAY=?,						\n")		//4
																	.append( " RECOMMEND=?,					\n")		//5											
																	.append( " START_DT=?,						\n")		//6
																	.append( " END_DT=?,							\n")		//7
																	.append( " VEND_CD=?,						\n")		//8
																	.append( " DEPT_CD=?,						\n")		//9
																	.append( " JOB_CD=?,							\n")		//10
																	.append( " WORK_CD=?,						\n")		//11
																	.append( " C_VEND_CD=?,					\n")		//12
																	.append( " SKILL_CD=?,						\n")		//13
																	.append( " CLASS_CD=?,						\n")		//14
																	.append( " CON_YEAR=?,						\n")		//15
																	.append( " U_DATE=CURRENT TIMESTAMP,	\n")	
																	.append( " U_EMPNO=?,						\n")		//16	 
																	.append( " ADDRESS=?,						\n")		//17									
																	.append( " HEIGHT=?,							\n")		//18
																	.append( " WEIGHT=?,							\n")		//19
																	.append( " BLOOD=?,							\n")		//20									
																	.append( " ATT_CD=?,							\n")		//21
																	.append( " SCH_NM=?,						\n")		//22
																	.append( " FAMILY=?,							\n")		//23
																	.append( " MARRIED=?							\n")		//24									
																	.append( " WHERE EMPNO=?				\n");		//25

																	logger.dbg.println(this,"UpdateSql.toString()::" + UpdateSql.toString());


						
						logger.dbg.println(this,"USESTS,				rows[j].getString(idx[0])::"+rows[j].getString(idx[0]));         
						logger.dbg.println(this,"EMPNMK,				rows[j].getString(idx[1])::"+rows[j].getString(idx[1]));         	
						logger.dbg.println(this,"EMPNO,               	rows[j].getString(idx[2])::"+rows[j].getString(idx[2]));         
						logger.dbg.println(this,"SEX,						rows[j].getString(idx[3])::"+rows[j].getString(idx[3]));         
						logger.dbg.println(this,"BIRTHDAY,          	rows[j].getString(idx[4])::"+rows[j].getString(idx[4]));         
						logger.dbg.println(this,"RECOMMEND,		rows[j].getString(idx[5])::"+rows[j].getString(idx[5]));         
						logger.dbg.println(this,"START_DT,          	rows[j].getString(idx[6])::"+rows[j].getString(idx[6]));         
						logger.dbg.println(this,"END_DT,					rows[j].getString(idx[7])::"+rows[j].getString(idx[7]));         
						logger.dbg.println(this,"VEND_CD,    			rows[j].getString(idx[8])::"+rows[j].getString(idx[8]));                   
						logger.dbg.println(this,"DEPT_CD,    			rows[j].getString(idx[9])::"+rows[j].getString(idx[9]));     
						logger.dbg.println(this,"JOB_CD,      			rows[j].getString(idx[10])::"+rows[j].getString(idx[10]));         
						logger.dbg.println(this,"WORK_CD,  			rows[j].getString(idx[11])::"+rows[j].getString(idx[11]));         
						logger.dbg.println(this,"C_VEND_CD,			rows[j].getString(idx[12])::"+rows[j].getString(idx[12]));         
						logger.dbg.println(this,"SKILL_CD,    			rows[j].getString(idx[13])::"+rows[j].getString(idx[13]));      
						logger.dbg.println(this,"CLASS_CD,				rows[j].getString(idx[14])::"+rows[j].getString(idx[14]));	    
						logger.dbg.println(this,"CON_YEAR,			rows[j].getString(idx[15])::"+rows[j].getInt(idx[15]));     

						logger.dbg.println(this,"I_DATE,               	rows[j].getString(idx[16])::"+rows[j].getString(idx[16]));     
						logger.dbg.println(this,"U_DATE,					rows[j].getString(idx[17])::"+rows[j].getString(idx[17]));         

						logger.dbg.println(this,"I_EMPNO,            	rows[j].getString(idx[18])::"+rows[j].getString(idx[18]));         
						logger.dbg.println(this,"U_EMPNO,				rows[j].getString(idx[19])::"+rows[j].getString(idx[19]));         
						logger.dbg.println(this,"ADDRESS,           	rows[j].getString(idx[20])::"+rows[j].getString(idx[20]));         
						logger.dbg.println(this,"HEIGHT,              	rows[j].getString(idx[21])::"+rows[j].getInt(idx[21]));         
						logger.dbg.println(this,"WEIGHT,					rows[j].getString(idx[22])::"+rows[j].getInt(idx[22]));         
						logger.dbg.println(this,"BLOOD,               	rows[j].getString(idx[23])::"+rows[j].getString(idx[23]));         
						logger.dbg.println(this,"ATT_CD,             	rows[j].getString(idx[24])::"+rows[j].getString(idx[24]));                  
						logger.dbg.println(this,"SCH_NM,            	rows[j].getString(idx[25])::"+rows[j].getString(idx[25]));
						logger.dbg.println(this,"FAMILY,					rows[j].getString(idx[26])::"+rows[j].getInt(idx[26]));
						logger.dbg.println(this,"MARRIED,				rows[j].getString(idx[27])::"+rows[j].getString(idx[27]));	

											
																	GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
																	gsmt.setGauceDataRow(rows[j]);
											
												
																	gsmt.bindColumn(1, idx[0]);		//USESTS
																	gsmt.bindColumn(2, idx[1]); 		//EMPNMK
																	gsmt.bindColumn(3, idx[3]);		//SEX
																	gsmt.bindColumn(4, idx[4]);		//BIRTHDAY
																	gsmt.bindColumn(5, idx[5]);   	 	//RECOMMEND
																	gsmt.bindColumn(6, idx[6]);		//START_DT
																	gsmt.bindColumn(7, idx[7]);		//END_DT
																	gsmt.bindColumn(8, idx[8]);		//VEND_CD
																	gsmt.bindColumn(9, idx[9]);		//DEPT_CD
																	gsmt.bindColumn(10, idx[10]);  	//JOB_CD
																	gsmt.bindColumn(11, idx[11]); 	//WORK_CD
																	gsmt.bindColumn(12, idx[12]); 	//C_VEND_CD
																	gsmt.bindColumn(13, idx[13]); 	//SKILL_CD
																	gsmt.bindColumn(14, idx[14]); 	//CLASS_CD
																	gsmt.bindColumn(15, idx[15]);	//CON_YEAR
																	gsmt.bindColumn(16, idx[19]); 
																	gsmt.bindColumn(17, idx[20]); 	 //
																	gsmt.bindColumn(18, idx[21]); 	//
																	gsmt.bindColumn(19, idx[22]); 	//
																	gsmt.bindColumn(20, idx[23]); 	//
																	gsmt.bindColumn(21, idx[24]); 
																	gsmt.bindColumn(22, idx[25]);
																	gsmt.bindColumn(23, idx[26]); 
																	gsmt.bindColumn(24, idx[27]); 	
																	gsmt.bindColumn(25, idx[2]); 
																								
																	gsmt.executeUpdate();
																	gsmt.close();



					}
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/

          /*TABLE KST010---------------------------------------------------------------------------------------*/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

						  	DeleteSql = new StringBuffer();
							DeleteSql.append( " DELETE  FROM SALES.KST010		\n")
											 .append( "	 WHERE  EMPNO=?								\n");
							
							GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
							gsmt.setGauceDataRow(rows[j]);
	  						gsmt.bindColumn(1, idx[0]);

							gsmt.executeUpdate();
							gsmt.close();

							//계약과 발령은 삭제하지 않음.

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





















