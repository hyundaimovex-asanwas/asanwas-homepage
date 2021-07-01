package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050018_t17 extends HttpServlet{

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

				String str1 = req.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxEMPNO	= userSet.indexOfColumn("EMPNO");		//사번 1
				int idxEXE		= userSet.indexOfColumn("EXE");				//임직원구분

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.PWCOLOAN SET										\n");
				UpdateSql.append( " EXE= ?																			\n");
				UpdateSql.append( " WHERE EMPNO = ? 															\n");

				for (int j = 0; j < rows.length; j++){
						
						if(rows[j].getJobType() != GauceDataRow.TB_JOB_UPDATE) {
							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idxEXE);
							gsmt.bindColumn(2, idxEMPNO);

							gsmt.executeUpdate(); 
							gsmt.close();         

							logger.dbg.println(this,UpdateSql.toString());

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