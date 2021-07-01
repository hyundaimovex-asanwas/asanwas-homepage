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

public class KS_Em012_t1 extends HttpServlet{

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
				
				String useid = reqGauce.getParameter("v_str2");
				
				int intBconyear=0;

				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				String[] strArrCN = new String[]{ "EMPNO",	"ORD_DT",

																	"SEQ", "CUST_SID", "ORD_CD",
					                                
																	"VEND_CD", "DEPT_CD",

																	"WORK_CD", "C_VEND_CD",
																					
																	"JOB_CD", "I_EMPNO",

																	"I_DATE","U_EMPNO","U_DATE"			                                
																									
																			  };

				int[] idx = new int[14]; //컬럼갯수를 넣어준다.

        for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					StringBuffer sql = new StringBuffer();
					Statement stmt= null;
					ResultSet rs = null;
					int intSeq = 0;

					sql.append( "SELECT IFNULL(MAX(SEQ),0)+1 AS SEQ \n" )
						 .append( "FROM SALES.KST015                  \n" )
						 .append( "WHERE EMPNO ='"+rows[j].getString(idx[0])+"'  \n" )
					   .append( "  AND ORD_DT ='"+rows[j].getString(idx[1])+"' \n" ); 

					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql.toString());

					while (rs.next())	{
						intSeq = rs.getInt(1);
					}
					rs.close();
					stmt.close();

					 rows[j].setInt(idx[2],intSeq);

           //발령 Insert
					 StringBuffer InsertSql = new StringBuffer();
					 InsertSql.append( " INSERT INTO SALES.KST015                          								\n" )
										.append( "( EMPNO,	 ORD_DT,	 SEQ,	CUST_SID,	ORD_CD,       	 	\n" )
										.append( "  VEND_CD, DEPT_CD, 	WORK_CD,  C_VEND_CD,	 				\n" )
										.append( "  JOB_CD,	I_EMPNO, I_DATE,	 U_EMPNO,	U_DATE )         \n" )
										.append( "  VALUES                                       											\n" )
										.append( " ( ?,?,?,?,?,?,?,?,?,                        											\n" )
										.append( "   ?,?,CURRENT TIMESTAMP,?,CURRENT TIMESTAMP)   			 \n" );
										
					 GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); 
					 gsmt.setGauceDataRow(rows[j]);
					 
					 logger.dbg.println(this,InsertSql.toString());//로그남기는것

					 logger.dbg.println(this,"EMPNO,				rows[j].getString(idx[0])::"+rows[j].getString(idx[0]));         
					 logger.dbg.println(this,"ORD_DT,				rows[j].getString(idx[1])::"+rows[j].getString(idx[1]));         	
					 logger.dbg.println(this,"SEQ,               	rows[j].getString(idx[2])::"+rows[j].getString(idx[2]));         
					 logger.dbg.println(this,"CUST_SID,						rows[j].getString(idx[3])::"+rows[j].getString(idx[3]));         
					 logger.dbg.println(this,"ORD_CD,          	rows[j].getString(idx[4])::"+rows[j].getString(idx[4]));         
					 logger.dbg.println(this,"VEND_CD,		rows[j].getString(idx[5])::"+rows[j].getString(idx[5]));         
					 logger.dbg.println(this,"DEPT_CD,          	rows[j].getString(idx[6])::"+rows[j].getString(idx[6]));         
					 logger.dbg.println(this,"WORK_CD,					rows[j].getString(idx[7])::"+rows[j].getString(idx[7]));         
					 logger.dbg.println(this,"C_VEND_CD,    	rows[j].getString(idx[8])::"+rows[j].getString(idx[8]));                   
					 logger.dbg.println(this,"JOB_CD,    	rows[j].getString(idx[9])::"+rows[j].getString(idx[9]));     
					 logger.dbg.println(this,"I_EMPNO,      	rows[j].getString(idx[10])::"+rows[j].getString(idx[10]));         
					 logger.dbg.println(this,"U_EMPNO,  	rows[j].getString(idx[12])::"+rows[j].getString(idx[12]));         
   
					 
					 
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
						gsmt.bindColumn(12, idx[12]);


						//logger.dbg.println(this,"?o미?");//로그남기는것

						gsmt.executeUpdate();
						gsmt.close();



