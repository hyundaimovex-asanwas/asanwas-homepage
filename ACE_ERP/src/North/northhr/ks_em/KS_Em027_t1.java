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

public class KS_Em027_t1 extends HttpServlet{

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
				String strEmpno = reqGauce.getParameter("v_str1");
			  	//String strYYYY="9999"; //의미없는 필드라서 9999를 넣는다.

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
		
						StringBuffer InsertSql = new StringBuffer();
									
						InsertSql.append( " INSERT INTO NORTHHR.KST160								\n" )
										 .append( " ( HOL_DT, EMPNO,   DAY_CD, 								\n" )         //5
										 .append( "   DEPT_CD, HOL_GB,  											\n" ) 		//9
										 .append( "   I_EMPNO,  I_DATE,	 U_EMPNO,	U_DATE )		\n" )
										 .append( "  VALUES																\n" )
										 .append( " ( ?,?,?,?,?,															\n" )
										 .append( "   ?,CURRENT TIMESTAMP,?,CURRENT TIMESTAMP)      \n" );
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); //로그남기는것
						
						gsmt.setGauceDataRow(rows[j]);						


						logger.dbg.println(this,InsertSql.toString());//로그남기는것
						logger.dbg.println(this,"HOL_DT,					rows[j].getString(idx[0])::"+rows[j].getString(idx[0]));         
						logger.dbg.println(this,"EMPNO,					rows[j].getString(idx[1])::"+rows[j].getString(idx[1]));         	
						logger.dbg.println(this,"DAY_CD,               	rows[j].getString(idx[2])::"+rows[j].getString(idx[2]));         
						logger.dbg.println(this,"DEPT_CD,				rows[j].getString(idx[3])::"+rows[j].getString(idx[3]));         
						logger.dbg.println(this,"HOL_GB,          		rows[j].getString(idx[4])::"+rows[j].getString(idx[4]));         
						logger.dbg.println(this,"I_EMPNO,				rows[j].getString(idx[5])::"+rows[j].getString(idx[5]));         
						logger.dbg.println(this,"U_EMPNO,          	rows[j].getString(idx[7])::"+rows[j].getString(idx[7]));         

										
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);
						gsmt.bindColumn(4, idx[3]);
						gsmt.bindColumn(5, idx[4]);
						gsmt.bindColumn(6, idx[5]);		//EMPNO 넣는것
						gsmt.bindColumn(7, idx[7]);
					
						gsmt.executeUpdate();						
						gsmt.close();							

						
						//출역일보 테이블에 휴가로 박아놓는다...
						StringBuffer InsertSql2 = new StringBuffer();					
					  				            
						InsertSql2.append( " INSERT INTO NORTHHR.KST100									\n" )
										 .append( "(ATT_DT,  EMPNO,   DEPT_CD,                                   \n" )													
										 .append( "SAYU_GB,																\n" ) 					
										 .append( "I_EMPNO,    I_DATE,       U_EMPNO,   U_DATE)          \n" )		
						
										 .append( " VALUES																	\n" )
										 .append( " (?,?,?,?,																	\n" )							
										 .append( " ?,CURRENT TIMESTAMP,?,CURRENT TIMESTAMP)		\n" );

														  
						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());


						logger.dbg.println(this,InsertSql2.toString());//로그남기는것
						logger.dbg.println(this,"HOL_DT,					rows[j].getString(idx[0])::"+rows[j].getString(idx[0]));         
						logger.dbg.println(this,"EMPNO,					rows[j].getString(idx[1])::"+rows[j].getString(idx[1]));         	     
						logger.dbg.println(this,"DEPT_CD,				rows[j].getString(idx[3])::"+rows[j].getString(idx[3]));         
						logger.dbg.println(this,"HOL_GB,          		rows[j].getString(idx[4])::"+rows[j].getString(idx[4]));         
						logger.dbg.println(this,"I_EMPNO,				rows[j].getString(idx[5])::"+rows[j].getString(idx[5]));         
   						


						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.bindColumn(1, idx[0]);		//ATT_DT
						gsmt2.bindColumn(2, idx[1]); 		//EMPNO
						gsmt2.bindColumn(3, idx[3]);		//DEPT_CD
						gsmt2.bindColumn(4, idx[4]);		//SAYU_GB
						gsmt2.bindColumn(5, idx[5]);   	//EMPNO 	
						gsmt2.bindColumn(6, idx[7]);
						
						gsmt2.executeUpdate();					
						gsmt2.close();			

					}




						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/
            
         	 if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						StringBuffer UpdateSql = new StringBuffer();		
						 
						 rows[j].setString(idx[20],strEmpno);
						 //rows[j].setString(idx[1],strYYYY);
						 
					 /*
				logger.dbg.println(this," SEQ2::"+rows[j].getInt(idx[13]));
						 
             
						 UpdateSql.append( " UPDATE NORTHHR.TCM355	    \n");
			    	logger.dbg.println(this,"1");
				UpdateSql.append( " SET                      \n");
											UpdateSql.append( " VEND_CD="+rows[j].getInt(idx[4])+",           \n");
				logger.dbg.println(this,"2");
							        UpdateSql.append( " DEPT_CD='"+rows[j].getString(idx[5])+"',    \n");
				logger.dbg.println(this,"3");
                      UpdateSql.append( " TEAM_CD='"+rows[j].getString(idx[6])+"',    \n");
				logger.dbg.println(this,"4");
							        UpdateSql.append( " WORK_CD='"+rows[j].getString(idx[7])+"',   \n");
				logger.dbg.println(this,"5");
							        UpdateSql.append( " START_DT='"+rows[j].getString(idx[8])+"',   \n");
				logger.dbg.println(this,"6");
							        UpdateSql.append( " END_DT='"+rows[j].getString(idx[9])+"',       \n");
				logger.dbg.println(this,"7");
  						        UpdateSql.append( " H_DAY="+rows[j].getInt(idx[10])+",            \n") ;
				logger.dbg.println(this,"8");
 						          UpdateSql.append( " H_RES='"+rows[j].getString(idx[11])+"',     \n");
				logger.dbg.println(this,"9");
							        UpdateSql.append( " H_YN='"+rows[j].getString(idx[12])+"',      \n");
				logger.dbg.println(this,"10");
				UpdateSql.append( " SEQ2="+rows[j].getInt(idx[13])+",               \n");
				UpdateSql.append( " REWARD_YM='"+rows[j].getString(idx[14])+"',           \n");
				UpdateSql.append( " BON_YM='"+rows[j].getString(idx[15])+"',           \n");
				UpdateSql.append( " BACK_GB='"+rows[j].getString(idx[16])+"',           \n");
                      UpdateSql.append( " U_EMPNO='"+rows[j].getString(idx[20])+"',   \n");
				logger.dbg.println(this,"11");
							        UpdateSql.append( " U_DATE=CURRENT TIMESTAMP    \n");
				logger.dbg.println(this,"12");
				UpdateSql.append( " WHERE EMPNO='"+rows[j].getString(idx[0])+"' \n");
				logger.dbg.println(this,"13");
				UpdateSql.append( "   AND YYYY='"+rows[j].getString(idx[1])+"'  \n");
				logger.dbg.println(this,"14");
				UpdateSql.append( "   AND SEQ="+rows[j].getInt(idx[2])+"        \n");
											
											
				logger.dbg.println(this,"aaaaa"+UpdateSql.toString());
			
					  UpdateSql.append( " UPDATE NORTHHR.TCM355			  \n")
											.append( " SET                      \n")
											.append( " VEND_CD=?,  DEPT_CD=?,  TEAM_CD=?,  WORK_CD=?,   \n")
											.append( " START_DT=?, END_DT=?,   H_DAY=?,    H_RES=?,     \n")
											.append( " H_YN=?,     SEQ2=?,     REWARD_YM =?,  BON_YM =?,  BACK_GB =?, \n")
							       	.append( " U_EMPNO=?,               \n")
											.append( " U_DATE=CURRENT TIMESTAMP \n")
											.append( " WHERE EMPNO=?						\n")
							        .append( "   AND YYYY=?             \n")
											.append( "   AND SEQ=?              \n");

						rows[j].setString(idx[20],strEmpno);
					

  					GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1,  idx[4]);	
						gsmt.bindColumn(2,  idx[5]);	
						gsmt.bindColumn(3,  idx[6]);	
						gsmt.bindColumn(4,  idx[7]);	
						gsmt.bindColumn(5,  idx[8]);	
						gsmt.bindColumn(6,  idx[9]);	
						gsmt.bindColumn(7,  idx[10]);	
						gsmt.bindColumn(8,  idx[11]);	
						gsmt.bindColumn(9,  idx[12]);	
						gsmt.bindColumn(10, idx[13]);	
						gsmt.bindColumn(11, idx[14]);
				    gsmt.bindColumn(12, idx[15]);
				    gsmt.bindColumn(13, idx[16]);	
						gsmt.bindColumn(14, idx[20]);	
						gsmt.bindColumn(15, idx[0]);	
						gsmt.bindColumn(16, idx[1]);	
						gsmt.bindColumn(17, idx[2]);	
			
						gsmt.executeUpdate();					
						gsmt.close();									
						
						//계약정보의 상여 지급년월을  수정한다. 
					  StringBuffer UpdateSql2 = new StringBuffer();
						//상여지급년월은  휴가미실시 보상년월의 계약관리 순번+1 의 년월과 동일하다
            String strSeq2 = rows[j].getString(idx[13]);
            double intSeq2 = Double.parseDouble(strSeq2)+1;
						rows[j].setDouble(idx[13],intSeq2);
					  				            
						UpdateSql2.append( " UPDATE NORTHHR.TCM345			  \n")
														  .append( "       SET                                \n")
														  .append( "       BON_YM=?,          \n")
						 							    .append( "       U_EMPNO=?,         \n")
														  .append( "       U_DATE=CURRENT TIMESTAMP \n")
														  .append( " WHERE EMPNO=?			 \n")
														  .append( "     AND SEQ=?              \n");
														  
						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.bindColumn(1,  idx[15]);
				    gsmt2.bindColumn(2,  idx[20]);
				    gsmt2.bindColumn(3,  idx[0]);	
						gsmt2.bindColumn(4,  idx[13]);	
														
						gsmt2.executeUpdate();					
						gsmt2.close();									
						
				*/		
					}
					
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/
         
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						
						//삭제시 휴가 년월의 ORIGINAL로 복구할까??? 흠 우선 두고....나중에 필요하면 반영하지... 
						            
						StringBuffer DeleteSql = new StringBuffer();						
												
						DeleteSql.append( " DELETE FROM NORTHHR.KST160						 	\n")
										       	.append( " WHERE HOL_DT=?							        \n")
							             		.append( "	   AND EMPNO=?							        \n");
            	
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);


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
