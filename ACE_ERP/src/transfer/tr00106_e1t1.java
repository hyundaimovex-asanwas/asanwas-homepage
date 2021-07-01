package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00106_e1t1 extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
	    GauceDataSet dSetMstID = null;
		GauceStatement gsmt = null ; 

		try{
			//loader = new ServiceLoader(req, res);
			loader = new com.gauce.ServiceLoader(req, res);
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
				logger.dbg.println(this,"start");

//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxCAR_NO      = userSet.indexOfColumn("CAR_NO");
				int idxCARTYPENO   = userSet.indexOfColumn("CARTYPENO");

				int idxPERSON_NO   = userSet.indexOfColumn("PERSON_NO");
				int idxPSN_KNAME   = userSet.indexOfColumn("PSN_KNAME");
				int idxREG_NO      = userSet.indexOfColumn("REG_NO");

				int idxCREATE_DT   = userSet.indexOfColumn("CREATE_DT");
				int idxCREATE_USR  = userSet.indexOfColumn("CREATE_USR");
				int idxUPDATE_DT   = userSet.indexOfColumn("UPDATE_DT");
				int idxUPDATE_UST  = userSet.indexOfColumn("UPDATE_UST");
				int idxUPDATE_USR  = userSet.indexOfColumn("UPDATE_USR");
				int idxTEL_NO      = userSet.indexOfColumn("TEL_NO");

	
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer InsertSqll = null;
				StringBuffer UpdateSql = null;
				StringBuffer UpdateSqll = null;
				StringBuffer DeleteSql = null;
				StringBuffer DeleteSqll = null;
				StringBuffer sql = null;  

for (int j = 0; j < rows.length; j++){
				int  ls_value = rows[j].getJobType() ; 

if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) { 


/***************************************************************************************************
		Description  : Get PlNo
***************************************************************************************************/
	dSetMstID = new GauceDataSet(); 
					  dSetMstID.addDataColumn( new GauceDataColumn( "PERSON_NO", GauceDataColumn.TB_STRING,10 ) );
						if(porder_no ==null ){
												sql = new StringBuffer() ; 

												sql.append(" SELECT  ") ; 
												sql.append(" CASE WHEN MAX(PERSON_NO) IS NULL THEN  '0000000001' ") ; 
												sql.append(" WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 1 ") ; 
												sql.append(" THEN '000000000' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1) ") ; 

												sql.append(" WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 2 ") ; 
												sql.append(" THEN '00000000' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1) ") ; 
  											sql.append("  WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 3 ") ; 
												sql.append(" THEN CHAR(DEC(MAX(PERSON_NO))+ 1) ") ; 
												sql.append(" WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 4 ") ; 
												sql.append(" THEN '0000000' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1) ") ; 
												sql.append(" WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 5 ") ; 
												sql.append(" THEN '000000' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1) ") ; 
												sql.append(" WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 6 ") ; 
												sql.append(" THEN '00000' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1) ") ; 
												sql.append(" WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 7 ") ; 
												sql.append(" THEN '0000' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1) ") ; 
												sql.append(" WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 8 ") ; 
												sql.append(" THEN '000' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1) ") ; 
												sql.append(" WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 9 ") ; 
												sql.append(" THEN '00' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1) ") ; 
												sql.append(" WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 10 ") ; 
												sql.append(" THEN '0' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1) ") ; 
												sql.append(" END AS PERSON_NO ") ; 
												sql.append(" FROM TRANSFER.LTPERSON  ") ; 
												
												gsmt = conn.getGauceStatement(sql.toString());
												gsmt.executeQuery(dSetMstID);
												gsmt.close(); 
												 
												if ( dSetMstID!=null && dSetMstID.getDataRowCnt() > 0 ) {
																	GauceDataRow[] dRowMstID = dSetMstID.getDataRows(); 
																	porder_no = dRowMstID[0].getString(0);  
																	logger.dbg.println(this,porder_no);   
												}
						}
	//logger.dbg.println(this,str2);  
	
			
				InsertSqll = new StringBuffer();
				InsertSqll.append( " INSERT INTO TRANSFER.LTPERSON         (  " );
				InsertSqll.append( " PERSON_NO, PSN_KNAME, REG_NO, TEL_NO,         \n " );
				InsertSqll.append( " CREATE_DT, CREATE_USR,                \n " );
				
				InsertSqll.append( " UPDATE_DT, UPDATE_USR   )                " );
			
				InsertSqll.append( " VALUES (                                 " );
				InsertSqll.append( " ?, ?, ?, ?,                             \n " );
				
				InsertSqll.append( " CURRENT TIMESTAMP, '"	+ str2 + "'," );
				InsertSqll.append( " CURRENT TIMESTAMP, '"	+ str3 + "' ) " );

				
						gsmt = conn.getGauceStatement(InsertSqll.toString());
						gsmt.setGauceDataRow(rows[j]);
//logger.dbg.println(this,"test11116");	
						gsmt.setString(1,porder_no.trim());
						//gsmt.bindColumn(1,  idxPERSON_NO);
						gsmt.bindColumn(2,  idxPSN_KNAME);
						gsmt.bindColumn(3,  idxREG_NO);
						gsmt.bindColumn(4,  idxTEL_NO);
						gsmt.executeUpdate();
						gsmt.close();

					}
if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) { 
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO TRANSFER.LTCARINFO       (  " );
				InsertSql.append( " CAR_NO, PERSON_NO, CARTYPENO,        \n " );
				InsertSql.append( " CREATE_DT, CREATE_USR,               \n " );
				InsertSql.append( " UPDATE_DT, UPDATE_UST   )               " );
			
				InsertSql.append( " VALUES (                                " );
				InsertSql.append( " ?, ?, ?,                             \n " );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str2 + "'," );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str3 + "' ) " );

						gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows[j]);
	
