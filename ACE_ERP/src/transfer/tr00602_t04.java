package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class tr00602_t04 extends HttpServlet{

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

				String[] strArrCN = new String[]{ "MAIGBN", "MAIYMD", "MAISEQ", "MAIREP", "MAITIME", 
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

				UpdateSql		= new StringBuffer();
				UpdateSql.append( " UPDATE TRANSFER.LTNOTICE	\n" )
						 .append( "    SET USERPW			= ? \n" )
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

				Statement stmt = null;
				String sql = "";
				ResultSet rs = null;
				int gseq = 0;
				int gbf = 0;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						gbf = 0;
						gbf = rows[j].getInt(idx[2]);

						stmt = gconn.createStatement();
						
						sql = " SELECT NVL(MAX(MAIREP)+1,0) FROM TRANSFER.LTNOTICE " +
							  "  WHERE MAIGBN = '" + gstr1 + "' " +
							  "    AND MAIYMD = '" + gstr2 + "'" +
							  "    AND MAISEQ = '" + gbf + "'";

						rs = stmt.executeQuery(sql);

						gseq = 0;
						while (rs.next()){
							gseq = rs.getInt(1); 
						}					

						InsertSql		= new StringBuffer();
						InsertSql.append( " INSERT INTO TRANSFER.LTNOTICE \n" )
										 .append( " ( " )
										 .append( "		MAIGBN, MAIYMD, MAISEQ, MAIREP, MAITIME, \n")
										 .append( "		MAISMAN, MAISUBJ, MAIDESC, MAIFILES, MAIFNAME, \n")
										 .append( "		MAIFILE, REGDATE, MAIFLAG \n")
										 .append( " ) VALUES ( \n" )
										 .append( " '" + gstr1 + "' , '" + gstr2 + "', " + gbf + ", " + gseq + ", ?, \n")
										 .append( " ?, ?, ?, ?, ?, \n")
										 .append( " ?, CURRENT_TIMESTAMP, ? ) ");

						GauceStatement gstmt = gconn.getGauceStatement(InsertSql.toString());
						gstmt.setGauceDataRow(rows[j]);

						int g = 1;
						for (int k=4; k<10; k++) {
							gstmt.bindColumn(g, idx[k]);
							g++;
						}

						gstmt.bindColumn(8, idx[12]);

						InputStream nst_file = (InputStream) rows[j].getInputStream(idx[10]);

						gstmt.setBinaryStream(7, nst_file, nst_file.available());	 //첨부파일

						gstmt.executeUpdate(); 
						gstmt.close();
					}
	
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						GauceStatement gstmt = gconn.getGauceStatement(UpdateSql.toString());
						gstmt.setGauceDataRow(rows[j]);
						gstmt.bindColumn(1, idx[0]);
						gstmt.bindColumn(2, idx[1]);
						gstmt.bindColumn(3, idx[2]);
						gstmt.bindColumn(4, idx[3]);
//						gstmt.executeUpdate();
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