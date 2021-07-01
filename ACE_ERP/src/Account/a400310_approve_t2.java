package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class a400310_approve_t2 extends HttpServlet{
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
				
				String str1 = reqGauce.getParameter("v_str1");				//사용자
				
				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");   //결재MST
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");  //결재DTL
				
				int idxAP_M_SID            = userSet.indexOfColumn("AP_M_SID");
				int idxAP_STATUS_M         = userSet.indexOfColumn("AP_STATUS_M");
				int idxL_EMPNO             = userSet.indexOfColumn("L_EMPNO");
				int idxU_EMPNO             = userSet.indexOfColumn("U_EMPNO");
				int idxU_IP                = userSet.indexOfColumn("U_IP");
				
				int idx2AP_SID             = userSet2.indexOfColumn("AP_SID");
				int idx2AP_TYPE            = userSet2.indexOfColumn("AP_TYPE");
				int idx2AP_STATUS_D        = userSet2.indexOfColumn("AP_STATUS_D");
				int idx2U_EMPNO            = userSet2.indexOfColumn("U_EMPNO");
				int idx2U_IP               = userSet2.indexOfColumn("U_IP");
				
				GauceDataRow[] rows  = userSet.getDataRows();
				GauceDataRow[] rows2 = userSet2.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;
				StringBuffer UpdateSql2 = null;
				
				GauceStatement gsmt= null;
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE COMMON.APPROVE_MASTER SET  \n" );
				UpdateSql.append( " AP_STATUS_M= ?,  \n" );
				UpdateSql.append( " L_EMPNO= ?,      \n" );
				UpdateSql.append( " U_EMPNO= ?,      \n" );
				UpdateSql.append( " U_IP   = ?,      \n" );
				UpdateSql.append( " U_DATE = CURRENT_TIMESTAMP  \n" );
				UpdateSql.append( " WHERE AP_M_SID  = ?         \n" );
				
				
				UpdateSql2 = new StringBuffer();
				UpdateSql2.append( " UPDATE COMMON.APPROVE_DETAIL SET  \n" );
				UpdateSql2.append( " AP_STATUS_D= ?,   \n" );
				UpdateSql2.append( " U_EMPNO= ?,       \n" );
				UpdateSql2.append( " U_IP   = ?,       \n" );
				UpdateSql2.append( " U_DATE = CURRENT_TIMESTAMP  \n" );
				UpdateSql2.append( " WHERE AP_SID  = ?           \n" );
				
				
				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
							
				   }else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
						
					    gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
								
		        		gsmt.bindColumn(1, idxAP_STATUS_M);
		        		gsmt.bindColumn(2, idxL_EMPNO);
						gsmt.bindColumn(3, idxU_EMPNO);
						gsmt.bindColumn(4, idxU_IP);
						gsmt.bindColumn(5, idxAP_M_SID);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
			 	   }else if (rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE){
					
				   }//if
				}//for	
				
				for (int i = 0; i < rows2.length; i++){
					
				   if(rows2[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {
							
				   }else if (rows2[i].getJobType() == GauceDataRow.TB_JOB_UPDATE){
						 
					    gsmt = conn.getGauceStatement(UpdateSql2.toString());
						
						gsmt.setGauceDataRow(rows2[i]);
								
		        		gsmt.bindColumn(1, idx2AP_STATUS_D);
						gsmt.bindColumn(2, idx2U_EMPNO);
						gsmt.bindColumn(3, idx2U_IP);
						gsmt.bindColumn(4, idx2AP_SID);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
			 	   }else if (rows2[i].getJobType() == GauceDataRow.TB_JOB_DELETE){
					
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