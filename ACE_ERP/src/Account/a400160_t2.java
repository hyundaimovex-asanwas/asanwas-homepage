package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class a400160_t2 extends HttpServlet{
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
	 		
	 		String strApp_no ="";  //신청번호
	 		String strSignet_mgr_no=""; //인감관리번호
	 		Integer intSignet_Seq=0;
	 		
	 		
			try {
				
				conn = service.getDBConnection();	
				conn.setAutoCommit(false);  //Transaction 
				
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String str1 = reqGauce.getParameter("v_str1");	
				//사용자
				
				GauceDataSet userSet3 = reqGauce.getGauceDataSet("USER3");  //법인인감 신청MST
				
				int idx3APP_NO             = userSet3.indexOfColumn("APP_NO");
				int idx3SIGNET_CERTI_NO    = userSet3.indexOfColumn("SIGNET_CERTI_NO");
				int idx3UPID               = userSet3.indexOfColumn("UPID");
				
				GauceDataRow[] rows3 = userSet3.getDataRows();
	
				StringBuffer UpdateSql3 = null;
				
				GauceStatement gsmt= null;
				
				UpdateSql3 = new StringBuffer();
				UpdateSql3.append( " UPDATE ACCOUNT.SIGNET_COR SET  \n" );
				UpdateSql3.append( " SIGNET_CERTI_NO = ?,           \n" );
				UpdateSql3.append( " UPID= ?,                       \n" );
				UpdateSql3.append( " UPDT= CURRENT_TIMESTAMP        \n" );
				UpdateSql3.append( " WHERE APP_NO  = ?              \n" );
				
				//
				for (int k = 0; k < rows3.length; k++){
					
				   if(rows3[k].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
				   }else if (rows3[k].getJobType() == GauceDataRow.TB_JOB_UPDATE){
					    
					    rows3[k].setString(idx3UPID, str1);
					   
					    gsmt = conn.getGauceStatement(UpdateSql3.toString());
						gsmt.setGauceDataRow(rows3[k]);
								
						gsmt.bindColumn(1, idx3SIGNET_CERTI_NO);
						gsmt.bindColumn(2, idx3UPID);
						gsmt.bindColumn(3, idx3APP_NO);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
			 	   }else if (rows3[k].getJobType() == GauceDataRow.TB_JOB_DELETE){
					
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