/*
						//기존의 기능구분을 B_SKILL_CD에 넣는다.
						StringBuffer sql_1 = new StringBuffer();
						Statement stmt_1= null;
						ResultSet rs_1 = null;
						String strBskill_cd="";

						sql_1.append( "SELECT SKILL_CD, B_CON_YEAR \n" )
							   .append( "  FROM SALES.TCM300  \n" )
							   .append( " WHERE EMPNO ='"+rows[j].getString(idx[0])+"'  \n" );
							   
						stmt_1 = conn.createStatement();
						rs_1 = stmt_1.executeQuery(sql_1.toString());

						while (rs_1.next())	{
							strBskill_cd = rs_1.getString(1);
							intBconyear = rs_1.getInt(2);
						}
						rs_1.close();
						stmt_1.close();

						//인사MST UPDATE
            			 StringBuffer UpdateSql = new StringBuffer();			
						 UpdateSql.append( " UPDATE SALES.TCM300	\n")
											.append( " SET                  \n")
											.append( " VEND_CD=?,           \n")
											.append( " DEPT_CD=?,           \n")
											.append( " TEAM_CD=?,           \n")
											.append( " WORK_CD=?,           \n")
											.append( " SKILL_CD=?,          \n")
                      .append( " JOB_CD=?,            \n");
           
           
            if(rows[j].getString(idx[4]).equals("007")){  //퇴사일경우 인사기본정보에 반영
           
             UpdateSql.append( " USESTS='3', \n");
			
						 UpdateSql.append( " END_DT='"+rows[j].getString(idx[1])+"',\n");
			
						}else{
			
							if(!rows[j].getString(idx[9]).equals(strBskill_cd)){  //변경일은 기능구분이 변경될 경우만 가능함.
								UpdateSql.append( " CHGYMD='"+rows[j].getString(idx[1])+"',\n");
							}
						}

            
            if(rows[j].getString(idx[4]).equals("002")){  //재입사일 경우 인사기본정보에 반영
            
              UpdateSql.append( " ORD_CD='002', \n");
						}

            
            if(!rows[j].getString(idx[9]).equals(strBskill_cd)&&intBconyear==0){  //기능구분이 동일하지 않을 경우 이전년차가 0 이면 1로 바꿔준다.
            
             UpdateSql.append( " B_CON_YEAR=1, \n");
						}

			
						 UpdateSql.append( " B_SKILL_CD='"+strBskill_cd+"',\n")
			
											.append( " U_EMPNO=?,           \n")
			
											.append( " U_DATE=CURRENT TIMESTAMP, \n")
			
							        .append( " C_VEND_CD=?,              \n") 
			
							        .append( " RETGB=?,                  \n") 
			
							        .append( " BLCHK=?                   \n") 
			
											.append( " WHERE EMPNO=?						 \n");
							
						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql.toString());

						gsmt2.setGauceDataRow(rows[j]);
							
						gsmt2.bindColumn(1,  idx[5]);	
						gsmt2.bindColumn(2,  idx[6]);	
						gsmt2.bindColumn(3,  idx[7]);	
						gsmt2.bindColumn(4,  idx[8]);	
						gsmt2.bindColumn(5,  idx[9]);	
						gsmt2.bindColumn(6,  idx[10]);	
						gsmt2.bindColumn(7,  idx[11]);	
						gsmt2.bindColumn(8,  idx[15]);	
						gsmt2.bindColumn(9,  idx[16]);	
						gsmt2.bindColumn(10, idx[17]);	
						gsmt2.bindColumn(11, idx[0]);															
						gsmt2.executeUpdate();					
						gsmt2.close();				

						if(rows[j].getString(idx[4]).equals("007")){  //퇴사일 경우 계약에 반영

							//퇴직시 - 계약 UPDATE (CLOSE_YN =Y로 만듬)
							 StringBuffer UpdateSql3 = new StringBuffer();			
							 UpdateSql3.append( " UPDATE SALES.TCM345 A	\n")
												 .append( "    SET A.CLOSE_YN='Y',\n")
												 .append( "        A.U_EMPNO=?,   \n")
												 .append( "        A.U_DATE=CURRENT TIMESTAMP \n")
												 .append( "  WHERE A.EMPNO=?				\n")
							           .append( "    AND A.SEQ= (SELECT MAX(SEQ) FROM SALES.TCM345 B WHERE B.EMPNO = A.EMPNO) \n");
								
							GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql3.toString());

							gsmt3.setGauceDataRow(rows[j]);
							gsmt3.bindColumn(1,  idx[11]);	
							gsmt3.bindColumn(2,  idx[0]);	
															
							gsmt3.executeUpdate();					
							gsmt3.close();						
						}

*/

					}
					
					
						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/
            /*
         	  if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
	
						logger.dbg.println(this,"step_UPDATE");//로그남기는것

						StringBuffer UpdateSql = new StringBuffer();			

						 UpdateSql.append( " UPDATE SALES.TCM335			\n")
											.append( " SET                      \n")
											.append( " START_DT=?,              \n")
											.append( " END_DT=?,                \n")
											.append( " EDU_CD=?,                \n")
											.append( " EDU_YN=?,                \n")
											.append( " EDU_CO=?,                \n")
											.append( " U_EMPNO=?,               \n")
											.append( " U_DATE=CURRENT TIMESTAMP \n")
											.append( " WHERE EMPNO=?						\n")
											.append( " AND SEQ=?                \n");


						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
//						logger.dbg.println(this,UpdateSql.toString());//로그남기는것

						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1,  idx[2]);	
						gsmt.bindColumn(2,  idx[3]);	
						gsmt.bindColumn(3,  idx[4]);	
						gsmt.bindColumn(4,  idx[5]);	
						gsmt.bindColumn(5,  idx[6]);	
						gsmt.bindColumn(6,  idx[7]);	
						gsmt.bindColumn(7,  idx[0]);	
						gsmt.bindColumn(8,  idx[1]);															
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
						DeleteSql.append( " DELETE FROM SALES.TCM305		\n")
										 .append( "	 WHERE EMPNO=?							\n")
				  					 .append( "    AND SEQ=?							  \n");
	
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
