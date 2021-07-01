package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class bm056i_t01 extends HttpServlet{

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

				String  str1	= reqGauce.getParameter("v_str1");
				if (str1==null || str1=="") str1 = "";

				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");

				String[] strArrCN = new String[]{ 
					                                "TH_SID", "SN_GU", "TH_UNIT", "TH_DATE"
														};

				int[] idx = new int[4]; //컬럼갯수를 넣어준다.

              for (int i=0; i<strArrCN.length; i++){	idx[i] = userSet.indexOfColumn(strArrCN[i]);	}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
					/******************************** **********************************************
					 * Insert 처리
					 ******************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						StringBuffer InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO SALES.TCM210 (											\n" )
										 .append( "			SN_GU, TH_UNIT, TH_DATE, I_EMPNO, I_DATE		\n" )
										 .append( "	) VALUES (																	\n" )
										 .append( "	?, ?, ?, '" + str1 + "', CURRENT TIMESTAMP					\n" )
										 .append( "	)																					" );
						//logger.dbg.println(this, rows[j].getString(idx[1]));
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						//logger.dbg.println(this,InsertSql.toString());//로그남기는것
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idx[1]);
						gsmt.bindColumn(2,  idx[2]);
						gsmt.bindColumn(3,  idx[3]);

						gsmt.executeUpdate();
						gsmt.close();

					}

         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						StringBuffer UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE SALES.TCM210									\n" )
										 .append( "		 SET SN_GU=?										\n" )
										 .append( "		    , TH_UNIT=?										\n" )
										 .append( "			, TH_DATE=?										\n" )
										 .append( "			, U_EMPNO='" + str1 + "'						\n" )
										 .append( "			, U_DATE = CURRENT TIMESTAMP		\n" )
										 .append( "	WHERE TH_SID=?											" );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

						//logger.dbg.println(this,UpdateSql.toString());//로그남기는것
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idx[1]); 
						gsmt.bindColumn(2,  idx[2]); 
						gsmt.bindColumn(3,  idx[3]); 
						gsmt.bindColumn(4,  idx[0]); 

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