package purch.common;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class menu_btn_auth_tr extends HttpServlet{

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
				//logger.dbg.println(this, str1);
				String[] strArrCN = new String[]{	"PGM_IDX"	,	"BTN_AUTH"	};

				int[] idx = new int[2]; //컬럼갯수를 넣어준다.

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

					}
					/*********************************************************************************
					 * Update 처리
					 *********************************************************************************/
	         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						//logger.dbg.println(this, rows[j].getString(idx[1]));
						//logger.dbg.println(this, rows[j].getString(idx[0]));
						UpdateSql = new StringBuffer();

						UpdateSql.append( " UPDATE COMMON.MENU_AUTH				\n" )
										 .append( "	SET BTN_AUTH = ?						\n" )
										 .append( "	WHERE PGM_IDX = ?						\n" )
										 .append( "	AND USERID = '" + str1 + "'	 				" );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

						//logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idx[1]);
						gsmt.bindColumn(2,  idx[0]);

						gsmt.executeUpdate();
						gsmt.close();
					}

					/*********************************************************************************
					 * DELETE 처리
					 *********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

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
