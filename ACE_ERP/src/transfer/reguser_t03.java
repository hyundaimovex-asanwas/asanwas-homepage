package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class reguser_t03 extends HttpServlet{

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

				GauceDataSet userSet = GauceReq.getGauceDataSet("USER");

				String[] strArrCN = new String[]{ "USERID","USERPW","USERNM","CDATE","VEND_CD",
																					"VEND_NM"
																				}; 
				int[] idx = new int[6];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql	= null;

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					}
	
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql		= new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.GCZM_VENDER	\n" )
										 .append( "    SET MPWD		= '" + rows[j].getString(1) + "' \n" )
										 .append( "  WHERE MSN		= UPPER('" + rows[j].getString(0) + "')  " );

						GauceStatement gstmt = gconn.getGauceStatement(UpdateSql.toString());
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