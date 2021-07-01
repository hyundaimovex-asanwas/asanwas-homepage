//**참고사항. delete,update할떼는 where절 이후에 primary key 컬럼을 꼭 추가해서 써준다***
package sales.menu.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class Em016_t2 extends HttpServlet{

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
				int intCon_Year=0;   //현재근속년차
				int intBCon_Year=0;  //이전근속년차
				String strChgymd=""; //계약변경일
				String strStartdt="";
				int intpSeq=0;

				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
         
				String[] strArrCN = new String[]{ "EMPNO", "CONT_GB", "REWARD_YM", "I_EMPNO", "U_EMPNO", "BON_YM"
																			  };
				int[] idx = new int[6]; //컬럼갯수를 넣어준다.

        for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				//logger.dbg.println(this,"length::"+rows.length);

				for (int j = 0; j < rows.length; j++){
				
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					  //연장계약자 생성
  				 StringBuffer InsertSql = new StringBuffer();
					 InsertSql.append("  INSERT INTO SALES.TCM345                                           \n" )
										.append("         (    EMPNO,   SEQ,     CUST_SID,    JOB_CD,  VEND_CD,       \n" )
										.append("              DEPT_CD, TEAM_CD, WORK_CD,     CONT_GB,                \n" )
										.append("              START_DT,                                              \n" )
										.append("              END_DT,                                                \n" )
										.append("              C_EMPNO, C_POSI_CD, C_OPI,                             \n" )
										.append("              T_EMPNO, T_POSI_CD, T_OPI,                             \n" )
										.append("              REWARD_YM,  PAY_GB, CON_YEAR,REMARK,                   \n" )
										.append("              I_EMPNO, I_DATE,  U_EMPNO, U_DATE, BON_YM, B_PAY0, CLOSE_YN  \n" )
										.append("          )                                                          \n" )
										.append("  SELECT A.EMPNO,   A.SEQ+1 AS SEQ,  A.CUST_SID, C.JOB_CD, C.VEND_CD,\n" )
						        .append("         C.DEPT_CD, C.TEAM_CD, C.WORK_CD, '"+rows[j].getString(idx[1])+"' AS CONT_GB,  \n" )
										.append("         REPLACE(CAST(CAST(SUBSTR(A.START_DT,1,4)||'-'||SUBSTR(A.START_DT,5,2)||'-'||SUBSTR(A.START_DT,7,2) AS DATE)+1 YEAR AS VARCHAR(10)),'-','') AS START_DT,     \n" )
										.append("         REPLACE(CAST(CAST(SUBSTR(A.END_DT,1,4)||'-'||SUBSTR(A.END_DT,5,2)||'-'||SUBSTR(A.END_DT,7,2) AS DATE)+1 YEAR AS VARCHAR(10)),'-','') AS END_DT,             \n" )
										.append("         ''C_EMPNO,''C_POSI_CD,''C_OPI,   \n" )
										.append("         ''T_EMPNO,''T_POSI_CD,''T_OPI,   \n" )
										.append("         '"+rows[j].getString(idx[2])+"' REWARD_YM, ''PAY_GB, A.CON_YEAR+1 AS CON_YEAR, ''REMARK,               \n" )
										.append("         '"+rows[j].getString(idx[3])+"', CURRENT TIMESTAMP, '"+rows[j].getString(idx[4])+"', CURRENT TIMESTAMP,'"+rows[j].getString(idx[5])+"', D.B_PAY,'' CLOSE_YN  \n" )
										.append("    FROM SALES.TCM345 A, SALES.TCM300 C            \n" )
						        .append("    LEFT JOIN SALES.TCM410 D ON D.YYYYMM = (SELECT MAX(YYYYMM) FROM SALES.TCM410)\n" )
        						.append("                            AND D.SKILL_CD = C.SKILL_CD   \n" )
						        .append("                            AND D.CON_YEAR = A.CON_YEAR \n" ) //이전 년차의 기본급을 가져옴.
										.append("   WHERE A.EMPNO = C.EMPNO                         \n" )
										.append("     AND A.SEQ IN ( SELECT MAX(B.SEQ)              \n" )
						        .append("                      FROM SALES.TCM345 B          \n" )
										.append("                     WHERE A.EMPNO = B.EMPNO)      \n" )
										.append("     AND A.EMPNO = '"+rows[j].getString(idx[0])+"' \n" );

					  //logger.dbg.println(this,InsertSql.toString());
							
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); //로그남기는것
						gsmt.setGauceDataRow(rows[j]);

						gsmt.executeUpdate();
						gsmt.close();


					 StringBuffer UpdateSql = new StringBuffer();			
					 UpdateSql.append( " UPDATE SALES.TCM300	\n")
										.append( "    SET CON_YEAR ="+intCon_Year+", \n")
						        .append( "        B_CON_YEAR ="+intBCon_Year+", \n")
						        .append( "        CHGYMD ='"+strChgymd+"', \n")
						 	      .append( "        U_EMPNO='"+rows[j].getString(idx[4])+"', \n")
										.append( "        U_DATE=CURRENT TIMESTAMP   \n")
						        .append( "  WHERE EMPNO = '"+rows[j].getString(idx[0])+"'  \n");

					  //logger.dbg.println(this,"DFDFDDFD::"+UpdateSql.toString());
  					GauceStatement gsmt_1 = conn.getGauceStatement(UpdateSql.toString());
						gsmt_1.setGauceDataRow(rows[j]);
						gsmt_1.executeUpdate();					
						gsmt_1.close();	

						intCon_Year=0;
						intBCon_Year=0;
						//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

						//이전년차에 Lock 설정 ++++++++++++++++++++++++++++++++++++++++++++++++++++
					 rows[j].setInt(idx[1],intpSeq);
					 StringBuffer UpdateSql_2 = new StringBuffer();			
					 UpdateSql_2.append( " UPDATE SALES.TCM345	\n")
									  	.append( "    SET CLOSE_YN ='Y' \n")
						          .append( "  WHERE EMPNO = ?  \n")
					            .append( "    AND SEQ = ?  \n");
						    
						//logger.dbg.println(this,"222222222::"+UpdateSql_2.toString());
  					GauceStatement gsmt_2 = conn.getGauceStatement(UpdateSql_2.toString());
						gsmt_2.setGauceDataRow(rows[j]);
						gsmt_2.bindColumn(1,  idx[0]);	
						gsmt_2.bindColumn(2,  idx[1]);	
						gsmt_2.executeUpdate();					
						gsmt_2.close();	
						//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

					}
 					 /*******************************************************************************
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
							        .append( " REWARD_YM=?, \n")
							        .append( " CON_YEAR=? \n")
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
						gsmt.bindColumn(18,  idx[23]);
						gsmt.bindColumn(19,  idx[0]);	
						gsmt.bindColumn(20,  idx[1]);	
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
