package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00508_t01 extends HttpServlet{

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

				String[] strArrCN = new String[]{ "CHARGECODE", "EFF_DATE", "EXP_DATE", "LINE_PART", "CLASS"
																				, "SECTION", "CARGO", "LOGIS_TYPE", "LOGIS_UNIT", "UNIT_PRICE"
																				, "RQST_PRICE", "CANCEL1", "CANCEL1DAY", "CANCEL2", "CANCEL2DAY"
																				, "CANCEL3", "CANCEL3DAY", "CREATE_DT", "CREATE_USR", "UPDATE_DT"
																				, "UPDATE_USR"
																				};
				int[] idx = new int[21];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql	= null;
				StringBuffer UpdateSql	= null;
				StringBuffer DeleteSql	= null;

				InsertSql		= new StringBuffer();

				UpdateSql		= new StringBuffer();

				DeleteSql		= new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTCHARGE WHERE CHARGECODE = ? AND EFF_DATE = ? AND EXP_DATE = ? " );

				for (int j = 0; j < rows.length; j++){

					String parm[] = new String [21];
					for (int t=0; t<21 ; t++) parm[t] = rows[j].getString(t);

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						InsertSql.append( " INSERT INTO TRANSFER.LTCHARGE \n" )
										 .append( " ( " )
										 .append( "				CHARGECODE, EFF_DATE, EXP_DATE, LINE_PART, CLASS \n ")
										 .append(" 			, SECTION, CARGO, LOGIS_TYPE, LOGIS_UNIT, UNIT_PRICE \n ")
										 .append(" 			, RQST_PRICE, CANCEL1, CANCEL1DAY, CANCEL2, CANCEL2DAY \n ")
										 .append(" 			, CANCEL3, CANCEL3DAY, CREATE_DT, CREATE_USR, UPDATE_DT \n ")
										 .append(" 			, UPDATE_USR \n")
										 .append( " ) VALUES ( \n" )
										 .append( "  '" + parm[0] + "', '" + parm[1] + "', '" + parm[2] + "', '" + parm[3] + "', '" + parm[4] + "' \n ")
										 .append( " ,'" + parm[5] + "', '" + parm[6] + "', '" + parm[7] + "', '" + parm[8] + "', " + parm[9] + " \n ")
										 .append( " , " + parm[10] + " ,'" + parm[11] + "' ");

						if (parm[12].equals("")) InsertSql.append( " ,TIMESTAMP('9999-12-31','00.00.00') ");
						else InsertSql.append( " ,TIMESTAMP(substr('" + parm[12] + "',1,4)||'-'||substr('" + parm[12] + "',5,2)||'-'||substr('" + parm[12] + "',7,2),'00.00.00') ");
						
						InsertSql.append( " ,'" + parm[13] + "' \n ");

						if (parm[14].equals("")) InsertSql.append( " ,TIMESTAMP('9999-12-31','00.00.00') ");
						else InsertSql.append( " ,TIMESTAMP(substr('" + parm[14] + "',1,4)||'-'||substr('" + parm[14] + "',5,2)||'-'||substr('" + parm[14] + "',7,2),'00.00.00') ");

						InsertSql.append( " ,'" + parm[15] + "' \n ");

						if (parm[16].equals("")) InsertSql.append( " ,TIMESTAMP('9999-12-31','00.00.00') ");
						else InsertSql.append( " ,TIMESTAMP(substr('" + parm[16] + "',1,4)||'-'||substr('" + parm[16] + "',5,2)||'-'||substr('" + parm[16] + "',7,2),'00.00.00') ");

						InsertSql.append( " , CURRENT TIMESTAMP, '" + parm[18] + "', CURRENT TIMESTAMP \n ")
										 .append( " ,'" + parm[20] + "') ");

						GauceStatement gstmt = gconn.getGauceStatement(InsertSql.toString());
						gstmt.setGauceDataRow(rows[j]);

						gstmt.executeUpdate(); 
						gstmt.close();
					}
	
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						UpdateSql.append( " UPDATE TRANSFER.LTCHARGE	\n" )
										 .append( "    SET LINE_PART = '" + parm[3] + "', \n" )
										 .append( "    		 CLASS = '" + parm[4] + "', \n" )
										 .append( "    		 SECTION = '" + parm[5] + "', \n" )
										 .append( "    		 CARGO = '" + parm[6] + "', \n" )
										 .append( "    		 LOGIS_TYPE = '" + parm[7] + "', \n" )
										 .append( "    		 LOGIS_UNIT = '" + parm[8] + "', \n" )
										 .append( "    		 UNIT_PRICE = '" + parm[9] + "', \n" )
										 .append( "    		 RQST_PRICE = '" + parm[10] + "', \n" )
										 .append( "    		 CANCEL1 = '" + parm[11] + "', \n" )
										 .append( "    		 CANCEL2 = '" + parm[13] + "', \n" )
										 .append( "    		 CANCEL3 = '" + parm[15] + "', \n" );

						if (parm[12].equals("")) UpdateSql.append( " CANCEL1DAY = TIMESTAMP('9999-12-31','00.00.00'), ");
						else UpdateSql.append( " CANCEL1DAY = TIMESTAMP(substr('" + parm[12] + "',1,4)||'-'||substr('" + parm[12] + "',5,2)||'-'||substr('" + parm[12] + "',7,2),'00.00.00'), ");

						if (parm[14].equals("")) UpdateSql.append( " CANCEL2DAY = TIMESTAMP('9999-12-31','00.00.00'), ");
						else UpdateSql.append( " CANCEL2DAY = TIMESTAMP(substr('" + parm[14] + "',1,4)||'-'||substr('" + parm[14] + "',5,2)||'-'||substr('" + parm[14] + "',7,2),'00.00.00'), ");

						if (parm[16].equals("")) UpdateSql.append( " CANCEL3DAY = TIMESTAMP('9999-12-31','00.00.00') ");
						else UpdateSql.append( " CANCEL3DAY = TIMESTAMP(substr('" + parm[16] + "',1,4)||'-'||substr('" + parm[16] + "',5,2)||'-'||substr('" + parm[16] + "',7,2),'00.00.00'), ");

						UpdateSql.append( "    		 UPDATE_DT = CURRENT TIMESTAMP, \n" )
										 .append( "    		 UPDATE_USR = '" + parm[20] + "' \n" )
										 .append( "  WHERE CHARGECODE	= '" + parm[0] + "'  " )
										 .append( "    AND EFF_DATE	= '" + parm[1] + "'  " )
										 .append( "    AND EXP_DATE	= '" + parm[2] + "'  " );

						GauceStatement gstmt = gconn.getGauceStatement(UpdateSql.toString());
						gstmt.setGauceDataRow(rows[j]);
						gstmt.executeUpdate();
						gstmt.close();
	
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						
						GauceStatement gstmt = gconn.getGauceStatement(DeleteSql.toString());
						gstmt.setGauceDataRow(rows[j]);
						gstmt.bindColumn(1, idx[0]);
						gstmt.bindColumn(2, idx[1]);
						gstmt.bindColumn(3, idx[2]);
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