//logger.dbg.println(this,"test6");	
				
						gsmt.bindColumn(1,  idxCAR_NO);
						gsmt.setString(2,porder_no.trim());
						//gsmt.bindColumn(2,  idxPERSON_NO);
						gsmt.bindColumn(3,  idxCARTYPENO);
						gsmt.executeUpdate();
						gsmt.close();
//logger.err.println(this,"test11112");
//logger.err.println(this,InsertSql.toString());
					}


//logger.dbg.println(this,InsertSqll.toString());
//logger.dbg.println(this,InsertSql.toString());

if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
				UpdateSql = new StringBuffer();

				UpdateSql.append( " UPDATE TRANSFER.LTCARINFO SET " );
				UpdateSql.append( "        PERSON_NO = ?, " );
				UpdateSql.append( "        CARTYPENO = ?, " );
				UpdateSql.append( "        UPDATE_DT = CURRENT TIMESTAMP," );
				UpdateSql.append( "        UPDATE_UST  = '" + str2 + "'" );
				UpdateSql.append( " WHERE CAR_NO = ? " );

						
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxPERSON_NO);
						gsmt.bindColumn(2,  idxCARTYPENO);
						gsmt.bindColumn(3,  idxCAR_NO);
						
						gsmt.executeUpdate(); 
						gsmt.close();         
                          
					}    
if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
			
				UpdateSqll = new StringBuffer();
				UpdateSqll.append( " UPDATE TRANSFER.LTPERSON SET " );
				UpdateSqll.append( "        PSN_KNAME = ?, " );
				UpdateSqll.append( "        REG_NO = ?, " );
				UpdateSqll.append( "        TEL_NO = ?, " );
				UpdateSqll.append( "        UPDATE_DT = CURRENT TIMESTAMP," );
				UpdateSqll.append( "        UPDATE_USR  = '" + str2 + "'" );
				UpdateSqll.append( " WHERE PERSON_NO = ? " );

						
						gsmt = conn.getGauceStatement(UpdateSqll.toString());
						gsmt.setGauceDataRow(rows[j]);
		
						gsmt.bindColumn(1,  idxPSN_KNAME);
						gsmt.bindColumn(2,  idxREG_NO);
						gsmt.bindColumn(3,  idxTEL_NO);
						gsmt.bindColumn(4,  idxPERSON_NO);
						
						gsmt.executeUpdate(); 
						gsmt.close();         
//logger.dbg.println(this,"test255555555");	                            
					}    

//logger.dbg.println(this,UpdateSql.toString());
//logger.dbg.println(this,UpdateSqll.toString());
//logger.dbg.println(this,"test11111111");		

			if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTCARINFO " );
				DeleteSql.append( " WHERE CAR_NO = ? " );

				
						//GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCAR_NO);
					
						gsmt.executeUpdate();
						gsmt.close();
//logger.dbg.println(this,DeleteSql.toString());
					}

		if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
				DeleteSqll = new StringBuffer();
				DeleteSqll.append( " DELETE FROM LTPERSON.LTPERSON " );
				DeleteSqll.append( " WHERE PERSON_NO = ? " );
			
//logger.dbg.println(this,DeleteSql.toString());

						gsmt = conn.getGauceStatement(DeleteSqll.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxPERSON_NO);
						gsmt.executeUpdate();
						gsmt.close();
//logger.dbg.println(this,DeleteSqll.toString());
						}
				}
			}
		catch(SQLException se){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.err.println(this,se.toString());
				
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.err.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}