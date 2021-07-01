package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trMakingPl extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		res.setContentType("text/html;charset=ksc5601");

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null; 
			GauceDataSet dSetMstID0 = null;
			GauceDataSet dSetMstID = null;
			GauceDataSet dSetMstID1 = null;
			GauceStatement gstmt = null;

			try {
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String order_no = reqGauce.getParameter("gstr1"); 
   				if ( order_no==null || order_no.trim().length()==0 ) { order_no=null; }
				String pl_no = reqGauce.getParameter("gstr2"); 
				if ( pl_no==null || pl_no.trim().length()==0 ) { pl_no=null; } 
				String car_no = null  ;
				String ctn_stdrd = null ; 
				int car_cnt = 0 ; 
				double t_weight = 0 ;
				double t_cbm = 0 ;
                
				 //logger.dbg.println(this,"start");

				
//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");   
				
				int idxORDER_NO =  userSet.indexOfColumn("ORDER_NO");

				GauceDataRow[] rows = userSet.getDataRows(); 
				 
				StringBuffer  InsertSql = null; 
				StringBuffer  Sql = null; 

				 logger.err.println(this,"start2");
				  

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {  
													
	
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

		/***************************************************************************************************8
		Description  : Get Order No
	****************************************************************************************************/	
					 order_no = rows[j].getString(idxORDER_NO);  
   /***************************************************************************************************8
		Description  : Get PlNo
	****************************************************************************************************/
						dSetMstID0 = new GauceDataSet(); 
					  dSetMstID0.addDataColumn( new GauceDataColumn( "PL_NO", GauceDataColumn.TB_STRING, 20 ) );

						Sql = new StringBuffer();
						Sql.append( "  SELECT ") ; 
						Sql.append( "  SUBSTRING(CHAR(CURRENT DATE),1,4) CONCAT  ") ; 
						Sql.append( "  SUBSTRING(CHAR(CURRENT DATE),6,2) CONCAT  ") ; 
						Sql.append( "  SUBSTRING(CHAR(CURRENT DATE),9,2) CONCAT ") ; 
						Sql.append( "  CASE WHEN MAX(PL_NO) IS NULL THEN  '0001' ") ; 
						Sql.append( "  WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1)) = 1  ") ; 
						Sql.append( "  THEN '000' CONCAT CHAR(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1) ") ; 
						Sql.append( "  WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1)) = 2  ") ;  
						Sql.append( "  THEN '00' CONCAT CHAR(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1) ") ; 
						Sql.append( "  WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1)) = 3  ") ; 
						Sql.append( "  THEN  '0' CONCAT CHAR(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1) ") ; 
						Sql.append( "  WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1)) = 4  ") ; 
						Sql.append( "  THEN CHAR(DEC(MAX(SUBSTRING(PL_NO,9,4)))+ 1) ") ; 
						Sql.append( "  END AS PL_NO ") ; 
						Sql.append( "  FROM TRANSFER.LTPCKLSCI WHERE PL_NO LIKE SUBSTRING(CHAR(CURRENT DATE),1,4) CONCAT ") ; 
						Sql.append( "  SUBSTRING(CHAR(CURRENT DATE),6,2) CONCAT ") ; 
						Sql.append( "  SUBSTRING(CHAR(CURRENT DATE),9,2) CONCAT '%' ") ; 
						GauceStatement gsmt = conn.getGauceStatement(Sql.toString());
						gsmt.executeQuery(dSetMstID0);
							gsmt.close(); 
						 
						if ( dSetMstID0!=null && dSetMstID0.getDataRowCnt() > 0 ) {
											GauceDataRow[] dRowMstID0 = dSetMstID0.getDataRows(); 
											pl_no = dRowMstID0[0].getString(0);  
											logger.err.println(this,pl_no);   
						}

							
	/***************************************************************************************************8
		Description  : Pl Master 생성
	****************************************************************************************************/
						InsertSql = new StringBuffer();
						InsertSql.append(" INSERT INTO TRANSFER.LTPCKLSCI(PL_NO,IN_OUT,PL_SHIPPER, ") ; 
						InsertSql.append(" PL_SHPPRNM,PL_SHPADD1,PL_SHPADD2,PL_SHPADD3,") ; 
						InsertSql.append(" PL_SHPTEL,PL_CSTM,PL_CSTMNM,PL_CSTADD1,PL_CSTADD2,") ; 
						InsertSql.append(" PL_CSTADD3,PL_CSTTEL,PL_BRKR,PL_BRKRNM,PL_BRKADD1,") ; 
						InsertSql.append(" PL_BRKADD2,PL_BRKADD3,PL_BRKTEL,START_LCT,REACH_LCT,") ; 
						InsertSql.append(" TRANS_CAR,START_DT,START_TIME,INVOICE_NO,INVOICE_DT,") ; 
						InsertSql.append(" REMARK,LCNO,LCDATE,LCBANK,WEIGHT,T_WEIGHT,T_CBM,GORDER_NO,") ; 
						InsertSql.append(" PACKING_CNT,PACKING_UNIT,PACKING_CBM,TELEPHONE,RPR_GOODS,") ; 
						InsertSql.append(" CARGO_TYPE,DNG_TYPE,CAR_TYPE,ORDER_NO,DCL_DATE,DCL_NO,") ; 
						InsertSql.append(" CURRENCY,CREATE_DT,CREATE_USR,UPDATE_DT,UPDATE_USR,LINE_PART") ; 
						InsertSql.append(" ,PL_CSN,PL_CSNNM,PL_CSNTEL,PL_CSNADDR,PL_CSNADDR2,PL_CSNADDR3)");
						InsertSql.append(" SELECT '"+pl_no+"' ,IN_OUT ,PL_SHIPPER,") ; 
						InsertSql.append(" PL_SHPPRNM,PL_SHIPADDR,PL_SHPADDR2,PL_SHPADDR3,") ; 
						InsertSql.append(" PL_SHIPTEL,PL_CSTM,PL_CSTMNM,PL_CSTADDR,PL_CSTADDR2,") ; 
						InsertSql.append(" PL_CSTADDR3,PL_CSTTEL,PL_BRKR,PL_BRKRNM,PL_BRKADDR,") ; 
						InsertSql.append(" PL_BRKADDR2,PL_BRKADDR3,PL_BRKTEL,LDCARGO,OFFCARGO,") ; 
						InsertSql.append(" '',ETD_DT,'','','',") ; 
						InsertSql.append(" '','','','',0,0,0,'',") ; 
						InsertSql.append(" 0,'',0,'','',") ; 
						InsertSql.append(" '','','',ORDER_NO,'','',") ; 
						InsertSql.append(" '',CURRENT TIMESTAMP,CREATE_USR,") ; 
						InsertSql.append(" CURRENT TIMESTAMP,'',LINE_PART ") ; 
						InsertSql.append(" ,PL_CSN,PL_CSNNM,PL_CSNTEL,PL_CSNADDR,PL_CSNADDR2,PL_CSNADDR3 ");
						InsertSql.append(" FROM TRANSFER.LTORDERMST ") ;  
						InsertSql.append(" WHERE ORDER_NO = '"+ order_no + "' " ) ; 
							
						
 logger.err.println(this,InsertSql.toString());
							gsmt = conn.getGauceStatement(InsertSql.toString()); 
							//gsmt.setGauceDataRow(rows[j]); 
							//gsmt.setString(1, pl_no);  
							//gsmt.setString(2, order_no);  
 
							gsmt.executeUpdate(); 
							gsmt.close();
							InsertSql = null ; 

/***************************************************************************************************8
		Description  : Pl Detail 생성
	****************************************************************************************************/
	
							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO  TRANSFER.LTPCKLSDT ( ") ; 
							InsertSql.append( " PL_NO,PL_SEQNO,CAR_NO,CNTN_NO,") ; 
							InsertSql.append( " CNTN_SDSZ,CNTN_SLNO,GOODS_CD,") ; 
							InsertSql.append( " GOODS_NM,GOODS_ENM,PACKING_NO,") ; 
							InsertSql.append( " PACKING_CNT,STDRD_SZ,HS_CODE,") ; 
							InsertSql.append( " GOODS_CNT,CNT_UNIT,UNIT_PRICE,PRICE,") ; 
							InsertSql.append( " PKC_CNT,PKG_WEIGHT,PKG_LNGTH,") ; 
							InsertSql.append( " PKG_HEIGHT,PKG_WIDTH,PKG_CBM,") ; 
							InsertSql.append( " PKG_UNIT,PR_WEIGHT,PT_WEIGHT,") ; 
							InsertSql.append( " T_WEIGHT,T_CNT,T_CBM,ORDER_NO,") ; 
							InsertSql.append( " ORDER_SEQ,REAMARK,CREATE_DT,") ; 
							InsertSql.append( " CREATE_USR,UPDATE_DT,UPDATE_USR )") ; 
							InsertSql.append( " SELECT ") ; 
							InsertSql.append( " '"+pl_no+"',A.ORDER_SEQ,IFNULL(C.CAR_NO,'') AS CAR_NO,'',") ; 
							InsertSql.append( " '','',A.ARTC_CD,") ; 
							InsertSql.append( " A.ARTC_NM ,'','',") ; 
							InsertSql.append( " IFNULL(B.PUNIT_CNT,0) AS PUNIT_CNT,A.STN_SZ,A.HSCODE,") ; 
							InsertSql.append( " IFNULL(B.ARTC_CNT,0) AS ARTC_CNT,A.ARTC_UNIT,A.UNIT_PRICE,A.PRICE AS PRICE1,") ; 
							InsertSql.append( " IFNULL(B.PKG_CNT,0) AS PUNIT_CNT,IFNULL(B.PUNIT_WEIGHT,0) AS PUNIT_WEIGHT,IFNULL(B.PKG_LNGTH,0) AS PKG_LNGTH,") ; 
							InsertSql.append( " IFNULL(B.PKG_HEIGHT,0) AS PKG_HEIGHT,IFNULL(B.PKG_WIDTH,0) AS PKG_WIDTH,FLOAT(TRIM(T '0' FROM CHAR(IFNULL(ROUND(B.PKG_LNGTH * B.PKG_HEIGHT* B.PKG_WIDTH/1000000,2),0)))) AS CBM") ; 
							InsertSql.append( " ,A.PUNIT_UNIT,B.TOTAL_WEIGHT,B.TOTAL_WEIGHT,") ; 
							InsertSql.append( " IFNULL(B.TOTAL_WEIGHT,0),FLOAT(TRIM(T '0' FROM CHAR(IFNULL(B.ARTC_CNT/CASE WHEN B.PUNIT_CNT IS NULL OR B.PUNIT_CNT = 0 THEN 1 ELSE B.PUNIT_CNT END,0)))),IFNULL(B.TOTAL_CBM,0),A.ORDER_NO,") ; 
							InsertSql.append( " A.ORDER_SEQ,'',CURRENT TIMESTAMP,'',CURRENT TIMESTAMP,'' ") ;
							InsertSql.append(" FROM TRANSFER.LTORDERDTL A , TRANSFER.LTLOADLST B ") ; 
						//	InsertSql.append(" ON A.ORDER_NO = B.ORDER_NO AND  A.ORDER_SEQ = B.ORDER_SEQ ,  ") ;	
							InsertSql.append(" ,TRANSFER.LTCARACC C ") ; 
							InsertSql.append( " WHERE A.ORDER_NO IS NOT NULL ") ; 
							InsertSql.append( " AND B.ORDER_NO IS NOT NULL AND B.ORDER_SEQ IS NOT NULL ") ; 
							InsertSql.append("  AND A.ORDER_NO = B.ORDER_NO AND  A.ORDER_SEQ = B.ORDER_SEQ    ") ;
							InsertSql.append("  AND B.CAR_SEQ_NO = C.CAR_SEQ_NO " ) ; 
							InsertSql.append( " AND ACCSECTION ='O' ") ; 
							InsertSql.append( " AND A.ORDER_NO = '"+order_no + "' ") ; 
						 
							gsmt = conn.getGauceStatement(InsertSql.toString()); 
							gsmt.setGauceDataRow(rows[j]); 
							//gsmt.setString(1, pl_no);  
							//gsmt.setString(2, order_no);  
 logger.err.println(this,InsertSql.toString()); 
							gsmt.executeUpdate(); 
							gsmt.close();
							InsertSql = null ; 

/***************************************************************************************************8
		Description  : Pl MASTER UPDATE   --->1 .  차량번호/ 대표물품
	****************************************************************************************************/
							dSetMstID = new GauceDataSet(); 
						  dSetMstID.addDataColumn(new GauceDataColumn("CAR_NO", GauceDataColumn.TB_STRING,20));
							dSetMstID.addDataColumn(new GauceDataColumn("CTN_STDRD", GauceDataColumn.TB_STRING,50));

							Sql = new StringBuffer();
							Sql.append( " SELECT A.CAR_NO,CTN_STDRD ") ; //--,A.PL_SEQNO,B.ORDER_NO,A.ORDER_NO,B.CAR_SEQ_NO,ACCSECTION ,C.CAR_SEQ_NO
							Sql.append( " FROM TRANSFER.LTPCKLSDT A,") ;
							Sql.append( " TRANSFER.LTORDCAR B,TRANSFER.LTCARACC C ") ;
							Sql.append( " WHERE A.CAR_NO IS NOT NULL ") ;
							Sql.append( " AND  A.CAR_NO = C.CAR_NO AND B.CAR_SEQ_NO = C.CAR_SEQ_NO ") ;
							Sql.append( " AND  A.PL_SEQNO = (SELECT MIN(D.PL_SEQNO)  ") ; 
							Sql.append( " FROM TRANSFER.LTPCKLSDT D WHERE TRIM(D.PL_NO) ='"+pl_no+"') ") ; 
							Sql.append( " AND ACCSECTION ='O' ") ; 
							Sql.append( " GROUP BY A.CAR_NO,CTN_STDRD ") ; 

							gsmt = conn.getGauceStatement(Sql.toString());
			logger.err.println(this,Sql.toString()); 			 
							gsmt.executeQuery(dSetMstID);
							gsmt.close(); 
		 
						if ( dSetMstID!=null && dSetMstID.getDataRowCnt() > 0 ) {
											GauceDataRow[] dRowMstID = dSetMstID.getDataRows(); 
											car_no = dRowMstID[0].getString(0); 
											car_no = new String(car_no.getBytes("8859_1"),"KSC5601");
											ctn_stdrd = dRowMstID[0].getString(1); 
										  ctn_stdrd = new String(ctn_stdrd.getBytes("8859_1"),"KSC5601");
											car_cnt = dSetMstID.getDataRowCnt() ; 
											logger.err.println(this,car_no);  
										
										InsertSql = new StringBuffer();
										InsertSql.append( " UPDATE TRANSFER.LTPCKLSCI " ) ; 
										InsertSql.append( " SET RPR_GOODS = '" + ctn_stdrd +"',") ; 
										InsertSql.append( " TRANS_CAR = '" +car_no + "'," ) ; 
										InsertSql.append( " PACKING_CNT = '" +car_cnt + "'," ) ; 
										InsertSql.append( " PACKING_UNIT = 'GT'" ) ; 
										InsertSql.append( " WHERE PL_NO = '" + pl_no + "'" ) ; 

									 
										gsmt = conn.getGauceStatement(InsertSql.toString()); 
										//gsmt.setGauceDataRow(rows[j]); 
										//gsmt.setString(1, pl_no);  
										//gsmt.setString(2, order_no);  
			 logger.err.println(this,InsertSql.toString()); 
										gsmt.executeUpdate(); 
										gsmt.close();
										InsertSql = null ;  
											
						}

						Sql = null ; 

/***************************************************************************************************8
		Description  : Pl MASTER UPDATE   --->2.순중량 , 총중량 , 용적 update
	****************************************************************************************************/
							dSetMstID1 = new GauceDataSet(); 
						  dSetMstID1.addDataColumn( new GauceDataColumn( "PACKING_CNT", GauceDataColumn.TB_DECIMAL, 13,3 ) );
							dSetMstID1.addDataColumn( new GauceDataColumn( "GOODS_CNT", GauceDataColumn.TB_DECIMAL, 13,3 ) );
							dSetMstID1.addDataColumn( new GauceDataColumn( "UNIT_PRICE", GauceDataColumn.TB_DECIMAL, 13,3 ) );
							dSetMstID1.addDataColumn( new GauceDataColumn( "PRICE1", GauceDataColumn.TB_DECIMAL, 13,3 ) );
							dSetMstID1.addDataColumn( new GauceDataColumn( "PKC_CNT", GauceDataColumn.TB_DECIMAL, 13,3 ) );
							dSetMstID1.addDataColumn( new GauceDataColumn( "PKG_WEIGHT", GauceDataColumn.TB_DECIMAL, 13,3 ) );
							dSetMstID1.addDataColumn( new GauceDataColumn( "PKG_CBM", GauceDataColumn.TB_DECIMAL, 13,3 ) );
							dSetMstID1.addDataColumn( new GauceDataColumn( "T_WEIGHT", GauceDataColumn.TB_DECIMAL, 13,3 ) );
							dSetMstID1.addDataColumn( new GauceDataColumn( "T_CNT", GauceDataColumn.TB_DECIMAL, 13,3 ) );
							dSetMstID1.addDataColumn( new GauceDataColumn( "T_CBM", GauceDataColumn.TB_DECIMAL, 13,3 ) );

							Sql = new StringBuffer();
							Sql.append( " SELECT SUM(PACKING_CNT) AS PACKING_CNT,SUM(GOODS_CNT) AS GOODS_CNT, ") ; 
							Sql.append( " SUM(UNIT_PRICE) AS UNIT_PRICE,SUM(PRICE) AS PRICE1, ") ; 
							Sql.append( " SUM(PKC_CNT) AS PKC_CNT,SUM(PKG_WEIGHT ) AS PKG_WEIGHT,SUM(PKG_CBM) AS PKG_CBM, ") ; 
							Sql.append( " SUM( T_WEIGHT) AS T_WEIGHT,SUM(T_CNT) AS T_CNT,SUM(T_CBM)  AS T_CBM  ") ; 
							Sql.append( " FROM TRANSFER.LTPCKLSDT  ") ; 
							Sql.append( " WHERE TRIM(PL_NO) ='" + pl_no + "'" ) ;  
logger.err.println(this,Sql.toString()); 	
							gsmt = conn.getGauceStatement(Sql.toString());
						 
							gsmt.executeQuery(dSetMstID1);
							gsmt.close(); 
		 
						if ( dSetMstID1!=null && dSetMstID1.getDataRowCnt() > 0 ) {
											GauceDataRow[] dRowMstID1 = dSetMstID1.getDataRows(); 
											t_weight = dRowMstID1[0].getDouble(7);
											t_cbm = dRowMstID1[0].getDouble(9);
											 
											logger.err.println(this,car_no);  
										
										InsertSql = new StringBuffer();
										InsertSql.append( " UPDATE TRANSFER.LTPCKLSCI " ) ; 
										InsertSql.append( " SET WEIGHT =  " + t_weight +",") ; 
										InsertSql.append( " T_WEIGHT = " + t_weight +"," ) ; 
										InsertSql.append( " T_CBM = " +t_cbm  ) ;  
										InsertSql.append( " WHERE PL_NO = '" + pl_no + "'" ) ; 

		 						 
										gsmt = conn.getGauceStatement(InsertSql.toString()); 
										//gsmt.setGauceDataRow(rows[j]); 
										//gsmt.setString(1, pl_no);  
										//gsmt.setString(2, order_no);  
			 logger.err.println(this,InsertSql.toString()); 
										gsmt.executeUpdate(); 
										gsmt.close();
										InsertSql = null ;  
											
						}

						Sql = null ; 

						InsertSql = new StringBuffer();
						InsertSql.append( " UPDATE TRANSFER.LTORDERMST " ) ; 
						InsertSql.append( " SET PL_NO =  '" + pl_no+"',") ; 
						InsertSql.append( " PL_DATE = CURRENT TIMESTAMP ," ) ; 
						InsertSql.append( " PL_TYPE = 'C' ") ; 
						InsertSql.append( " WHERE ORDER_NO = '" + order_no + "'" ) ;  
						gsmt = conn.getGauceStatement(InsertSql.toString()); 
										//gsmt.setGauceDataRow(rows[j]); 
										//gsmt.setString(1, pl_no);  
										//gsmt.setString(2, order_no);  
						// logger.err.println(this,InsertSql.toString()); 
										gsmt.executeUpdate(); 
										gsmt.close();
										InsertSql = null ;   
 
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						
						  /*Sql = new StringBuffer();
							Sql.append("DELETE FROM  TRANSFER.LTPCKLSDT  ") ; 
							Sql.append(" WHERE PL_NO = ? AND  PL_SEQNO = ? ") ;
							 
							
//logger.err.println(this,Sql.toString());
							GauceStatement gsmt = conn.getGauceStatement(Sql.toString()); 
							gsmt.setGauceDataRow(rows[j]);   
							gsmt.setString(1, pl_no);  
							gsmt.bindColumn(2, idxPL_SEQNO); 
 
							gsmt.executeUpdate(); 
							gsmt.close();
							Sql = null ; */
						 
					}//Case insert//update//Delete 
				} //Loop While 
				
				//****************Master Update****************/ 
				 


			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.err.println(this,se);
				//logger.dbg.println(this,se.toString());
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}

	 
}