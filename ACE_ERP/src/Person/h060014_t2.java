package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060014_t2 extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				GauceStatement gsmt=null;

	     // String strEvaym  = reqGauce.getParameter("v_str1");   //고과년월
			//	String strEmpnoh = reqGauce.getParameter("v_str2");   //고과자         


				int idxEVAYM       = userSet.indexOfColumn("EVAYM");  //고과년월
				int idxEMPNOH      = userSet.indexOfColumn("EMPNOH"); //고과자
				int idxEMPNO       = userSet.indexOfColumn("EMPNO");  //사용자   --보통 고과자랑 동일 하겠지

				logger.dbg.println(this,"Step1");

				GauceDataRow[] rows = userSet.getDataRows();
				StringBuffer UpdateSql = null;
				StringBuffer InsertSql = null;

				UpdateSql = new StringBuffer();
				UpdateSql.append( "  UPDATE PAYROLL.HVSCORES " );
				UpdateSql.append( "     SET EMPNOH = '9999999' " );
				UpdateSql.append( "        ,EVASEQ = EVASEQ+45 " );		                            
				UpdateSql.append( "   WHERE  EVAYM = ?  " );
				UpdateSql.append( "     AND  EMPNOH = ?  " );

				InsertSql = new StringBuffer();
				InsertSql.append( "  INSERT INTO PAYROLL.HVCLOSE ( EVAYM, EMPNOH, SUBMITST, WRDT, WRID ) " );
				InsertSql.append( "  VALUES ( ?, ? ,'C', CURRENT TIMESTAMP,? ) " );
			
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						logger.dbg.println(this,"Step2");
            //UPDATE
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEVAYM);
						gsmt.bindColumn(2, idxEMPNOH);
						gsmt.executeUpdate();
						gsmt.close();
						logger.dbg.println(this,"Step3");
            gsmt=null;

						logger.dbg.println(this,"Step4");

            //INSERT 
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEVAYM);
						gsmt.bindColumn(2, idxEMPNOH);
						gsmt.bindColumn(3, idxEMPNO);
						gsmt.executeUpdate();
						gsmt.close();

						logger.dbg.println(this,"Step5");

					}//if
				}//for
			}//try
			catch(Exception e){
				logger.dbg.println(this,"7r"); 
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}//catch
         conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}//try
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}//catch
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}//finally
	}//public
}//public