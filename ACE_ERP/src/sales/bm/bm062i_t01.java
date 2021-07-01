// * ��Ÿ���� : �̹� ���� (�Է�,����)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class bm062i_t01 extends HttpServlet{

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
													"CLIENT_NM",	"TEAM_NM",	"WORK_NO",	"CUST_NM",	"HAIR_SID",
													"HAIR_DATE",	"CUST_SID",	"CALC_YN",	"HAIR_FEE",	"I_EMPNO",
													"I_DATE",			"U_EMPNO",	"U_DATE"
													};

				int[] idx = new int[13]; //�÷������� �־��ش�.

		        for (int i=0; i<strArrCN.length; i++) idx[i] = userSet.indexOfColumn(strArrCN[i]);

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
					/******************************** **********************************************
					 * Insert ó��
					 *********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						StringBuffer InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO SALES.TCM120 (						\n" )
										 .append( "			HAIR_DATE, CUST_SID, CALC_YN,  	\n" )
										 .append( "			HAIR_FEE, I_EMPNO, I_DATE			\n" )
										 .append( "	) VALUES (												\n" )
										 .append( "	?,?,?,?,?,												\n" )
										 .append( "	CURRENT TIMESTAMP							\n" )
										 .append( "	)																" );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idx[5]); 
						gsmt.bindColumn(2,  idx[6]); 
						gsmt.bindColumn(3,  idx[7]); 
						gsmt.bindColumn(4,  idx[8]);
						gsmt.bindColumn(5,  idx[9]);
						//logger.dbg.println(this,InsertSql.toString());//�α׳���°�
						gsmt.executeUpdate();
						gsmt.close();

					}
					/******************************** **********************************************
					 * Update ó��
					 *********************************************************************************/
         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
						StringBuffer UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE SALES.TCM120																		\n" )
										 .append( "		 SET CALC_YN=?, U_EMPNO=?, U_DATE=CURRENT_TIMESTAMP	\n" )
										 .append( "	WHERE HAIR_SID=?																			" );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//logger.dbg.println(this,UpdateSql.toString());//�α׳���°�
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idx[7]); 
						gsmt.bindColumn(2,  idx[11]);
						gsmt.bindColumn(3,  idx[4]); 

						gsmt.executeUpdate();
						gsmt.close();
					}
					/******************************** **********************************************
					 * DELETE ó��
					 *********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

					}

				}
			}
			catch(Exception e){
				logger.err.println(this,e.getMessage());	
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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