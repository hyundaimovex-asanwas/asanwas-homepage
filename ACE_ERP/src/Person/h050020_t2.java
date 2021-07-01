package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class h050020_t2 extends HttpServlet{

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

				GauceStatement gsmt=null;

				int intJTGB =0;   //재택구분
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 

				int idxAPPDT    = userSet.indexOfColumn("APPDT");	   // 급여년월
				int idxEMPNO    = userSet.indexOfColumn("EMPNO");	   // 급여년월
				int idxJTGB     = userSet.indexOfColumn("JTGB");	   // 재택구분
				int idxREMARK   = userSet.indexOfColumn("REMARK");	 // 비고
						
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer UpdateSql = null;
        
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {	
	
					}//if

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE PAYROLL.HLJTGB SET " );
						UpdateSql.append( " JTGB = ?, ");
						UpdateSql.append( " REMARK = ? ");
						UpdateSql.append( " WHERE APPDT = ? AND EMPNO = ?  " );

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxJTGB);
						gsmt.bindColumn(2, idxREMARK);
						gsmt.bindColumn(3, idxAPPDT);
						gsmt.bindColumn(4, idxEMPNO);
						
						gsmt.executeUpdate(); 
						gsmt.close();       						

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
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