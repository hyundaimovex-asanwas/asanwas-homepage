package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class a400160_t1 extends HttpServlet{
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
				
				GauceDataSet userSet3 = reqGauce.getGauceDataSet("USER3");  //사용인감 신청MST
				GauceDataSet userSet4 = reqGauce.getGauceDataSet("USER4");  //이력관리
				
				int idx3APP_NO             = userSet3.indexOfColumn("APP_NO");
				int idx3RECE_DATE          = userSet3.indexOfColumn("RECE_DATE");
				int idx3UPID               = userSet3.indexOfColumn("UPID");
				
				//이력관리.
				int idx4SIGNET_ID          = userSet4.indexOfColumn("SIGNET_ID");
				int idx4SIGNET_SEQ         = userSet4.indexOfColumn("SIGNET_SEQ");
				int idx4WORK_GB            = userSet4.indexOfColumn("WORK_GB");
				int idx4MGR_TEAMCD         = userSet4.indexOfColumn("MGR_TEAMCD");
				int idx4MGR_TEAMNM         = userSet4.indexOfColumn("MGR_TEAMNM");
				int idx4MAIN_EMPID         = userSet4.indexOfColumn("MAIN_EMPID");
				int idx4SUB_EMPID          = userSet4.indexOfColumn("SUB_EMPID");
				int idx4SEND_DATE          = userSet4.indexOfColumn("SEND_DATE");
				int idx4DISUSE_DATE        = userSet4.indexOfColumn("DISUSE_DATE");
				int idx4DISUSE_REASON      = userSet4.indexOfColumn("DISUSE_REASON");
				int idx4RECE_DATE          = userSet4.indexOfColumn("RECE_DATE");
				int idx4RECE_REASON        = userSet4.indexOfColumn("RECE_REASON");
				int idx4USEGB              = userSet4.indexOfColumn("USEGB");
				int idx4USE_REMARK         = userSet4.indexOfColumn("USE_REMARK");
				int idx4ETC                = userSet4.indexOfColumn("ETC");
				int idx4WRID               = userSet4.indexOfColumn("WRID");
				int idx4SEND_DATE_CONFIRM  = userSet4.indexOfColumn("SEND_DATE_CONFIRM");
				int idx4RECEIVE_DATE       = userSet4.indexOfColumn("RECEIVE_DATE");
				
				GauceDataRow[] rows3 = userSet3.getDataRows();
				GauceDataRow[] rows4 = userSet4.getDataRows();

				StringBuffer UpdateSql3 = null;
				StringBuffer InsertSql_His = null;
				
				GauceStatement gsmt= null;
				
				UpdateSql3 = new StringBuffer();
				UpdateSql3.append( " UPDATE ACCOUNT.SIGNET_USE SET  \n" );
				UpdateSql3.append( " SEND_DATE_CONFIRM = CURRENT_TIMESTAMP, \n" );
				UpdateSql3.append( " UPID= ?,                       \n" );
				UpdateSql3.append( " UPDT= CURRENT_TIMESTAMP        \n" );
				UpdateSql3.append( " WHERE APP_NO  = ?              \n" );
				
				InsertSql_His = new StringBuffer();
				InsertSql_His.append( " INSERT INTO ACCOUNT.SIGNET_HIS (                                 \n" );
				InsertSql_His.append( " SIGNET_ID,    SIGNET_SEQ,  WORK_GB,   MGR_TEAMCD,  MGR_TEAMNM,   \n" );
				InsertSql_His.append( " MAIN_EMPID,   SUB_EMPID,   SEND_DATE, DISUSE_DATE, DISUSE_REASON,\n" );
				InsertSql_His.append( " RECE_DATE,    RECE_REASON, USEGB,     USE_REMARK,  ETC,  \n" );
				InsertSql_His.append( " SEND_DATE_CONFIRM, RECEIVE_DATE,      WRID, WRDT         \n" );
				InsertSql_His.append( " )VALUES (                                     \n" );
				InsertSql_His.append( " ?,?,?,?,?,                                    \n" );
				InsertSql_His.append( " ?,?,?,?,?,                                    \n" );
				InsertSql_His.append( " ?,?,?,?,?,                                    \n" );
				InsertSql_His.append( " CURRENT_TIMESTAMP,?,?,CURRENT_TIMESTAMP       \n" );
				InsertSql_His.append( " )                                             \n" );
				
				//
				for (int k = 0; k < rows3.length; k++){
					
				   if(rows3[k].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
				   }else if (rows3[k].getJobType() == GauceDataRow.TB_JOB_UPDATE){
					    
					    rows3[k].setString(idx3UPID, str1);
					    
					    gsmt = conn.getGauceStatement(UpdateSql3.toString());
						gsmt.setGauceDataRow(rows3[k]);
								
						//gsmt.bindColumn(1, idx3RECE_DATE);
						gsmt.bindColumn(1, idx3UPID);
						gsmt.bindColumn(2, idx3APP_NO);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
			 	   }else if (rows3[k].getJobType() == GauceDataRow.TB_JOB_DELETE){
					
				   }//if
				}//for	
				
				//이력관리
				for (int m= 0; m < rows4.length; m++){
					
				   if(rows4[m].getJobType() == GauceDataRow.TB_JOB_INSERT) {
				   
					 //채번시작///////////////////////////////////////////////////////////////////////////////
						Statement stmt2= conn.createStatement();
						StringBuffer sql2 = new StringBuffer();
						sql2.append( "  SELECT NVL(MAX(TO_NUMBER(SIGNET_SEQ)),0)+1 FROM ACCOUNT.SIGNET_HIS "); 
						sql2.append( "   WHERE SIGNET_ID ='"+rows4[m].getString(idx4SIGNET_ID)+"'"); 
						
						ResultSet rs2 = stmt2.executeQuery(sql2.toString()); 
						if(rs2.next()){
							intSignet_Seq= rs2.getInt(1);
						}
						rs2.close();
						stmt2.close();
						
						rows4[m].setInt(idx4SIGNET_SEQ,intSignet_Seq);
						//채번완료///////////////////////////////////////////////////////////////////////////////
						
						gsmt = conn.getGauceStatement(InsertSql_His.toString());
						
						gsmt.setGauceDataRow(rows4[m]);
						
						gsmt.bindColumn(1, idx4SIGNET_ID);
						gsmt.bindColumn(2, idx4SIGNET_SEQ);
						gsmt.bindColumn(3, idx4WORK_GB);
						gsmt.bindColumn(4, idx4MGR_TEAMCD);
						gsmt.bindColumn(5, idx4MGR_TEAMNM);
						gsmt.bindColumn(6, idx4MAIN_EMPID);
						gsmt.bindColumn(7, idx4SUB_EMPID);
						gsmt.bindColumn(8, idx4SEND_DATE);
						gsmt.bindColumn(9, idx4DISUSE_DATE);
						gsmt.bindColumn(10,idx4DISUSE_REASON);
						gsmt.bindColumn(11,idx4RECE_DATE);
						gsmt.bindColumn(12,idx4RECE_REASON);
						gsmt.bindColumn(13,idx4USEGB);
						gsmt.bindColumn(14,idx4USE_REMARK);
						gsmt.bindColumn(15,idx4ETC);
						gsmt.bindColumn(16,idx4RECEIVE_DATE);
						gsmt.bindColumn(17,idx4WRID);						
						
												
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
				   }else if (rows4[m].getJobType() == GauceDataRow.TB_JOB_UPDATE){
					   
					    
						
			 	   }else if (rows4[m].getJobType() == GauceDataRow.TB_JOB_DELETE){
					
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