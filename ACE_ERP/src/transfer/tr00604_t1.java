package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00604_t1 extends HttpServlet{

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

				int idxAPPL_NO     = userSet.indexOfColumn("APPL_NO");
				int idxITEM_SEQ    = userSet.indexOfColumn("ITEM_SEQ");
				int idxLINE_PART   = userSet.indexOfColumn("LINE_PART");
				int idxITEM_DIV    = userSet.indexOfColumn("ITEM_DIV");
				int idxITEM_NM     = userSet.indexOfColumn("ITEM_NM");

				int idxHS_CODE     = userSet.indexOfColumn("HS_CODE");
				int idxMODEL_NM    = userSet.indexOfColumn("MODEL_NM");
				int idxITEM_SPC    = userSet.indexOfColumn("ITEM_SPC");
				int idxSERIAL_NO   = userSet.indexOfColumn("SERIAL_NO");
				int idxCPU_SPC     = userSet.indexOfColumn("CPU_SPC");

				int idxHARD_SPC    = userSet.indexOfColumn("HARD_SPC");
				int idxRAM_SPC     = userSet.indexOfColumn("RAM_SPC");
				int idxITEM_UNIT   = userSet.indexOfColumn("ITEM_UNIT");
				int idxITEM_QTY    = userSet.indexOfColumn("ITEM_QTY");
				int idxUNIT_PRICE  = userSet.indexOfColumn("UNIT_PRICE");

				int idxITEM_PRICE  = userSet.indexOfColumn("ITEM_PRICE");
				int idxMANG_NM     = userSet.indexOfColumn("MANG_NM");
				int idxUSE_PPS     = userSet.indexOfColumn("USE_PPS");
				int idxAPPL_DT     = userSet.indexOfColumn("APPL_DT");
				int idxETD_DT      = userSet.indexOfColumn("ETD_DT");

				int idxREMARK      = userSet.indexOfColumn("REMARK");
				int idxCREATE_DT   = userSet.indexOfColumn("CREATE_DT");
				int idxCREATE_USR  = userSet.indexOfColumn("CREATE_USR");
				int idxUPDATE_DT   = userSet.indexOfColumn("UPDATE_DT");
				int idxUPDATE_USR  = userSet.indexOfColumn("UPDATE_USR");
	
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO TRANSFER.LTSTRITEM                         (  " );
				InsertSql.append( " APPL_NO, ITEM_SEQ, LINE_PART, ITEM_DIV, ITEM_NM,          " );
				InsertSql.append( " HS_CODE, MODEL_NM, ITEM_SPC, SERIAL_NO, CPU_SPC,          " );
				InsertSql.append( " HARD_SPC, RAM_SPC, ITEM_UNIT, ITEM_QTY, UNIT_PRICE,       " );
				InsertSql.append( " ITEM_PRICE, MANG_NM, USE_PPS, APPL_DT, ETD_DT,            " );
				InsertSql.append( " REMARK, CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_USR   )  " );
			
				InsertSql.append( " VALUES (  " );
				InsertSql.append( " ?, ?, ?, ?, ?,      " );
				InsertSql.append( " ?, ?, ?, ?, ?,      " );
				InsertSql.append( " ?, ?, ?, ?, ?,      " );
				InsertSql.append( " ?, ?, ?, ?, ?,      " );
				InsertSql.append( " ?,                  " );
			
			
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str1 + "'," );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str2 + "' ) " );


//logger.dbg.println(this,InsertSql.toString());

				UpdateSql = new StringBuffer();

				UpdateSql.append( " UPDATE TRANSFER.LTSTRITEM SET " );
				
				UpdateSql.append( "        LINE_PART = ?, " );
				UpdateSql.append( "        ITEM_DIV = ?," );
				UpdateSql.append( "        ITEM_NM = ?," );

				UpdateSql.append( "        HS_CODE = ?," );
				UpdateSql.append( "        MODEL_NM = ?," );
				UpdateSql.append( "        ITEM_SPC = ?," );
				UpdateSql.append( "        SERIAL_NO = ?," );
				UpdateSql.append( "        CPU_SPC = ?," );

				UpdateSql.append( "        HARD_SPC = ?," );
				UpdateSql.append( "        RAM_SPC = ?," );
				UpdateSql.append( "        ITEM_UNIT = ?," );
				UpdateSql.append( "        ITEM_QTY = ?," );
				UpdateSql.append( "        UNIT_PRICE = ?," );

				UpdateSql.append( "        ITEM_PRICE = ?," );
				UpdateSql.append( "        MANG_NM = ?," );
				UpdateSql.append( "        USE_PPS = ?," );
				UpdateSql.append( "        APPL_DT = ?," );
				UpdateSql.append( "        ETD_DT = ?," );

				UpdateSql.append( "        REMARK = ?," );

				UpdateSql.append( "        UPDATE_DT = CURRENT TIMESTAMP," );
				UpdateSql.append( "        UPDATE_USR  = '" + str1 + "'" );
				UpdateSql.append( " WHERE APPL_NO = ? " );
				UpdateSql.append( "   AND ITEM_SEQ = ? " );
				
