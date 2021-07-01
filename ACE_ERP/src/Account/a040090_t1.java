package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040090_t1 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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

			String strSeq = "";
			String strVend_CD="";

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				String str1 = reqGauce.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				int idxBS_ID  	= userSet.indexOfColumn("BS_ID");
				int idxVEND_ID  	= userSet.indexOfColumn("VEND_ID");
				int idxVEND_CD  	= userSet.indexOfColumn("VEND_CD");
				int idxVEND_NM  	= userSet.indexOfColumn("VEND_NM");
				int idxVD_DIRECT	= userSet.indexOfColumn("VD_DIRECT");
				int idxBSNS_CND 	= userSet.indexOfColumn("BSNS_CND");
				int idxBSNS_KND 	= userSet.indexOfColumn("BSNS_KND");
				int idxVD_TELNO 	= userSet.indexOfColumn("VD_TELNO");
				int idxVD_FAXNO 	= userSet.indexOfColumn("VD_FAXNO");
				int idxPOST_NO1 	= userSet.indexOfColumn("POST_NO1");
				int idxPOST_NO2 	= userSet.indexOfColumn("POST_NO2");
				int idxADDRESS1 	= userSet.indexOfColumn("ADDRESS1");
				int idxADDRESS2 	= userSet.indexOfColumn("ADDRESS2");
				int idxCOCOMYN  	= userSet.indexOfColumn("COCOMYN");
				int idxUSE_TAG  	= userSet.indexOfColumn("USE_TAG");
				int idxWRID     	= userSet.indexOfColumn("WRID");
				int idxWRDT     	= userSet.indexOfColumn("WRDT");
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer UpdateSql2 = null;
				
				GauceStatement gsmt =null;
				GauceStatement gsmt2 =null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.GCZM_VENDER ( 							" );
				InsertSql.append( "VEND_ID,VEND_CD,VEND_NM,VD_DIRECT,BSNS_CND,  			" );
				InsertSql.append( "BSNS_KND,VD_TELNO,VD_FAXNO,POST_NO1,POST_NO2,	" );
				InsertSql.append( "ADDRESS1,ADDRESS2,COCOMYN,USE_TAG,   					" );
				InsertSql.append( "WRID,WRDT                                   		" );
				InsertSql.append( "	) VALUES( 											" );
				InsertSql.append( " ?, ?, ?, ?, ?, 										" );
				InsertSql.append( " ?, ?, ?, ?, ?, 										" );
				InsertSql.append( " ?, ?, ?, ?,  											" );
				InsertSql.append( " '"+str1+"', sysdate ) 								" );				
				//System.out.println("# Query : \n" + InsertSql);				
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.GCZM_VENDER SET " );				
				UpdateSql.append( "  VEND_NM = ? " );
				UpdateSql.append( " ,VD_DIRECT = ? " );
				UpdateSql.append( " ,BSNS_CND = ? " );
				UpdateSql.append( " ,BSNS_KND = ? " );
				UpdateSql.append( " ,VD_TELNO = ? " );
				UpdateSql.append( " ,VD_FAXNO = ? " );
				UpdateSql.append( " ,POST_NO1 = ? " );
				UpdateSql.append( " ,POST_NO2 = ? " );
				UpdateSql.append( " ,ADDRESS1 = ? " );
				UpdateSql.append( " ,ADDRESS2 = ? " );
				UpdateSql.append( " ,COCOMYN = ? " );
				UpdateSql.append( " ,WRID = '"+str1+"'" );
				UpdateSql.append( " ,WRDT = sysdate " );
				UpdateSql.append( "  WHERE  VEND_CD = ? " );	
				//System.out.println("# Query : \n" + UpdateSql);						
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.GCZM_VENDER " );				
				DeleteSql.append( "  WHERE  VEND_CD = ? " );	
				//System.out.println("# Query : \n" + DeleteSql);					
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
				//		sql0.append( " SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(SUBSTR(VEND_CD,2,10)),0)+1)),6) 	\n");
						sql0.append( " SELECT LPAD(TO_NUMBER(NVL(MAX(SUBSTR(VEND_CD,2,10)),0))+1,6,0)   \n");
						sql0.append( "   FROM ACCOUNT.GCZM_VENDER  										\n");
						sql0.append( "  WHERE VEND_CD LIKE 'V%' 		 								\n");
				
						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							strSeq= rs0.getString(1);
							strVend_CD="V"+strSeq;
						}
						rs0.close();
						stmt0.close();

					    rows[j].setString(idxVEND_CD,strVend_CD);
					    
						gsmt = conn.getGauceStatement(InsertSql.toString());
					
						//System.out.println("# Query1 : \n");
						
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxVEND_ID);	
						gsmt.bindColumn(2,  idxVEND_CD);	
						gsmt.bindColumn(3,  idxVEND_NM);	
						gsmt.bindColumn(4,  idxVD_DIRECT);	
						gsmt.bindColumn(5,  idxBSNS_CND);	
						gsmt.bindColumn(6,  idxBSNS_KND);	
						gsmt.bindColumn(7,  idxVD_TELNO);	
						gsmt.bindColumn(8,  idxVD_FAXNO);	
						gsmt.bindColumn(9,  idxPOST_NO1);	
						gsmt.bindColumn(10, idxPOST_NO2);	
						gsmt.bindColumn(11, idxADDRESS1);	
						gsmt.bindColumn(12, idxADDRESS2);	
						gsmt.bindColumn(13, idxCOCOMYN);	
						gsmt.bindColumn(14, idxUSE_TAG);			
		
						gsmt.executeUpdate();
						gsmt.close();
		
						UpdateSql2 = new StringBuffer();
						UpdateSql2.append( " UPDATE  VNDUS.TBS010 SET 							\n");				
						UpdateSql2.append( "                BS_VENDCD =  '"+strVend_CD+"'		\n");	
						UpdateSql2.append( "  WHERE  BS_VENDID = ? 								\n");	

						gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.bindColumn(1,  idxVEND_ID);	
						gsmt2.executeUpdate();
						gsmt2.close();
						
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						gsmt = conn.getGauceStatement(UpdateSql.toString());

						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1,  idxVEND_NM);	
						gsmt.bindColumn(2,  idxVD_DIRECT);	
						gsmt.bindColumn(3,  idxBSNS_CND);	
						gsmt.bindColumn(4,  idxBSNS_KND);	
						gsmt.bindColumn(5,  idxVD_TELNO);	
						gsmt.bindColumn(6,  idxVD_FAXNO);	
						gsmt.bindColumn(7,  idxPOST_NO1);	
						gsmt.bindColumn(8, idxPOST_NO2);	
						gsmt.bindColumn(9, idxADDRESS1);	
						gsmt.bindColumn(10, idxADDRESS2);	
						gsmt.bindColumn(11, idxCOCOMYN);			
						gsmt.bindColumn(12, idxVEND_CD);	

						gsmt.executeUpdate();
						gsmt.close();
					
					}
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						gsmt = conn.getGauceStatement(DeleteSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
	
						gsmt.bindColumn(1, idxVEND_CD);	

						gsmt.executeUpdate();
						gsmt.close();
					}    					
				}
			}
			catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
      
			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {

			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}