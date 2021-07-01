package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trPlDetail_new extends HttpServlet{

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
			GauceDataSet dSetMstID = null;
			GauceStatement gstmt = null;

			try {
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String pl_no = reqGauce.getParameter("gstr1"); 
   				if ( pl_no==null || pl_no.trim().length()==0 ) { pl_no=null; }
				String auth_no  = null ; 
				String ls_check = null ; 



//-----------------------------------------------------------------------------
//	Description : PL MASTER  积己 START
//-----------------------------------------------------------------------------		
				GauceDataSet userSetM = reqGauce.getGauceDataSet("USERM");
				
				//int idxPL_NO            =userSet.indexOfColumn("PL_NO");       
				int idxIN_OUT_M           =userSetM.indexOfColumn("IN_OUT");      
				int idxPL_SHIPPER_M       =userSetM.indexOfColumn("PL_SHIPPER");  
				int idxPL_SHPPRNM_M       =userSetM.indexOfColumn("PL_SHPPRNM");  
				int idxPL_SHPADD1_M       =userSetM.indexOfColumn("PL_SHPADD1");  
				int idxPL_SHPADD2_M       =userSetM.indexOfColumn("PL_SHPADD2");  
				int idxPL_SHPADD3_M       =userSetM.indexOfColumn("PL_SHPADD3");  
				int idxPL_SHPTEL_M        =userSetM.indexOfColumn("PL_SHPTEL");   
				int idxPL_CSTM_M          =userSetM.indexOfColumn("PL_CSTM");     
				int idxPL_CSTMNM_M        =userSetM.indexOfColumn("PL_CSTMNM");   
				int idxPL_CSTADD1_M       =userSetM.indexOfColumn("PL_CSTADD1");  
				int idxPL_CSTADD2_M       =userSetM.indexOfColumn("PL_CSTADD2");  
				int idxPL_CSTADD3_M       =userSetM.indexOfColumn("PL_CSTADD3");  
				int idxPL_CSTTEL_M        =userSetM.indexOfColumn("PL_CSTTEL");   
				int idxPL_BRKR_M          =userSetM.indexOfColumn("PL_BRKR");     
				int idxPL_BRKRNM_M        =userSetM.indexOfColumn("PL_BRKRNM");   
				int idxPL_BRKADD1_M       =userSetM.indexOfColumn("PL_BRKADD1");  
				int idxPL_BRKADD2_M       =userSetM.indexOfColumn("PL_BRKADD2");  
				int idxPL_BRKADD3_M       =userSetM.indexOfColumn("PL_BRKADD3");  
				int idxPL_BRKTEL_M        =userSetM.indexOfColumn("PL_BRKTEL");   
				//int idxPL_NOTICE        =userSetM.indexOfColumn("PL_NOTICE");   
				//int idxPLNOTICENM       =userSetM.indexOfColumn("PLNOTICENM");  
				int idxSTART_LCT_M        =userSetM.indexOfColumn("START_LCT");   
				int idxREACH_LCT_M        =userSetM.indexOfColumn("REACH_LCT");   
				int idxTRANS_CAR_M        =userSetM.indexOfColumn("TRANS_CAR");   
				int idxSTART_DT_M         =userSetM.indexOfColumn("START_DT");    
				int idxINVOICE_NO_M       =userSetM.indexOfColumn("INVOICE_NO");  
				int idxINVOICE_DT_M       =userSetM.indexOfColumn("INVOICE_DT");  
				int idxREMARK_M           =userSetM.indexOfColumn("REMARK");      
				int idxLCNO_M             =userSetM.indexOfColumn("LCNO");        
				int idxLCDATE_M           =userSetM.indexOfColumn("LCDATE");      
				int idxLCBANK_M           =userSetM.indexOfColumn("LCBANK");      
				int idxWEIGHT_M           =userSetM.indexOfColumn("WEIGHT");      
				int idxT_WEIGHT_M         =userSetM.indexOfColumn("T_WEIGHT");    
				int idxT_CBM_M            =userSetM.indexOfColumn("T_CBM");       
				int idxGORDER_NO_M        =userSetM.indexOfColumn("GORDER_NO");   
				int idxPACKING_CNT_M      =userSetM.indexOfColumn("PACKING_CNT"); 
				int idxPACKING_UNIT_M     =userSetM.indexOfColumn("PACKING_UNIT");
				int idxPACKING_CBM_M      =userSetM.indexOfColumn("PACKING_CBM"); 
				int idxTELEPHONE_M        =userSetM.indexOfColumn("TELEPHONE");   
				int idxRPR_GOODS_M        =userSetM.indexOfColumn("RPR_GOODS");   
				int idxCARGO_TYPE_M       =userSetM.indexOfColumn("CARGO_TYPE");  
				int idxDNG_TYPE_M         =userSetM.indexOfColumn("DNG_TYPE");    
				int idxCAR_TYPE_M         =userSetM.indexOfColumn("CAR_TYPE");    
				int idxORDER_NO_M         =userSetM.indexOfColumn("ORDER_NO");    
				int idxDCL_DATE_M         =userSetM.indexOfColumn("DCL_DATE");    
				int idxDCL_NO_M           =userSetM.indexOfColumn("DCL_NO");      
				int idxCURRENCY_M         =userSetM.indexOfColumn("CURRENCY");    
				int idxCREATE_DT_M        =userSetM.indexOfColumn("CREATE_DT");   
				int idxCREATE_USR_M       =userSetM.indexOfColumn("CREATE_USR");  
				int idxUPDATE_DT_M        =userSetM.indexOfColumn("UPDATE_DT");   
				int idxUPDATE_USR_M       =userSetM.indexOfColumn("UPDATE_USR");  
				int idxSTART_TIME_M       =userSetM.indexOfColumn("START_TIME") ; 
				int idxLINE_PART_M       =userSetM.indexOfColumn("LINE_PART") ; 
				int idxPL_CSN_M   =  userSetM.indexOfColumn("PL_CSN");
				int idxPL_CSNNM_M =  userSetM.indexOfColumn("PL_CSNNM");
				int idxPL_CSNTEL_M =  userSetM.indexOfColumn("PL_CSNTEL");
				int idxPL_CSNADDR_M =  userSetM.indexOfColumn("PL_CSNADDR");
				int idxPL_CSNADDR2_M =  userSetM.indexOfColumn("PL_CSNADDR2");
				int idxPL_CSNADDR3_M=  userSetM.indexOfColumn("PL_CSNADDR3");
				
				GauceDataRow[] rows00 = userSetM.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  

				for (int j = 0; j < rows00.length; j++){
					InsertSql = null;
					UpdateSql = null;
					DeleteSql = null;  

					if(rows00[j].getJobType() == GauceDataRow.TB_JOB_INSERT) { 
 
						InsertSql = new StringBuffer();
            InsertSql.append(" INSERT INTO TRANSFER.LTPCKLSCI ( \n")
										 .append("		PL_NO,IN_OUT,PL_SHIPPER,PL_SHPPRNM,PL_SHPADD1,PL_SHPADD2, \n")
										 .append("		PL_SHPADD3,PL_SHPTEL,PL_CSTM,PL_CSTMNM,PL_CSTADD1, \n")
										 .append("		PL_CSTADD2,PL_CSTADD3,PL_CSTTEL,PL_BRKR,PL_BRKRNM, \n")
										 .append("		PL_BRKADD1,PL_BRKADD2,PL_BRKADD3,PL_BRKTEL, \n")
										 .append("		START_LCT,REACH_LCT,TRANS_CAR,START_DT, \n")
										 .append("		INVOICE_NO,INVOICE_DT,REMARK,LCNO,LCDATE,LCBANK, \n")
										 .append("		WEIGHT,T_WEIGHT,T_CBM,GORDER_NO,PACKING_CNT, \n")
										 .append("		PACKING_UNIT,PACKING_CBM,TELEPHONE,RPR_GOODS, \n")
										 .append("		CARGO_TYPE,DNG_TYPE,CAR_TYPE,ORDER_NO,DCL_DATE, \n")
										 .append("		DCL_NO,CURRENCY,CREATE_DT,CREATE_USR,UPDATE_DT,UPDATE_USR,START_TIME ,LINE_PART, \n")
										 .append("		PL_CSN,PL_CSNNM,PL_CSNTEL,PL_CSNADDR,PL_CSNADDR2,PL_CSNADDR3) \n")
										 .append(" Values( \n")
										 .append("		?,?,?,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?, \n")
										 .append("		?,?,?,?, \n")
										 .append("		?,?,?,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,?,?, \n")
										 .append("		?,?,?,?,?, \n")
										 .append("		?,?,CURRENT TIMESTAMP,?,CURRENT TIMESTAMP,?,?,?, \n")
										 .append("		?,?,?,?,?,?) ");

					  logger.dbg.println(this,InsertSql.toString());												

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows00[j]);  
 						
						gsmt.setString(1,pl_no);
						gsmt.bindColumn(2,idxIN_OUT_M);
						gsmt.bindColumn(3,idxPL_SHIPPER_M);
						gsmt.bindColumn(4,idxPL_SHPPRNM_M);
						gsmt.bindColumn(5,idxPL_SHPADD1_M);
						gsmt.bindColumn(6,idxPL_SHPADD2_M);
						gsmt.bindColumn(7,idxPL_SHPADD3_M); 
						gsmt.bindColumn(8,idxPL_SHPTEL_M) ; 
						gsmt.bindColumn(9,idxPL_CSTM_M) ; 
						gsmt.bindColumn(10,idxPL_CSTMNM_M) ; 
						gsmt.bindColumn(11,idxPL_CSTADD1_M) ; 
						gsmt.bindColumn(12,idxPL_CSTADD2_M) ; 
						gsmt.bindColumn(13,idxPL_CSTADD3_M) ; 
						gsmt.bindColumn(14,idxPL_CSTTEL_M) ; 
						gsmt.bindColumn(15,idxPL_BRKR_M) ; 
						gsmt.bindColumn(16,idxPL_BRKRNM_M) ; 
						gsmt.bindColumn(17,idxPL_BRKADD1_M) ; 
						gsmt.bindColumn(18,idxPL_BRKADD2_M) ; 
						gsmt.bindColumn(19,idxPL_BRKADD3_M) ; 
						gsmt.bindColumn(20,idxPL_BRKTEL_M) ; 
						//gsmt.bindColumn(21,idxPL_NOTICE) ; 
						//gsmt.bindColumn(22,idxPLNOTICENM) ; 
						gsmt.bindColumn(21,idxSTART_LCT_M) ; 
						gsmt.bindColumn(22,idxREACH_LCT_M) ; 
						gsmt.bindColumn(23,idxTRANS_CAR_M) ; 
						gsmt.bindColumn(24,idxSTART_DT_M) ; 
						gsmt.bindColumn(25,idxINVOICE_NO_M) ; 
						gsmt.bindColumn(26,idxINVOICE_DT_M) ; 
						gsmt.bindColumn(27,idxREMARK_M) ; 
						gsmt.bindColumn(28,idxLCNO_M) ; 
						gsmt.bindColumn(29,idxLCDATE_M) ; 
						gsmt.bindColumn(30,idxLCBANK_M) ; 
						gsmt.bindColumn(31,idxWEIGHT_M) ; 
						gsmt.bindColumn(32,idxT_WEIGHT_M) ; 
						gsmt.bindColumn(33,idxT_CBM_M) ; 
						gsmt.bindColumn(34,idxGORDER_NO_M) ; 
						gsmt.bindColumn(35,idxPACKING_CNT_M) ; 
						gsmt.bindColumn(36,idxPACKING_UNIT_M) ; 
						gsmt.bindColumn(37,idxPACKING_CBM_M) ; 
						gsmt.bindColumn(38,idxTELEPHONE_M) ; 
						gsmt.bindColumn(39,idxRPR_GOODS_M) ; 
						gsmt.bindColumn(40,idxCARGO_TYPE_M) ; 
						gsmt.bindColumn(41,idxDNG_TYPE_M) ; 
						gsmt.bindColumn(42,idxCAR_TYPE_M) ; 
						gsmt.bindColumn(43,idxORDER_NO_M) ; 
						gsmt.bindColumn(44,idxDCL_DATE_M) ; 
						gsmt.bindColumn(45,idxDCL_NO_M) ; 
						gsmt.bindColumn(46,idxCURRENCY_M) ; 
						gsmt.bindColumn(47,idxCREATE_USR_M) ; 
						gsmt.bindColumn(48,idxUPDATE_USR_M) ; 
						gsmt.bindColumn(49,idxSTART_TIME_M) ; 
						gsmt.bindColumn(50,idxLINE_PART_M) ; 
						gsmt.bindColumn(51, idxPL_CSN_M ) ;  
						gsmt.bindColumn(52, idxPL_CSNNM_M ) ;
						gsmt.bindColumn(53, idxPL_CSNTEL_M ) ;  
						gsmt.bindColumn(54, idxPL_CSNADDR_M ) ;
						gsmt.bindColumn(55, idxPL_CSNADDR2_M ) ;
						gsmt.bindColumn(56, idxPL_CSNADDR3_M ) ; 
					
	 					gsmt.executeUpdate(); 
						gsmt.close(); 

					}

					if(rows00[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTPCKLSCI SET \n")
										 .append("		IN_OUT = ?,PL_SHIPPER = ?,PL_SHPPRNM = ?,PL_SHPADD1 = ?,PL_SHPADD2 = ?, \n")
										 .append("		PL_SHPADD3 = ?,PL_SHPTEL = ?,PL_CSTM = ?,PL_CSTMNM = ?,PL_CSTADD1 = ?, \n")
										 .append("		PL_CSTADD2 = ?,PL_CSTADD3 = ?,PL_CSTTEL = ?,PL_BRKR = ?,PL_BRKRNM = ?, \n")
										 .append("		PL_BRKADD1 = ?,PL_BRKADD2 = ?,PL_BRKADD3 = ?,PL_BRKTEL = ?, \n")
										 .append("		START_LCT = ?,REACH_LCT = ?,TRANS_CAR = ?,START_DT = ?, \n")
										 .append("		INVOICE_NO = ?,INVOICE_DT = ?,REMARK = ?,LCNO = ?,LCDATE = ?,LCBANK = ?, \n")
										 .append("		WEIGHT = ?,T_WEIGHT = ?,T_CBM = ?,GORDER_NO = ?,PACKING_CNT = ?, \n")
										 .append("		PACKING_UNIT = ?,PACKING_CBM = ?,TELEPHONE = ?,RPR_GOODS = ?, \n")
										 .append("		CARGO_TYPE = ?,DNG_TYPE = ?,CAR_TYPE = ?,ORDER_NO = ?,DCL_DATE = ?, \n")
										 .append("		DCL_NO = ?,CURRENCY = ?,UPDATE_DT = CURRENT TIMESTAMP,UPDATE_USR = ?,LINE_PART = ?, \n")
										 .append("		PL_CSN = ?,PL_CSNNM = ?,PL_CSNTEL = ?,PL_CSNADDR = ?,PL_CSNADDR2 = ?,PL_CSNADDR3 = ? \n")
										 .append(" WHERE PL_NO = ? ") ;  
						
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows00[j]); 
					
						gsmt.bindColumn(1,idxIN_OUT_M);
						gsmt.bindColumn(2,idxPL_SHIPPER_M);
						gsmt.bindColumn(3,idxPL_SHPPRNM_M);
						gsmt.bindColumn(4,idxPL_SHPADD1_M);
						gsmt.bindColumn(5,idxPL_SHPADD2_M);
						gsmt.bindColumn(6,idxPL_SHPADD3_M); 
						gsmt.bindColumn(7,idxPL_SHPTEL_M) ; 
						gsmt.bindColumn(8,idxPL_CSTM_M) ; 
						gsmt.bindColumn(9,idxPL_CSTMNM_M) ; 
						gsmt.bindColumn(10,idxPL_CSTADD1_M) ; 
						gsmt.bindColumn(11,idxPL_CSTADD2_M) ; 
						gsmt.bindColumn(12,idxPL_CSTADD3_M) ; 
						gsmt.bindColumn(13,idxPL_CSTTEL_M) ; 
						gsmt.bindColumn(14,idxPL_BRKR_M) ; 
						gsmt.bindColumn(15,idxPL_BRKRNM_M) ; 
						gsmt.bindColumn(16,idxPL_BRKADD1_M) ; 
						gsmt.bindColumn(17,idxPL_BRKADD2_M) ; 
						gsmt.bindColumn(18,idxPL_BRKADD3_M) ; 
						gsmt.bindColumn(19,idxPL_BRKTEL_M) ; 
						//mt.bindColumn(20,idxPL_NOTICE) ; 
						//mt.bindColumn(21,idxPLNOTICENM) ; 
						gsmt.bindColumn(20,idxSTART_LCT_M) ; 
						gsmt.bindColumn(21,idxREACH_LCT_M) ; 
						gsmt.bindColumn(22,idxTRANS_CAR_M) ; 
						gsmt.bindColumn(23,idxSTART_DT_M) ; 
						gsmt.bindColumn(24,idxINVOICE_NO_M) ; 
						gsmt.bindColumn(25,idxINVOICE_DT_M) ; 
						gsmt.bindColumn(26,idxREMARK_M) ; 
						gsmt.bindColumn(27,idxLCNO_M) ; 
						gsmt.bindColumn(28,idxLCDATE_M) ; 
						gsmt.bindColumn(29,idxLCBANK_M) ; 
						gsmt.bindColumn(30,idxWEIGHT_M) ; 
						gsmt.bindColumn(31,idxT_WEIGHT_M) ; 
						gsmt.bindColumn(32,idxT_CBM_M) ; 
						gsmt.bindColumn(33,idxGORDER_NO_M) ; 
						gsmt.bindColumn(34,idxPACKING_CNT_M) ; 
						gsmt.bindColumn(35,idxPACKING_UNIT_M) ; 
						gsmt.bindColumn(36,idxPACKING_CBM_M) ; 
						gsmt.bindColumn(37,idxTELEPHONE_M) ; 
						gsmt.bindColumn(38,idxRPR_GOODS_M) ; 
						gsmt.bindColumn(39,idxCARGO_TYPE_M) ; 
						gsmt.bindColumn(40,idxDNG_TYPE_M) ; 
						gsmt.bindColumn(41,idxCAR_TYPE_M) ; 
						gsmt.bindColumn(42,idxORDER_NO_M) ; 
						gsmt.bindColumn(43,idxDCL_DATE_M) ; 
						gsmt.bindColumn(44,idxDCL_NO_M) ; 
						gsmt.bindColumn(45,idxCURRENCY_M) ;  
						gsmt.bindColumn(46,idxUPDATE_USR_M) ;  
						gsmt.bindColumn(47,idxLINE_PART_M) ; 
						gsmt.bindColumn(48, idxPL_CSN_M ) ;  
						gsmt.bindColumn(49, idxPL_CSNNM_M ) ;
						gsmt.bindColumn(50, idxPL_CSNTEL_M ) ;  
						gsmt.bindColumn(51, idxPL_CSNADDR_M ) ;
						gsmt.bindColumn(52, idxPL_CSNADDR2_M ) ;
						gsmt.bindColumn(53, idxPL_CSNADDR3_M ) ; 
						gsmt.setString(54, pl_no);

						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows00[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						
						DeleteSql = new StringBuffer();
						DeleteSql.append(" DELETE FROM  TRANSFER.LTPCKLSCI \n")
										 .append(" WHERE PL_NO = ?  ");
						
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows00[j]);
						gsmt.setString(1,pl_no);

						gsmt.executeUpdate();
						gsmt.close();
					}
				}

//-----------------------------------------------------------------------------
//	Description : PL MASTER  积己 END
//-----------------------------------------------------------------------------		

                
//-----------------------------------------------------------------------------
//	Description : PL DETAIL 积己 START
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 

				int idxPL_NO            =userSet.indexOfColumn("PL_NO");      
				int idxPL_SEQNO         =userSet.indexOfColumn("PL_SEQNO");   
				int idxCAR_NO           =userSet.indexOfColumn("CAR_NO");     
				int idxCNTN_NO          =userSet.indexOfColumn("CNTN_NO");    
				int idxCNTN_SDSZ        =userSet.indexOfColumn("CNTN_SDSZ");  
				int idxCNTN_SLNO        =userSet.indexOfColumn("CNTN_SLNO");  
				int idxGOODS_CD         =userSet.indexOfColumn("GOODS_CD");   
				int idxGOODS_NM         =userSet.indexOfColumn("GOODS_NM");   
				int idxGOODS_ENM        =userSet.indexOfColumn("GOODS_ENM");  
				int idxPACKING_NO       =userSet.indexOfColumn("PACKING_NO"); 
				int idxPACKING_CNT      =userSet.indexOfColumn("PACKING_CNT");
				int idxSTDRD_SZ         =userSet.indexOfColumn("STDRD_SZ");   
				int idxHS_CODE          =userSet.indexOfColumn("HS_CODE");    
				int idxGOODS_CNT        =userSet.indexOfColumn("GOODS_CNT");        
				int idxCNT_UNIT         =userSet.indexOfColumn("CNT_UNIT");   
				int idxUNIT_PRICE       =userSet.indexOfColumn("UNIT_PRICE"); 
				int idxPRICE            =userSet.indexOfColumn("PRICE");      
				int idxPKC_CNT          =userSet.indexOfColumn("PKC_CNT");    
				int idxPKG_WEIGHT       =userSet.indexOfColumn("PKG_WEIGHT"); 
				int idxPKG_LNGTH        =userSet.indexOfColumn("PKG_LNGTH");  
				int idxPKG_HEIGHT       =userSet.indexOfColumn("PKG_HEIGHT"); 
				int idxPKG_WIDTH        =userSet.indexOfColumn("PKG_WIDTH");  
				int idxPKG_CBM          =userSet.indexOfColumn("PKG_CBM");    
				int idxPKG_UNIT         =userSet.indexOfColumn("PKG_UNIT");   
				int idxT_WEIGHT         =userSet.indexOfColumn("T_WEIGHT");   //眠啊
				int idxORDER_NO         =userSet.indexOfColumn("ORDER_NO");   
				int idxORDER_SEQ        =userSet.indexOfColumn("ORDER_SEQ");  
				int idxREAMARK          =userSet.indexOfColumn("REAMARK");    
				int idxCREATE_DT        =userSet.indexOfColumn("CREATE_DT");  
				int idxCREATE_USR       =userSet.indexOfColumn("CREATE_USR"); 
				int idxUPDATE_DT        =userSet.indexOfColumn("UPDATE_DT");  
				int idxUPDATE_USR       =userSet.indexOfColumn("UPDATE_USR");  

				GauceDataRow[] rows = userSet.getDataRows();
				 
				StringBuffer  Sql = null; 

				for (int j = 0; j < rows.length; j++){
					Sql = null;

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) { 
						 
						Sql = new StringBuffer();
						Sql.append(" INSERT INTO TRANSFER.LTPCKLSDT \n")
							 .append("	( \n")
							 .append("		PL_NO, PL_SEQNO, CAR_NO, CNTN_NO, CNTN_SDSZ, \n")
							 .append(" 		CNTN_SLNO, GOODS_CD, GOODS_NM, GOODS_ENM, PACKING_NO, \n")
							 .append("		PACKING_CNT, STDRD_SZ, HS_CODE, GOODS_CNT, CNT_UNIT, \n")
							 .append("		UNIT_PRICE, PRICE, PKC_CNT, PKG_WEIGHT, PKG_LNGTH, \n")
							 .append("		PKG_HEIGHT, PKG_WIDTH, PKG_CBM, PKG_UNIT, T_WEIGHT, ORDER_NO, \n")
							 .append("		ORDER_SEQ, REAMARK, CREATE_DT, CREATE_USR, UPDATE_DT, \n" )
							 .append("		UPDATE_USR \n")
						 	 .append(" ) VALUES ( ")
							 .append("	 ?,?,?,?,?, \n")
							 .append("	 ?,?,?,?,?, \n")
							 .append("	 ?,?,?,?,?, \n")
							 .append("	 ?,?,?,?,?, \n")
							 .append("	 ?,?,?,?,?,?, \n")
							 .append("	 ?,?,CURRENT TIMESTAMP,?,CURRENT TIMESTAMP, \n" )
							 .append("	 ? \n")
							 .append(" )") ; 

					  //logger.dbg.println(this,Sql.toString());
						
						GauceStatement gsmt = conn.getGauceStatement(Sql.toString()); 
						gsmt.setGauceDataRow(rows[j]); 
						gsmt.setString(1, pl_no);  
						gsmt.bindColumn(2, idxPL_SEQNO); 
						gsmt.bindColumn(3, idxCAR_NO); 
						gsmt.bindColumn(4, idxCNTN_NO); 
						gsmt.bindColumn(5, idxCNTN_SDSZ); 
						gsmt.bindColumn(6, idxCNTN_SLNO); 
						gsmt.bindColumn(7, idxGOODS_CD); 	
						gsmt.bindColumn(8, idxGOODS_NM); 
						gsmt.bindColumn(9, idxGOODS_ENM); 
						gsmt.bindColumn(10, idxPACKING_NO); 
						gsmt.bindColumn(11, idxPACKING_CNT); 
						gsmt.bindColumn(12, idxSTDRD_SZ);  
						gsmt.bindColumn(13, idxHS_CODE); 
						gsmt.bindColumn(14, idxGOODS_CNT); 
						gsmt.bindColumn(15, idxCNT_UNIT); 
						gsmt.bindColumn(16, idxUNIT_PRICE); 
						gsmt.bindColumn(17, idxPRICE); 
						gsmt.bindColumn(18, idxPKC_CNT); 
						gsmt.bindColumn(19, idxPKG_WEIGHT); 
						gsmt.bindColumn(20, idxPKG_LNGTH); 
						gsmt.bindColumn(21, idxPKG_HEIGHT); 
						gsmt.bindColumn(22, idxPKG_WIDTH); 
						gsmt.bindColumn(23, idxPKG_CBM); 
						gsmt.bindColumn(24, idxPKG_UNIT); 
						gsmt.bindColumn(25, idxT_WEIGHT); 
						gsmt.bindColumn(26, idxORDER_NO); 
						gsmt.bindColumn(27, idxORDER_SEQ); 
						gsmt.bindColumn(28, idxREAMARK); 
						gsmt.bindColumn(29, idxCREATE_USR); 
						gsmt.bindColumn(30, idxUPDATE_USR);  
 
						gsmt.executeUpdate(); 
						gsmt.close();
						Sql = null ; 
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						Sql = new StringBuffer();
						Sql.append(" UPDATE TRANSFER.LTPCKLSDT SET \n")
							 .append("			CAR_NO = ?,CNTN_NO = ?,CNTN_SDSZ = ?, \n")
					     .append(" 			CNTN_SLNO = ?,GOODS_CD = ?,GOODS_NM = ?,GOODS_ENM = ?, \n")
							 .append("			PACKING_NO = ?,PACKING_CNT = ?,STDRD_SZ = ?,HS_CODE = ?, \n")
							 .append("			GOODS_CNT = ?,CNT_UNIT = ?,UNIT_PRICE = ?,PRICE = ?,PKC_CNT = ?, \n")
							 .append("			PKG_WEIGHT = ?,PKG_LNGTH = ?,PKG_HEIGHT = ?, \n")
							 .append("			PKG_WIDTH = ?,PKG_CBM = ?,PKG_UNIT = ?,T_WEIGHT = ?,ORDER_NO = ?, \n")
							 .append("			ORDER_SEQ = ?,REAMARK = ?, \n")
							 .append("			UPDATE_DT = CURRENT TIMESTAMP,UPDATE_USR = ? \n")
							 .append("	WHERE PL_NO = ?  \n")
							 .append("		AND PL_SEQNO = ? ");

							GauceStatement gsmt = conn.getGauceStatement(Sql.toString()); 
							gsmt.setGauceDataRow(rows[j]);  
							gsmt.bindColumn(1, idxCAR_NO); 
							gsmt.bindColumn(2, idxCNTN_NO); 
							gsmt.bindColumn(3, idxCNTN_SDSZ); 
							gsmt.bindColumn(4, idxCNTN_SLNO); 
							gsmt.bindColumn(5, idxGOODS_CD); 	
							gsmt.bindColumn(6, idxGOODS_NM); 
							gsmt.bindColumn(7, idxGOODS_ENM); 
							gsmt.bindColumn(8, idxPACKING_NO); 
							gsmt.bindColumn(9, idxPACKING_CNT); 
							gsmt.bindColumn(10, idxSTDRD_SZ);  
							gsmt.bindColumn(11, idxHS_CODE); 
							gsmt.bindColumn(12, idxGOODS_CNT); 
							gsmt.bindColumn(13, idxCNT_UNIT); 
							gsmt.bindColumn(14, idxUNIT_PRICE); 
							gsmt.bindColumn(15, idxPRICE); 
							gsmt.bindColumn(16, idxPKC_CNT); 
							gsmt.bindColumn(17, idxPKG_WEIGHT); 
							gsmt.bindColumn(18, idxPKG_LNGTH); 
							gsmt.bindColumn(19, idxPKG_HEIGHT); 
							gsmt.bindColumn(20, idxPKG_WIDTH); 
							gsmt.bindColumn(21, idxPKG_CBM); 
							gsmt.bindColumn(22, idxPKG_UNIT); 
							gsmt.bindColumn(23, idxT_WEIGHT); 
							gsmt.bindColumn(24, idxORDER_NO); 
							gsmt.bindColumn(25, idxORDER_SEQ); 
							gsmt.bindColumn(26, idxREAMARK); 
							gsmt.bindColumn(27, idxUPDATE_USR);  
							gsmt.bindColumn(28, idxPL_NO);  
							gsmt.bindColumn(29, idxPL_SEQNO); 

/*
						Sql = new StringBuffer();
						Sql.append(" UPDATE TRANSFER.LTPCKLSDT SET \n")
							 .append("			CAR_NO = '" + idxCAR_NO + "',CNTN_NO = '" + idxCNTN_NO + "', CNTN_SDSZ = '" + idxCNTN_SDSZ + "', \n")
					     .append(" 			CNTN_SLNO = '" +idxCNTN_SLNO+ "', GOODS_CD = '" +idxGOODS_CD	 + "', GOODS_NM = '" + idxGOODS_NM+ "', GOODS_ENM = '" +idxGOODS_ENM + "', \n")
							 .append("			PACKING_NO = '" + idxPACKING_NO+ "',PACKING_CNT = '" +idxPACKING_CNT + "', STDRD_SZ = '" + idxSTDRD_SZ + "', HS_CODE = '" +idxHS_CODE+ "', \n")
							 .append("			GOODS_CNT = '" + idxGOODS_CNT+ "', CNT_UNIT = '" +idxCNT_UNIT + "', UNIT_PRICE = '" +idxUNIT_PRICE + "', PRICE = '" +idxPRICE + "', PKC_CNT = '" + idxPKC_CNT+ "', \n")
							 .append("			PKG_WEIGHT = '" + idxPKG_WEIGHT+ "',PKG_LNGTH = '" + idxPKG_LNGTH+ "', PKG_HEIGHT = '" + idxPKG_HEIGHT+ "', \n")
							 .append("			PKG_WIDTH = '" +idxPKG_WIDTH + "', PKG_CBM = '" +idxPKG_CBM + "', PKG_UNIT = '" +idxPKG_UNIT + "', ORDER_NO = '" +idxORDER_NO + "', \n")
							 .append("			ORDER_SEQ = '" +idxORDER_SEQ + "', REAMARK = '" + idxREAMARK+ "', \n")
							 .append("			UPDATE_DT = CURRENT TIMESTAMP,UPDATE_USR = '"+idxUPDATE_USR+"' \n")
							 .append("	WHERE PL_NO = '"+pl_no+"'  \n")
							 .append("		AND PL_SEQNO = '"+idxPL_SEQNO+"' ");
*/
							gsmt.executeUpdate(); 
							gsmt.close();
							Sql = null ; 
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
					  Sql = new StringBuffer();
						Sql.append("DELETE FROM TRANSFER.LTPCKLSDT  \n")
							 .append(" WHERE PL_NO = ?  \n")
							 .append("	 AND PL_SEQNO = ? ") ;

						GauceStatement gsmt = conn.getGauceStatement(Sql.toString()); 
						gsmt.setGauceDataRow(rows[j]);   
						gsmt.setString(1, pl_no);  
						gsmt.bindColumn(2, idxPL_SEQNO); 
						gsmt.executeUpdate(); 
						gsmt.close();
						Sql = null ; 
						 
					}//Case insert//update//Delete 
					
				} //Loop While 
				
				//****************Master Update****************/ 
				Sql = new StringBuffer() ; 
				Sql.append(" UPDATE TRANSFER.LTORDERMST \n")
					 .append("		SET PL_NO = ? , \n")
					 .append("				PL_DATE = CURRENT TIMESTAMP , \n")
//					 .append("				PL_TYPE = 'A' \n")
					 .append("				PL_TYPE = CASE WHEN PL_TYPE = 'N' THEN 'A' ELSE 'C' END \n")
					 .append("  WHERE ORDER_NO IN (SELECT DISTINCT ORDER_NO \n")
					 .append("											 FROM TRANSFER.LTPCKLSDT \n")
					 .append("											WHERE TRIM(PL_NO) = ? \n")
					 .append("											GROUP BY ORDER_NO) ");

				gstmt = conn.getGauceStatement(Sql.toString()); 

				gstmt.setString(1,pl_no);
				gstmt.setString(2,pl_no);

				gstmt.executeUpdate(); 
				gstmt.close();  
//-----------------------------------------------------------------------------
//	Description : PL DETAIL 积己 END
//-----------------------------------------------------------------------------	

			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","历厘矫 舅荐绝绰 俊矾惯积!!(Error Code :"+se.toString()+")");
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