package sales.common;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class menuauth_tr extends HttpServlet{

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

				String str1 = reqGauce.getParameter("v_str1");	//사번
				
				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");
				//logger.dbg.println(this,"step1");//로그남기는것
				
				String[] strArrCN = new String[]{	"PGM_IDX"		};

				int[] idx = new int[1]; //컬럼갯수를 넣어준다.

		        for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;

				for (int j = 0; j < rows.length; j++){
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/   
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO COMMON.MENU_AUTH (				\n" )
										 .append( "	PGM_IDX, BTN_AUTH, USERID, I_DATE			\n" )
										 .append( "	) VALUES (													\n" )
										 .append( "	     ?, 'S', "+str1+",CURRENT TIMESTAMP		\n" )
										 .append( "	)															" );

							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

							gsmt.setGauceDataRow(rows[j]);
							gsmt.bindColumn(1,  idx[0]);
							//logger.dbg.println(this,InsertSql.toString());
							gsmt.executeUpdate();
							gsmt.close();
					}
					/*********************************************************************************
					 * Update 처리
					 *********************************************************************************/
	         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

					}

					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						UpdateSql = new StringBuffer();

						UpdateSql.append( " DELETE FROM COMMON.MENU_AUTH	\n" )
										 .append( "	WHERE PGM_IDX = ?						\n" )
										 .append( "	AND USERID = '" + str1 + "'	 				" );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							
						//logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idx[0]);

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
