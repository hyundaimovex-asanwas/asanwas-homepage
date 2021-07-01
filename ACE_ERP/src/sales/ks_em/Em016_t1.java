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

public class Em016_t1 extends HttpServlet{

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
				int intCon_Year=0;
				int intBCon_Year=0;
				String strContgb=""; //계약구분
				String strChgymd=""; //계약변경일
				String strStartdt="";

				int intpSeq = 0; //이전년차
				/*******************************************************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
         
				String[] strArrCN = new String[]{ "EMPNO","SEQ","CUST_SID","JOB_CD","VEND_CD",
					                                "DEPT_CD","TEAM_CD","WORK_CD","CONT_GB","START_DT",
                                          "END_DT", "C_EMPNO","C_POSI_CD","C_OPI","T_EMPNO",  
                                          "T_POSI_CD","T_OPI", "REMARK",   
																					"I_EMPNO","I_DATE","U_EMPNO","U_DATE","REWARD_YM",
					                                "CON_YEAR","SKILL_CD","B_PAY0", "BON_YM","CLOSE_YN"
																			  };

				int[] idx = new int[28]; //컬럼갯수를 넣어준다.

        for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

            //SEQ 생성
						StringBuffer sql = new StringBuffer();
						Statement stmt= null;
						ResultSet rs = null;
						int intSeq = 0;
						intpSeq =0;

						sql.append( "SELECT IFNULL(MAX(SEQ),0)+1 AS SEQ, MAX(SEQ) AS P_SEQ \n" )
							 .append( "FROM SALES.TCM345                  \n" )
							 .append( "WHERE EMPNO ='"+rows[j].getString(idx[0])+"'  \n" );

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while (rs.next())	{
							intSeq = rs.getInt(1);
							intpSeq = rs.getInt(2);
						}
						rs.close();
						stmt.close();

            //계약시점의 기본급을 입력한다.(휴가미실시보상금 지급을 위함)/////////////////////
            StringBuffer sql_1 = new StringBuffer();
						Statement stmt_1= null;
						ResultSet rs_1 = null;
						int intB_pay0 = 0;

						if(rows[j].getString(idx[8]).equals("002")){ //연장계약일 경우
							intBCon_Year = rows[j].getInt(idx[23])-1;
							strChgymd = rows[j].getString(idx[9]);
					  }

						sql_1.append( "SELECT B_PAY     \n" )
							   .append( "  FROM SALES.TCM410 \n" )
							   .append( " WHERE YYYYMM = (SELECT MAX(YYYYMM) FROM SALES.TCM410)  \n" )
						     .append( "   AND SKILL_CD ='"+rows[j].getString(idx[24])+"'  \n" )
								 .append( "   AND CON_YEAR ='"+intBCon_Year+"'  \n" );

						logger.dbg.println(this,"sql_1::"+sql_1.toString());

						stmt_1 = conn.createStatement();
						rs_1 = stmt_1.executeQuery(sql_1.toString());

						while (rs_1.next())	{
							intB_pay0 = rs_1.getInt(1);
						}

						logger.dbg.println(this,"intB_pay0::"+intB_pay0);
						rs_1.close();
						stmt_1.close();
						//////////////////////////////////////////////////////////////////////////////////

						rows[j].setInt(idx[1],intSeq);
						rows[j].setInt(idx[25],intB_pay0);

						StringBuffer InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO SALES.TCM345                          \n" )
										 .append( " ( EMPNO,    SEQ,     CUST_SID,  JOB_CD,  VEND_CD, \n" )
										 .append( "   DEPT_CD,  TEAM_CD, WORK_CD,   CONT_GB, START_DT,\n" )
										 .append( "   END_DT,   C_EMPNO, C_POSI_CD, C_OPI,   T_EMPNO, \n" )
										 .append( "   T_POSI_CD,T_OPI,   REMARK,                      \n" )
										 .append( "   I_EMPNO,  I_DATE,	 U_EMPNO,	 U_DATE, REWARD_YM, CON_YEAR, B_PAY0, BON_YM,CLOSE_YN  ) \n" )
										 .append( "  VALUES                                           \n" )
										 .append( " ( ?,?,?,?,?,?,?,?,?,?,                            \n" )
										 .append( "   ?,?,?,?,?,?,?,?,                                \n" )
										 .append( "   ?,CURRENT TIMESTAMP,?,CURRENT TIMESTAMP,?,?,?,?,?)    \n" );
										
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
						gsmt.bindColumn(16, idx[15]);
						gsmt.bindColumn(17, idx[16]);
						gsmt.bindColumn(18, idx[17]);
						gsmt.bindColumn(19, idx[18]);
						gsmt.bindColumn(20, idx[20]);
						gsmt.bindColumn(21, idx[22]);
						gsmt.bindColumn(22, idx[23]);
						gsmt.bindColumn(23, idx[25]);
						gsmt.bindColumn(24, idx[26]);
						gsmt.bindColumn(25, idx[27]);
			
						gsmt.executeUpdate();
						gsmt.close();

            /*
					  if(rows[j].getString(idx[8]).equals("002")){ //연장계약일 경우
							intBCon_Year = rows[j].getInt(idx[23])-1;
							strChgymd = rows[j].getString(idx[9]);
					  }
						*/

