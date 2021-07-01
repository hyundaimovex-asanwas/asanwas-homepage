package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a300075_t2 extends HttpServlet{
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
	 		
	 		
	 		String strAcctcd="";  //계좌코드
	 		
			try {
				
				conn = service.getDBConnection();	
				conn.setAutoCommit(false);
				
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String str1 = reqGauce.getParameter("v_str1");				//사용자
				String str2 = reqGauce.getParameter("v_str2");				//접수일자
				String str3 = reqGauce.getParameter("v_str3");				//접수상태 1.미지급, 2.접수, 3.완료
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPNO          = userSet.indexOfColumn("APPNO");
				int idxPAYSTAT        = userSet.indexOfColumn("PAYSTAT");
				int idxRECDATE        = userSet.indexOfColumn("RECDATE");
				int idxUPID           = userSet.indexOfColumn("UPID");
							
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				
				GauceStatement gsmt= null;
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ACAPPFUND SET  \n" );
				UpdateSql.append( " PAYSTAT = ?,      \n" );
				UpdateSql.append( " RECDATE = ?, \n" );
				UpdateSql.append( " UPID = ?,        \n" );
				UpdateSql.append( " UPDT = CURRENT_TIMESTAMP   \n" );
				UpdateSql.append( " WHERE APPNO = ? \n" );
				
				for (int j = 0; j < rows.length; j++){
					
					if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
						//gsmt.setString(idxUPID, str1);
						rows[j].setString(idxUPID,str1);
						rows[j].setString(idxRECDATE,str2);
						rows[j].setString(idxPAYSTAT,str3);
												
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxPAYSTAT);
						gsmt.bindColumn(2, idxRECDATE);
						gsmt.bindColumn(3, idxUPID);
						gsmt.bindColumn(4, idxAPPNO);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
					}
				}
			}
			catch(Exception e){
				System.out.println("ERROR000::"+e);
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			conn.commit(); 
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			
			System.out.println("ERROR::"+e);
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}