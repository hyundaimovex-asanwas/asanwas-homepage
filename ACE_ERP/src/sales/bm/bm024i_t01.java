// * ������������ : ü�������û (������Ʈ)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class bm024i_t01 extends HttpServlet{

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
			//logger.dbg.println(this,"1");
			try {
				conn = service.getDBConnection();
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
 
				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");
				
				String[] strArrCN = new String[]{
													"ARRIVE_DATE",		"ARRIVE_TIME",		"RSV_SID",	"LSTAY_DEL",		"U_EMPNO"
													};

				int[] idx = new int[5]; //�÷������� �־��ش�.
        
				for (int i=0; i<strArrCN.length; i++) idx[i] = userSet.indexOfColumn(strArrCN[i]);

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
					//	Update ó��
					if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						StringBuffer UpdateSql = new StringBuffer();

						UpdateSql.append( " UPDATE SALES.TRV020										\n" )
										 .append( "		 SET ARRIVE_DATE=?, ARRIVE_TIME=?		\n" )
										 .append( "	WHERE RSV_SID = ?											" );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//logger.dbg.println(this,UpdateSql.toString());//�α׳���°�
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idx[0]); 
						gsmt.bindColumn(2,  idx[1]);
						gsmt.bindColumn(3,  idx[2]);

						gsmt.executeUpdate();
						gsmt.close();

						StringBuffer UpdateSql2 = new StringBuffer();

						UpdateSql2.append( " UPDATE SALES.TCM040																			\n" )
										.append( "		 SET LSTAY_DEL='', U_EMPNO=?, U_DATE=CURRENT TIMESTAMP			\n" )
//										.append( "		 SET LSTAY_DEL=?, U_EMPNO=?, U_DATE=CURRENT TIMESTAMP	 		\n" )
										.append( "	WHERE RSV_SID = ?																				" );

						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						//logger.dbg.println(this,UpdateSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.bindColumn(1,  idx[3]);
						gsmt2.bindColumn(2,  idx[4]);
						gsmt2.bindColumn(3,  idx[2]);

						gsmt2.executeUpdate();
						gsmt2.close();

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