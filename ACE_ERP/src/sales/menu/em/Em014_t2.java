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

public class Em014_t2 extends HttpServlet{

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
			
				String[] strArrCN = new String[]{ "EMPNO",     "ATT_DT",  "CUST_SID", "VEND_CD","DEPT_CD",
					                                "TEAM_CD",   "WORK_CD", "WORK_GB",  "W_TIME", "W2_TIME",
                                          "W_TIME_TOT","W_REMARK","O_TIME",   "O2_TIME","O_TIME_TOT",
                                          "O_DTIME",   "O_NTIME", "O_REMARK", "REMARK", "CHK",
					                               	"I_EMPNO",   "I_DATE",  "U_EMPNO",  "U_DATE"
																			  };
				int[] idx = new int[24]; //컬럼갯수를 넣어준다.

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
				/*
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					 StringBuffer InsertSql = new StringBuffer();
					 InsertSql.append( " INSERT INTO SALES.TCM350(                                                     \n" )
										.append( " EMPNO,     ATT_DT,  CUST_SID, VEND_CD,DEPT_CD,                                \n" )
										.append( " TEAM_CD,   WORK_CD, WORK_GB,  W_TIME, W2_TIME,                                \n" )
										.append( " W_TIME_TOT,W_REMARK,O_TIME,   O2_TIME,O_TIME_TOT,                             \n" )
										.append( " O_DTIME,   O_NTIME, O_REMARK, REMARK,                                         \n" )
										.append( " I_EMPNO,   I_DATE,  U_EMPNO,  U_DATE  )                                      \n" )
										.append( " SELECT A.EMPNO,  '"+strATT_DT+"' AS ATT_DT, A.CUST_SID, A.VEND_CD,  A.DEPT_CD,    \n" )
										.append( "        A.TEAM_CD, A.WORK_CD, '"+strWORK_GB+"' AS WORK_GB, '"+strW_TIME+"' AS W_TIME, '"+strW2_TIME+"' AS W2_TIME, \n")
										.append( "        0 W_TIME_TOT, ''W_REMARK, '"+strO_TIME+"' AS  O_TIME, '"+strO2_TIME+"' AS O2_TIME, 0 O_TIME_TOT,   \n")
						        .append( "        0 O_DTIME,   0 O_NTIME, ''O_REMARK, ''REMARK,                          \n" )
										.append( "        '"+strEmpno+"' , CURRENT TIMESTAMP,'"+strEmpno+"',CURRENT TIMESTAMP    \n" )
										.append( "   FROM SALES.TCM300 A                                                         \n" )
										.append( "  WHERE USESTS='1'                                                             \n" );
					 
					 GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); //로그남기는것
					 gsmt.setGauceDataRow(rows[j]);

         
            
						gsmt.executeUpdate();
						gsmt.close();


					}
					*/
						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/
            
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
											.append( " U_DATE=CURRENT TIMESTAMP \n")
											.append( " WHERE EMPNO=?						\n")
											.append( "   AND ATT_DT =?          \n");


						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
//						logger.dbg.println(this,UpdateSql.toString());//로그남기는것

						gsmt.setGauceDataRow(rows[j]);

						rows[j].setString(idx[19],strEmpno);
	
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
						gsmt.bindColumn(13, idx[19]);	
						gsmt.bindColumn(14, idx[0]);	
						gsmt.bindColumn(15, idx[1]);	
						gsmt.executeUpdate();					
						gsmt.close();									

						//DLSDFDSF
					}
					
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
