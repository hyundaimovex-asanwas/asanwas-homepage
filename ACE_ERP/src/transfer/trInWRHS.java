package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trInWRHS extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceDataSet dSetMstID = null;

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
				String enter_date = reqGauce.getParameter("gstr1"); 
				String strUser = reqGauce.getParameter("gstr2"); 

   			if ( enter_date==null || enter_date.trim().length()==0 ) { enter_date=null; }
        if ( strUser==null || strUser.trim().length()==0 ) { strUser=null; }       
				String enter_no = null ;         

				dSetMstID = new GauceDataSet(); 
				dSetMstID.addDataColumn(new GauceDataColumn("ENTER_NO", GauceDataColumn.TB_STRING,7));

//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				int idxENTER_DATE   = userSet.indexOfColumn("ENTER_DATE") ; 
				int idxENTER_NO     = userSet.indexOfColumn("ENTER_NO") ; 
				int idxWAREHOUSE    = userSet.indexOfColumn("WAREHOUSE") ; 
				int idxGOODS_SEQ    = userSet.indexOfColumn("GOODS_SEQ") ; 
				int idxARTC_NM      = userSet.indexOfColumn("ARTC_NM") ; 
				int idxARTC_CNT     = userSet.indexOfColumn("ARTC_CNT") ; 
				int idxPUNIT_CNT    = userSet.indexOfColumn("PUNIT_CNT") ; 
				int idxPUNIT_WEIGHT = userSet.indexOfColumn("PUNIT_WEIGHT") ; 
				int idxPKG_LNGTH    = userSet.indexOfColumn("PKG_LNGTH") ; 
				int idxPKG_HEIGHT   = userSet.indexOfColumn("PKG_HEIGHT") ; 
				int idxPKG_WIDTH    = userSet.indexOfColumn("PKG_WIDTH") ; 
				int idxPKG_CBM      = userSet.indexOfColumn("PKG_CBM") ; 
				int idxTOTAL_CBM    = userSet.indexOfColumn("TOTAL_CBM") ; 
				int idxTOTAL_WEIGHT = userSet.indexOfColumn("TOTAL_WEIGHT") ; 
				int idxENTER_STS    = userSet.indexOfColumn("ENTER_STS") ; 
				int idxEXTRA_STS    = userSet.indexOfColumn("EXTRA_STS") ; 
				int idxORDER_NO     = userSet.indexOfColumn("ORDER_NO") ; 
				int idxORDER_SEQ    = userSet.indexOfColumn("ORDER_SEQ") ;
				int idxPKG_CNT			 = userSet.indexOfColumn("PKG_CNT") ;
				int idxORG_GOODS_SEQ = userSet.indexOfColumn("ORG_GOODS_SEQ") ; //UPDATE용 

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  
				StringBuffer sql = null;  

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						sql = new StringBuffer();
						sql.append( " SELECT	CASE WHEN MAX(ENTER_NO) IS NULL  THEN '00000001'                                  \n ")
							 .append( "					WHEN LENGTH(TRIM(MAX(ENTER_NO)+1)) = 1 THEN '0000000'CONCAT TRIM(MAX(ENTER_NO)+1) \n ")
							 .append( "					WHEN LENGTH(TRIM(MAX(ENTER_NO)+1)) = 2 THEN '000000'CONCAT TRIM(MAX(ENTER_NO)+1)  \n ")
							 .append( "					WHEN LENGTH(TRIM(MAX(ENTER_NO)+1)) = 3 THEN '00000'CONCAT TRIM(MAX(ENTER_NO)+1)   \n ")
							 .append( "					WHEN LENGTH(TRIM(MAX(ENTER_NO)+1)) = 4 THEN '0000'CONCAT TRIM(MAX(ENTER_NO)+1)    \n ")
							 .append( "					WHEN LENGTH(TRIM(MAX(ENTER_NO)+1)) = 5 THEN '000'CONCAT TRIM(MAX(ENTER_NO)+1)     \n ")
							 .append( "					WHEN LENGTH(TRIM(MAX(ENTER_NO)+1)) = 6 THEN '00'CONCAT TRIM(MAX(ENTER_NO)+1)      \n ")
							 .append( "					WHEN LENGTH(TRIM(MAX(ENTER_NO)+1)) = 7 THEN '0'CONCAT TRIM(MAX(ENTER_NO)+1)       \n ")
							 .append( "					ELSE TRIM(MAX(ENTER_NO)+1) END AS ENTER_NO                                        \n ")
							 .append( "		FROM  TRANSFER.LTINWRHS WHERE ENTER_DATE = '" + enter_date +"'                          \n ") ; 
						
						GauceStatement gstmt = conn.getGauceStatement(sql.toString());
						 
						gstmt.executeQuery(dSetMstID);
						gstmt.close(); 
		 
						if ( dSetMstID!=null && dSetMstID.getDataRowCnt() > 0 ) {
							GauceDataRow[] dRowMstID = dSetMstID.getDataRows(); 
							enter_no = dRowMstID[0].getString(0);   
						}

 
						InsertSql = new StringBuffer();
            InsertSql.append(" INSERT INTO TRANSFER.LTINWRHS \n ")
										 .append(" ( \n")
										 .append(" ENTER_DATE, ENTER_NO, WAREHOUSE, GOODS_SEQ, ARTC_NM, \n ")
										 .append(" ARTC_CNT, PUNIT_CNT, PUNIT_WEIGHT, PKG_LNGTH, PKG_HEIGHT, \n ")
										 .append(" PKG_WIDTH, PKG_CBM, TOTAL_CBM, TOTAL_WEIGHT, ENTER_STS, \n ")
										 .append(" EXTRA_STS, ORDER_NO, ORDER_SEQ, PKG_CNT, CREATE_DT, CREATE_USR")
										 .append(" ) VALUES ( \n ")
										 .append(" ?,?,?,?,?, \n ")
										 .append(" ?,?,?,?,?, \n ")
										 .append(" ?,?,?,?,?, \n ")
										 .append(" ?,?,?,?,CURRENT TIMESTAMP,'"+strUser+"' \n ")
										 .append(" ) ") ; 

						gstmt = conn.getGauceStatement(InsertSql.toString()); 
						gstmt.setGauceDataRow(rows[j]); 
						
 						gstmt.bindColumn(1,  idxENTER_DATE  ) ; 
						gstmt.setString( 2,   enter_no);
						gstmt.bindColumn(3,  idxWAREHOUSE  ) ; 
						gstmt.bindColumn(4,  idxGOODS_SEQ  ) ; 
						gstmt.bindColumn(5,  idxARTC_NM  ) ;  
						gstmt.bindColumn(6,  idxARTC_CNT  ) ; 
						gstmt.bindColumn(7,  idxPUNIT_CNT  ) ; 
						gstmt.bindColumn(8,  idxPUNIT_WEIGHT  ) ;
						gstmt.bindColumn(9,  idxPKG_LNGTH  ) ;
						gstmt.bindColumn(10,  idxPKG_HEIGHT  ) ;
						gstmt.bindColumn(11,  idxPKG_WIDTH  ) ;
						gstmt.bindColumn(12,  idxPKG_CBM  ) ;
						gstmt.bindColumn(13,  idxTOTAL_CBM  ) ;
						gstmt.bindColumn(14,  idxTOTAL_WEIGHT  ) ;
						gstmt.bindColumn(15,  idxENTER_STS  ) ;
						gstmt.bindColumn(16,  idxEXTRA_STS  ) ;
						gstmt.bindColumn(17,  idxORDER_NO  ) ;
						gstmt.bindColumn(18,  idxORDER_SEQ  ) ; 
						gstmt.bindColumn(19,  idxPKG_CNT  ) ; 
	 					gstmt.executeUpdate(); 
						gstmt.close(); 

					}

          if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTINWRHS SET ARTC_CNT =?,  \n")
							       .append("	      UPDATE_DT	= CURRENT TIMESTAMP, \n")
							       .append("	      UPDATE_UST	= '"+strUser+"' \n") 
										 .append("	WHERE ENTER_DATE	= ? \n")
										 .append("		AND ENTER_NO	=? \n")
						         .append("		AND WAREHOUSE	=? \n")
										 .append("		AND GOODS_SEQ	=? \n");

						GauceStatement gstmt2 = conn.getGauceStatement(UpdateSql.toString());	
						gstmt2.setGauceDataRow(rows[j]); 
						
 						gstmt2.bindColumn(1,  idxARTC_CNT);
						gstmt2.bindColumn(2,  idxENTER_DATE); 
            gstmt2.bindColumn(3,  idxENTER_NO); 
            gstmt2.bindColumn(4,  idxWAREHOUSE); 
            gstmt2.bindColumn(5,  idxORG_GOODS_SEQ); 

						gstmt2.executeUpdate(); 
						gstmt2.close(); 
          }

				}//for
			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
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