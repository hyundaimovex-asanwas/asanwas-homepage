package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00513_t1 extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection gconn = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest GauceReq = null;
	 		GauceResponse GauceRes = null;

			try {
				gconn = service.getDBConnection();

				GauceReq = service.getGauceRequest();
				GauceRes = service.getGauceResponse();

				String gstr1 = GauceReq.getParameter("v_str1");

				GauceDataSet userSet = GauceReq.getGauceDataSet("DATA");

				String[] strArrCN = new String[]{ "LINE_PART", "CAL_DT", "WEEK_DAY", "HOLY_DIV", "APP_DT1",		
																					"APP_DT2", "APP_DT3", "HOLY_TYPE", "CAL_REM", "CREATE_DT", 
																			    "CREATE_USR", "UPDATE_DT","UPDATE_USR"
																	};

				int[] idx = new int[13];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql	= null;

				UpdateSql		= new StringBuffer();
				UpdateSql.append( " UPDATE TRANSFER.LTCALENDAR	\n" )
								 .append( "    SET HOLY_DIV			= ?, \n" )
								 .append( "				 APP_DT1			= ?, \n" )
								 .append( "				 APP_DT2			= ?, \n" )
								 .append( "				 APP_DT3			= ?, \n" )
								 .append( "				 HOLY_TYPE		= ?, \n" )
								 .append( "				 CAL_REM			= ?, \n" )
								 .append( "				 UPDATE_DT		= CURRENT TIMESTAMP, \n" )
								 .append( "				 UPDATE_USR		= '" + gstr1 + "' \n" )
								 .append( "  WHERE LINE_PART			= ?  " )
								 .append( "		 AND CAL_DT = ? ");

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					}
	
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						GauceStatement gstmt = gconn.getGauceStatement(UpdateSql.toString());
						gstmt.setGauceDataRow(rows[j]);
						gstmt.bindColumn(1, idx[3]);
						gstmt.bindColumn(2, idx[4]);
						gstmt.bindColumn(3, idx[5]);
						gstmt.bindColumn(4, idx[6]);
						gstmt.bindColumn(5, idx[7]);
						gstmt.bindColumn(6, idx[8]);
						gstmt.bindColumn(7, idx[0]);
						gstmt.bindColumn(8, idx[1]);

						gstmt.executeUpdate();
						gstmt.close();
	
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

					}
				}
			}

			catch(Exception e){
				GauceRes.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}


			GauceRes.flush();
			GauceRes.commit();
			GauceRes.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (gconn != null) {	try {	gconn.close();	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}