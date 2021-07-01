package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p030007_t3 extends HttpServlet{

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

				int idxYYYY			= userSet.indexOfColumn("YYYY");			//귀속년도
				int idxEMPNO		= userSet.indexOfColumn("EMPNO");			//사번
				int idxPAYCD		= userSet.indexOfColumn("PAYCD");			//정산항목코드
				int idxPAYAMT   = userSet.indexOfColumn("PAYAMT");		//제외금액

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.YCEXCEPT ( ");
				InsertSql.append( " YYYY,			EMPNO,		PAYCD,		PAYAMT ");
				InsertSql.append( ") VALUES( " );
				InsertSql.append( " ?, ?, ?, ? ) " );
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.YCEXCEPT SET ");
				UpdateSql.append( " PAYAMT = ? ");
				UpdateSql.append( " WHERE YYYY = ? AND EMPNO = ? AND PAYCD = ? ");

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.YCEXCEPT WHERE YYYY = ? AND EMPNO = ? AND PAYCD = ? ");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxYYYY);
						gsmt.bindColumn(2,  idxEMPNO);
						gsmt.bindColumn(3,  idxPAYCD);
						gsmt.bindColumn(4,  idxPAYAMT);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxPAYAMT);
						gsmt.bindColumn(2,  idxYYYY);
						gsmt.bindColumn(3,  idxEMPNO);
						gsmt.bindColumn(4,  idxPAYCD);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxYYYY);
						gsmt.bindColumn(2,  idxEMPNO);
						gsmt.bindColumn(3,  idxPAYCD);
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