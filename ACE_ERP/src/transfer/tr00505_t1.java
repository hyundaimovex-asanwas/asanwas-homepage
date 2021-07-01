package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00505_t1 extends HttpServlet{

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
											
				int idxSETTLE_CD   = userSet.indexOfColumn("SETTLE_CD");
				int idxSETTLE_NM   = userSet.indexOfColumn("SETTLE_NM");
				int idxACC_CODE    = userSet.indexOfColumn("ACC_CODE");
				int idxSELL_TYPE   = userSet.indexOfColumn("SELL_TYPE");
				int idxSORT_NO     = userSet.indexOfColumn("SORT_NO");
				int idxREMARK	   = userSet.indexOfColumn("REMARK");
				int idxCREATE_DT   = userSet.indexOfColumn("CREATE_DT");
				int idxCREATE_USR  = userSet.indexOfColumn("CREATE_USR");
				int idxUPDATE_DT   = userSet.indexOfColumn("UPDATE_DT");
				int idxUPDATE_USR  = userSet.indexOfColumn("UPDATE_USR");
	
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO TRANSFER.LTSTTMNTCD                     (  " );
				InsertSql.append( " SETTLE_CD, SETTLE_NM, ACC_CODE,  SELL_TYPE, SORT_NO,   " );
				InsertSql.append( " REMARK, CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_USR ) " );
				InsertSql.append( " VALUES ( ?,?,?,?,?, " );
				InsertSql.append( " ?, CURRENT TIMESTAMP, '"	+ str1 + "'," );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str2 + "' ) " );

				//InsertSql.append( " ?,'"	+ str1 + "',curent timestamp ) " );

//logger.dbg.println(this,InsertSql.toString());

				UpdateSql = new StringBuffer();

				UpdateSql.append( " UPDATE TRANSFER.LTSTTMNTCD SET " );
				UpdateSql.append( "        SETTLE_NM = ?, " );
				UpdateSql.append( "        ACC_CODE = ?, " );
				UpdateSql.append( "        SELL_TYPE = ?," );
				UpdateSql.append( "        SORT_NO = ?," );
				UpdateSql.append( "        REMARK = ?," );
					
				UpdateSql.append( "        UPDATE_DT = CURRENT TIMESTAMP," );
				UpdateSql.append( "        UPDATE_USR  = '" + str1 + "'" );
				UpdateSql.append( " WHERE SETTLE_CD = ? " );
				//UpdateSql.append( " AND   SETTLE_NM = ?  " );

				
//logger.dbg.println(this,UpdateSql.toString());
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTSTTMNTCD " );
				DeleteSql.append( " WHERE SETTLE_CD= ? "  );

//logger.dbg.println(this,DeleteSql.toString());

				for (int j = 0; j < rows.length; j++){
//logger.err.println(this,"test");
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
//logger.err.println(this,"111111111111111111");
						//String test1 = rows[j].getString(idxSETTLE_CD);
						//String test2 = rows[j].getString(idxSETTLE_NM);
						//String test3 = rows[j].getString(idxACC_CODE);
						//String test4 = rows[j].getString(idxSELL_TYPE);

						//logger.dbg.println(this,test1 + ":"+ test2 +":"+test3+":"+test4);
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
//logger.err.println(this,"test1");
						gsmt.setGauceDataRow(rows[j]);
//logger.err.println(this,"test2");	
						gsmt.bindColumn(1,  idxSETTLE_CD);
						gsmt.bindColumn(2,  idxSETTLE_NM);
						gsmt.bindColumn(3,  idxACC_CODE);
						gsmt.bindColumn(4,  idxSELL_TYPE);
						gsmt.bindColumn(5,  idxSORT_NO);
						gsmt.bindColumn(6,  idxREMARK);
						
						gsmt.executeUpdate();
						gsmt.close();

//logger.err.println(this,InsertSql.toString());
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						//logger.err.println(this,"test");
						//logger.err.println(this,UpdateSql.toString());

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
				
						gsmt.bindColumn(1,  idxSETTLE_NM);
						gsmt.bindColumn(2,  idxACC_CODE);
						gsmt.bindColumn(3,  idxSELL_TYPE);
						gsmt.bindColumn(4,  idxSORT_NO);
						gsmt.bindColumn(5,  idxREMARK);
						gsmt.bindColumn(6,  idxSETTLE_CD);
						
						gsmt.executeUpdate(); 
						gsmt.close();         
                                   
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxSETTLE_CD);
						
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
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