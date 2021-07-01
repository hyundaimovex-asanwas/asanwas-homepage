package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trPlMastar extends HttpServlet{

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
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String pl_no = reqGauce.getParameter("gstr1"); 
   				if ( pl_no==null || pl_no.trim().length()==0 ) { pl_no=null; }
        String enter_no = null ;         

//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				//int idxPL_NO            =userSet.indexOfColumn("PL_NO");       
				int idxIN_OUT           =userSet.indexOfColumn("IN_OUT");      
				int idxPL_SHIPPER       =userSet.indexOfColumn("PL_SHIPPER");  
				int idxPL_SHPPRNM       =userSet.indexOfColumn("PL_SHPPRNM");  
				int idxPL_SHPADD1       =userSet.indexOfColumn("PL_SHPADD1");  
				int idxPL_SHPADD2       =userSet.indexOfColumn("PL_SHPADD2");  
				int idxPL_SHPADD3       =userSet.indexOfColumn("PL_SHPADD3");  
				int idxPL_SHPTEL        =userSet.indexOfColumn("PL_SHPTEL");   
				int idxPL_CSTM          =userSet.indexOfColumn("PL_CSTM");     
				int idxPL_CSTMNM        =userSet.indexOfColumn("PL_CSTMNM");   
				int idxPL_CSTADD1       =userSet.indexOfColumn("PL_CSTADD1");  
				int idxPL_CSTADD2       =userSet.indexOfColumn("PL_CSTADD2");  
				int idxPL_CSTADD3       =userSet.indexOfColumn("PL_CSTADD3");  
				int idxPL_CSTTEL        =userSet.indexOfColumn("PL_CSTTEL");   
				int idxPL_BRKR          =userSet.indexOfColumn("PL_BRKR");     
				int idxPL_BRKRNM        =userSet.indexOfColumn("PL_BRKRNM");   
				int idxPL_BRKADD1       =userSet.indexOfColumn("PL_BRKADD1");  
				int idxPL_BRKADD2       =userSet.indexOfColumn("PL_BRKADD2");  
				int idxPL_BRKADD3       =userSet.indexOfColumn("PL_BRKADD3");  
				int idxPL_BRKTEL        =userSet.indexOfColumn("PL_BRKTEL");   
				//int idxPL_NOTICE        =userSet.indexOfColumn("PL_NOTICE");   
				//int idxPLNOTICENM       =userSet.indexOfColumn("PLNOTICENM");  
				int idxSTART_LCT        =userSet.indexOfColumn("START_LCT");   
				int idxREACH_LCT        =userSet.indexOfColumn("REACH_LCT");   
				int idxTRANS_CAR        =userSet.indexOfColumn("TRANS_CAR");   
				int idxSTART_DT         =userSet.indexOfColumn("START_DT");    
				int idxINVOICE_NO       =userSet.indexOfColumn("INVOICE_NO");  
				int idxINVOICE_DT       =userSet.indexOfColumn("INVOICE_DT");  
				int idxREMARK           =userSet.indexOfColumn("REMARK");      
				int idxLCNO             =userSet.indexOfColumn("LCNO");        
				int idxLCDATE           =userSet.indexOfColumn("LCDATE");      
				int idxLCBANK           =userSet.indexOfColumn("LCBANK");      
				int idxWEIGHT           =userSet.indexOfColumn("WEIGHT");      
				int idxT_WEIGHT         =userSet.indexOfColumn("T_WEIGHT");    
				int idxT_CBM            =userSet.indexOfColumn("T_CBM");       
				int idxGORDER_NO        =userSet.indexOfColumn("GORDER_NO");   
				int idxPACKING_CNT      =userSet.indexOfColumn("PACKING_CNT"); 
				int idxPACKING_UNIT     =userSet.indexOfColumn("PACKING_UNIT");
				int idxPACKING_CBM      =userSet.indexOfColumn("PACKING_CBM"); 
				int idxTELEPHONE        =userSet.indexOfColumn("TELEPHONE");   
				int idxRPR_GOODS        =userSet.indexOfColumn("RPR_GOODS");   
				int idxCARGO_TYPE       =userSet.indexOfColumn("CARGO_TYPE");  
				int idxDNG_TYPE         =userSet.indexOfColumn("DNG_TYPE");    
				int idxCAR_TYPE         =userSet.indexOfColumn("CAR_TYPE");    
				int idxORDER_NO         =userSet.indexOfColumn("ORDER_NO");    
				int idxDCL_DATE         =userSet.indexOfColumn("DCL_DATE");    
				int idxDCL_NO           =userSet.indexOfColumn("DCL_NO");      
				int idxCURRENCY         =userSet.indexOfColumn("CURRENCY");    
				int idxCREATE_DT        =userSet.indexOfColumn("CREATE_DT");   
				int idxCREATE_USR       =userSet.indexOfColumn("CREATE_USR");  
				int idxUPDATE_DT        =userSet.indexOfColumn("UPDATE_DT");   
				int idxUPDATE_USR       =userSet.indexOfColumn("UPDATE_USR");  
				int idxSTART_TIME       =userSet.indexOfColumn("START_TIME") ; 
				int idxLINE_PART       =userSet.indexOfColumn("LINE_PART") ; 
				int idxPL_CSN   =  userSet.indexOfColumn("PL_CSN");
				int idxPL_CSNNM =  userSet.indexOfColumn("PL_CSNNM");
				int idxPL_CSNTEL =  userSet.indexOfColumn("PL_CSNTEL");
				int idxPL_CSNADDR =  userSet.indexOfColumn("PL_CSNADDR");
				int idxPL_CSNADDR2 =  userSet.indexOfColumn("PL_CSNADDR2");
				int idxPL_CSNADDR3=  userSet.indexOfColumn("PL_CSNADDR3");
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  

				for (int j = 0; j < rows.length; j++){
					InsertSql = null;
					UpdateSql = null;
					DeleteSql = null;  

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) { 
 
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
						gsmt.setGauceDataRow(rows[j]);  
 						
						gsmt.setString(1,pl_no);
						gsmt.bindColumn(2,idxIN_OUT);
						gsmt.bindColumn(3,idxPL_SHIPPER);
						gsmt.bindColumn(4,idxPL_SHPPRNM);
						gsmt.bindColumn(5,idxPL_SHPADD1);
						gsmt.bindColumn(6,idxPL_SHPADD2);
						gsmt.bindColumn(7,idxPL_SHPADD3); 
						gsmt.bindColumn(8,idxPL_SHPTEL) ; 
						gsmt.bindColumn(9,idxPL_CSTM) ; 
						gsmt.bindColumn(10,idxPL_CSTMNM) ; 
						gsmt.bindColumn(11,idxPL_CSTADD1) ; 
						gsmt.bindColumn(12,idxPL_CSTADD2) ; 
						gsmt.bindColumn(13,idxPL_CSTADD3) ; 
						gsmt.bindColumn(14,idxPL_CSTTEL) ; 
						gsmt.bindColumn(15,idxPL_BRKR) ; 
						gsmt.bindColumn(16,idxPL_BRKRNM) ; 
						gsmt.bindColumn(17,idxPL_BRKADD1) ; 
						gsmt.bindColumn(18,idxPL_BRKADD2) ; 
						gsmt.bindColumn(19,idxPL_BRKADD3) ; 
						gsmt.bindColumn(20,idxPL_BRKTEL) ; 
						//gsmt.bindColumn(21,idxPL_NOTICE) ; 
						//gsmt.bindColumn(22,idxPLNOTICENM) ; 
						gsmt.bindColumn(21,idxSTART_LCT) ; 
						gsmt.bindColumn(22,idxREACH_LCT) ; 
						gsmt.bindColumn(23,idxTRANS_CAR) ; 
						gsmt.bindColumn(24,idxSTART_DT) ; 
						gsmt.bindColumn(25,idxINVOICE_NO) ; 
						gsmt.bindColumn(26,idxINVOICE_DT) ; 
						gsmt.bindColumn(27,idxREMARK) ; 
						gsmt.bindColumn(28,idxLCNO) ; 
						gsmt.bindColumn(29,idxLCDATE) ; 
						gsmt.bindColumn(30,idxLCBANK) ; 
						gsmt.bindColumn(31,idxWEIGHT) ; 
						gsmt.bindColumn(32,idxT_WEIGHT) ; 
						gsmt.bindColumn(33,idxT_CBM) ; 
						gsmt.bindColumn(34,idxGORDER_NO) ; 
						gsmt.bindColumn(35,idxPACKING_CNT) ; 
						gsmt.bindColumn(36,idxPACKING_UNIT) ; 
						gsmt.bindColumn(37,idxPACKING_CBM) ; 
						gsmt.bindColumn(38,idxTELEPHONE) ; 
						gsmt.bindColumn(39,idxRPR_GOODS) ; 
						gsmt.bindColumn(40,idxCARGO_TYPE) ; 
						gsmt.bindColumn(41,idxDNG_TYPE) ; 
						gsmt.bindColumn(42,idxCAR_TYPE) ; 
						gsmt.bindColumn(43,idxORDER_NO) ; 
						gsmt.bindColumn(44,idxDCL_DATE) ; 
						gsmt.bindColumn(45,idxDCL_NO) ; 
						gsmt.bindColumn(46,idxCURRENCY) ; 
						gsmt.bindColumn(47,idxCREATE_USR) ; 
						gsmt.bindColumn(48,idxUPDATE_USR) ; 
						gsmt.bindColumn(49,idxSTART_TIME) ; 
						gsmt.bindColumn(50,idxLINE_PART) ; 
						gsmt.bindColumn(51, idxPL_CSN ) ;  
						gsmt.bindColumn(52, idxPL_CSNNM ) ;
						gsmt.bindColumn(53, idxPL_CSNTEL ) ;  
						gsmt.bindColumn(54, idxPL_CSNADDR ) ;
						gsmt.bindColumn(55, idxPL_CSNADDR2 ) ;
						gsmt.bindColumn(56, idxPL_CSNADDR3 ) ; 
					
	 					gsmt.executeUpdate(); 
						gsmt.close(); 

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
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
						gsmt.setGauceDataRow(rows[j]); 
					
						gsmt.bindColumn(1,idxIN_OUT);
						gsmt.bindColumn(2,idxPL_SHIPPER);
						gsmt.bindColumn(3,idxPL_SHPPRNM);
						gsmt.bindColumn(4,idxPL_SHPADD1);
						gsmt.bindColumn(5,idxPL_SHPADD2);
						gsmt.bindColumn(6,idxPL_SHPADD3); 
						gsmt.bindColumn(7,idxPL_SHPTEL) ; 
						gsmt.bindColumn(8,idxPL_CSTM) ; 
						gsmt.bindColumn(9,idxPL_CSTMNM) ; 
						gsmt.bindColumn(10,idxPL_CSTADD1) ; 
						gsmt.bindColumn(11,idxPL_CSTADD2) ; 
						gsmt.bindColumn(12,idxPL_CSTADD3) ; 
						gsmt.bindColumn(13,idxPL_CSTTEL) ; 
						gsmt.bindColumn(14,idxPL_BRKR) ; 
						gsmt.bindColumn(15,idxPL_BRKRNM) ; 
						gsmt.bindColumn(16,idxPL_BRKADD1) ; 
						gsmt.bindColumn(17,idxPL_BRKADD2) ; 
						gsmt.bindColumn(18,idxPL_BRKADD3) ; 
						gsmt.bindColumn(19,idxPL_BRKTEL) ; 
						//mt.bindColumn(20,idxPL_NOTICE) ; 
						//mt.bindColumn(21,idxPLNOTICENM) ; 
						gsmt.bindColumn(20,idxSTART_LCT) ; 
						gsmt.bindColumn(21,idxREACH_LCT) ; 
						gsmt.bindColumn(22,idxTRANS_CAR) ; 
						gsmt.bindColumn(23,idxSTART_DT) ; 
						gsmt.bindColumn(24,idxINVOICE_NO) ; 
						gsmt.bindColumn(25,idxINVOICE_DT) ; 
						gsmt.bindColumn(26,idxREMARK) ; 
						gsmt.bindColumn(27,idxLCNO) ; 
						gsmt.bindColumn(28,idxLCDATE) ; 
						gsmt.bindColumn(29,idxLCBANK) ; 
						gsmt.bindColumn(30,idxWEIGHT) ; 
						gsmt.bindColumn(31,idxT_WEIGHT) ; 
						gsmt.bindColumn(32,idxT_CBM) ; 
						gsmt.bindColumn(33,idxGORDER_NO) ; 
						gsmt.bindColumn(34,idxPACKING_CNT) ; 
						gsmt.bindColumn(35,idxPACKING_UNIT) ; 
						gsmt.bindColumn(36,idxPACKING_CBM) ; 
						gsmt.bindColumn(37,idxTELEPHONE) ; 
						gsmt.bindColumn(38,idxRPR_GOODS) ; 
						gsmt.bindColumn(39,idxCARGO_TYPE) ; 
						gsmt.bindColumn(40,idxDNG_TYPE) ; 
						gsmt.bindColumn(41,idxCAR_TYPE) ; 
						gsmt.bindColumn(42,idxORDER_NO) ; 
						gsmt.bindColumn(43,idxDCL_DATE) ; 
						gsmt.bindColumn(44,idxDCL_NO) ; 
						gsmt.bindColumn(45,idxCURRENCY) ;  
						gsmt.bindColumn(46,idxUPDATE_USR) ;  
						gsmt.bindColumn(47,idxLINE_PART) ; 
						gsmt.bindColumn(48, idxPL_CSN ) ;  
						gsmt.bindColumn(49, idxPL_CSNNM ) ;
						gsmt.bindColumn(50, idxPL_CSNTEL ) ;  
						gsmt.bindColumn(51, idxPL_CSNADDR ) ;
						gsmt.bindColumn(52, idxPL_CSNADDR2 ) ;
						gsmt.bindColumn(53, idxPL_CSNADDR3 ) ; 
						gsmt.setString(54,pl_no);

						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						
						DeleteSql = new StringBuffer();
						DeleteSql.append(" DELETE FROM  TRANSFER.LTPCKLSCI \n")
										 .append(" WHERE PL_NO = ?  ");
						
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.setString(1,pl_no);

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