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

public class tr00508_t1 extends HttpServlet{

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
				
				
			//	int idxPORDER_NO   = userSet.indexOfColumn("PORDER_NO") ;
				int idxCHARGECODE  = userSet.indexOfColumn("CHARGECODE");
				int idxEFF_DATE    = userSet.indexOfColumn("EFF_DATE");
				int idxEXP_DATE    = userSet.indexOfColumn("EXP_DATE");
				int idxLINE_PART   = userSet.indexOfColumn("LINE_PART");
				int idxCLASS       = userSet.indexOfColumn("CLASS");

				int idxSECTION     = userSet.indexOfColumn("SECTION");
				int idxSECTION2    = userSet.indexOfColumn("SECTION2");
				int idxARTC_CD     = userSet.indexOfColumn("ARTC_CD");
				int idxLOGIS_TYPE  = userSet.indexOfColumn("LOGIS_TYPE");
				int idxLOGIS_UNIT  = userSet.indexOfColumn("LOGIS_UNIT");

				int idxUNIT_PRICE  = userSet.indexOfColumn("UNIT_PRICE");
				int idxRQST_PRICE  = userSet.indexOfColumn("RQST_PRICE");
				int idxRQST_PRICE2 = userSet.indexOfColumn("RQST_PRICE2");
				int idxRQST_PRCNT  = userSet.indexOfColumn("RQST_PRCNT");
				int idxCURRENCY    = userSet.indexOfColumn("CURRENCY");

				int idxCAR_CLASS   = userSet.indexOfColumn("CAR_CLASS");
				int idxCANCLE1     = userSet.indexOfColumn("CANCLE1");
				int idxCANCLE2     = userSet.indexOfColumn("CANCLE2");
				int idxCANCLE3     = userSet.indexOfColumn("CANCLE3");
				int idxCANCLE4     = userSet.indexOfColumn("CANCLE4");

				int idxCANCLE5     = userSet.indexOfColumn("CANCLE5");
				int idxCREATE_DT   = userSet.indexOfColumn("CREATE_DT");
				int idxCREATE_USR  = userSet.indexOfColumn("CREATE_USR");
				int idxUPDATE_DT   = userSet.indexOfColumn("UPDATE_DT");
				int idxUPDATE_UST  = userSet.indexOfColumn("UPDATE_UST");
				

				// logger.err.println(this,"stART" ); 
				 

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  
				StringBuffer sql = null;  

