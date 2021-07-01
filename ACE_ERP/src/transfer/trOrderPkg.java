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

public class trOrderPkg extends HttpServlet{

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
				String str2 = reqGauce.getParameter("gstr2"); 
   				if ( str2==null || str2.trim().length()==0 ) { str2=null; }
				String str3 = reqGauce.getParameter("gstr3"); 
   				if ( str3==null || str3.trim().length()==0 ) { str3=null; }
        String enter_no = null ;         
				//logger.err.println(this,"start");

				 

//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				
					//int idxPORDER_NO   =userSet.indexOfColumn("PORDER_NO") ;
					int idxORDER_DATE  =userSet.indexOfColumn("ORDER_DATE") ;
					int idxWORK_FORM   =userSet.indexOfColumn("WORK_FORM") ;
					int idxCUST_CD     =userSet.indexOfColumn("CUST_CD") ;
					int idxARTC_CD     =userSet.indexOfColumn("ARTC_CD") ;
					int idxARTC_NM     =userSet.indexOfColumn("ARTC_NM") ;
					int idxENTER_STS   =userSet.indexOfColumn("ENTER_STS") ;
					int idxPKG_FORM    =userSet.indexOfColumn("PKG_FORM") ;
					int idxPKG_CNT     =userSet.indexOfColumn("PKG_CNT") ;
					int idxPKG_UNIT    =userSet.indexOfColumn("PKG_UNIT") ;
					int idxWAREHOUSE   =userSet.indexOfColumn("WAREHOUSE") ;
					int idxBFILE_NAME  =userSet.indexOfColumn("BFILE_NAME") ;
					int idxREMARK      =userSet.indexOfColumn("REMARK") ;
					int idxORDER_STS   =userSet.indexOfColumn("ORDER_STS") ;
					int idxORDER_CHK   =userSet.indexOfColumn("ORDER_CHK") ;
					int idxEND_DATE    =userSet.indexOfColumn("END_DATE") ;
					int idxEND_TIME    =userSet.indexOfColumn("END_TIME") ;
					int idxAFILE_NAME  =userSet.indexOfColumn("AFILE_NAME") ;
					int idxCREATE_DT   =userSet.indexOfColumn("CREATE_DT") ;
					int idxCREATE_USR  =userSet.indexOfColumn("CREATE_USR") ;
					int idxUPDATE_DT   =userSet.indexOfColumn("UPDATE_DT") ;
					int idxUPDATE_USR  =userSet.indexOfColumn("UPDATE_USR") ;
					int idxBFILE= userSet.indexOfColumn("BFILE");
					int idxAFILE= userSet.indexOfColumn("AFILE"); 
					int idxPACK_TYPE= userSet.indexOfColumn("PACK_TYPE");
					int idxACM_YM= userSet.indexOfColumn("ACM_YM");
					

				 logger.err.println(this,"stART" ); 
				 

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  
				StringBuffer sql = null;  

				//logger.err.println(this,"start2");