//logger.dbg.println(this,UpdateSql.toString());
//logger.err.println(this,"test1");					
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTSTRITEM " );
				DeleteSql.append( " WHERE APPL_NO = ? " );
				DeleteSql.append( "   AND ITEM_SEQ = ? " );

			
//logger.dbg.println(this,DeleteSql.toString());

				for (int j = 0; j < rows.length; j++){
//logger.err.println(this,"test3");
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
//logger.err.println(this,"test4");
//						String test1 = rows[j].getString(idxCAR_SEQ_NO);
//						String test2 = rows[j].getString(idxACCSECTION);
//						String test3 = rows[j].getString(idxCAR_NO);
//						String test4 = rows[j].getString(idxCAR_TYPE);

//						logger.dbg.println(this,test1 + ":"+ test2 +":"+test3+":"+test4);
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
//logger.err.println(this,"test5");
					
						gsmt.setGauceDataRow(rows[j]);

//logger.err.println(this,"test6");	
						gsmt.bindColumn(1,  idxAPPL_NO);
						gsmt.bindColumn(2,  idxITEM_SEQ);
						gsmt.bindColumn(3,  idxLINE_PART);
						gsmt.bindColumn(4,  idxITEM_DIV);
						gsmt.bindColumn(5,  idxITEM_NM);

						gsmt.bindColumn(6,  idxHS_CODE);
						gsmt.bindColumn(7,  idxMODEL_NM);
						gsmt.bindColumn(8,  idxITEM_SPC);
						gsmt.bindColumn(9,  idxSERIAL_NO);
						gsmt.bindColumn(10, idxCPU_SPC);

						gsmt.bindColumn(11,  idxHARD_SPC);
						gsmt.bindColumn(12,  idxRAM_SPC);
						gsmt.bindColumn(13,  idxITEM_UNIT);
						gsmt.bindColumn(14,  idxITEM_QTY);
						gsmt.bindColumn(15,  idxUNIT_PRICE);

						gsmt.bindColumn(16,  idxITEM_PRICE);
						gsmt.bindColumn(17,  idxMANG_NM);
						gsmt.bindColumn(18,  idxUSE_PPS);
						gsmt.bindColumn(19,  idxAPPL_DT);
						gsmt.bindColumn(20,  idxETD_DT);

						gsmt.bindColumn(21,  idxREMARK);
		
						
						gsmt.executeUpdate();
						gsmt.close();
//logger.err.println(this,"test11112");
//logger.err.println(this,InsertSql.toString());n
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
//logger.err.println(this,"test32323");
//logger.err.println(this,UpdateSql.toString());

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
		
						
						gsmt.bindColumn(1,  idxLINE_PART);
						gsmt.bindColumn(2,  idxITEM_DIV);
						gsmt.bindColumn(3,  idxITEM_NM);

						gsmt.bindColumn(4,  idxHS_CODE);
						gsmt.bindColumn(5,  idxMODEL_NM);
						gsmt.bindColumn(6,  idxITEM_SPC);
						gsmt.bindColumn(7,  idxSERIAL_NO);
						gsmt.bindColumn(8,  idxCPU_SPC);

						gsmt.bindColumn(9,  idxHARD_SPC);
						gsmt.bindColumn(10,  idxRAM_SPC);
						gsmt.bindColumn(11,  idxITEM_UNIT);
						gsmt.bindColumn(12,  idxITEM_QTY);
						gsmt.bindColumn(13,  idxUNIT_PRICE);

						gsmt.bindColumn(14,  idxITEM_PRICE);
						gsmt.bindColumn(15,  idxMANG_NM);
						gsmt.bindColumn(16,  idxUSE_PPS);
						gsmt.bindColumn(17,  idxAPPL_DT);
						gsmt.bindColumn(18,  idxETD_DT);

						gsmt.bindColumn(19,  idxREMARK);
						gsmt.bindColumn(20,  idxAPPL_NO);
						gsmt.bindColumn(21,  idxITEM_SEQ);
						

						gsmt.executeUpdate(); 
						gsmt.close();         
       	//	logger.err.println(this,"test255555555");	                            
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxAPPL_NO);
						gsmt.bindColumn(2, idxITEM_SEQ);
					
						gsmt.executeUpdate();
						gsmt.close();
						logger.err.println(this,DeleteSql.toString());
					}
				}
			}
			catch(Exception e){
				logger.err.println(this,e.toString());	
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