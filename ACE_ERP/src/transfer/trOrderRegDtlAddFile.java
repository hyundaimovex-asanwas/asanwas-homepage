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

public class trOrderRegDtlAddFile extends HttpServlet{

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
				String ord_no = reqGauce.getParameter("gstr1"); 
   				if ( ord_no==null || ord_no.trim().length()==0 ) { ord_no=null; }
                
				 logger.err.println(this,"start");

//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				
				int idxORDER_NO= userSet.indexOfColumn("ORDER_NO");
				int idxORDER_SEQ= userSet.indexOfColumn("ORDER_SEQ");
				int idxARTC_CD= userSet.indexOfColumn("ARTC_CD");
				int idxARTC_NM= userSet.indexOfColumn("ARTC_NM");
				int idxSTN_SZ= userSet.indexOfColumn("STN_SZ");
				int idxSTN_SZNM= userSet.indexOfColumn("STN_SZNM");
				int idxHSCODE= userSet.indexOfColumn("HSCODE");
				int idxARTC_CNT= userSet.indexOfColumn("ARTC_CNT");
				int idxARTC_UNIT= userSet.indexOfColumn("ARTC_UNIT");
				int idxUNIT_PRICE= userSet.indexOfColumn("UNIT_PRICE");
				int idxPRICE= userSet.indexOfColumn("PRICE");
				int idxLDCARGO= userSet.indexOfColumn("LDCARGO");
				int idxLDCARGONM= userSet.indexOfColumn("LDCARGONM");
				int idxOFFCARGO= userSet.indexOfColumn("OFFCARGO");
				int idxOFFCARGONM= userSet.indexOfColumn("OFFCARGONM");
				int idxPUNIT_CNT= userSet.indexOfColumn("PUNIT_CNT");
				int idxPUNIT_UNIT= userSet.indexOfColumn("PUNIT_UNIT");
				int idxPUNIT_WGHT= userSet.indexOfColumn("PUNIT_WGHT");
				int idxPKG_LNGTH= userSet.indexOfColumn("PKG_LNGTH");
				int idxPKG_HEIGHT= userSet.indexOfColumn("PKG_HEIGHT");
				int idxPKG_WIDTH= userSet.indexOfColumn("PKG_WIDTH");
				int idxPKG_CBM= userSet.indexOfColumn("PKG_CBM");
				int idxPKG_CNT= userSet.indexOfColumn("PKG_CNT");
				int idxMIX_OTHERS= userSet.indexOfColumn("MIX_OTHERS");
				int idxSAMEAS= userSet.indexOfColumn("SAMEAS");
				int idxSETTLE_STS= userSet.indexOfColumn("SETTLE_STS"); 
				int idxCREATE_USR= userSet.indexOfColumn("CREATE_USR"); 
				int idxUPDATE_USR= userSet.indexOfColumn("UPDATE_USR");
				int idxREGFILE= userSet.indexOfColumn("REGFILE");
				int idxREGFILENAME= userSet.indexOfColumn("REGFILENAME"); 

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  

				 logger.dbg.println(this,"start2");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
 
