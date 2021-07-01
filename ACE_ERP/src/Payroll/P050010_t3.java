package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class P050010_t3 extends HttpServlet{

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
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();


				String str1 = reqGauce.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxSETTDT      = userSet.indexOfColumn("SETTDT");
	
	

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.PWCARDUP SET " );
				UpdateSql.append( " CLOSEYN = 'C', " );
				UpdateSql.append( " U_DATE = CURRENT TIMESTAMP, " );
				UpdateSql.append( " U_EMPNO = '"+str1+"' " );
				UpdateSql.append( " WHERE SETTDT =? " );



				for (int j = 0; j < 1; j++){

						if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxSETTDT);		
						gsmt.executeUpdate(); 
						gsmt.close();        
					}    									
				}				
			}
			catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
      
			conn.commit();
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