					 //년차 UPDATE ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
					 StringBuffer UpdateSql_1 = new StringBuffer();			
					 UpdateSql_1.append( " UPDATE SALES.TCM300	\n")
									  	.append( "    SET CON_YEAR =?, \n")
						          .append( "        B_CON_YEAR ="+intBCon_Year+", \n")
						          .append( "        CHGYMD ='"+strChgymd+"', \n")
						 	        .append( "        U_EMPNO=?, \n")
										  .append( "        U_DATE=CURRENT TIMESTAMP   \n")
						          .append( "  WHERE EMPNO = ?  \n");
						    
  					GauceStatement gsmt_1 = conn.getGauceStatement(UpdateSql_1.toString());
						gsmt_1.setGauceDataRow(rows[j]);

						gsmt_1.bindColumn(1,  idx[23]);	
						gsmt_1.bindColumn(2,  idx[20]);	
						gsmt_1.bindColumn(3,  idx[0]);	
				
						gsmt_1.executeUpdate();					
						gsmt_1.close();	

						intCon_Year=0;

						//이전년차에 Lock 설정 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
					 rows[j].setInt(idx[1],intpSeq);
					 StringBuffer UpdateSql_2 = new StringBuffer();			
					 UpdateSql_2.append( " UPDATE SALES.TCM345	\n")
									  	.append( "    SET CLOSE_YN ='Y' \n")
						          .append( "  WHERE EMPNO = ?  \n")
					            .append( "    AND SEQ = ?  \n");
						    