				//logger.err.println(this,"start2");

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
					  dSetMstID.addDataColumn( new GauceDataColumn( "CHARGECODE", GauceDataColumn.TB_STRING,10 ) );
						if(porder_no ==null ){
												sql = new StringBuffer() ; 

												sql.append(" SELECT  ") ; 
												//sql.append(" SELECT 'P' CONCAT ") ; 
												//sql.append(" SUBSTRING(CHAR(CURRENT DATE),1,4) CONCAT ") ; 
												//sql.append(" SUBSTRING(CHAR(CURRENT DATE),6,2) CONCAT ") ; 
												//sql.append(" SUBSTRING(CHAR(CURRENT DATE),9,2) CONCAT ") ;  
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
												sql.append(" FROM TRANSFER.LTCHARGE  ") ; 
											//	sql.append(" WHERE CHARGECODE LIKE 'P' CONCAT ") ;  
												//sql.append(" WHERE CHARGECODE LIKE 'P' CONCAT ") ; 
											//	sql.append("SUBSTRING(CHAR(CURRENT DATE),1,4) CONCAT  ") ;  
											//	sql.append(" SUBSTRING(CHAR(CURRENT DATE),6,2) CONCAT  ") ;  
											//	sql.append(" SUBSTRING(CHAR(CURRENT DATE),9,2) CONCAT '%'  ") ;  


											/* SELECT

 CASE WHEN MAX(CHARGECODE) IS NULL THEN  '001'
 WHEN LENGTH(TRIM(DEC(MAX(CHARGECODE))+ 1)) = 1
 THEN '00' CONCAT CHAR(DEC(MAX(CHARGECODE ))+ 1)
 WHEN LENGTH(TRIM(DEC(MAX(CHARGECODE))+ 1)) = 2
 THEN '0' CONCAT CHAR(DEC(MAX(CHARGECODE ))+ 1)
 WHEN LENGTH(TRIM(DEC(MAX(CHARGECODE))+ 1)) = 3
 THEN CHAR(DEC(MAX(CHARGECODE ))+ 1)
 END AS CHARGECODE
 FROM TRANSFER.LTCHARGE*/


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
					InsertSql.append( " INSERT INTO TRANSFER.LTCHARGE                          (  " );
					InsertSql.append( " CHARGECODE, EFF_DATE, EXP_DATE, LINE_PART, CLASS,          \n " );
					InsertSql.append( " SECTION, SECTION2, ARTC_CD, LOGIS_TYPE, LOGIS_UNIT,        \n " );
					InsertSql.append( " UNIT_PRICE, RQST_PRICE, RQST_PRICE2, RQST_PRCNT, CURRENCY, \n " );
					InsertSql.append( " CAR_CLASS, CANCLE1, CANCLE2, CANCLE3, CANCLE4, \n " );
					InsertSql.append( " CANCLE5, CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_USR )   " );
					InsertSql.append( " VALUES (   " );
					InsertSql.append( " ?, ?, ?, ?, ?,          \n " );
					InsertSql.append( " ?, ?, ?, ?, ?,        \n " );
					InsertSql.append( " ?, ?, ?, ?, ?, \n " );
					InsertSql.append( " ?, ?, ?, ?, ?, \n " );
					InsertSql.append( " ?,   " );
					InsertSql.append( " CURRENT TIMESTAMP, '"	+ str2 + "'," );
					InsertSql.append( " CURRENT TIMESTAMP, '"	+ str3 + "' ) " );
//if(str2 !=null && str2.equals("T")){	InsertSql.append(" ,BFILE"); }
//if(str3 !=null && str3.equals("T")){	InsertSql.append(" ,AFILE ") ; }
																			
//if(str2 !=null && str2.equals("T")){	InsertSql.append(" ,? ") ; }
//if(str3 !=null && str3.equals("T")){	InsertSql.append(" ,? ") ; }
																			//InsertSql.append(" ,?,? ") ; 
																			//InsertSql.append(") ") ; 
												
//logger.err.println(this,InsertSql.toString());
						 
												gsmt = conn.getGauceStatement(InsertSql.toString()); 
												gsmt.setGauceDataRow(rows[j]);   

												gsmt.setString(1,porder_no.trim());
										//gsmt.bindColumn(1,idxCHARGECODE);
												gsmt.bindColumn(2,idxEFF_DATE);
												gsmt.bindColumn(3,idxEXP_DATE);							 
												gsmt.bindColumn(4,idxLINE_PART);									 
												gsmt.bindColumn(5,idxCLASS);	

												gsmt.bindColumn(6,idxSECTION);	
												gsmt.bindColumn(7,idxSECTION2);	 
												gsmt.bindColumn(8,idxARTC_CD);	 
												gsmt.bindColumn(9,idxLOGIS_TYPE);	 
												gsmt.bindColumn(10,idxLOGIS_UNIT);	

												gsmt.bindColumn(11,idxUNIT_PRICE);	
												gsmt.bindColumn(12,idxRQST_PRICE);	
												gsmt.bindColumn(13,idxRQST_PRICE2);	 
												gsmt.bindColumn(14,idxRQST_PRCNT);	
												gsmt.bindColumn(15,idxCURRENCY);
												
												gsmt.bindColumn(16,idxCAR_CLASS);
												gsmt.bindColumn(17,idxCANCLE1);
												gsmt.bindColumn(18,idxCANCLE2);
												gsmt.bindColumn(19,idxCANCLE3);  
												gsmt.bindColumn(20,idxCANCLE4);
												gsmt.bindColumn(21,idxCANCLE5); 
//if(str2 !=null && str2.equals("T")){			InputStream nst_file = (InputStream) rows[j].getInputStream(idxBFILE);
//												gsmt.setBinaryStream(21, nst_file, nst_file.available());	 //첨부파일 
//												 }
//if(str3 !=null && str3.equals("T") && str2.equals("T"))
//												{			InputStream nst_file1 = (InputStream) rows[j].getInputStream(idxAFILE);
//												gsmt.setBinaryStream(22, nst_file1, nst_file1.available());	 //첨부파일 
//												 }

												gsmt.executeUpdate(); 
												gsmt.close();  

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
//logger.err.println(this,   "update" + String.valueOf(GauceDataRow.TB_JOB_UPDATE)  ); 					
																			UpdateSql = new StringBuffer();
																			UpdateSql.append( " UPDATE TRANSFER.LTCHARGE SET " );
			UpdateSql.append( "        EFF_DATE = ?, " );
			UpdateSql.append( "        EXP_DATE = ?, " );
			UpdateSql.append( "        LINE_PART = ?, " );
			UpdateSql.append( "        CLASS = ?, " );

			UpdateSql.append( "        SECTION = ?," );
			UpdateSql.append( "        SECTION2 = ?," );
			UpdateSql.append( "        ARTC_CD = ?," );
			UpdateSql.append( "        LOGIS_TYPE = ?," );
			UpdateSql.append( "        LOGIS_UNIT = ?," );

			UpdateSql.append( "        UNIT_PRICE = ?," );
			UpdateSql.append( "        RQST_PRICE = ?," );
			UpdateSql.append( "        RQST_PRICE2 = ?," );
			UpdateSql.append( "        RQST_PRCNT = ?," );
			UpdateSql.append( "        CURRENCY = ?," );

			UpdateSql.append( "        CAR_CLASS = ?," );
			UpdateSql.append( "        CANCLE1 = ?," );
			UpdateSql.append( "        CANCLE2 = ?," );
			UpdateSql.append( "        CANCLE3 = ?," );
			UpdateSql.append( "        CANCLE4 = ?," );

			UpdateSql.append( "        CANCLE5 = ?," );
				
			UpdateSql.append( "        UPDATE_DT = CURRENT TIMESTAMP," );
			UpdateSql.append( "        UPDATE_USR  = '" + str2 + "'" );
			//UpdateSql.append( " WHERE PORDER_NO = ? " );

																		//	UpdateSql.append(" UPDATE TRANSFER.LTORDPACK SET ") ; 
																	//		UpdateSql.append(" ORDER_DATE = ?,WORK_FORM = ?, ") ; 
																//			UpdateSql.append(" CUST_CD= ?,ARTC_CD= ?,ARTC_NM= ?,ENTER_STS= ?,") ; 
															//				UpdateSql.append(" PKG_FORM= ?,PKG_CNT= ?,PKG_UNIT= ?,WAREHOUSE= ?,") ; 
														//					UpdateSql.append(" BFILE_NAME= ?,REMARK= ?,ORDER_STS= ?,ORDER_CHK= ?,END_DATE= ?,END_TIME= ?,") ; 
													//						UpdateSql.append(" AFILE_NAME= ?,UPDATE_DT=CURRENT TIMESTAMP,UPDATE_USR = ?  ") ; 
													//						UpdateSql.append(" ,PACK_TYPE = ?,ACM_YM  = ? ") ; 
//if(str2 !=null && str2.equals("T")){	UpdateSql.append(",BFILE = ? ") ; }
//if(str2 !=null && str3.equals("T")){  UpdateSql.append(",AFILE = ? ") ;  }
												UpdateSql.append(" WHERE  CHARGECODE = ?   ") ;  
						
												gsmt = conn.getGauceStatement(UpdateSql.toString());
//logger.err.println(this,UpdateSql.toString());
												gsmt.setGauceDataRow(rows[j]); 

												gsmt.bindColumn(1,idxEFF_DATE);
												gsmt.bindColumn(2,idxEXP_DATE);							 
												gsmt.bindColumn(3,idxLINE_PART);									 
												gsmt.bindColumn(4,idxCLASS);	

												gsmt.bindColumn(5,idxSECTION);	
												gsmt.bindColumn(6,idxSECTION2);	 
												gsmt.bindColumn(7,idxARTC_CD);	 
												gsmt.bindColumn(8,idxLOGIS_TYPE);	 
												gsmt.bindColumn(9,idxLOGIS_UNIT);	

												gsmt.bindColumn(10,idxUNIT_PRICE);	
												gsmt.bindColumn(11,idxRQST_PRICE);	
												gsmt.bindColumn(12,idxRQST_PRICE2);	 
												gsmt.bindColumn(13,idxRQST_PRCNT);	
												gsmt.bindColumn(14,idxCURRENCY);
												
												gsmt.bindColumn(15,idxCAR_CLASS);
												gsmt.bindColumn(16,idxCANCLE1);
												gsmt.bindColumn(17,idxCANCLE2);
												gsmt.bindColumn(18,idxCANCLE3);  
												gsmt.bindColumn(19,idxCANCLE4);
												gsmt.bindColumn(20,idxCANCLE5); 
												
												//gsmt.setString(21,porder_no);
												gsmt.bindColumn(21,idxCHARGECODE);

											
												
												
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
														
														//gsmt.setString(21,porder_no); 


						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM TRANSFER.LTCHARGE " );
			//	DeleteSql.append( " WHERE PORDER_NO = ? " );
						//DeleteSql.append(" DELETE FROM  TRANSFER.LTORDPACK  ") ; 
						DeleteSql.append(" WHERE CHARGECODE = ?  ") ; 
						
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						////logger.err.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						//gsmt.setString(1,porder_no);
						gsmt.bindColumn(1,idxCHARGECODE);
						
						/*gsmt.bindColumn(1, idxCAR_TYPE);*/
						gsmt.executeUpdate();
						gsmt.close();
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