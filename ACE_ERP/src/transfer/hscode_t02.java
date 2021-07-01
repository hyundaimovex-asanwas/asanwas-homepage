package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class hscode_t02 extends HttpServlet{

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

				String[] strArrCN = new String[]{ "MAJOR_CD", "MINOR_CD", "MINOR_NM", "MINOR_LEN", "ETC_CD1",
																					"ETC_CD2", "ETC_CD3", "ETC_NO1", "ETC_NO2", "ETC_NO3",
																					"STS_CD", "WRITE_PS", "WRITE_DT", "UPDATE_PS", "UPDATE_DT",
																					"MLEN"
																				}; 
        int[] idx = new int[16];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql	= null;
				StringBuffer UpdateSql	= null;
				StringBuffer DeleteSql	= null;

				InsertSql		= new StringBuffer();
				
				InsertSql.append( " INSERT INTO TRANSFER.LTHSCODE \n" )
								 .append( " ( \n" )
								 .append( " MAJOR_CD, MINOR_CD, MINOR_NM, MINOR_LEN, ETC_CD1,  \n")
								 .append( " ETC_CD2, ETC_CD3, ETC_NO1, ETC_NO2, ETC_NO3,  \n")
								 .append( " STS_CD, WRITE_PS, WRITE_DT \n" )
								 .append( " ) \n" )
								 .append( "  VALUES \n" )
								 .append( " ( \n" )
								 .append( " ?,?,?,?,?, \n" )
								 .append( " ?,?,?,?,?, \n" )
								 .append( " ?,?,CURRENT TIMESTAMP \n" )
								 .append( " ) " );


				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for (int k=1;k<13;k++) gsmt.bindColumn(k, idx[k-1]);
						gsmt.executeUpdate(); 
						gsmt.close();

					}
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						UpdateSql		= new StringBuffer();
						UpdateSql.append( " UPDATE TRANSFER.LTHSCODE " )
										 .append( "    SET MINOR_NM = ?, " )
										 .append( "        MINOR_LEN = ?, " )
										 .append( "        ETC_CD1 = ?, " )
										 .append( "        ETC_CD2 = ?, " )	
										 .append( "        ETC_CD3 = ?, " )	
										 .append( "        ETC_NO1 = ?, " )
										 .append( "        ETC_NO2 = ?, " )
										 .append( "        ETC_NO3 = ?, " )
										 .append( "        STS_CD = ?, " )
										 .append( "        UPDATE_PS = ?, " )
										 .append( "        UPDATE_DT = CURRENT TIMESTAMP " )
										 .append( "  WHERE MAJOR_CD = ? \n" )
										 .append( "    AND MINOR_CD = ? " );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						for (int t=2;t<11;t++) gsmt.bindColumn(t-1, idx[t]);
						gsmt.bindColumn(10, idx[13]);
						gsmt.bindColumn(11, idx[10]);
						gsmt.bindColumn(12, idx[1]);
						gsmt.executeUpdate();
						gsmt.close();
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						String strInfodiv = rows[j].getString(idx[0]);	

						DeleteSql		= new StringBuffer();
						DeleteSql.append( " DELETE FROM TRANSFER.LTHSCODE " )
										 .append( "  WHERE MAJOR_CD = ? \n" )
										 .append( "    AND MINOR_CD = ? " );
						
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.executeUpdate();
					}

				}

			}

			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}