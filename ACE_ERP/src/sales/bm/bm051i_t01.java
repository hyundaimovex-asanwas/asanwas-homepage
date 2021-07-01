// * 통신관리 : 전화번호 관리 (입력,수정)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class bm051i_t01 extends HttpServlet{

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
														"TEL_SID",		"TEL_NUM",		"CUST_SID",		"REC_PLAC",		"SN",
														"OP",				"BIGO",				"REGI_DATE",		"I_EMPNO",		"I_DATE",    
														"U_EMPNO",	"U_DATE",			"CUST_NM"
															};

				int[] idx = new int[13]; //컬럼갯수를 넣어준다.

		        for (int i=0; i<strArrCN.length; i++) idx[i] = userSet.indexOfColumn(strArrCN[i]);

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
					/******************************** **********************************************
					 * Insert 처리
					 *********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						StringBuffer InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO SALES.TCM070 (										\n" )
										 .append( "			TEL_NUM, CUST_SID , REC_PLAC, SN, OP,		\n" )
										 .append( "			BIGO   , REGI_DATE, I_EMPNO , I_DATE			\n" )
										 .append( "	) VALUES (																\n" )
										 .append( "	?,?,?,?,?,																\n" )
										 .append( "	?,?,?,CURRENT TIMESTAMP										\n" )
										 .append( "	)																				" );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idx[1]);  //TEL_NUM
						gsmt.bindColumn(2,  idx[2]);  //CUST_SID
						gsmt.bindColumn(3,  idx[3]);  //REC_PLAC
						gsmt.bindColumn(4,  idx[4]);  //SN
						gsmt.bindColumn(5,  idx[5]);  //OP
						gsmt.bindColumn(6,  idx[6]);  //BIGO
						gsmt.bindColumn(7,  idx[7]);  //REGI_DATE
						gsmt.bindColumn(8,  idx[8]);  //I_EMPNO
			           //logger.dbg.println(this,InsertSql.toString());//로그남기는것
						gsmt.executeUpdate();
						gsmt.close();

					}
					/******************************** **********************************************
					 * Update 처리
					 *********************************************************************************/
         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
						StringBuffer UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE SALES.TCM070															\n" )
										 .append( "		 SET CUST_SID=?, REC_PLAC=?, SN=?, OP=?, BIGO=?,	\n" )
										 .append( "		  	 U_EMPNO=?, U_DATE=CURRENT TIMESTAMP				\n" )
										 .append( "	WHERE TEL_NUM=? AND TEL_SID=?										" );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

						//logger.dbg.println(this,UpdateSql.toString());//로그남기는것

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idx[2]); //CUST_SID
						gsmt.bindColumn(2,  idx[3]); //REC_PLAC
						gsmt.bindColumn(3,  idx[4]); //SN
						gsmt.bindColumn(4,  idx[5]); //OP
						gsmt.bindColumn(5,  idx[6]); //BIGO
						gsmt.bindColumn(6,  idx[10]);//U_EMPNO
						gsmt.bindColumn(7,  idx[1]); //TEL_NUM
						gsmt.bindColumn(8,  idx[0]); //TEL_SID

						gsmt.executeUpdate();
						gsmt.close();
					}
					/******************************** **********************************************
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