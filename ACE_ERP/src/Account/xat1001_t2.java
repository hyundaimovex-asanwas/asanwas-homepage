package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class xat1001_t2 extends HttpServlet{

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

				int idxHEAD_CD       = userSet.indexOfColumn("HEAD_CD");
				int idxDETAIL_CD     = userSet.indexOfColumn("DETAIL_CD");
				int idxDETAIL_NAME   = userSet.indexOfColumn("DETAIL_NAME");
				int idxPRT_SEQ       = userSet.indexOfColumn("PRT_SEQ");
				int idxUSE_GB        = userSet.indexOfColumn("USE_GB");
				int idxITEM1         = userSet.indexOfColumn("ITEM1");
				int idxITEM2         = userSet.indexOfColumn("ITEM2");
				int idxITEM3         = userSet.indexOfColumn("ITEM3");
				int idxITEM4         = userSet.indexOfColumn("ITEM4");
				int idxITEM5         = userSet.indexOfColumn("ITEM5");
				int idxREMARK        = userSet.indexOfColumn("REMARK");
				int idxCREATE_ID     = userSet.indexOfColumn("CREATE_ID");
				int idxCREATE_DATE   = userSet.indexOfColumn("CREATE_DATE");
				int idxUPDATE_ID     = userSet.indexOfColumn("UPDATE_ID");
				int idxUPDATE_DATE   = userSet.indexOfColumn("UPDATE_DATE");
				
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append (" INSERT INTO ACCOUNT.TBIF_COMSUB (  \n");
				InsertSql.append ("        HEAD_CD,DETAIL_CD,DETAIL_NAME,PRT_SEQ,USE_GB,  \n");
				InsertSql.append ("        ITEM1,ITEM2,ITEM3,ITEM4,ITEM5,REMARK,          \n");
				InsertSql.append ("        CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE    \n");
				InsertSql.append (" ) VALUES (                                            \n");
				InsertSql.append (" ?,?,?,?,?,  \n");
				InsertSql.append (" ?,?,?,?,?,?, \n");
				InsertSql.append (" ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP  \n");
				InsertSql.append (" )\n");

  
				UpdateSql = new StringBuffer();
				UpdateSql.append (" UPDATE ACCOUNT.TBIF_COMSUB SET  \n");
				UpdateSql.append ("  DETAIL_NAME = ?         \n");
				UpdateSql.append (" ,PRT_SEQ = ?             \n");
				UpdateSql.append (" ,USE_GB = ?              \n");
				UpdateSql.append (" ,ITEM1 = ?               \n");
				UpdateSql.append (" ,ITEM2 = ?               \n");
				UpdateSql.append (" ,ITEM3 = ?               \n");
				UpdateSql.append (" ,ITEM4 = ?               \n");
				UpdateSql.append (" ,ITEM5 = ?               \n");
				UpdateSql.append (" ,REMARK = ?              \n");
				UpdateSql.append (" ,UPDATE_ID = ?           \n");
				UpdateSql.append (" ,UPDATE_DATE=CURRENT_TIMESTAMP  \n");
				UpdateSql.append ("  WHERE HEAD_CD = ?      \n");
				UpdateSql.append ("    AND DETAIL_CD = ?    \n");
				

				DeleteSql = new StringBuffer();
				DeleteSql.append (" DELETE FROM ACCOUNT.TBIF_COMSUB \n");
				DeleteSql.append ("  WHERE HEAD_CD = ?       \n");
				DeleteSql.append ("    AND DETAIL_CD = ?     \n");		


				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,idxHEAD_CD);
						gsmt.bindColumn(2,idxDETAIL_CD);
						gsmt.bindColumn(3,idxDETAIL_NAME);
						gsmt.bindColumn(4,idxPRT_SEQ);
						gsmt.bindColumn(5,idxUSE_GB);
						gsmt.bindColumn(6,idxITEM1);
						gsmt.bindColumn(7,idxITEM2);
						gsmt.bindColumn(8,idxITEM3);
						gsmt.bindColumn(9,idxITEM4);
						gsmt.bindColumn(10,idxITEM5);
						gsmt.bindColumn(11,idxREMARK);
						gsmt.bindColumn(12,idxCREATE_ID);
						gsmt.bindColumn(13,idxUPDATE_ID);
						
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,idxDETAIL_NAME);
						gsmt.bindColumn(2,idxPRT_SEQ);
						gsmt.bindColumn(3,idxUSE_GB);
						gsmt.bindColumn(4,idxITEM1);
						gsmt.bindColumn(5,idxITEM2);
						gsmt.bindColumn(6,idxITEM3);
						gsmt.bindColumn(7,idxITEM4);
						gsmt.bindColumn(8,idxITEM5);
						gsmt.bindColumn(9,idxREMARK);
						gsmt.bindColumn(10,idxUPDATE_ID);
						gsmt.bindColumn(11,idxHEAD_CD);
						gsmt.bindColumn(12,idxDETAIL_CD);
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,idxHEAD_CD);
						gsmt.bindColumn(2,idxDETAIL_CD);
						
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