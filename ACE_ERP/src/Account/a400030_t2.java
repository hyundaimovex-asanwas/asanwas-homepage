package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400030_t2 extends HttpServlet{
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

			try {
				
				System.out.println("# a400030_t2 START : \n" );
				
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
       
				GauceStatement gsmt = null;
				
				String strUserid = reqGauce.getParameter("v_str1");

				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");
							
				int idxDEDATE            = userSet.indexOfColumn("DEDATE");
				int idxWRID              = userSet.indexOfColumn("WRID");
                
				GauceDataRow[] rows  = userSet.getDataRows();
				
				StringBuffer UpdateSql  = null;
				UpdateSql = new StringBuffer();

				UpdateSql.append( " UPDATE ACCOUNT.ACDPSUM SET     \n ");
				UpdateSql.append( "        CLOSEYN ='Y',           \n ");
				UpdateSql.append( "        UPID=?,                 \n ");
				UpdateSql.append( "        UPDT= CURRENT_TIMESTAMP \n ");
				UpdateSql.append( "  WHERE DEDATE = ?              \n ");
				
				System.out.println("# a400030_t2 START : \n "  + UpdateSql.toString());
				                
				for (int j = 0; j < rows.length; j++){
					//////////////////////////////////////////////////////////////////////////
					//if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					
						rows[j].setString(idxWRID, strUserid);
						
						//신규 생성 - A
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxWRID);
						gsmt.bindColumn(2,  idxDEDATE);   
						
						System.out.println("# a400030_t2 START : \n " );
						
						gsmt.executeUpdate();
						gsmt.close();

						System.out.println("# a400030_t2 end : \n " );
						gsmt=null;
					//}
				} //for
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