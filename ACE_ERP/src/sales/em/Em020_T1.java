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

public class Em020_T1 extends HttpServlet{

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
				
				String[] strArrCN = new String[]{ "EMPNO","PAY_DIV","PB_DIV","PAY_CD","CUST_SID",
                                          "EX_PAY","EX_FRDT","EX_TODT","I_EMPNO","U_EMPNO",
                                          "I_DATE","U_DATE","ORG_PB_DIV","ORG_PAY_CD"
																				}; //12

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

						rows[j].setString(idx[8],useid);
						rows[j].setString(idx[9],useid);

						StringBuffer InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO SALES.TCM420               \n" )//PAY_DIV,급여지급구분
										.append( "(EMPNO,PAY_DIV,PB_DIV,PAY_CD,CUST_SID, \n" )
										.append( "EX_PAY,EX_FRDT,EX_TODT,I_EMPNO,U_EMPNO,\n" )
										.append( "I_DATE,U_DATE)                         \n" )
										.append( "	VALUES                               \n" )
										.append( "	(?,'1',?,?,?,                        \n" )
										.append( "   ?,?,?,?,?,                          \n" )
										.append( "	CURRENT TIMESTAMP,CURRENT TIMESTAMP) \n" );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());//로그남기는것
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[2]);
						gsmt.bindColumn(3, idx[3]);
						gsmt.bindColumn(4, idx[4]);
						gsmt.bindColumn(5, idx[5]);
						gsmt.bindColumn(6, idx[6]);
						gsmt.bindColumn(7, idx[7]);
						gsmt.bindColumn(8, idx[8]);
						gsmt.bindColumn(9, idx[9]);

						gsmt.executeUpdate();
						gsmt.close();
					}
						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/

         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

	          rows[j].setString(idx[9],useid);
						StringBuffer UpdateSql = new StringBuffer();
					  UpdateSql.append( " UPDATE SALES.TCM420   \n")
											.append( " SET                  \n")
							        .append( " PB_DIV=?,PAY_CD=?,   \n")
											.append( " EX_PAY=?,EX_FRDT=?,EX_TODT=?,U_EMPNO=?,U_DATE=CURRENT TIMESTAMP \n")
											.append( " WHERE EMPNO=?                                                   \n")
											.append( " AND PAY_DIV=?                                                   \n")
											.append( " AND PB_DIV=?                                                    \n")
											.append( " AND PAY_CD=?                                                    \n");
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

            gsmt.bindColumn(1, idx[2]);
						gsmt.bindColumn(2, idx[3]);
						gsmt.bindColumn(3, idx[5]);
						gsmt.bindColumn(4, idx[6]);
						gsmt.bindColumn(5, idx[7]);
						gsmt.bindColumn(6, idx[9]);
						gsmt.bindColumn(7, idx[0]);
						gsmt.bindColumn(8, idx[1]);
						gsmt.bindColumn(9, idx[12]);
						gsmt.bindColumn(10, idx[13]);
																		
						gsmt.executeUpdate();
						gsmt.close();
					}
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

						StringBuffer DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE  FROM SALES.TCM420		\n")
										 .append( "	WHERE EMPNO=?								\n")
                     .append( " AND PAY_DIV=?               \n")
                     .append( " AND PB_DIV=?                \n")
                     .append( " AND PAY_CD=?                \n");
	
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);
						gsmt.bindColumn(4, idx[3]);

						gsmt.executeUpdate();
						gsmt.close();

					}

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
