package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class tr00514_t1 extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
	  GauceDataSet dSetMstID = null;
		GauceStatement gsmt = null ; 
		 

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
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String porder_no = reqGauce.getParameter("gstr1"); 
   				if ( porder_no==null || porder_no.trim().length()==0 ) { porder_no=null; }
				String str2 = reqGauce.getParameter("v_str1"); 
   				if ( str2==null || str2.trim().length()==0 ) { str2=null; }
				String str3 = reqGauce.getParameter("v_str2"); 
   				if ( str3==null || str3.trim().length()==0 ) { str3=null; }
        String enter_no = null ;         
				logger.err.println(this,"start");

				 
//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxCHARGECODE  = userSet.indexOfColumn("CHARGECODE");
				int idxPACK_TYPE   = userSet.indexOfColumn("PACK_TYPE");
				int idxFROM_CBM    = userSet.indexOfColumn("FROM_CBM");
				int idxTO_CBM      = userSet.indexOfColumn("TO_CBM");
				int idxUNIT_PRICE  = userSet.indexOfColumn("UNIT_PRICE");

				int idxRQST_PRICE  = userSet.indexOfColumn("RQST_PRICE");
				int idxRQST_PRICE2 = userSet.indexOfColumn("RQST_PRICE2");
				int idxACM_PRICE   = userSet.indexOfColumn("ACM_PRICE");
				int idxEFF_DATE    = userSet.indexOfColumn("EFF_DATE");
				int idxEXP_DATE    = userSet.indexOfColumn("EXP_DATE");

				
				int idxCREATE_DT   = userSet.indexOfColumn("CREATE_DT");
				int idxCREATE_USR  = userSet.indexOfColumn("CREATE_USR");
				int idxUPDATE_DT   = userSet.indexOfColumn("UPDATE_DT");
				int idxUPDATE_USR  = userSet.indexOfColumn("UPDATE_USR");
	
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer sql = null;  

				for (int j = 0; j < rows.length; j++){
				int  ls_value = rows[j].getJobType() ; 
				 
 //logger.err.println(this, "type"  + String.valueOf(ls_value)  ); 
//logger.err.println(this,   "insert" + Sring.valueOf(GauceDataRow.TB_JOB_INSERT)  ); 
//logger.err.println(this,   "update" + String.valueOf(GauceDataRow.TB_JOB_UPDATE)  ); 
//logger.err.println(this,   "delete" + String.valueOf(GauceDataRow.TB_JOB_DELETE)  ); 
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) { 

/***************************************************************************************************
		Description  : Get PlNo
***************************************************************************************************/
						dSetMstID = new GauceDataSet(); 
					  dSetMstID.addDataColumn( new GauceDataColumn( "CHARGECODE", GauceDataColumn.TB_STRING,10 ) );
						if(porder_no ==null ){
							sql = new StringBuffer() ; 

							sql.append(" SELECT  ") ; 
							
							sql.append(" CASE WHEN MAX(CHARGECODE) IS NULL THEN  '00001' ") ; 
							sql.append(" WHEN LENGTH(TRIM(DEC(MAX(CHARGECODE))+ 1)) = 1 ") ; 
							sql.append(" THEN '0000' CONCAT CHAR(DEC(MAX(CHARGECODE))+ 1) ") ; 
							sql.append(" WHEN LENGTH(TRIM(DEC(MAX(CHARGECODE))+ 1)) = 2 ") ; 
							sql.append(" THEN '000' CONCAT CHAR(DEC(MAX(CHARGECODE))+ 1) ") ; 
							sql.append(" WHEN LENGTH(TRIM(DEC(MAX(CHARGECODE))+ 1)) = 3 ") ; 
							sql.append(" THEN CHAR(DEC(MAX(CHARGECODE))+ 1) ") ; 
							sql.append(" WHEN LENGTH(TRIM(DEC(MAX(CHARGECODE))+ 1)) = 4 ") ; 
							sql.append(" THEN '00' CONCAT CHAR(DEC(MAX(CHARGECODE))+ 1) ") ; 
							sql.append(" WHEN LENGTH(TRIM(DEC(MAX(CHARGECODE))+ 1)) = 5 ") ; 
							sql.append(" THEN '0' CONCAT CHAR(DEC(MAX(CHARGECODE))+ 1) ") ; 
							sql.append(" END AS CHARGECODE ") ; 
							sql.append(" FROM TRANSFER.LTPCKCHRG  ") ; 
					
							gsmt = conn.getGauceStatement(sql.toString());
							gsmt.executeQuery(dSetMstID);
							gsmt.close(); 
							 
							if ( dSetMstID!=null && dSetMstID.getDataRowCnt() > 0 ) {
												GauceDataRow[] dRowMstID = dSetMstID.getDataRows(); 
												porder_no = dRowMstID[0].getString(0);  
												logger.err.println(this,porder_no);   
							}
						}
	//logger.err.println(this,str2);  
	//	logger.err.println(this,str3);  
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO TRANSFER.LTPCKCHRG                          (  " );
				InsertSql.append( " CHARGECODE, PACK_TYPE, FROM_CBM, TO_CBM, UNIT_PRICE,       " );
				InsertSql.append( " RQST_PRICE, RQST_PRICE2, ACM_PRICE, EFF_DATE, EXP_DATE,    " );
				InsertSql.append( " CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_USR   )           " );
			
				InsertSql.append( " VALUES (  " );
				InsertSql.append( " ?, ?, ?, ?, ?,       " );
				InsertSql.append( " ?, ?, ?, ?, ?,    " );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str2 + "'," );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str3 + "' ) " );

