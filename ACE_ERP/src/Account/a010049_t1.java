package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010049_t1 extends HttpServlet{
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
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

                GauceStatement gsmt=null;
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				int idxFND_REGNO        = userSet.indexOfColumn("FND_REGNO");       //사업자번호
				int idxFND_USER         = userSet.indexOfColumn("FND_USER");        //사번
				int idxFND_USER_NAME    = userSet.indexOfColumn("FND_USER_NAME");   //사원명
				int idxSMART_ID         = userSet.indexOfColumn("SMART_ID");        //스마트빌ID
				int idxSMART_PASSWORD   = userSet.indexOfColumn("SMART_PASSWORD");  //스마트빌PW	
				int idxSMART_EMAIL   = userSet.indexOfColumn("SMART_EMAIL");  //스마트빌EMAIL
				
				String strGB ="";
				String strHiperson ="";



				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				StringBuffer UpdateSql2 = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "  INSERT INTO HDASAN_EDI.XXSB_DTI_SM_USER ( FND_REGNO, FND_USER, FND_USER_NAME, SMART_ID, SMART_PASSWORD ) \n");
				InsertSql.append( "  VALUES ( ?, ? ,?, ?, ? ) 									\n");

                UpdateSql = new StringBuffer();
				UpdateSql.append( "  UPDATE HDASAN_EDI.XXSB_DTI_SM_USER 		\n");
				UpdateSql.append( "     SET FND_USER_NAME=?,            					\n");
				UpdateSql.append( "         SMART_ID=?,                 							\n");		
				UpdateSql.append( "         SMART_PASSWORD=?            					\n");		
				UpdateSql.append( "   WHERE FND_REGNO=?                 					\n");
				UpdateSql.append( "     AND FND_USER=?                  						\n");
       
				DeleteSql = new StringBuffer();
				DeleteSql.append( "  DELETE FROM  HDASAN_EDI.XXSB_DTI_SM_USER 	\n");		
				DeleteSql.append( "   WHERE FND_REGNO = ?  									\n");
				DeleteSql.append( "     AND FND_USER = ?   										\n");
								
				
			   

				for (int j = 0; j < rows.length; j++){
					
					strGB = rows[j].getString(idxFND_USER).substring(0,1);
						
					if(strGB.equals("1")||strGB.equals("2")){
						strHiperson ="HIPERSON";	
					}else{
						strHiperson ="T_HIPERSON";
					}
					
					UpdateSql2 = new StringBuffer();
					UpdateSql2.append( "  UPDATE PAYROLL."+strHiperson+"  SET 	\n");
					UpdateSql2.append( "                EMAIL =?  								\n");
					UpdateSql2.append( "   WHERE EMPNO=? 								\n");
					

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxFND_REGNO);
						gsmt.bindColumn(2, idxFND_USER);
						gsmt.bindColumn(3, idxFND_USER_NAME);
						gsmt.bindColumn(4, idxSMART_ID);
						gsmt.bindColumn(5, idxSMART_PASSWORD);

						gsmt.executeUpdate();
						gsmt.close();
                        gsmt=null;         
                        
                        
						gsmt = conn.getGauceStatement(UpdateSql2.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxSMART_EMAIL);
						gsmt.bindColumn(2, idxFND_USER);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;         
                        
					}//if

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxFND_USER_NAME);
						gsmt.bindColumn(2, idxSMART_ID);
						gsmt.bindColumn(3, idxSMART_PASSWORD);
						gsmt.bindColumn(4, idxFND_REGNO);
						gsmt.bindColumn(5, idxFND_USER);
             
						gsmt.executeUpdate();
						gsmt.close();
           				gsmt=null;       
           				 
						gsmt = conn.getGauceStatement(UpdateSql2.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxSMART_EMAIL);
						gsmt.bindColumn(2, idxFND_USER);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;           

					}//if
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxFND_REGNO);
						gsmt.bindColumn(2, idxFND_USER);
						gsmt.executeUpdate();
						gsmt.close();
           				 gsmt=null;         
					}//if
				}//for
			}
			catch(Exception e)
				{
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				logger.err.println(this,e.toString()); //
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