package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00512_t1 extends HttpServlet{

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

				GauceDataSet userSet = GauceReq.getGauceDataSet("DATA");

				String gstr1 = GauceReq.getParameter("v_str1");

				String[] strArrCN = new String[]{ "CAR_TYPE","CAR_NAME","CAR_LENGTH","CAR_WIDTH","CAR_HEIGHT",
																					"CAR_CBM","CAR_TON","CAR_CLASS","CREATE_DT","CREATE_USR",
																					"UPDATE_DT","UPDATE_USR" 
																				}; 

				int[] idx = new int[12];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql	= null;
				StringBuffer UpdateSql	= null;
				StringBuffer DeleteSql	= null;

				InsertSql		= new StringBuffer();
				InsertSql.append( " INSERT INTO TRANSFER.LTCARTYPE \n" )
								 .append( " ( " )
								 .append( "		CAR_TYPE, CAR_NAME, CAR_LENGTH, CAR_WIDTH, CAR_HEIGHT, \n")
								 .append( "		CAR_CBM, CAR_TON, CAR_CLASS, CREATE_DT, CREATE_USR, \n")
								 .append( "		UPDATE_DT, UPDATE_USR \n")
								 .append( " ) VALUES ( \n" )
								 .append( " ?, ?, ?, ?, ?, \n")
								 .append( " ?, ?, ?, CURRENT TIMESTAMP, '" + gstr1 + "', \n")
								 .append( " CURRENT TIMESTAMP, '" + gstr1 + "' ) ");

				UpdateSql		= new StringBuffer();
				UpdateSql.append( " UPDATE TRANSFER.LTCARTYPE	\n" )
								 .append( "    SET CAR_NAME			= ?, \n" )
								 .append( "				 CAR_LENGTH		= ?, \n" )
								 .append( "				 CAR_WIDTH		= ?, \n" )
								 .append( "				 CAR_HEIGHT		= ?, \n" )
								 .append( "				 CAR_CBM			= ?, \n" )
								 .append( "				 CAR_TON			= ?, \n" )
								 .append( "				 CAR_CLASS		= ?, \n" )
								 .append( "				 UPDATE_DT		= CURRENT TIMESTAMP, \n" )
								 .append( "				 UPDATE_USR		= '" + gstr1 + "' \n" )
								 .append( "  WHERE CAR_TYPE			= ?  " );

				DeleteSql		= new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTCARTYPE WHERE CAR_TYPE = ? " );

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gstmt = gconn.getGauceStatement(InsertSql.toString());
						gstmt.setGauceDataRow(rows[j]);
						for (int k=1; k<9; k++) gstmt.bindColumn(k, idx[k-1]);
						gstmt.executeUpdate(); 
						gstmt.close();
					}
	
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						GauceStatement gstmt = gconn.getGauceStatement(UpdateSql.toString());
						gstmt.setGauceDataRow(rows[j]);
						for (int k=1; k<8; k++) gstmt.bindColumn(k, idx[k]);
						gstmt.bindColumn(8, idx[0]);
						gstmt.executeUpdate();
						gstmt.close();
	
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						GauceStatement gstmt = gconn.getGauceStatement(DeleteSql.toString());
						gstmt.setGauceDataRow(rows[j]);
						gstmt.bindColumn(1, idx[0]);
						gstmt.executeUpdate();
						gstmt.close();
	
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