//logger.err.println(this,InsertSql.toString());
						 
		
						gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows[j]);   

						gsmt.setString(1,porder_no.trim());
				//gsmt.bindColumn(1,idxCHARGECODE);
						gsmt.bindColumn(2,  idxPACK_TYPE);
						gsmt.bindColumn(3,  idxFROM_CBM);
						gsmt.bindColumn(4,  idxTO_CBM);
						gsmt.bindColumn(5,  idxUNIT_PRICE);

						gsmt.bindColumn(6,  idxRQST_PRICE);
						gsmt.bindColumn(7,  idxRQST_PRICE2);
						gsmt.bindColumn(8,  idxACM_PRICE);
						gsmt.bindColumn(9,  idxEFF_DATE);
						gsmt.bindColumn(10, idxEXP_DATE);

					
						gsmt.executeUpdate();
						gsmt.close();
//logger.err.println(this,"test11112");
//logger.err.println(this,InsertSql.toString());
					}
				

				if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
//logger.err.println(this,   "update" + String.valueOf(GauceDataRow.TB_JOB_UPDATE)  ); 					
				
				UpdateSql = new StringBuffer();

				UpdateSql.append( " UPDATE TRANSFER.LTPCKCHRG SET " );
				UpdateSql.append( "        PACK_TYPE = ?, " );
				UpdateSql.append( "        FROM_CBM = ?, " );
				UpdateSql.append( "        TO_CBM = ?," );
				UpdateSql.append( "        UNIT_PRICE = ?," );

				UpdateSql.append( "        RQST_PRICE = ?," );
				UpdateSql.append( "        RQST_PRICE2 = ?," );
				UpdateSql.append( "        ACM_PRICE = ?," );
				UpdateSql.append( "        EFF_DATE = ?," );
				UpdateSql.append( "        EXP_DATE = ?," );

				UpdateSql.append( "        UPDATE_DT = CURRENT TIMESTAMP," );
				UpdateSql.append( "        UPDATE_USR  = '" + str2 + "'" );
				UpdateSql.append( " WHERE CHARGECODE = ? " );


						gsmt = conn.getGauceStatement(UpdateSql.toString());
//logger.err.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]); 

						gsmt.bindColumn(1,  idxPACK_TYPE);
						gsmt.bindColumn(2,  idxFROM_CBM);
						gsmt.bindColumn(3,  idxTO_CBM);
						gsmt.bindColumn(4,  idxUNIT_PRICE);

						gsmt.bindColumn(5,  idxRQST_PRICE);
						gsmt.bindColumn(6,  idxRQST_PRICE2);
						gsmt.bindColumn(7,  idxACM_PRICE);
						gsmt.bindColumn(8,  idxEFF_DATE);
						gsmt.bindColumn(9,  idxEXP_DATE);
						gsmt.bindColumn(10, idxCHARGECODE);
		
						gsmt.executeUpdate(); 
						gsmt.close();         
//  		logger.err.println(this,"test255555555");	                            
					}    
				
				
//logger.dbg.println(this,UpdateSql.toString());
//logger.err.println(this,"test1");	

			if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTPCKCHRG " );
				DeleteSql.append( " WHERE CHARGECODE = ? " );

				
			
//logger.dbg.println(this,DeleteSql.toString());
					
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCHARGECODE);
					
						gsmt.executeUpdate();
						gsmt.close();
						logger.err.println(this,DeleteSql.toString());
				}
				}
			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.err.println(this,se.toString());
				//logger.err.println(this,se);
				//logger.err.println(this,se.toString());
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			//logger.err.println(this,e);
			//logger.err.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}