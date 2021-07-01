package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class tr00510_t1 extends HttpServlet{

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
				logger.dbg.println(this,"start");


//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxPERSON_NO   = userSet.indexOfColumn("PERSON_NO");
				int idxPSN_KNAME   = userSet.indexOfColumn("PSN_KNAME");
				int idxPSN_ENAME   = userSet.indexOfColumn("PSN_ENAME");
				int idxZIPCODE     = userSet.indexOfColumn("ZIPCODE");
				int idxADDRESS1    = userSet.indexOfColumn("ADDRESS1");

				int idxADDRESS2    = userSet.indexOfColumn("ADDRESS2");
				int idxREG_NO      = userSet.indexOfColumn("REG_NO");
				int idxGENDER      = userSet.indexOfColumn("GENDER");
				int idxCOMPANY     = userSet.indexOfColumn("COMPANY");
				int idxPOSITION    = userSet.indexOfColumn("POSITION");

				int idxINVITENO    = userSet.indexOfColumn("INVITENO");
				int idxINVITESTS   = userSet.indexOfColumn("INVITESTS");
				int idxPURPOSE     = userSet.indexOfColumn("PURPOSE");
				int idxCREATE_DT   = userSet.indexOfColumn("CREATE_DT");
				int idxCREATE_USR  = userSet.indexOfColumn("CREATE_USR");

				int idxUPDATE_DT   = userSet.indexOfColumn("UPDATE_DT");
				int idxUPDATE_UST  = userSet.indexOfColumn("UPDATE_UST");
				int idxAPPRDATE    = userSet.indexOfColumn("APPRDATE");
				int idxRENEWDATE   = userSet.indexOfColumn("RENEWDATE");
				int idxENDDATE     = userSet.indexOfColumn("ENDDATE");
				int idxTEL_NO      = userSet.indexOfColumn("TEL_NO");
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer sql = null;  

for (int j = 0; j < rows.length; j++){
				int  ls_value = rows[j].getJobType() ; 
				 
// logger.err.println(this, "type"  + String.valueOf(ls_value)  ); 
//logger.err.println(this,   "insert" + S ring.valueOf(GauceDataRow.TB_JOB_INSERT)  ); 
//logger.err.println(this,   "update" + String.valueOf(GauceDataRow.TB_JOB_UPDATE)  ); 
//logger.err.println(this,   "delete" + String.valueOf(GauceDataRow.TB_JOB_DELETE)  ); 
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

											/* SELECT


CASE WHEN MAX(PERSON_NO) IS NULL THEN  '0000000001'
     WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 1
     THEN '000000000' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1)
     WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 2

     THEN '00000000' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1)

 WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 3
     THEN CHAR(DEC(MAX(PERSON_NO))+ 1)
     WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 4
     THEN '0000000' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1)
     WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 5
     THEN '000000' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1)
     WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 6
     THEN '00000' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1)
     WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 7
     THEN '0000' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1)
     WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 8
     THEN '000' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1)
     WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 9
     THEN '00' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1)
     WHEN LENGTH(TRIM(DEC(MAX(PERSON_NO))+ 1)) = 10
     THEN '0' CONCAT CHAR(DEC(MAX(PERSON_NO))+ 1)
     END AS PERSON_NO
 FROM TRANSFER.LTPERSON */




												gsmt = conn.getGauceStatement(sql.toString());
												gsmt.executeQuery(dSetMstID);
												gsmt.close(); 
												 
												if ( dSetMstID!=null && dSetMstID.getDataRowCnt() > 0 ) {
																	GauceDataRow[] dRowMstID = dSetMstID.getDataRows(); 
																	porder_no = dRowMstID[0].getString(0);  
																	logger.dbg.println(this,porder_no);   
												}
						}
	logger.dbg.println(this,str2);  

				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO TRANSFER.LTPERSON                          (  " );
				InsertSql.append( " PERSON_NO, PSN_KNAME, PSN_ENAME, ZIPCODE, ADDRESS1,       " );
				InsertSql.append( " ADDRESS2, REG_NO, GENDER, COMPANY, POSITION,              " );
				InsertSql.append( " INVITENO, INVITESTS, PURPOSE, CREATE_DT, CREATE_USR,       " );
				InsertSql.append( " UPDATE_DT, UPDATE_USR, APPRDATE, RENEWDATE, ENDDATE, TEL_NO    )    " );
			
				InsertSql.append( " VALUES (              " );
				InsertSql.append( " ?, ?, ?, ?, ?,       " );
				InsertSql.append( " ?, ?, ?, ?, ?,              " );
				InsertSql.append( " ?, ?, ?,       " );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str2 + "'," );
				InsertSql.append( " CURRENT TIMESTAMP, '"	+ str3 + "', " );
				InsertSql.append( " ?, ?, ?, ?    )    " );

				//for (int j = 0; j < rows.length; j++){
//logger.err.println(this,"test3");
				///	if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
//logger.err.println(this,"test4");
//						String test1 = rows[j].getString(idxCAR_SEQ_NO);
//						String test2 = rows[j].getString(idxACCSECTION);
//						String test3 = rows[j].getString(idxCAR_NO);
//						String test4 = rows[j].getString(idxCAR_TYPE);

//						logger.dbg.println(this,test1 + ":"+ test2 +":"+test3+":"+test4);
						
						
//logger.err.println(this,"test5");
						
						gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows[j]);

