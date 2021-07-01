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

public class Em021_T extends HttpServlet{

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
				String useid = reqGauce.getParameter("v_str1");
				
				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				String[] strArrCN = new String[]{ "YYYYMM","SKILL_CD","CON_YEAR","B_PAY","T_PAY",
                                          "I_EMPNO","U_EMPNO","I_DATE","U_DATE"
																			   }; 
				int[] idx = new int[9];

        for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/   

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
							rows[j].setString(idx[5],useid);
							rows[j].setString(idx[6],useid);

						 InsertSql = new StringBuffer();
		         InsertSql.append( " INSERT INTO SALES.TCM410								 \n" )
											.append( " (YYYYMM,SKILL_CD,CON_YEAR,B_PAY,T_PAY,  \n" )
											.append( " I_EMPNO,U_EMPNO,I_DATE,U_DATE)					 \n" )
											.append( " VALUES                                  \n" )
											.append( " (?,?,?,?,?,                             \n" )
											.append( " ?,?,CURRENT TIMESTAMP,CURRENT TIMESTAMP)\n" );
					 
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idx[0]);
							gsmt.bindColumn(2, idx[1]);
							gsmt.bindColumn(3, idx[2]);
							gsmt.bindColumn(4, idx[3]);
							gsmt.bindColumn(5, idx[4]);
							gsmt.bindColumn(6, idx[5]);
							gsmt.bindColumn(7, idx[6]);

  						gsmt.executeUpdate();
						  gsmt.close();
					}

						/******************************************************************************
						* Update 처리
						*********************************************************************************/

         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
	
						rows[j].setString(idx[6],useid);
						 UpdateSql = new StringBuffer();
						 UpdateSql.append( " UPDATE SALES.TCM410	\n")
											.append( " SET									\n")
											.append( " B_PAY=?,             \n")
											.append( " T_PAY=?,             \n")
											.append( " U_EMPNO=?,           \n")
											.append( " U_DATE= CURRENT TIMESTAMP  \n")
											.append( " WHERE YYYYMM = ?     \n")
											.append( " AND SKILL_CD = ?     \n")
											.append( " AND CON_YEAR=?       \n");

											GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
											gsmt.setGauceDataRow(rows[j]);
											
											gsmt.bindColumn(1,  idx[3]);
											gsmt.bindColumn(2,  idx[4]);
											gsmt.bindColumn(3,  idx[6]);
											gsmt.bindColumn(4,  idx[0]);
											gsmt.bindColumn(5,  idx[1]);
											gsmt.bindColumn(6,  idx[2]);
																							
											gsmt.executeUpdate();
											gsmt.close();

					}
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE  FROM SALES.TCM410		\n")
										 .append( "	WHERE YYYYMM=?							\n")
										 .append( " AND SKILL_CD = ?            \n")
										 .append( " AND CON_YEAR=?       \n");
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);

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
