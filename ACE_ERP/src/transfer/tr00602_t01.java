package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00602_t01 extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection gconn = null;
		Connection conn = null;

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
				String gstr2 = GauceReq.getParameter("v_str2");

				if (gstr1 == null) gstr1 = "";
				if (gstr2 == null) gstr2 = "";

				String[] strArrCN = new String[]{ "MAIGBN",  "MAIYMD", "MAISEQ", "MAIREP", "MAITIME", 
												  "MAISMAN", "MAISUBJ", "MAIDESC", "MAIFILES", "MAIFNAME",
												  "MAIFILE", "REGNM", "MAIFLAG"
												}; 
				int[] idx = new int[13];
				for (int i=0; i<strArrCN.length; i++) {
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql	= null;
				StringBuffer UpdateSql	= null;
				StringBuffer DeleteSql	= null;

				Statement stmt = gconn.createStatement();
				
				String sql = " SELECT NVL(MAX(MAISEQ)+1,0) FROM TRANSFER.LTNOTICE " 
					       + "  WHERE MAIGBN = '" + gstr1 + "' " 
						   + "    AND MAIYMD = '" + gstr2 + "'";

				ResultSet rs = stmt.executeQuery(sql);

				int gseq = 0;
				while (rs.next()){
					gseq = rs.getInt(1); 
				}					

				InsertSql		= new StringBuffer();
				InsertSql.append( " INSERT INTO TRANSFER.LTNOTICE \n" )
						 .append( " ( " )
						 .append( "		MAIGBN, MAIYMD, MAISEQ, MAIREP, MAITIME, \n")
						 .append( "		MAISMAN, MAISUBJ, MAIDESC, MAIFILES, MAIFNAME, \n")
						 .append( "		REGDATE, MAIFLAG \n")
						 .append( " ) VALUES ( \n" )
						 .append( " '" + gstr1 + "' , '" + gstr2 + "', " + gseq + ", 0, ?, \n")
						 .append( " ?, ?, ?, ?, ?, \n")
						 .append( " CURRENT_TIMESTAMP, ? ) ");

				UpdateSql		= new StringBuffer();
				UpdateSql.append( " UPDATE TRANSFER.LTNOTICE	\n" )
						 .append( "    SET MAIFLAG = ? \n" )
				         .append( "  WHERE MAIGBN = ? " )
				         .append( "    AND MAIYMD = ? " )
				         .append( "    AND MAISEQ = ? " )
				         .append( "    AND MAIREP = ? " );

				DeleteSql		= new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTNOTICE \n ")
				         .append( "  WHERE MAIGBN = ? " )
				         .append( "    AND MAIYMD = ? " )
				         .append( "    AND MAISEQ = ? " )
				         .append( "    AND MAIREP = ? " );

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gstmt = gconn.getGauceStatement(InsertSql.toString());
						gstmt.setGauceDataRow(rows[j]);

						int g = 1;
						for (int k=4; k<10; k++) {
							gstmt.bindColumn(g, idx[k]);
							g++;
						}
							gstmt.bindColumn(7, idx[12]);

						gstmt.executeUpdate(); 
						gstmt.close();
					}
	
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						GauceStatement gstmt = gconn.getGauceStatement(UpdateSql.toString());
						gstmt.setGauceDataRow(rows[j]);
						gstmt.bindColumn(1, idx[12]);
						gstmt.bindColumn(2, idx[0]);
						gstmt.bindColumn(3, idx[1]);
						gstmt.bindColumn(4, idx[2]);
						gstmt.bindColumn(5, idx[3]);
						gstmt.executeUpdate();
						gstmt.close();
	
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						
						GauceStatement gstmt = gconn.getGauceStatement(DeleteSql.toString());
						gstmt.setGauceDataRow(rows[j]);
						gstmt.bindColumn(1, idx[0]);
						gstmt.bindColumn(2, idx[1]);
						gstmt.bindColumn(3, idx[2]);
						gstmt.bindColumn(4, idx[3]);
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