logger.dbg.println(this,"test6");	
						gsmt.setString(1,porder_no.trim());
						//gsmt.bindColumn(1,  idxPERSON_NO);
						gsmt.bindColumn(2,  idxPSN_KNAME);
						gsmt.bindColumn(3,  idxPSN_ENAME);
						gsmt.bindColumn(4,  idxZIPCODE);
						gsmt.bindColumn(5,  idxADDRESS1);

						gsmt.bindColumn(6,  idxADDRESS2);
						gsmt.bindColumn(7,  idxREG_NO);
						gsmt.bindColumn(8,  idxGENDER);
						gsmt.bindColumn(9,  idxCOMPANY);
						gsmt.bindColumn(10, idxPOSITION);

						gsmt.bindColumn(11, idxINVITENO);
						gsmt.bindColumn(12, idxINVITESTS);
						gsmt.bindColumn(13, idxPURPOSE);
						gsmt.bindColumn(14, idxAPPRDATE);
						gsmt.bindColumn(15, idxRENEWDATE);
						gsmt.bindColumn(16, idxENDDATE);
						gsmt.bindColumn(17, idxTEL_NO);

						
						
						gsmt.executeUpdate();
						gsmt.close();
//logger.err.println(this,"test11112");
logger.dbg.println(this,InsertSql.toString());
					}
			

//logger.dbg.println(this,InsertSql.toString());
		if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

				UpdateSql = new StringBuffer();

				UpdateSql.append( " UPDATE TRANSFER.LTPERSON SET " );
				UpdateSql.append( "        PSN_KNAME = ?, " );
				UpdateSql.append( "        PSN_ENAME = ?, " );
				UpdateSql.append( "        ZIPCODE = ?," );
				UpdateSql.append( "        ADDRESS1 = ?," );

				UpdateSql.append( "        ADDRESS2 = ?," );
				UpdateSql.append( "        REG_NO = ?," );
				UpdateSql.append( "        GENDER = ?," );
				UpdateSql.append( "        COMPANY = ?," );
				UpdateSql.append( "        POSITION = ?," );

				UpdateSql.append( "        INVITENO = ?," );
				UpdateSql.append( "        INVITESTS = ?," );
				UpdateSql.append( "        PURPOSE = ?," );

				UpdateSql.append( "        UPDATE_DT = CURRENT TIMESTAMP," );
				UpdateSql.append( "        UPDATE_USR  = '" + str2 + "'," );

				UpdateSql.append( "        APPRDATE = ?," );
				UpdateSql.append( "        RENEWDATE = ?," );
				UpdateSql.append( "        ENDDATE = ?, " );
				UpdateSql.append( "        TEL_NO = ? " );

				UpdateSql.append( " WHERE PERSON_NO = ? " );


logger.dbg.println(this,"test32323");
//logger.err.println(this,UpdateSql.toString());

						//GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt = conn.getGauceStatement(UpdateSql.toString()); 
						gsmt.setGauceDataRow(rows[j]);
		
						gsmt.bindColumn(1,  idxPSN_KNAME);
						gsmt.bindColumn(2,  idxPSN_ENAME);
						gsmt.bindColumn(3,  idxZIPCODE);
						gsmt.bindColumn(4,  idxADDRESS1);
						gsmt.bindColumn(5,  idxADDRESS2);

						gsmt.bindColumn(6,  idxREG_NO);
						gsmt.bindColumn(7,  idxGENDER);
						gsmt.bindColumn(8,  idxCOMPANY);
						gsmt.bindColumn(9,  idxPOSITION);
						gsmt.bindColumn(10, idxINVITENO);

						gsmt.bindColumn(11, idxINVITESTS);
						gsmt.bindColumn(12, idxPURPOSE);
						gsmt.bindColumn(13, idxAPPRDATE);
						gsmt.bindColumn(14, idxRENEWDATE);
						gsmt.bindColumn(15, idxENDDATE);
						gsmt.bindColumn(16, idxTEL_NO);
						

						gsmt.bindColumn(17, idxPERSON_NO);
						

						gsmt.executeUpdate(); 
						gsmt.close();         
logger.dbg.println(this,"test255555555");	                            
					}    
				
				
//logger.dbg.println(this,UpdateSql.toString());
//logger.err.println(this,"test1");		
if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM TRANSFER.LTPERSON " );
				DeleteSql.append( " WHERE PERSON_NO = ? " );
			
//logger.dbg.println(this,DeleteSql.toString());
					
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxPERSON_NO);
					
						gsmt.executeUpdate();
						gsmt.close();
						logger.err.println(this,DeleteSql.toString());
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