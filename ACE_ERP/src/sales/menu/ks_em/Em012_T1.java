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

public class Em012_T1 extends HttpServlet{

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

				//파라메타 받아오는것 선언
				String useid = reqGauce.getParameter("v_str1");

				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				String[] strArrCN = new String[]{
                                          "YYYYMM","SEQ","CUST_SID","VEND_CD","DEPT_CD","TEAM_CD","JOB_CD",//7
                                         "TO_MCNT","TO_FCNT","TO_CNT",
                                        "CUR_MCNT","CUR_FCNT","CUR_CNT",
                                        "ARR_MCNT","ARR_FCNT","ARR_CNT",
                                        "HOL_MCNT","HOL_FCNT","HOL_CNT",
                                        "BAK_MCNT","BAK_FCNT","BAK_CNT",
                                        "SKM_MCNT","SKM_FCNT","SKM_CNT",
                                        "CHO_MCNT","CHO_FCNT","CHO_CNT",
                                         "I_EMPNO","U_EMPNO","I_DATE","U_DATE"
																					}; //32

				int[] idx = new int[32]; //컬럼갯수를 넣어준다.

        for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
					}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

          rows[j].setString(idx[28],useid);
          rows[j].setString(idx[29],useid);

					logger.dbg.println(this,"step_INSERT1");//로그남기는것

						StringBuffer InsertSql = new StringBuffer();
		         InsertSql.append( "INSERT INTO SALES.TCM320                               \n" )
											.append( "(YYYYMM,SEQ,CUST_SID,VEND_CD,DEPT_CD,TEAM_CD,JOB_CD,   \n" )//7
											.append( "	TO_MAN,TO_WOM,                                       \n" )
											.append( "	CUR_MAN,CUR_WOM,                                     \n" )
											.append( "	ARR_MAN,ARR_WOM,                                     \n" )
											.append( "	HOL_MAN,HOL_WOM,                                     \n" )
											.append( "	BAK_MAN,BAK_WOM,                                     \n" )
											.append( "	I_EMPNO,U_EMPNO,                                     \n" )
											.append( "	I_DATE,U_DATE)                                       \n" )
											.append( "	VALUES                                               \n" )
											.append( "	(?,?,?,?,?,?,?,                                      \n" )
											.append( "		?,?,                                               \n" )
											.append( "		?,?,                                               \n" )
											.append( "		?,?,                                               \n" )
											.append( "		?,?,                                               \n" )
											.append( "		?,?,                                               \n" )
											.append( "		?,?,                                               \n" )
											.append( "	CURRENT TIMESTAMP,CURRENT TIMESTAMP)                 \n" );

					 
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());//로그남기는것
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
                      gsmt.bindColumn(10, idx[10]);
                      gsmt.bindColumn(11, idx[11]);
                      gsmt.bindColumn(12, idx[13]);
                      gsmt.bindColumn(13, idx[14]);
                      gsmt.bindColumn(14, idx[16]);
                      gsmt.bindColumn(15, idx[17]);
                      gsmt.bindColumn(16, idx[19]);
                      gsmt.bindColumn(17, idx[20]);
                      gsmt.bindColumn(18, idx[28]);
                      gsmt.bindColumn(19, idx[29]);


            logger.dbg.println(this,InsertSql.toString());//로그남기는것
            logger.dbg.println(this,"TEST_INSERT");//로그남기는것

						gsmt.executeUpdate();
						gsmt.close();
					}
						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/

         			if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

	          rows[j].setString(idx[29],useid);

						logger.dbg.println(this,"step_UPDATE");//로그남기는것

						StringBuffer UpdateSql = new StringBuffer();


						 UpdateSql.append( " UPDATE SALES.TCM320                               \n")
											.append( " SET                                               \n")
											.append( " VEND_CD=?,DEPT_CD=?,TEAM_CD=?,JOB_CD=?,           \n")
											.append( " TO_MAN=?,TO_WOM=?,                                \n")
											.append( " CUR_MAN=?,CUR_WOM=?,                              \n")
											.append( " ARR_MAN=?,ARR_WOM=?,                              \n")
											.append( " HOL_MAN=?,HOL_WOM=?,                              \n")
											.append( " BAK_MAN=?,BAK_WOM=?,                              \n")
											.append( " U_EMPNO=?,                                        \n")//16
											.append( " U_DATE=CURRENT TIMESTAMP                          \n")
											.append( " WHERE YYYYMM=?                                    \n")
											.append( " AND SEQ=?                                         \n");

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						logger.dbg.println(this,UpdateSql.toString());//로그남기는것
						gsmt.setGauceDataRow(rows[j]);


                      gsmt.bindColumn(1, idx[3]);
                      gsmt.bindColumn(2, idx[4]);
                      gsmt.bindColumn(3, idx[5]);
                      gsmt.bindColumn(4, idx[6]);
                      gsmt.bindColumn(5, idx[7]);
                      gsmt.bindColumn(6, idx[8]);
                      gsmt.bindColumn(7, idx[10]);
                      gsmt.bindColumn(8, idx[11]);
                      gsmt.bindColumn(9, idx[13]);
                      gsmt.bindColumn(10, idx[14]);
                      gsmt.bindColumn(11, idx[16]);
                      gsmt.bindColumn(12, idx[17]);
                      gsmt.bindColumn(13, idx[19]);
                      gsmt.bindColumn(14, idx[20]);
                      gsmt.bindColumn(15, idx[29]);
                      gsmt.bindColumn(16, idx[0]);
                      gsmt.bindColumn(17, idx[1]);
																		
						gsmt.executeUpdate();
						gsmt.close();
					}
					/******************************** **********************************************
					 * DELETE 처리
					 ********************************************************************************

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

						logger.dbg.println(this,"step_DELETE");//로그남기는것

						StringBuffer DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE  FROM SALES.TCM320		\n")
										 .append( "	WHERE EMPNO=?								\n")
										 .append( "	AND SEQ=?										\n");
	
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						logger.dbg.println(this,DeleteSql.toString());//로그남기는것


								gsmt.setGauceDataRow(rows[j]);
								gsmt.bindColumn(1, idx[0]);
								gsmt.bindColumn(2, idx[1]);

						gsmt.executeUpdate();
						gsmt.close();

				}*/

				}
			}
			catch(Exception e){
				logger.err.println(this,e.getMessage());	
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
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