						InsertSql = new StringBuffer();
                        InsertSql.append(" INSERT INTO TRANSFER.LTORDERDTL( ") ; 
                        InsertSql.append(" ORDER_NO,ORDER_SEQ,ARTC_CD,ARTC_NM,  ") ; 
                        InsertSql.append(" STN_SZ,STN_SZNM,HSCODE,ARTC_CNT, ") ; 
                        InsertSql.append(" ARTC_UNIT,UNIT_PRICE,PRICE,LDCARGO, ") ; 
                        InsertSql.append(" LDCARGONM,OFFCARGO,OFFCARGONM, ") ; 
                        InsertSql.append(" PUNIT_CNT,PUNIT_UNIT,PUNIT_WGHT, ") ; 
                        InsertSql.append(" PKG_LNGTH,PKG_HEIGHT,PKG_WIDTH,PKG_CBM, ") ; 
                        InsertSql.append(" PKG_CNT,MIX_OTHERS,SAMEAS,SETTLE_STS, ") ; 
                        InsertSql.append(" CREATE_DT,CREATE_USR,UPDATE_DT, ") ; 
                        InsertSql.append(" UPDATE_USR,REGFILE,REGFILENAME ) ") ; 
                        InsertSql.append(" VALUES( ") ; 
                        InsertSql.append(" ?,?,?,?, ") ; 
                        InsertSql.append(" ?,?,?,?, ") ; 
                        InsertSql.append(" ?,?,?,?, ") ; 
                        InsertSql.append(" ?,?,?, ") ; 
                        InsertSql.append(" ?,?,?, ") ; 
                        InsertSql.append(" ?,?,?,?, ") ; 
                        InsertSql.append(" ?,?,?,?, ") ; 
                        InsertSql.append(" CURRENT TIMESTAMP,?,CURRENT TIMESTAMP, ") ; 
                        InsertSql.append(" ?,?,? ) ") ;  
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows[j]); 
						gsmt.setString(1, ord_no); 
						gsmt.bindColumn(2,idxORDER_SEQ);
						gsmt.bindColumn(3,idxARTC_CD);
						gsmt.bindColumn(4,idxARTC_NM);
						gsmt.bindColumn(5,idxSTN_SZ);
						gsmt.bindColumn(6,idxSTN_SZNM);
						gsmt.bindColumn(7,idxHSCODE);
						gsmt.bindColumn(8,idxARTC_CNT);
						gsmt.bindColumn(9,idxARTC_UNIT);
						gsmt.bindColumn(10,idxUNIT_PRICE);
						gsmt.bindColumn(11,idxPRICE);
						gsmt.bindColumn(12,idxLDCARGO);
						gsmt.bindColumn(13,idxLDCARGONM);
						gsmt.bindColumn(14,idxOFFCARGO);
						gsmt.bindColumn(15,idxOFFCARGONM);
						gsmt.bindColumn(16,idxPUNIT_CNT);
						gsmt.bindColumn(17,idxPUNIT_UNIT);
						gsmt.bindColumn(18,idxPUNIT_WGHT);
						gsmt.bindColumn(19,idxPKG_LNGTH);
						gsmt.bindColumn(20,idxPKG_HEIGHT);
						gsmt.bindColumn(21,idxPKG_WIDTH);
						gsmt.bindColumn(22,idxPKG_CBM);
						gsmt.bindColumn(23,idxPKG_CNT);
						gsmt.bindColumn(24,idxMIX_OTHERS);
						gsmt.bindColumn(25,idxSAMEAS);
						gsmt.bindColumn(26,idxSETTLE_STS);
						gsmt.bindColumn(27,idxCREATE_USR);
						gsmt.bindColumn(28,idxUPDATE_USR); 

						InputStream nst_file = (InputStream) rows[j].getInputStream(idxREGFILE);
						 
						gsmt.setBinaryStream(29, nst_file, nst_file.available());	 //첨부파일
						gsmt.bindColumn(30,idxREGFILENAME); 
	 					gsmt.executeUpdate(); 
						gsmt.close(); 
						 

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append(" UPDATE TRANSFER.LTORDERDTL SET  ") ; 
						UpdateSql.append(" ARTC_CD = ? ,ARTC_NM = ?,  ") ; 
						UpdateSql.append(" STN_SZ = ?,STN_SZNM = ?,HSCODE = ?,ARTC_CNT = ?, ") ; 
						UpdateSql.append(" ARTC_UNIT = ?,UNIT_PRICE= ?,PRICE= ?,LDCARGO= ?, ") ; 
						UpdateSql.append(" LDCARGONM= ?,OFFCARGO= ?,OFFCARGONM= ?, ") ; 
						UpdateSql.append(" PUNIT_CNT= ?,PUNIT_UNIT= ?,PUNIT_WGHT= ?, ") ; 
						UpdateSql.append(" PKG_LNGTH= ?,PKG_HEIGHT= ?,PKG_WIDTH= ?,PKG_CBM= ?, ") ; 
						UpdateSql.append(" PKG_CNT= ?,MIX_OTHERS= ?,SAMEAS= ?,SETTLE_STS= ?, ") ; 
						UpdateSql.append(" UPDATE_DT=CURRENT TIMESTAMP, ") ; 
						UpdateSql.append(" UPDATE_USR  = ? WHERE  ") ; 
						UpdateSql.append(" ORDER_NO = ? AND ORDER_SEQ =?") ; 
						 
						
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						////logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						
						gsmt.bindColumn(1,idxARTC_CD);
						gsmt.bindColumn(2,idxARTC_NM);
						gsmt.bindColumn(3,idxSTN_SZ);
						gsmt.bindColumn(4,idxSTN_SZNM);
						gsmt.bindColumn(5,idxHSCODE);
						gsmt.bindColumn(6,idxARTC_CNT);
						gsmt.bindColumn(7,idxARTC_UNIT);
						gsmt.bindColumn(8,idxUNIT_PRICE);
						gsmt.bindColumn(9,idxPRICE);
						gsmt.bindColumn(10,idxLDCARGO);
						gsmt.bindColumn(11,idxLDCARGONM);
						gsmt.bindColumn(12,idxOFFCARGO);
						gsmt.bindColumn(13,idxOFFCARGONM);
						gsmt.bindColumn(14,idxPUNIT_CNT);
						gsmt.bindColumn(15,idxPUNIT_UNIT);
						gsmt.bindColumn(16,idxPUNIT_WGHT);
						gsmt.bindColumn(17,idxPKG_LNGTH);
						gsmt.bindColumn(18,idxPKG_HEIGHT);
						gsmt.bindColumn(19,idxPKG_WIDTH);
						gsmt.bindColumn(20,idxPKG_CBM);
						gsmt.bindColumn(21,idxPKG_CNT);
						gsmt.bindColumn(22,idxMIX_OTHERS);
						gsmt.bindColumn(23,idxSAMEAS);
						gsmt.bindColumn(24,idxSETTLE_STS);
						 gsmt.bindColumn(25,idxUPDATE_USR); 
						gsmt.setString(26, ord_no); 
						gsmt.bindColumn(27,idxORDER_SEQ);

						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						////logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						/*gsmt.bindColumn(1, idxCAR_TYPE);*/
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
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