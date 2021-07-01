package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class reguser_t02 extends HttpServlet{

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

				String[] strArrCN = new String[]{ "VEND_CD","VEND_NM","PROJECT_CD","VEND_PRS","VEND_PST",
																					"VEND_TEL","VEND_CPHN","VEND_FAX","VEND_EMAIL","VEND_ADD1",
																					"VEND_ADD2","VEND_ADD3","REMARK","CREATE_DT","CREATE_USR",
																					"UPDATE_DT","UPDATE_UST"
																				}; 
				int[] idx = new int[17];
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
						UpdateSql.append( " UPDATE TRANSFER.LTCUSTMST	\n" )
										 .append( "    SET PROJECT_CD		= '" + rows[j].getString(2) + "', \n" )
										 .append( "				 VEND_PRS			= '" + rows[j].getString(3) + "', \n" )
										 .append( "				 VEND_PST			= '" + rows[j].getString(4) + "', \n" )
										 .append( "				 VEND_TEL			= '" + rows[j].getString(5) + "', \n" )
										 .append( "				 VEND_CPHN		= '" + rows[j].getString(6) + "', \n" )
										 .append( "				 VEND_FAX			= '" + rows[j].getString(7) + "', \n" )
										 .append( "				 VEND_EMAIL		= '" + rows[j].getString(8) + "', \n" )
										 .append( "				 VEND_ADD1		= '" + rows[j].getString(9) + "', \n" )
										 .append( "				 VEND_ADD2		= '" + rows[j].getString(10) + "', \n" )
										 .append( "				 VEND_ADD3		= '" + rows[j].getString(11) + "', \n" )
										 .append( "				 REMARK				=	'" + rows[j].getString(12) + "', \n" )
										 .append( "				 UPDATE_DT		=	CURRENT TIMESTAMP, \n" )
										 .append( "				 UPDATE_UST		=	'" + gstr1 +"' \n" )
										 .append( "  WHERE VEND_CD			= UPPER('" + rows[j].getString(0) + "')  " );

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