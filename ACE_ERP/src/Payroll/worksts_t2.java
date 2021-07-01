package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class worksts_t2 extends HttpServlet{

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

				String str1 = req.getParameter("v_str1");		//적용년월
				String str2 = req.getParameter("v_str2");		//지급구분
				String str3 = req.getParameter("v_str3");		//

				String str4 = "";


				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPDT 	= userSet.indexOfColumn("APPDT");
				int idxPAYDIV	= userSet.indexOfColumn("PAYDIV");
				int idxPAYCD	= userSet.indexOfColumn("PAYCD");
				int idxWRKSTS	= userSet.indexOfColumn("WRKSTS");

				if(str3.equals("Y103001S")){
					str3="Y10300";
					str4="Y10400";
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
			

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.PCWRKPAY SET " );
				UpdateSql.append( " WRKSTS = 'C' "	);
				UpdateSql.append( " WHERE APPDT = '"+str1+"' AND PAYDIV = '"+str2+"' " );

				if(str3.equals("Y10300")){
          UpdateSql.append( "   AND (PAYCD LIKE '"+str3+"%' OR PAYCD LIKE '"+str4+"%') ");
				}else{
					UpdateSql.append( "   AND PAYCD LIKE '"+str3+"%' ");
				}

				//logger.dbg.println(this, UpdateSql.toString());

				DeleteSql = new StringBuffer();


				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();
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