package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400310_approve_t1 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
	 		
	 		String strApp_no ="";  //관리자ID
	 		
			try {
				
				conn = service.getDBConnection();	
				conn.setAutoCommit(false);  //Transaction 
				
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String str1 = reqGauce.getParameter("v_str1");				//사용자
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAP_SID              = userSet.indexOfColumn("AP_SID");
				int idxAP_DESC             = userSet.indexOfColumn("AP_DESC");
				int idxU_EMPNO             = userSet.indexOfColumn("U_EMPNO");
				int idxU_IP                = userSet.indexOfColumn("U_IP");
				

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;
				
				GauceStatement gsmt= null;
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE COMMON.APPROVE_DETAIL SET  \n" );
				UpdateSql.append( " AP_DESC= ?,   \n" );
				UpdateSql.append( " U_EMPNO= ?,   \n" );
				UpdateSql.append( " U_IP   = ?,   \n" );
				UpdateSql.append( " U_DATE = CURRENT_TIMESTAMP  \n" );
				UpdateSql.append( " WHERE AP_SID  = ?   \n" );
				
				//
				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
							
				   }else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
						
					    gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
								
		        		gsmt.bindColumn(1, idxAP_DESC);
						gsmt.bindColumn(2, idxU_EMPNO);
						gsmt.bindColumn(3, idxU_IP);
						gsmt.bindColumn(4, idxAP_SID);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
						
			 	   }else if (rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE){
					
					}//if
					
				}//for	
				
			}//inner try
			catch(Exception e){
				System.out.println("ERROR000::"+e);
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			conn.commit(); 
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}//outer try
		catch (Exception e) {
			
			System.out.println("ERROR::"+e);
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}//public void
	
}//classes