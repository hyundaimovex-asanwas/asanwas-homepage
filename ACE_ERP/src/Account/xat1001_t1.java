package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class xat1001_t1 extends HttpServlet{

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

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1");
				String str2 = reqGauce.getParameter("v_str2");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxHEAD_CD          = userSet.indexOfColumn("HEAD_CD");
				int idxHEAD_NAME        = userSet.indexOfColumn("HEAD_NAME");
				int idxUSE_GB           = userSet.indexOfColumn("USE_GB");
				int idxREMARK           = userSet.indexOfColumn("REMARK");
				int idxCREATE_ID        = userSet.indexOfColumn("CREATE_ID");
				int idxCREATE_DATE      = userSet.indexOfColumn("CREATE_DATE");
				int idxUPDATE_ID        = userSet.indexOfColumn("UPDATE_ID");
				int idxUPDATE_DATE      = userSet.indexOfColumn("UPDATE_DATE");
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append (" INSERT INTO ACCOUNT.TBIF_COMMST (                   \n");
				InsertSql.append ("        HEAD_CD,HEAD_NAME,USE_GB,REMARK,             \n");
				InsertSql.append ("        CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE  \n");
				InsertSql.append (" ) VALUES (                                          \n");
				InsertSql.append (" ?,?,?,?,                                            \n");
				InsertSql.append (" ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP )           \n");

  
				UpdateSql = new StringBuffer();
				UpdateSql.append (" UPDATE ACCOUNT.TBIF_COMMST SET        \n");
				UpdateSql.append ("        HEAD_NAME = ?                  \n");
				UpdateSql.append ("       ,UPDATE_ID = ?                  \n");
				UpdateSql.append ("       ,UPDATE_DATE=CURRENT_TIMESTAMP  \n");
				UpdateSql.append ("  WHERE HEAD_CD = ? \n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.TBIF_COMMST 	  \n");
				DeleteSql.append( "  WHERE HEAD_CD= ?					  \n");				


				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,idxHEAD_CD);
						gsmt.bindColumn(2,idxHEAD_NAME);
						gsmt.bindColumn(3,idxUSE_GB);
						gsmt.bindColumn(4,idxREMARK);
						gsmt.bindColumn(5,idxCREATE_ID);
						gsmt.bindColumn(6,idxUPDATE_ID);
						
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxHEAD_NAME);
						gsmt.bindColumn(2, idxUPDATE_ID);
						gsmt.bindColumn(3, idxHEAD_CD);
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxHEAD_CD);
						gsmt.executeUpdate();
						gsmt.close();
					}
					
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				
				System.out.println("err:::::::::::::"+e);
			}

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