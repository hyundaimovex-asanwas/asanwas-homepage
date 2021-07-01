// * 기타관리 : 무전기(입력,수정)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class bm055i_t01 extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");

				String[] strArrCN = new String[]{
													"RT_SID",		"RT_SERIAL",		"RT_MODEL",		"CUST_SID",		"RT_DATE",      
													"USE_YN",		"I_EMPNO",		"I_DATE",			"U_EMPNO",		"U_DATE"
															};

				int[] idx = new int[10]; //컬럼갯수를 넣어준다.

		        for (int i=0; i<strArrCN.length; i++) idx[i] = userSet.indexOfColumn(strArrCN[i]);

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						StringBuffer InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO SALES.TCM100 (										\n" )
									 .append( "			RT_SERIAL, RT_MODEL, USE_YN, I_EMPNO			\n" )
									 .append( "	) VALUES (                                                                 \n" )
									 .append( "	?,?,'Y',?																		\n" )
									 .append( "	)																					" );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idx[1]);  //RT_SERIAL
						gsmt.bindColumn(2,  idx[2]);  //RT_MODEL
						gsmt.bindColumn(3,  idx[6]);  //I_EMPNO 
						//logger.dbg.println(this,InsertSql.toString());
						gsmt.executeUpdate();
						gsmt.close();

					}
					// Update 지급(처리)
	         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
						StringBuffer UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE SALES.TCM100							\n" )
										 .append( "		 SET RT_SERIAL=?							\n" )
										 .append( "		 , RT_MODEL=?								\n" )
										 .append( "		 , U_EMPNO=?								\n" )
										 .append( "		 , U_DATE=CURRENT TIMESTAMP	\n" )
										 .append( "	WHERE RT_SID=?									" );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//logger.dbg.println(this,UpdateSql.toString());//로그남기는것
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idx[2]);
						gsmt.bindColumn(2,  idx[3]);
						gsmt.bindColumn(3,  idx[8]);
						gsmt.bindColumn(4,  idx[0]);

						gsmt.executeUpdate();
						gsmt.close();
					}
					// DELETE 처리
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						StringBuffer UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE SALES.TCM100									\n" )
										 .append( "		 SET USE_YN='N'									\n" )
										 .append( "		 ,		CUST_SID=0									\n" )
										 .append( "		 , U_EMPNO=?										\n" )
										 .append( "		 , U_DATE=CURRENT TIMESTAMP			\n" )
										 .append( "	WHERE RT_SID=?											" );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//logger.dbg.println(this,UpdateSql.toString());//로그남기는것
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idx[8]);	//U_EMPNO
						gsmt.bindColumn(2,  idx[0]);	//RT_SID

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