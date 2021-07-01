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

public class Em021_T2 extends HttpServlet{

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
				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				String[] strArrCN = new String[]{ "STRGB","STR2","STR3","EMPNO","YYYYMM"  }; 
				int[] idx = new int[5];

        for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				for (int j = 0; j < rows.length; j++){
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/   
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						 if(rows[j].getString(idx[0]).equals("1")){
							 InsertSql = new StringBuffer();
							 InsertSql.append( " INSERT INTO SALES.TCM410								\n" )
												.append( " (YYYYMM,SKILL_CD,CON_YEAR,B_PAY,T_PAY, \n" )
												.append( "  I_EMPNO,U_EMPNO,I_DATE,U_DATE)				\n" )
												.append( " SELECT YYYYMM, SKILL_CD,'"+rows[j].getString(idx[2])+"', B_PAY, T_PAY,               \n" )
												.append( "        '"+rows[j].getString(idx[3])+"', '"+rows[j].getString(idx[3])+"', CURRENT TIMESTAMP, CURRENT TIMESTAMP \n" )           
												.append( "   FROM SALES.TCM410                    \n" )
												.append( "  WHERE YYYYMM = ?                      \n" )
												.append( "    AND CON_YEAR=?                      \n" );
						 
								GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
								gsmt.setGauceDataRow(rows[j]);

								gsmt.bindColumn(1, idx[4]);
								gsmt.bindColumn(2, idx[1]);

								gsmt.executeUpdate();
								gsmt.close();
						 }else if(rows[j].getString(idx[0]).equals("2")){
								InsertSql = new StringBuffer();
							  InsertSql.append( " INSERT INTO SALES.TCM410							\n" )
												 .append( " (YYYYMM,SKILL_CD,CON_YEAR,B_PAY,T_PAY, \n" )
												 .append( "  I_EMPNO,U_EMPNO,I_DATE,U_DATE)				\n" )
												 .append( " SELECT '"+rows[j].getString(idx[2])+"', SKILL_CD, CON_YEAR, B_PAY, T_PAY, \n" )
												 .append( "        '"+rows[j].getString(idx[3])+"', '"+rows[j].getString(idx[3])+"', CURRENT TIMESTAMP, CURRENT TIMESTAMP \n" )           
												 .append( "   FROM SALES.TCM410                    \n" )
												 .append( "  WHERE YYYYMM = ?                      \n" );
						 
								GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
								gsmt.setGauceDataRow(rows[j]);

								gsmt.bindColumn(1, idx[4]);

								gsmt.executeUpdate();
								gsmt.close();
						 }
					}

						/******************************************************************************
						* Update 처리
						*********************************************************************************/

         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
	
					}
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

	
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
