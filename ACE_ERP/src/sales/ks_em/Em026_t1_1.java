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

public class Em026_t1_1 extends HttpServlet{

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
				/*******************************************************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
        String strPaycd="";
				String strMemo="";
				//파라메타 받아오는것 선언
				String usrid = reqGauce.getParameter("v_str1");
			
				String[] strArrCN = new String[]{ "PAY_YM","PAY_DIV","I_EMPNO"                         
																			  };

				int[] idx = new int[3]; //컬럼갯수를 넣어준다.

        for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					 /*+++++++++++++++++++++++++++++++++++++++++++++++ 
              급여계산작업 시작 : 기본급, 시간외 계산
					  +++++++++++++++++++++++++++++++++++++++++++++++*/
						for(int k=1;k<=1;k++) { 
               if (k==1){
								 strPaycd ="900"; 
								 strMemo="근무일수 계산중";  //기본급
							 }

							 StringBuffer InsertSql_2 = new StringBuffer();
							 InsertSql_2.append("  INSERT INTO SALES.TCM499 (  \n" )
													.append("   APPDT,	PAYDIV,	 PAYDT,	  PBDIV,	PAYCD,  \n" )
													.append("    FRDT,	FRTM,	    TODT, 	 TOTM, 	WRKSTS,	\n" )
													.append("    MEMO,  I_EMPNO,I_DATE,	U_EMPNO,	U_DATE  \n" )
													.append("  ) VALUES ( \n" )
													.append("  '"+rows[j].getString(idx[0])+"', \n" )
													.append("  '"+rows[j].getString(idx[1])+"', \n" )
													.append("  '','1', \n" )
													.append("  '"+strPaycd+"',\n" )
													.append("   REPLACE(CHAR(CURRENT DATE ,ISO),'-',''), \n" )
													.append("   REPLACE(REPLACE(CHAR(CURRENT TIME ,ISO),'.',''),':',''),  \n" )
													.append("   '','',\n" )
													.append("   '1', \n" ) //진행중
													.append("   '"+strMemo+"', \n" )
													.append("  '"+rows[j].getString(idx[2])+"', CURRENT TIMESTAMP,\n" )
													.append("  '"+rows[j].getString(idx[2])+"', CURRENT TIMESTAMP) \n" );

							GauceStatement gsmt_2 = conn.getGauceStatement(InsertSql_2.toString()); 
							gsmt_2.setGauceDataRow(rows[j]);

							gsmt_2.executeUpdate();
							gsmt_2.close();
						}

            /*+++++++++++++++++++++++++++++++++++++++++++++++ 
              근무일수 재계산  
              H_DAY - 실제휴일
              RW_DAY1 - 실제근무일 (일할계산 이전)
              RW_DAY2 - 실제근무일 (일할계산 이후 일할계산 없을 경우)
              W_DAY1 -  계산근무일 (일할계산 이전)
              W_DAY2 -  계산근무일 (일할계산 이후 일할계산 없을 경우)
						  +++++++++++++++++++++++++++++++++++++++++++++++*/
            /*
            StringBuffer UpdateSql_1 = new StringBuffer();
					  UpdateSql_1.append(" UPDATE SALES.TCM400 A                                                                                   \n" )
						 				   .append("    SET (A.W_DAY1,A.W_DAY2)=                                                                             \n" )
							         .append("    ( SELECT X.W_DAY1, X.W_DAY2                                                                          \n" )
							         .append("       FROM (SELECT EMPNO, PAY_YM, PAY_DIV, H_DAY, RW_DAY1, RW_DAY2,M_DAYS,                              \n" )
							         .append(" 									 CASE WHEN RW_DAY1<>0 AND RW_DAY1>RW_DAY2 THEN                                         \n" )
							         .append(" 												CASE WHEN (H_DAY+RW_DAY1+RW_DAY2)>=15 THEN                                       \n" )
							         .append(" 														 CASE WHEN H_DAY = 0 THEN RW_DAY1                                            \n" )
							         .append(" 																	WHEN H_DAY = 1 THEN RW_DAY1+1                                          \n" )
							         .append(" 																	WHEN H_DAY >=2 THEN RW_DAY1+2                                          \n" )
							         .append(" 																	ELSE 0 END                                                             \n" )
							         .append(" 														 WHEN (RW_DAY1+RW_DAY2)<15 THEN                                              \n" )
							         .append(" 														 CASE WHEN H_DAY = 0 THEN RW_DAY1                                            \n" )
							         .append(" 																	WHEN H_DAY >= 1 THEN RW_DAY1+1                                         \n" )
							         .append(" 																	ELSE 0 END                                                             \n" )
							         .append(" 														 ELSE 0 END                                                                  \n" )
							         .append(" 												WHEN RW_DAY1<>0 AND RW_DAY1<RW_DAY2 THEN RW_DAY1                                 \n" )
							         .append(" 									 END AS W_DAY1,                                                                        \n" )
							         .append(" 									 CASE WHEN RW_DAY1=0 THEN                                                              \n" )
							         .append(" 												CASE WHEN (H_DAY+RW_DAY1+RW_DAY2)>=15 THEN                                       \n" )
							         .append(" 														 CASE WHEN (RW_DAY1+RW_DAY2+2)>=M_DAYS THEN M_DAYS ELSE RW_DAY1+RW_DAY2+2 END \n" )
							         .append(" 														 WHEN (RW_DAY1+RW_DAY2)<15 THEN RW_DAY1+RW_DAY2+1 ELSE 0 END                 \n" )
							         .append(" 												WHEN RW_DAY1<>0 AND RW_DAY1<RW_DAY2 THEN                                         \n" )
							         .append(" 														 CASE WHEN (H_DAY+RW_DAY1+RW_DAY2)>=15 THEN                                  \n" )
							         .append(" 																	CASE WHEN H_DAY = 0 THEN RW_DAY2                                       \n" )
							         .append(" 																			 WHEN H_DAY = 1 THEN RW_DAY2+1                                     \n" )
							         .append(" 																			 WHEN H_DAY >=2 THEN RW_DAY2+2                                     \n" )
							         .append(" 																			 ELSE 0 END                                                        \n" )
							         .append(" 																	WHEN (RW_DAY1+RW_DAY2)<15 THEN                                         \n" )
							         .append(" 																	CASE WHEN H_DAY = 0 THEN RW_DAY2                                       \n" )
							         .append(" 																			 WHEN H_DAY >= 1 THEN RW_DAY2+1                                    \n" )
							         .append(" 																			 ELSE 0 END                                                        \n" )
							         .append(" 																	ELSE 0 END                                                             \n" )
							         .append(" 												WHEN RW_DAY1<>0 AND RW_DAY1>RW_DAY2 THEN RW_DAY2                                 \n" )
							         .append(" 										END AS W_DAY2                                                                        \n" )
							         .append(" 							FROM SALES.TCM400                                                                          \n" )
							         .append(" 						 WHERE PAY_YM =?                                               \n" )
							         .append(" 							 AND PAY_DIV=?                                               \n" )
							         .append(" 				 )X                                                                                              \n" )
							         .append("     WHERE X.EMPNO = A.EMPNO                                                                             \n" )
							         .append("       AND X.PAY_YM = A.PAY_YM                                                                           \n" )
							         .append("       AND X.PAY_DIV =A.PAY_DIV                                                                          \n" )
							         .append("    )                                                                                                    \n" );
						GauceStatement gsmt_1 = conn.getGauceStatement(UpdateSql_1.toString()); //로그남기는것
						gsmt_1.setGauceDataRow(rows[j]);

						gsmt_1.bindColumn(1, idx[0]);
						gsmt_1.bindColumn(2, idx[1]);

						gsmt_1.executeUpdate();
						gsmt_1.close();
						*/
						
