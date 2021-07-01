package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trSettlement extends HttpServlet{

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
				String settle_no = reqGauce.getParameter("gstr1"); 
   				if ( settle_no==null || settle_no.trim().length()==0 ) { settle_no=null; }
                
				////logger.err.println(this,"start");

//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	
				dSetMstID = new GauceDataSet(); 
				dSetMstID.addDataColumn(new GauceDataColumn("SETTLE_NO", GauceDataColumn.TB_STRING,10));

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 
				
				int idxSETTLE_NO    =userSet.indexOfColumn("SETTLE_NO");
				//logger.err.println(this,"idxSETTLE_NO ;" + idxSETTLE_NO); 
				int idxCUST_CD      =userSet.indexOfColumn("CUST_CD");
				//logger.err.println(this,"idxCUST_CD ;" + idxCUST_CD);
				int idxSETTLE_YM    =userSet.indexOfColumn("SETTLE_YM");
				//logger.err.println(this,"idxSETTLE_YM ;" + idxSETTLE_YM);
				int idxSETTLE_CD    =userSet.indexOfColumn("SETTLE_CD");
				//logger.err.println(this,"idxSETTLE_CD ;" + idxSETTLE_CD);
				int idxSETTLE_ITEMS  =userSet.indexOfColumn("SETTLE_ITEMS");
				//logger.err.println(this,"idxSETTLE_ITEMS ;" + idxSETTLE_ITEMS);
				int idxCAR_TYPE     =userSet.indexOfColumn("CAR_TYPE");
				//logger.err.println(this,"idxCAR_TYPE ;" + idxCAR_TYPE);
				int idxPACKING_TYPE  =userSet.indexOfColumn("PACKING_TYPE");
				//logger.err.println(this,"PACKING_TYPE ;" + idxPACKING_TYPE);
				int idxLOAD_LCT     =userSet.indexOfColumn("LOAD_LCT");
				//logger.err.println(this,"idxLOAD_LCT ;" + idxLOAD_LCT);
				int idxOFF_LCT      =userSet.indexOfColumn("OFF_LCT");
				//logger.err.println(this,"idxOFF_LCT ;" + idxOFF_LCT);
				int idxUNIT_CBM     =userSet.indexOfColumn("UNIT_CBM");
				//logger.err.println(this,"idxUNIT_CBM ;" + idxUNIT_CBM);

				int idxUNIT         =userSet.indexOfColumn("UNIT");
				//logger.err.println(this,"idxUNIT ;" + idxUNIT);

				int idxCNT          =userSet.indexOfColumn("CNT");
				//logger.err.println(this,"idxCNT ;" + idxCNT);

				int idxUNIT_PRICE   =userSet.indexOfColumn("UNIT_PRICE");
				//logger.err.println(this,"idxUNIT_PRICE ;" + idxUNIT_PRICE);

				int idxPRICE        =userSet.indexOfColumn("PRICE");
				//logger.err.println(this,"idxPRICE ;" + idxPRICE);

				int idxREQ_PRICE1   =userSet.indexOfColumn("REQ_PRICE1");
				//logger.err.println(this,"idxREQ_PRICE1 ;" + idxREQ_PRICE1);

				int idxREQ_PRICE2   =userSet.indexOfColumn("REQ_PRICE2");
				//logger.err.println(this,"idxREQ_PRICE2 ;" + idxREQ_PRICE2);

				int idxVAT_AMT      =userSet.indexOfColumn("VAT_AMT");
				//logger.err.println(this,"idxVAT_AMT ;" + idxVAT_AMT);

				int idxREMARK       =userSet.indexOfColumn("REMARK");
				//logger.err.println(this,"idxREMARK ;" + idxREMARK); 

				int idxTR_PAPER     =userSet.indexOfColumn("TR_PAPER");
				//logger.err.println(this,"idxTR_PAPER ;" + idxTR_PAPER);

				int idxSTM_ACCT     =userSet.indexOfColumn("STM_ACCT");
				//logger.err.println(this,"idxSTM_ACCT ;" + idxSTM_ACCT);

				int idxSTTL_DATE    =userSet.indexOfColumn("STTL_DATE");
				//logger.err.println(this,"idxSTTL_DATE ;" + idxSTTL_DATE);

				int idxORDER_NO     =userSet.indexOfColumn("ORDER_NO");
				//logger.err.println(this,"idxORDER_NO ;" + idxORDER_NO);

				int idxORDER_SEQ    =userSet.indexOfColumn("ORDER_SEQ");
				//logger.err.println(this,"idxORDER_SEQ ;" + idxORDER_SEQ);

				int idxLINE         =userSet.indexOfColumn("LINE");
				//logger.err.println(this,"idxLINE ;" + idxLINE);

				int idxPROJECT      =userSet.indexOfColumn("PROJECT");
				//logger.err.println(this,"idxPROJECT ;" + idxPROJECT);

				int idxVEND_CD      =userSet.indexOfColumn("VEND_CD");
				//logger.err.println(this,"idxVEND_CD ;" + idxVEND_CD);

				int idxCHARGE_RATE  =userSet.indexOfColumn("CHARGE_RATE");
				//logger.err.println(this,"idxCHARGE_RATE ;" + idxCHARGE_RATE);

				int idxETD_DT       =userSet.indexOfColumn("ETD_DT");
				//logger.err.println(this,"idxETD_DT ;" + idxETD_DT);

				int idxSELL_TYPE    =userSet.indexOfColumn("SELL_TYPE");
				//logger.err.println(this,"idxSELL_TYPE ;" + idxSELL_TYPE);

				int idxACC_CH       =userSet.indexOfColumn("ACC_CH");
				//logger.err.println(this,"idxACC_CH ;" + idxACC_CH);

				int idxACC_DATE     =userSet.indexOfColumn("ACC_DATE");
				//logger.err.println(this,"idxACC_DATE ;" + idxACC_DATE);

				int idxACC_CODE     =userSet.indexOfColumn("ACC_CODE");
				//logger.err.println(this,"idxACC_CODE ;" + idxACC_CODE);

				 

				int idxCREATE_USR   =userSet.indexOfColumn("CREATE_USR");
				//logger.err.println(this,"idxCREATE_USR ;" + idxCREATE_USR);
				 
				int idxUPDATE_USR   =userSet.indexOfColumn("UPDATE_USR");
				//logger.err.println(this,"idxUPDATE_USR ;" + idxUPDATE_USR);
 

				////logger.err.println(this,"UPDATE_USR ;" + idxUPDATE_USR);   
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  
				StringBuffer sql = null ; 

				////logger.err.println(this,"start2");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {


						sql = new StringBuffer();
						sql.append( " SELECT ") ; 
						sql.append( " SUBSTR(CHAR(CURRENT DATE),3,2) CONCAT SUBSTR(CHAR(CURRENT DATE),6,2) CONCAT  ") ; 
						sql.append( " CASE WHEN MAX(SETTLE_NO) IS NULL THEN '00001'  ") ; 
						sql.append( " WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(SETTLE_NO,6,5)))+ 1)) = 1  ") ; 
						sql.append( " THEN '0000' CONCAT CHAR(DEC(MAX(SUBSTRING(SETTLE_NO,6,5)))+ 1)  ") ; 
						sql.append( " WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(SETTLE_NO,6,5)))+ 1)) = 2  ") ; 
						sql.append( " THEN '000' CONCAT CHAR(DEC(MAX(SUBSTRING(SETTLE_NO,6,5)))+ 1)  ") ; 
						sql.append( " WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(SETTLE_NO,6,5)))+ 1)) = 3  ") ; 
						sql.append( " THEN '00' CONCAT CHAR(DEC(MAX(SUBSTRING(SETTLE_NO,6,5)))+ 1)  ") ; 
						sql.append( " WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(SETTLE_NO,6,5)))+ 1)) = 4  ") ; 
						sql.append( " THEN '0' CONCAT CHAR(DEC(MAX(SUBSTRING(SETTLE_NO,6,5)))+ 1)  ") ; 
						sql.append( " ELSE '00001' END AS SETTLE_NO FROM TRANSFER.LTSTTMNT  ") ; 
						sql.append( " WHERE SUBSTR(SETTLE_NO,1,4) =SUBSTR(CHAR(CURRENT DATE),3,2) CONCAT SUBSTR(CHAR(CURRENT DATE),6,2)  ") ; 
						
						GauceStatement gsmt = conn.getGauceStatement(sql.toString());
						 
						gsmt.executeQuery(dSetMstID);
						gsmt.close(); 
		 
						if ( dSetMstID!=null && dSetMstID.getDataRowCnt() > 0 ) {
											GauceDataRow[] dRowMstID = dSetMstID.getDataRows(); 
											settle_no = dRowMstID[0].getString(0);   
											//logger.err.println(this,settle_no);
											 
														 
						}
 
						InsertSql = new StringBuffer();
						InsertSql.append(" INSERT INTO TRANSFER.LTSTTMNT" ) ; 
						InsertSql.append(" (SETTLE_NO,CUST_CD,SETTLE_YM,SETTLE_CD,SETTLE_ITEMS,") ; 
						InsertSql.append(" CAR_TYPE,PACKING_TYPE,LOAD_LCT,OFF_LCT,UNIT_CBM,UNIT,") ; 
						InsertSql.append(" CNT,UNIT_PRICE,PRICE,REQ_PRICE1,REQ_PRICE2,VAT_AMT,") ; 
						InsertSql.append(" REMARK,TR_PAPER,STM_ACCT,STTL_DATE,ORDER_NO,ORDER_SEQ,") ; 
						InsertSql.append(" LINE,PROJECT,VEND_CD,CHARGE_RATE,ETD_DT,SELL_TYPE,") ; 
						InsertSql.append(" ACC_CH,ACC_DATE,ACC_CODE,CREATE_DT,CREATE_USR,") ; 
						InsertSql.append(" UPDATE_DT,UPDATE_USR ) "); //,CUST_NM,VEND_NM )");
						InsertSql.append(" values " ) ; 
						InsertSql.append(" (?,?,?,?,?,") ; 
						InsertSql.append(" ?,?,?,?,?,?,") ; 
						InsertSql.append(" ?,?,?,?,?,?,") ; 
						InsertSql.append(" ?,?,?,?,?,?,") ; 
						InsertSql.append(" ?,?,?,?,?,?,") ; 
						InsertSql.append(" ?,?,?,CURRENT TIMESTAMP,?,") ; 
						InsertSql.append(" CURRENT TIMESTAMP,?)") ; //,?,? )");
												 
					  gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows[j]); 
											gsmt.setString(1, settle_no);
											gsmt.bindColumn(2,idxCUST_CD) ; 
											gsmt.bindColumn(3,idxSETTLE_YM) ;  
											gsmt.bindColumn(4,idxSETTLE_CD) ;  
											gsmt.bindColumn(5,idxSETTLE_ITEMS) ;  
											gsmt.bindColumn(6,idxCAR_TYPE) ;  
											gsmt.bindColumn(7,idxPACKING_TYPE) ;  
											gsmt.bindColumn(8,idxLOAD_LCT) ; 
											gsmt.bindColumn(9,idxOFF_LCT) ;  
											gsmt.bindColumn(10,idxUNIT_CBM) ;  
											gsmt.bindColumn(11,idxUNIT) ;  
											gsmt.bindColumn(12,idxCNT) ;  
											gsmt.bindColumn(13,idxUNIT_PRICE) ;  
											gsmt.bindColumn(14,idxPRICE) ; 
											gsmt.bindColumn(15,idxREQ_PRICE1) ;  
											gsmt.bindColumn(16,idxREQ_PRICE2) ;  
											gsmt.bindColumn(17,idxVAT_AMT) ;  
											gsmt.bindColumn(18,idxREMARK) ;  
											gsmt.bindColumn(19,idxTR_PAPER) ; 
											gsmt.bindColumn(20,idxSTM_ACCT) ; 
											gsmt.bindColumn(21,idxSTTL_DATE) ;  
											gsmt.bindColumn(22,idxORDER_NO) ;  
											gsmt.bindColumn(23,idxORDER_SEQ) ;  
											gsmt.bindColumn(24,idxLINE) ;  
											gsmt.bindColumn(25,idxPROJECT) ;   
											gsmt.bindColumn(26,idxVEND_CD) ; 
											gsmt.bindColumn(27,idxCHARGE_RATE) ;  
											gsmt.bindColumn(28,idxETD_DT) ;  
											gsmt.bindColumn(29,idxSELL_TYPE) ;  
											gsmt.bindColumn(30,idxACC_CH) ;  
											gsmt.bindColumn(31,idxACC_DATE) ;  
											gsmt.bindColumn(32,idxACC_CODE) ; 
											gsmt.bindColumn(33,idxCREATE_USR) ;  
											gsmt.bindColumn(34,idxUPDATE_USR) ;  
										 
												
	 					gsmt.executeUpdate(); 
						gsmt.close(); 
						 

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
					UpdateSql = new StringBuffer();
					UpdateSql.append(" UPDATE TRANSFER.LTORDERMST SET ") ; 
					UpdateSql.append(" CUST_CD= ?,SETTLE_YM= ?,SETTLE_CD= ?,SETTLE_ITEMS= ?,") ; 
					UpdateSql.append(" CAR_TYPE= ?,PACKING_TYPE= ?,LOAD_LCT=?,OFF_LCT= ?,UNIT_CBM= ?,UNIT= ?,") ; 
					UpdateSql.append(" CNT= ?,UNIT_PRICE= ?,PRICE= ?,REQ_PRICE1= ?,REQ_PRICE2= ?,VAT_AMT= ?,") ; 
					UpdateSql.append(" REMARK= ?,TR_PAPER= ?,STM_ACCT= ?,STTL_DATE= ?,ORDER_NO= ?,ORDER_SEQ= ?,") ; 
					UpdateSql.append(" LINE= ?,PROJECT= ?,VEND_CD= ?,CHARGE_RATE= ?,ETD_DT= ?,SELL_TYPE= ?,") ; 
					UpdateSql.append(" ACC_CH= ?,ACC_DATE= ?,ACC_CODE= ?,") ; 
					UpdateSql.append(" UPDATE_DT=CURRENT TIMESTAMP,UPDATE_USR = ? " ) ; 
					UpdateSql.append(" WHERE SETTLE_NO = ? ") ; 
										   
						
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//////logger.err.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);  

						gsmt.bindColumn(1,idxCUST_CD) ; 
						gsmt.bindColumn(2,idxSETTLE_YM) ;  
						gsmt.bindColumn(3,idxSETTLE_CD) ;  
						gsmt.bindColumn(4,idxSETTLE_ITEMS) ;  
						gsmt.bindColumn(5,idxCAR_TYPE) ;  
						gsmt.bindColumn(6,idxPACKING_TYPE) ;  
						gsmt.bindColumn(7,idxLOAD_LCT) ; 
						gsmt.bindColumn(8,idxOFF_LCT) ;  
						gsmt.bindColumn(9,idxUNIT_CBM) ;  
						gsmt.bindColumn(10,idxUNIT) ;  
						gsmt.bindColumn(11,idxCNT) ;  
						gsmt.bindColumn(12,idxUNIT_PRICE) ;  
						gsmt.bindColumn(13,idxPRICE) ; 
						gsmt.bindColumn(14,idxREQ_PRICE1) ;  
						gsmt.bindColumn(15,idxREQ_PRICE2) ;  
						gsmt.bindColumn(16,idxVAT_AMT) ;  
						gsmt.bindColumn(17,idxREMARK) ;  
						gsmt.bindColumn(18,idxTR_PAPER) ; 
						gsmt.bindColumn(19,idxSTM_ACCT) ; 
						gsmt.bindColumn(20,idxSTTL_DATE) ;  
						gsmt.bindColumn(21,idxORDER_NO) ;  
						gsmt.bindColumn(22,idxORDER_SEQ) ;  
						gsmt.bindColumn(23,idxLINE) ;  
						gsmt.bindColumn(24,idxPROJECT) ;   
						gsmt.bindColumn(25,idxVEND_CD) ; 
						gsmt.bindColumn(26,idxCHARGE_RATE) ;  
						gsmt.bindColumn(27,idxETD_DT) ;  
						gsmt.bindColumn(28,idxSELL_TYPE) ;  
						gsmt.bindColumn(29,idxACC_CH) ;  
						gsmt.bindColumn(30,idxACC_DATE) ;  
						gsmt.bindColumn(31,idxACC_CODE) ;  
						gsmt.bindColumn(32,idxUPDATE_USR) ;  
						 
						gsmt.setString(33,settle_no);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql =  new StringBuffer() ; 
						DeleteSql.append(" DELETE FROM TRANSFER.LTORDERMST ") ; 
						DeleteSql.append(" WHERE SETTLE_NO = ? ") ;
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//////logger.err.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.setString(1,settle_no);
						/*gsmt.bindColumn(1, idxCAR_TYPE);*/
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				////logger.err.println(this,se);
				 //logger.err.println(this,se.toString());
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			////logger.err.println(this,e);
			//logger.err.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}