				for (int j = 0; j < rows.length; j++){
				int  ls_value = rows[j].getJobType() ; 
				 
 logger.err.println(this, "type"  + String.valueOf(ls_value)  ); 
//logger.err.println(this,   "insert" + S ring.valueOf(GauceDataRow.TB_JOB_INSERT)  ); 
//logger.err.println(this,   "update" + String.valueOf(GauceDataRow.TB_JOB_UPDATE)  ); 
//logger.err.println(this,   "delete" + String.valueOf(GauceDataRow.TB_JOB_DELETE)  ); 
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) { 


/***************************************************************************************************8
		Description  : Get PlNo
	****************************************************************************************************/
	/*					dSetMstID = new GauceDataSet(); 
					  dSetMstID.addDataColumn( new GauceDataColumn( "PORDER_NO", GauceDataColumn.TB_STRING, 12 ) );
						if(porder_no ==null ){
												sql = new StringBuffer() ; 

												sql.append(" SELECT 'P' CONCAT ") ; 
												sql.append(" SUBSTRING(CHAR(CURRENT DATE),1,4) CONCAT ") ; 
												sql.append(" SUBSTRING(CHAR(CURRENT DATE),6,2) CONCAT ") ; 
												sql.append(" SUBSTRING(CHAR(CURRENT DATE),9,2) CONCAT ") ;  
												sql.append(" CASE WHEN MAX(PORDER_NO) IS NULL THEN  '001' ") ; 
												sql.append(" WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(PORDER_NO,10,3)))+ 1)) = 1 ") ; 
												sql.append(" THEN '00' CONCAT CHAR(DEC(MAX(SUBSTRING(PORDER_NO,10,3)))+ 1) ") ; 
												sql.append(" WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(PORDER_NO,10,3)))+ 1)) = 2 ") ; 
												sql.append(" THEN '0' CONCAT CHAR(DEC(MAX(SUBSTRING(PORDER_NO,10,3)))+ 1) ") ; 
  											sql.append(" WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(PORDER_NO,10,3)))+ 1)) = 3 ") ; 
												sql.append(" THEN CHAR(DEC(MAX(SUBSTRING(PORDER_NO,10,3)))+ 1) ") ; 
												sql.append(" END AS PORDER_NO ") ; 
												sql.append(" FROM TRANSFER.LTORDPACK  ") ; 
												sql.append(" WHERE PORDER_NO LIKE 'P' CONCAT ") ;  
												sql.append("SUBSTRING(CHAR(CURRENT DATE),1,4) CONCAT  ") ;  
												sql.append(" SUBSTRING(CHAR(CURRENT DATE),6,2) CONCAT  ") ;  
												sql.append(" SUBSTRING(CHAR(CURRENT DATE),9,2) CONCAT '%'  ") ;  

												gsmt = conn.getGauceStatement(sql.toString());
												gsmt.executeQuery(dSetMstID);
												gsmt.close(); 
												 
												if ( dSetMstID!=null && dSetMstID.getDataRowCnt() > 0 ) {
																	GauceDataRow[] dRowMstID = dSetMstID.getDataRows(); 
																	porder_no = dRowMstID[0].getString(0);  
																	logger.err.println(this,porder_no);   
												}
						}
*/
						InsertSql = new StringBuffer();
																			InsertSql.append(" INSERT INTO TRANSFER.LTORDPACK ( ") ; 
																			InsertSql.append(" PORDER_NO,ORDER_DATE,WORK_FORM, ") ; 
																			InsertSql.append(" CUST_CD,ARTC_CD,ARTC_NM,ENTER_STS,") ; 
																			InsertSql.append(" PKG_FORM,PKG_CNT,PKG_UNIT,WAREHOUSE,") ; 
																			InsertSql.append(" BFILE_NAME,REMARK,ORDER_STS,ORDER_CHK,END_DATE,END_TIME,") ; 
																			InsertSql.append(" AFILE_NAME,CREATE_DT,CREATE_USR,UPDATE_DT,UPDATE_USR ") ; 
																			InsertSql.append(" ,PACK_TYPE,ACM_YM ") ; 
//if(str2 !=null && str2.equals("T")){	InsertSql.append(" ,BFILE"); }
//if(str3 !=null && str3.equals("T")){	InsertSql.append(" ,AFILE ") ; }
																			InsertSql.append(" ) ") ;  
																			InsertSql.append(" Values( ") ; 
																			InsertSql.append(" ?,?,?, ") ; 
																			InsertSql.append(" ?,?,?,?,") ; 
																			InsertSql.append(" ?,?,?,?,") ; 
																			InsertSql.append(" ?,?,?,?,?,?,") ; 
																			InsertSql.append(" ?,CURRENT TIMESTAMP,?,CURRENT TIMESTAMP,? ") ; 
//if(str2 !=null && str2.equals("T")){	InsertSql.append(" ,? ") ; }
//if(str3 !=null && str3.equals("T")){	InsertSql.append(" ,? ") ; }
																			InsertSql.append(" ,?,? ") ; 
																			InsertSql.append(") ") ; 
												
logger.err.println(this,InsertSql.toString());
						 
												gsmt = conn.getGauceStatement(InsertSql.toString()); 
												gsmt.setGauceDataRow(rows[j]);  
											
												gsmt.setString(1,porder_no);
												gsmt.bindColumn(2,idxORDER_DATE);
												gsmt.bindColumn(3,idxWORK_FORM);
												gsmt.bindColumn(4,idxCUST_CD);							 
												gsmt.bindColumn(5,idxARTC_CD);									 
												gsmt.bindColumn(6,idxARTC_NM);	
												gsmt.bindColumn(7,idxENTER_STS);	
												gsmt.bindColumn(8,idxPKG_FORM);	 
												gsmt.bindColumn(9,idxPKG_CNT);	 
												gsmt.bindColumn(10,idxPKG_UNIT);	 
												gsmt.bindColumn(11,idxWAREHOUSE);	
												gsmt.bindColumn(12,idxBFILE_NAME);	
												gsmt.bindColumn(13,idxREMARK);	
												gsmt.bindColumn(14,idxORDER_STS);	 
												gsmt.bindColumn(15,idxORDER_CHK);	
												gsmt.bindColumn(16,idxEND_DATE);	
												gsmt.bindColumn(17,idxEND_TIME);
												gsmt.bindColumn(18,idxAFILE_NAME);
												gsmt.bindColumn(19,idxCREATE_USR);
												gsmt.bindColumn(20,idxUPDATE_USR);  
												gsmt.bindColumn(21,idxPACK_TYPE);
												gsmt.bindColumn(22,idxACM_YM); 
//if(str2 !=null && str2.equals("T")){			InputStream nst_file = (InputStream) rows[j].getInputStream(idxBFILE);
//												gsmt.setBinaryStream(21, nst_file, nst_file.available());	 //첨부파일 
//												 }
//if(str3 !=null && str3.equals("T") && str2.equals("T"))
//												{			InputStream nst_file1 = (InputStream) rows[j].getInputStream(idxAFILE);
//												gsmt.setBinaryStream(22, nst_file1, nst_file1.available());	 //첨부파일 
//												 }
//if(str3 !=null && str3.equals("T") && str2.equals("F"))
//												{			InputStream nst_file1 = (InputStream) rows[j].getInputStream(idxAFILE);
//												gsmt.setBinaryStream(21, nst_file1, nst_file1.available());	 //첨부파일 
//												 }
												gsmt.executeUpdate(); 
												gsmt.close();  

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
logger.err.println(this,   "update" + String.valueOf(GauceDataRow.TB_JOB_UPDATE)  ); 					
																			UpdateSql = new StringBuffer();
																			UpdateSql.append(" UPDATE TRANSFER.LTORDPACK SET ") ; 
																			UpdateSql.append(" ORDER_DATE = ?,WORK_FORM = ?, ") ; 
																			UpdateSql.append(" CUST_CD= ?,ARTC_CD= ?,ARTC_NM= ?,ENTER_STS= ?,") ; 
																			UpdateSql.append(" PKG_FORM= ?,PKG_CNT= ?,PKG_UNIT= ?,WAREHOUSE= ?,") ; 
																			UpdateSql.append(" BFILE_NAME= ?,REMARK= ?,ORDER_STS= ?,ORDER_CHK= ?,END_DATE= ?,END_TIME= ?,") ; 
																			UpdateSql.append(" AFILE_NAME= ?,UPDATE_DT=CURRENT TIMESTAMP,UPDATE_USR = ?  ") ; 
																			UpdateSql.append(" ,PACK_TYPE = ?,ACM_YM  = ? ") ; 
//if(str2 !=null && str2.equals("T")){	UpdateSql.append(",BFILE = ? ") ; }
//if(str2 !=null && str3.equals("T")){  UpdateSql.append(",AFILE = ? ") ;  }
												UpdateSql.append(" WHERE PORDER_NO = ?   ") ;  
						
												gsmt = conn.getGauceStatement(UpdateSql.toString());
												logger.err.println(this,UpdateSql.toString());
												gsmt.setGauceDataRow(rows[j]);  
												
												gsmt.bindColumn(1,idxORDER_DATE);
												gsmt.bindColumn(2,idxWORK_FORM);
												gsmt.bindColumn(3,idxCUST_CD);							 
												gsmt.bindColumn(4,idxARTC_CD);									 
												gsmt.bindColumn(5,idxARTC_NM);	
												gsmt.bindColumn(6,idxENTER_STS);	
												gsmt.bindColumn(7,idxPKG_FORM);	 
												gsmt.bindColumn(8,idxPKG_CNT);	 
												gsmt.bindColumn(9,idxPKG_UNIT);	 
												gsmt.bindColumn(10,idxWAREHOUSE);	
												gsmt.bindColumn(11,idxBFILE_NAME);	
												gsmt.bindColumn(12,idxREMARK);	
												gsmt.bindColumn(13,idxORDER_STS);	 
												gsmt.bindColumn(14,idxORDER_CHK);	
												gsmt.bindColumn(15,idxEND_DATE);	
												gsmt.bindColumn(16,idxEND_TIME);
												gsmt.bindColumn(17,idxAFILE_NAME); 
												gsmt.bindColumn(18,idxUPDATE_USR); 
												gsmt.bindColumn(19,idxPACK_TYPE);
												gsmt.bindColumn(20,idxACM_YM); 
												
//if(str2 !=null && str2.equals("T")){			InputStream nst_file = (InputStream) rows[j].getInputStream(idxBFILE);
//												gsmt.setBinaryStream(19, nst_file, nst_file.available());	 //첨부파일 
//												 }
//if(str3 !=null && str3.equals("T") && str2.equals("T"))
//												{			InputStream nst_file1 = (InputStream) rows[j].getInputStream(idxAFILE);
//												gsmt.setBinaryStream(20, nst_file1, nst_file1.available());	 //첨부파일 
//												gsmt.setString(21,porder_no);
//												 }
//if(str3 !=null && str3.equals("T") && str2.equals("F"))
//												{			InputStream nst_file1 = (InputStream) rows[j].getInputStream(idxAFILE);
//												gsmt.setBinaryStream(19, nst_file1, nst_file1.available());	 //첨부파일 
//												gsmt.setString(20,porder_no);
//												 }
//if(str3 !=null && str3.equals("F") && str2.equals("T"))
//												{			InputStream nst_file1 = (InputStream) rows[j].getInputStream(idxAFILE);
//															gsmt.setString(20,porder_no);
//												 }

//if((str3 ==null && str2 ==null ) ||  (str2.equals("F") && str3.equals("F")))
//												{			InputStream nst_file1 = (InputStream) rows[j].getInputStream(idxAFILE);
//															gsmt.setString(19,porder_no);
//												 }
														
														gsmt.setString(21,porder_no); 


						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						
						DeleteSql = new StringBuffer();
						DeleteSql.append(" DELETE FROM  TRANSFER.LTORDPACK  ") ; 
						DeleteSql.append(" WHERE PORDER_NO = ?  ") ; 
						
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						////logger.err.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.setString(1,porder_no);
						/*gsmt.bindColumn(1, idxCAR_TYPE);*/
						gsmt.executeUpdate();
						gsmt.close();
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