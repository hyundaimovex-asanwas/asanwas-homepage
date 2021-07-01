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

public class h050020_t4 extends HttpServlet{

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

				String strGB = reqGauce.getParameter("v_str1");      // ������, ����� ����
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 

				int idxAPPDT    = userSet.indexOfColumn("APPDT");	   // �޿����
				int idxEMPNO    = userSet.indexOfColumn("EMPNO");	   // �޿����
				int idxJTGB     = userSet.indexOfColumn("JTGB");	   // �޿����
						
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer UpdateSql = null;
        
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {	
					           
						UpdateSql = new StringBuffer();

            if(strGB.equals("R")){
							UpdateSql.append( " UPDATE PAYROLL.HLJTGB SET " );
							UpdateSql.append( " CLOSEYN = 'C' ");
							UpdateSql.append( " WHERE APPDT = ? AND SUBSTR(EMPNO,1,1) IN ('1','2')  " );
						}else{
							UpdateSql.append( " UPDATE PAYROLL.HLJTGB SET " );
							UpdateSql.append( " CLOSEYN = 'C' ");
							UpdateSql.append( " WHERE APPDT = ? AND SUBSTR(EMPNO,1,1) = '3'  " );
						}

						//logger.dbg.println(this, UpdateSql.toString());

						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxAPPDT);
						
						gsmt.executeUpdate(); 
						gsmt.close();       						
             
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
					}
				}
			}
			catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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