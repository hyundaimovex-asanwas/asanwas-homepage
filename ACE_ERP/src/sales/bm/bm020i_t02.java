//입출국 등록(북->남)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class bm020i_t02 extends HttpServlet{

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
				String str1 = reqGauce.getParameter("v_str1"); //guser_id

				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");

				String[] strArrCN = new String[]{
													"RSV_SID", "CHK"
													};

				int[] idx = new int[2]; //컬럼갯수를 넣어준다.

		        for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
//					logger.dbg.println(this, "i:::" +i+"::::"+idx[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
								UpdateSql = new StringBuffer();
								UpdateSql.append( " UPDATE SALES.TCM040																				\n" )
												.append( "		 SET NS_YN=?, U_EMPNO=" + str1 + ", U_DATE=CURRENT TIMESTAMP		\n" )
												.append( "	WHERE RSV_SID = ?																						" );
								//logger.dbg.println(this,UpdateSql.toString());//로그남기는것
								GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

								gsmt.setGauceDataRow(rows[j]);
								gsmt.bindColumn(1,  idx[1]); 
								gsmt.bindColumn(2,  idx[0]); 
								//logger.dbg.println(this,rows[j].getString(idx[0]));
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
