package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p031004_t3 extends HttpServlet{

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

				String strYyyy="";
     
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPYY    = userSet.indexOfColumn("APPYY");   //귀속년도       
				int idxEMPNO    = userSet.indexOfColumn("EMPNO");   //귀속년도       

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer SelectSql = null;

				GauceStatement gsmt = null;
				Statement stmt = null;
				ResultSet rs = null;
	       
        //===================================================================================
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						SelectSql = new StringBuffer();
						SelectSql.append( " SELECT A.TOTPAY, X.DUDPAY, A.TOTPAY-X.DUDPAY AS LABPAY                                                       \n" ); 
						SelectSql.append( "   FROM PAYROLL.YCPAY10 A,                                                                                    \n" ); 
						SelectSql.append( "      ( SELECT CASE WHEN TOTPAY <= 5000000 THEN INTEGER(TOTPAY*0.8)                                           \n" ); 
						SelectSql.append( "                    WHEN TOTPAY > 5000000  AND TOTPAY<=15000000 THEN INTEGER(4000000+(TOTPAY-5000000)*0.5)    \n" ); 
						SelectSql.append( "                    WHEN TOTPAY > 15000000 AND TOTPAY<=30000000 THEN INTEGER(9000000+(TOTPAY-15000000)*0.15)  \n" ); 
						SelectSql.append( "                    WHEN TOTPAY > 30000000 AND TOTPAY<=45000000 THEN INTEGER(11250000+(TOTPAY-30000000)*0.10) \n" ); 
						SelectSql.append( "                    WHEN TOTPAY > 45000000 THEN INTEGER(12750000+(TOTPAY-45000000)*0.05)                      \n" ); 
						SelectSql.append( "                    ELSE 0 END DUDPAY,                                                               \n" );
						SelectSql.append( "                B.APPYY, B.EMPNO                                                                     \n" ); 
						SelectSql.append( "          FROM PAYROLL.YCPAY10 B                                                                     \n" ); 
						SelectSql.append( "         WHERE B.APPYY = '"+rows[j].getString(idxAPPYY)+"'                                           \n" ); 
						SelectSql.append( "           AND B.EMPNO = '"+rows[j].getString(idxEMPNO)+"'                                           \n" ); 
						SelectSql.append( "       ) X                                                                                           \n" ); 
						SelectSql.append( "  WHERE A.APPYY = X.APPYY                                                                            \n" ); 
						SelectSql.append( "    AND A.EMPNO = X.EMPNO                                                                            \n" ); 
						SelectSql.append( "    AND A.APPYY= '"+rows[j].getString(idxAPPYY)+"'                                                   \n" );
						SelectSql.append( "    AND A.EMPNO ='"+rows[j].getString(idxEMPNO)+"'                                                   \n" ); 
					
						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

						while(rs.next()){  
							/////////////////////////////////////////////////////////////////////////////////////////////
							//0 근로소득공제 //5 근로소득금액 
							/////////////////////////////////////////////////////////////////////////////////////////////
								UpdateSql = new StringBuffer();
								UpdateSql.append( "  UPDATE PAYROLL.YCPAY10 SET     \n");
								UpdateSql.append( "  DUDPAY="+rs.getLong("DUDPAY")+" \n");
								UpdateSql.append( " ,LABPAY="+rs.getLong("LABPAY")+" \n");
								UpdateSql.append( "   WHERE APPYY =  '"+rows[j].getString(idxAPPYY)+"' " );
								UpdateSql.append( "     AND EMPNO = '"+rows[j].getString(idxEMPNO)+"'  " );
								logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
								gsmt = conn.getGauceStatement(UpdateSql.toString());
								gsmt.executeUpdate();
								gsmt.close();
 					 }//while			
					 stmt.close();
					 rs.close();

				 } //getJobType
			}  //for j 
     			
			} //try
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::");
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