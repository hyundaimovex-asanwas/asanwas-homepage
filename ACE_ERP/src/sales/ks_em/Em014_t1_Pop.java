//**참고사항. delete,update할떼는 where절 이후에 primary key 컬럼을 꼭 추가해서 써준다***
package sales.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class Em014_t1_Pop extends HttpServlet{

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
				String strEmpno = reqGauce.getParameter("v_str1");
			
				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
         
				String[] strArrCN = new String[]{ "EMPNO",  "WORK_GB",   "W_TIME",    "W2_TIME","W_TIME_TOT", "W_REMARK",
					                               					  "O_TIME", "O2_TIME",      "O3_TIME",  "O4_TIME", "O_TIME_TOT","O_DTIME","O_NTIME","O_REMARK",
                                                                      "I_EMPNO","I_DATE","U_EMPNO","U_DATE"
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

					

					}
						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/
            
         	 if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
         	 	
								StringBuffer sql = new StringBuffer();

								Statement stmt= null;
								ResultSet rs = null;
								
								int intCnt = 0;
								String strCnt="";

								sql.append( "SELECT COUNT(*) CNT \n" )
								  	 .append( "FROM SALES.TCM360                  \n" )
										 .append( "WHERE EMPNO ='"+rows[j].getString(idx[0])+"'  \n" );

								stmt = conn.createStatement();
								rs = stmt.executeQuery(sql.toString());

								while (rs.next())	{
									intCnt = rs.getInt(1);
								}
								
				
				       strCnt =String.valueOf(intCnt);	;
								
				       rows[j].setString(idx[14],strEmpno);
				       rows[j].setString(idx[16],strEmpno);
				       
         	 	   if(strCnt.equals("0")){ //insert
         	 	            	 	   	
         		   	
											StringBuffer InsertSql = new StringBuffer();
											InsertSql.append( " INSERT INTO SALES.TCM360                          \n" )
															      .append( " ( EMPNO,    WORK_GB,    W_TIME,     W2_TIME, W_TIME_TOT, W_REMARK,  \n" )
					                                              .append( "   O_TIME,  O2_TIME,	 O3_TIME,	O4_TIME,  O_TIME_TOT,  O_DTIME, O_NTIME,  O_REMARK, \n" )
															      .append( "   I_EMPNO,  I_DATE,	 U_EMPNO,	U_DATE ) \n" )
															      .append( "  VALUES      \n" )
															      .append( " ( ?,?,?,?,?,?, \n" )
					                                              .append( "   ?,?,?,?,?,?,?,?,  \n" )
															      .append( "   ?,CURRENT TIMESTAMP,?,CURRENT TIMESTAMP)      \n" );
										
											GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); //로그남기는것
											gsmt.setGauceDataRow(rows[j]);
					
											gsmt.bindColumn(1, idx[0]);
											gsmt.bindColumn(2, idx[1]);
											gsmt.bindColumn(3, idx[2]);
											gsmt.bindColumn(4, idx[3]);
											gsmt.bindColumn(5, idx[4]);
											gsmt.bindColumn(6, idx[5]);
											gsmt.bindColumn(7, idx[6]);
											gsmt.bindColumn(8, idx[7]);
											gsmt.bindColumn(9, idx[8]);
											gsmt.bindColumn(10, idx[9]);
											gsmt.bindColumn(11, idx[10]);
											gsmt.bindColumn(12, idx[11]);
											gsmt.bindColumn(13, idx[12]);
											gsmt.bindColumn(14, idx[13]);
											gsmt.bindColumn(15, idx[14]);
											gsmt.bindColumn(16, idx[16]); 
											
											gsmt.executeUpdate();
											gsmt.close();	
         	 	   	
         	 	   }else{        //update
				  
											StringBuffer UpdateSql = new StringBuffer();		
						
									    UpdateSql.append( " UPDATE SALES.TCM360	     \n")
											        	.append( " SET                                      \n")
														.append( " WORK_GB=?,  W_TIME=?,  W2_TIME=?,  W_TIME_TOT=?,  W_REMARK=?, \n")
					                                    .append( " O_TIME=?,  O2_TIME=?,  O3_TIME=?,  O4_TIME=?,  O_TIME_TOT=?,  O_DTIME=?, O_NTIME=?, O_REMARK=?,\n")
													    .append( " U_EMPNO=?,                        \n")
														.append( " U_DATE=CURRENT TIMESTAMP  \n")
														.append( " WHERE EMPNO=?						            \n");
													          
									   GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
									   gsmt.setGauceDataRow(rows[j]);
						
									     gsmt.bindColumn(1,  idx[1]);	
									     gsmt.bindColumn(2,  idx[2]);	
										 gsmt.bindColumn(3,  idx[3]);	
										 gsmt.bindColumn(4,  idx[4]);	
										 gsmt.bindColumn(5,  idx[5]);	
										 gsmt.bindColumn(6,  idx[6]);	
										 gsmt.bindColumn(7,  idx[7]);	
										 gsmt.bindColumn(8,  idx[8]);	
										 gsmt.bindColumn(9,  idx[9]);	
										 gsmt.bindColumn(10,  idx[10]);	
										 gsmt.bindColumn(11,  idx[11]);	
										 gsmt.bindColumn(12,  idx[12]);	
										 gsmt.bindColumn(13,  idx[13]);	
										 gsmt.bindColumn(14,  idx[16]);	
										 gsmt.bindColumn(15,  idx[0]);		
										
										 gsmt.executeUpdate();					
										 gsmt.close();									 
         	 	   	
         	 	   }
         	 	
					}
					
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/
         
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
            /*
						StringBuffer DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM SALES.TCM355		\n")
										 .append( "	 WHERE EMPNO=?							\n")
							       .append( "	   AND YYYY=?							  \n")
				  					 .append( "    AND SEQ=?							  \n");
	
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);

						gsmt.executeUpdate();
						gsmt.close();
						*/

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
