package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060005_t2 extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				int idxEVAYM	= userSet.indexOfColumn("EVAYM");
				int idxEMPNO	= userSet.indexOfColumn("EMPNO");
				int idxGRADE	= userSet.indexOfColumn("GRADE");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.HVEMP SET " );
				UpdateSql.append( " GRADE = ?, " );
				UpdateSql.append( " GRADE2 = ?, " );
				UpdateSql.append( " GRADE3 = ? " );
				UpdateSql.append( " WHERE EVAYM = ? and EMPNO = ?" );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxGRADE);
						gsmt.bindColumn(2, idxGRADE);
						gsmt.bindColumn(3, idxGRADE);
						gsmt.bindColumn(4, idxEVAYM);
						gsmt.bindColumn(5, idxEMPNO);
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