				    /*+++++++++++++++++++++++++++++++++++++++++++++++ 
               급여계산작업 종료 : 기본급 및 시간외 
						  +++++++++++++++++++++++++++++++++++++++++++++++*/
						for(int m=1;m<=2;m++) { 
							 strPaycd="";
							 if (m==1){ 
								 strPaycd ="900"; 
								 strMemo="근무일수 계산완료";  //
							 }

							StringBuffer UpdateSql = new StringBuffer();			
							UpdateSql.append( " UPDATE SALES.TCM499		\n")
												.append( " SET                  \n")
												.append( " TODT=REPLACE(CHAR(CURRENT DATE ,ISO),'-',''), \n")
												.append( " TOTM=REPLACE(REPLACE(CHAR(CURRENT TIME ,ISO),'.',''),':',''),,  WRKSTS='2',   \n")
                        .append("  MEMO = '"+strMemo+"', \n" )
												.append( " U_DATE=CURRENT TIMESTAMP \n")
												.append( " WHERE APPDT='"+rows[j].getString(idx[0])+"'	\n")
												.append( "   AND PAYDIV='"+rows[j].getString(idx[1])+"' \n")
												.append( "   AND PAYCD='"+strPaycd+"'       \n");

							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);
								
							gsmt.executeUpdate();					
							gsmt.close();									
					  }
					
					}
						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/
            
         	 if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

            /*
	
						StringBuffer UpdateSql = new StringBuffer();			

					  UpdateSql.append( " UPDATE SALES.TCM345			\n")
											.append( " SET                      \n")
											.append( " JOB_CD=?,  VEND_CD=?,  DEPT_CD=?,   TEAM_CD=?, WORK_CD=?,   \n")
											.append( " CONT_GB=?, START_DT=?, END_DT=?,    C_EMPNO=?, C_POSI_CD=?, \n")
											.append( " C_OPI=?,   T_EMPNO=?,  T_POSI_CD=?, T_OPI=?,   REMARK=?,    \n")
							       	.append( " U_EMPNO=?,               \n")
											.append( " U_DATE=CURRENT TIMESTAMP, \n")
							        .append( " REWARD_YM=? \n")
											.append( " WHERE EMPNO=?						\n")
											.append( " AND SEQ=?                \n");

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
						gsmt.bindColumn(10,  idx[12]);	
						gsmt.bindColumn(11,  idx[13]);	
						gsmt.bindColumn(12,  idx[14]);	
						gsmt.bindColumn(13,  idx[15]);	
						gsmt.bindColumn(14,  idx[16]);	
						gsmt.bindColumn(15,  idx[17]);	
						gsmt.bindColumn(16,  idx[20]);
						gsmt.bindColumn(17,  idx[22]);
						gsmt.bindColumn(18,  idx[0]);	
						gsmt.bindColumn(19,  idx[1]);	
						gsmt.executeUpdate();					
						gsmt.close();									
						*/
					}
					
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/
         
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
            /*

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
