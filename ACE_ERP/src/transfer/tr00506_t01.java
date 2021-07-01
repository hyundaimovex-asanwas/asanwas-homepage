package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00506_t01 extends HttpServlet{

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

				String[] strArrCN = new String[]{ "CAR_NO","PERSON_NO","CARTYPENO","CAR_YEAR","COMPANY",
																					"LEAD_CLASS","LEADCHARGE","REMARK","CREATE_DT","CREATE_USR",
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
				InsertSql.append( " INSERT INTO TRANSFER.LTCARINFO \n" )
								 .append( " ( " )
								 .append( "		CAR_NO, PERSON_NO, CARTYPENO, CAR_YEAR, COMPANY, \n")
								 .append( "		LEAD_CLASS, LEADCHARGE, REMARK, CREATE_DT, CREATE_USR, \n")
								 .append( "		UPDATE_DT, UPDATE_USR \n")
								 .append( " ) VALUES ( \n" )
								 .append( " ?, ?, ?, ?, ?, \n")
								 .append( " ?, ?, ?, CURRENT TIMESTAMP, ?, \n")
								 .append( " CURRENT TIMESTAMP, ? ) ");

				UpdateSql		= new StringBuffer();
				UpdateSql.append( " UPDATE TRANSFER.LTCARINFO	\n" )
								 .append( "    SET PERSON_NO		= ?, \n" )
								 .append( "				 CARTYPENO		= ?, \n" )
								 .append( "				 CAR_YEAR			= ?, \n" )
								 .append( "				 COMPANY			= ?, \n" )
								 .append( "				 LEAD_CLASS		= ?, \n" )
								 .append( "				 LEADCHARGE		= ?, \n" )
								 .append( "				 REMARK				= ?, \n" )
								 .append( "				 UPDATE_DT		= CURRENT TIMESTAMP, \n" )
								 .append( "				 UPDATE_USR		= ? \n" )
								 .append( "  WHERE CAR_NO				= ?  " );

				DeleteSql		= new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTCARINFO WHERE CAR_NO = ? " );

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gstmt = gconn.getGauceStatement(InsertSql.toString());
						gstmt.setGauceDataRow(rows[j]);
						for (int k=1; k<9; k++) gstmt.bindColumn(k, idx[k-1]);
						gstmt.bindColumn(9, idx[9]);
						gstmt.bindColumn(10, idx[11]);
						gstmt.executeUpdate(); 
						gstmt.close();
					}
	
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						GauceStatement gstmt = gconn.getGauceStatement(UpdateSql.toString());
						gstmt.setGauceDataRow(rows[j]);
						for (int k=1; k<8; k++) gstmt.bindColumn(k, idx[k]);
						gstmt.bindColumn(8, idx[11]);
						gstmt.bindColumn(9, idx[0]);
						gstmt.executeUpdate();
						gstmt.close();
	
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						
						GauceStatement gstmt = gconn.getGauceStatement(DeleteSql.toString());
						gstmt.setGauceDataRow(rows[j]);
						gstmt.bindColumn(1, idx[0]);
						gstmt.executeUpdate();
	
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