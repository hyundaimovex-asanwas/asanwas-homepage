package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trPlDetail extends HttpServlet{

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
//	Description : DataSet Index Setting
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
				int idxT_WEIGHT         =userSet.indexOfColumn("T_WEIGHT");   //추가
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