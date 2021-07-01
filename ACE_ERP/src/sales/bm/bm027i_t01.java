//개인정보관리 : 휴가신청서 작성(입력,수정)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class bm027i_t01 extends HttpServlet{

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
													"T1CUST_SID",		"POSITIONS",		"CUST_NM",		"ORDER_DATE",		"DEPRT_SID",     
													"CUST_SID",			"REASON",			"REASON_NM",	"NS_PLAN",			"SN_PLAN",
													"VACA_DAYS",		"BIGO",				"NUMBERS",		"I_EMPNO",			"I_DATE",
													"U_EMPNO",			"U_DATE",			"CUST_SIDYN"//추가
														};

				int[] idx = new int[18]; //컬럼갯수를 넣어준다.

		        for (int i=0; i<strArrCN.length; i++) idx[i] = userSet.indexOfColumn(strArrCN[i]);

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
					// Insert 처리
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						StringBuffer InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO SALES.TCM060 (														\n" )
										 .append( "			CUST_SID, NS_PLAN, SN_PLAN, REASON, VACA_DAYS,		\n" )
										 .append( "			BIGO, NUMBERS, I_EMPNO, I_DATE									\n" )
										 .append( "	) VALUES (																				\n" )
										 .append( "	?,?,?,?,?,																				\n" )
										 .append( "	?,?,?,CURRENT TIMESTAMP														\n" )
										 .append( "	)																								" );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idx[5]);  //CUST_SID
						gsmt.bindColumn(2,  idx[8]);  //NS_PLAN
						gsmt.bindColumn(3,  idx[9]);  //SN_PLAN
						gsmt.bindColumn(4,  idx[6]);  //REASON
						gsmt.bindColumn(5,  idx[10]); //VACA_DAYS
						gsmt.bindColumn(6,  idx[11]); //BIGO
						gsmt.bindColumn(7,  idx[12]); //NUMBERS
						gsmt.bindColumn(8,  idx[13]); //I_EMPNO

						//logger.dbg.println(this,InsertSql.toString());//로그남기는것

						gsmt.executeUpdate();
						gsmt.close();

					}
					//Update 처리
         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
						StringBuffer UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE SALES.TCM060																			\n" )
										 .append( "		 SET NS_PLAN=?,SN_PLAN=?,REASON=?,VACA_DAYS=?,BIGO=?,		\n" )
										 .append( "		  	 NUMBERS=?,U_EMPNO=?,U_DATE=CURRENT TIMESTAMP			\n" )
										 .append( "	WHERE DEPRT_SID=?																				" );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

						//logger.dbg.println(this,UpdateSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idx[8]); //NS_PLAN
						gsmt.bindColumn(2,  idx[9]); //SN_PLAN
						gsmt.bindColumn(3,  idx[6]); //REASON
						gsmt.bindColumn(4,  idx[10]);//VACA_DAYS
						gsmt.bindColumn(5,  idx[11]);//BIGO
						gsmt.bindColumn(6,  idx[12]);//NUMBERS
						gsmt.bindColumn(7,  idx[15]);//U_EMPNO
						gsmt.bindColumn(8,  idx[4]); //DEPRT_SID

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