  					GauceStatement gsmt_2 = conn.getGauceStatement(UpdateSql_2.toString());
						gsmt_2.setGauceDataRow(rows[j]);
						gsmt_2.bindColumn(1,  idx[0]);	
						gsmt_2.bindColumn(2,  idx[1]);	
						gsmt_2.executeUpdate();					
						gsmt_2.close();	
						//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
					}
						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/
            
         	 if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

             //계약시점의 기본급을 입력한다.(휴가미실시보상금 지급을 위함)/////////////////////
            StringBuffer sql_1 = new StringBuffer();
						Statement stmt_1= null;
						ResultSet rs_1 = null;
						int intB_pay0 = 0;
            
					 if(rows[j].getString(idx[8]).equals("002")){ //연장계약일 경우
						 intBCon_Year = rows[j].getInt(idx[23])-1;
						 strChgymd = rows[j].getString(idx[9]);
					 }


						sql_1.append( "SELECT B_PAY  \n" )
							   .append( "  FROM SALES.TCM410 \n" )
							   .append( " WHERE YYYYMM = (SELECT MAX(YYYYMM) FROM SALES.TCM410)  \n" )
						     .append( "   AND SKILL_CD ='"+rows[j].getString(idx[24])+"'  \n" )
								 .append( "   AND CON_YEAR ='"+intBCon_Year+"'  \n" );

						stmt_1 = conn.createStatement();
						rs_1 = stmt_1.executeQuery(sql_1.toString());

						while (rs_1.next())	{
							intB_pay0 = rs_1.getInt(1);
						}
						rs_1.close();
						stmt_1.close();
						//////////////////////////////////////////////////////////////////////////////////
						rows[j].setInt(idx[25],intB_pay0);

    				StringBuffer UpdateSql = new StringBuffer();	
					  UpdateSql.append( " UPDATE SALES.TCM345			\n")
											.append( " SET                      \n")
											.append( " JOB_CD=?,  VEND_CD=?,  DEPT_CD=?,   TEAM_CD=?, WORK_CD=?,   \n")
											.append( " CONT_GB=?, START_DT=?, END_DT=?,    C_EMPNO=?, C_POSI_CD=?, \n")
											.append( " C_OPI=?,   T_EMPNO=?,  T_POSI_CD=?, T_OPI=?,   REMARK=?,    \n")
							       	.append( " U_EMPNO=?,               \n")
											.append( " U_DATE=CURRENT TIMESTAMP, \n")
							        .append( " REWARD_YM=?,  \n")
							        .append( " CON_YEAR=?,   \n")
							        .append( " B_PAY0=?,      \n")
							        .append( " BON_YM=?      \n")
											.append( " WHERE EMPNO=? \n")
											.append( " AND SEQ=?     \n");

						rows[j].setString(idx[20],strEmpno);
  					GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1,  idx[3]);	
						gsmt.bindColumn(2,  idx[4]);	
						gsmt.bindColumn(3,  idx[5]);	
						gsmt.bindColumn(4,  idx[6]);	
						gsmt.bindColumn(5,  idx[7]);	
						gsmt.bindColumn(6,  idx[8]);	
						gsmt.bindColumn(7,  idx[9]);	
						gsmt.bindColumn(8,  idx[10]);	
						gsmt.bindColumn(9,  idx[11]);	
						gsmt.bindColumn(10, idx[12]);	
						gsmt.bindColumn(11, idx[13]);	
						gsmt.bindColumn(12, idx[14]);	
						gsmt.bindColumn(13, idx[15]);	
						gsmt.bindColumn(14, idx[16]);	
						gsmt.bindColumn(15, idx[17]);	
						gsmt.bindColumn(16, idx[20]);
						gsmt.bindColumn(17, idx[22]);
						gsmt.bindColumn(18, idx[23]);
						gsmt.bindColumn(19, idx[25]);
						gsmt.bindColumn(20, idx[26]);
						gsmt.bindColumn(21, idx[0]);	
						gsmt.bindColumn(22, idx[1]);	
						
						gsmt.executeUpdate();					
						gsmt.close();		

						//년차 UPDATE ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
             /*
						 if(rows[j].getString(idx[8]).equals("002")){ //연장계약일 경우
							 intBCon_Year = rows[j].getInt(idx[23])-1;
							 strChgymd = rows[j].getString(idx[9]);
					   }
						 */
						
						 StringBuffer UpdateSql_1 = new StringBuffer();			
						 UpdateSql_1.append( " UPDATE SALES.TCM300	\n")
												.append( "    SET CON_YEAR =?, \n")
							          .append( "        B_CON_YEAR ="+intBCon_Year+", \n")
							          .append( "        CHGYMD ='"+strChgymd+"', \n")
												.append( "        U_EMPNO=?, \n")
												.append( "        U_DATE=CURRENT TIMESTAMP   \n")
												.append( "  WHERE EMPNO = ?  \n");
									
							GauceStatement gsmt_1 = conn.getGauceStatement(UpdateSql_1.toString());
							gsmt_1.setGauceDataRow(rows[j]);

							gsmt_1.bindColumn(1,  idx[23]);	
							gsmt_1.bindColumn(2,  idx[20]);	
							gsmt_1.bindColumn(3,  idx[0]);	
					
							gsmt_1.executeUpdate();					
							gsmt_1.close();	

						  intBCon_Year=0;
							
						//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
					}
					
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/
         
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

						StringBuffer DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM SALES.TCM345		\n")
										 .append( "	 WHERE EMPNO=?							\n")
				  					 .append( "    AND SEQ=?							  \n");
	
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);

						gsmt.executeUpdate();
						gsmt.close();


						intpSeq=0;

						//년차 UPDATE ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            StringBuffer sql_1 = new StringBuffer();
						Statement stmt_1= null;
						ResultSet rs_1 = null;
						sql_1.append( " SELECT A.CON_YEAR , A.CONT_GB,  A.START_DT, A.SEQ  \n" )
							   .append( " 	FROM SALES.TCM345 A                       \n" )
							   .append( "  WHERE A.EMPNO = '"+rows[j].getString(idx[0])+"' \n" )
							   .append( " 	 AND A.SEQ IN ( SELECT MAX(B.SEQ)         \n" )
							   .append( " 										FROM SALES.TCM345 B     \n" )
							   .append( " 									 WHERE A.EMPNO = B.EMPNO) \n" );
						stmt_1 = conn.createStatement();
						rs_1 = stmt_1.executeQuery(sql_1.toString());

						while (rs_1.next())	{
							intCon_Year = rs_1.getInt(1);
							strContgb = rs_1.getString(2);
							strStartdt = rs_1.getString(3);
							intpSeq = rs_1.getInt(4);
						}

						rs_1.close();
						stmt_1.close();

						if(strContgb.equals("002")){
							strChgymd = strStartdt;
						}else{
              strChgymd="";
						}

					 intBCon_Year = intCon_Year-1;

					 StringBuffer UpdateSql_1 = new StringBuffer();			
					 UpdateSql_1.append( " UPDATE SALES.TCM300	\n")
										  .append( "    SET CON_YEAR =?, \n")
						          .append( "        B_CON_YEAR ="+intBCon_Year+", \n")
						          .append( "        CHGYMD ='"+strChgymd+"', \n")
						 	        .append( "        U_EMPNO=?, \n")
										  .append( "        U_DATE=CURRENT TIMESTAMP   \n")
						          .append( "  WHERE EMPNO = ?  \n");
					  
						rows[j].setInt(idx[23],intCon_Year);
		
  					GauceStatement gsmt_1 = conn.getGauceStatement(UpdateSql_1.toString());
						gsmt_1.setGauceDataRow(rows[j]);
						
						gsmt_1.bindColumn(1,  idx[23]);	
						gsmt_1.bindColumn(2,  idx[20]);	
						gsmt_1.bindColumn(3,  idx[0]);	

						gsmt_1.executeUpdate();					
						gsmt_1.close();	

						intCon_Year=0;
						intBCon_Year=0;

						//이전년차에 Lock 해지 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
						 rows[j].setInt(idx[1],intpSeq);
						 StringBuffer UpdateSql_2 = new StringBuffer();			
						 UpdateSql_2.append( " UPDATE SALES.TCM345	\n")
												.append( "    SET CLOSE_YN ='' \n")
												.append( "  WHERE EMPNO = ?  \n")
												.append( "    AND SEQ = ?  \n");
									
							GauceStatement gsmt_2 = conn.getGauceStatement(UpdateSql_2.toString());
							gsmt_2.setGauceDataRow(rows[j]);
							gsmt_2.bindColumn(1,  idx[0]);	
							gsmt_2.bindColumn(2,  idx[1]);	
							gsmt_2.executeUpdate();					
							gsmt_2.close();	
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
