package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010052_t1 extends HttpServlet{
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
				
				
				String strVD_DIRECT="";  //대표자
				String strBSNS_CND="";   //업태
				String strBSNS_KND="";   //업종
				String strADDRESS1="";   //주소
				


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				String str1 = reqGauce.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

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
				int idxREMARK   	= userSet.indexOfColumn("REMARK");
				int idxWRID     	= userSet.indexOfColumn("WRID");
				int idxWRDT     	= userSet.indexOfColumn("WRDT");
				int idxSTATUS     	= userSet.indexOfColumn("STATUS");
				int idxVENDER_USERGB= userSet.indexOfColumn("VENDER_USERGB");
				int idxEMPNO        = userSet.indexOfColumn("EMPNO");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.GCZM_VENDER_USER ( 				\n");
				InsertSql.append( "VEND_ID,VEND_CD,VEND_NM,VD_DIRECT,BSNS_CND,  		\n");
				InsertSql.append( "BSNS_KND,VD_TELNO,VD_FAXNO,POST_NO1,POST_NO2,	    \n");
				InsertSql.append( "ADDRESS1,ADDRESS2,COCOMYN,USE_TAG,REMARK,    		\n");
				InsertSql.append( "WRID,WRDT, STATUS                                    \n");
				InsertSql.append( "	) VALUES( 											\n");
				InsertSql.append( " ?, ?, ?, ?, ?, 										\n");
				InsertSql.append( " ?, ?, ?, ?, ?, 										\n");
				InsertSql.append( " ?, ?, ?, ?, ?, 										\n");
				InsertSql.append( " '"+str1+"', sysdate, ? ) 							\n");
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.GCZM_VENDER_USER SET 	\n");				
				UpdateSql.append( "  VEND_NM = ? 							\n");
				UpdateSql.append( " ,VD_DIRECT = ? 							\n");
				UpdateSql.append( " ,BSNS_CND = ? 							\n");
				UpdateSql.append( " ,BSNS_KND = ? 							\n");
				UpdateSql.append( " ,VD_TELNO = ? 							\n");
				UpdateSql.append( " ,VD_FAXNO = ? 							\n");
				UpdateSql.append( " ,POST_NO1 = ? 							\n");
				UpdateSql.append( " ,POST_NO2 = ? 							\n");
				UpdateSql.append( " ,ADDRESS1 = ? 							\n");
				UpdateSql.append( " ,ADDRESS2 = ? 							\n");
				UpdateSql.append( " ,COCOMYN = ? 							\n");
				UpdateSql.append( " ,REMARK = ? 							\n");
				UpdateSql.append( " ,STATUS = ? 							\n");
				UpdateSql.append( " ,WRID = '"+str1+"'						\n");
				UpdateSql.append( " ,WRDT =	sysdate 						\n");
				UpdateSql.append( "  WHERE  VEND_CD = ? 					\n");	
				
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.GCZM_VENDER_USER 	\n");				
				DeleteSql.append( "  WHERE  VEND_CD = ? 					\n");	

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

			            // logger.dbg.println(this,InsertSql.toString());

						Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						/*
						sql0.append( " SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(SUBSTR(VEND_CD,2,10)),0)+1)),6) 		"); 
						sql0.append( "	 FROM ACCOUNT.GCZM_VENDER_USER  					  					    ");
						sql0.append( "  WHERE SUBSTR(VEND_CD,1,1)='P' 												");
						*/
						
						if(rows[j].getString(idxVENDER_USERGB).equals("F")){
							sql0.append( " SELECT CASE WHEN MAX(VEND_CD) IS NULL THEN '000001'                \n"); 
							sql0.append( "        ELSE LPAD(TO_NUMBER(MAX(SUBSTR(VEND_CD,2,10)))+1,6,'0') END \n");
							sql0.append( "   FROM ACCOUNT.GCZM_VENDER_USER                                    \n");
							sql0.append( "  WHERE VEND_CD LIKE 'F%'	                                          \n");
							
							ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
							if(rs0.next()){
								strSeq= rs0.getString(1);
								strVend_CD="F"+strSeq;
							}
							rs0.close();
							stmt0.close();
							
							rows[j].setString(idxVEND_ID,strVend_CD);
							
							
							strVD_DIRECT=".";  //대표자
							strBSNS_CND=".";   //업태
							strBSNS_KND=".";   //업종
							strADDRESS1="해외"; //주소
							
							rows[j].setString(idxVD_DIRECT,strVD_DIRECT);  //대표자
							rows[j].setString(idxBSNS_CND,strBSNS_CND);   //업태
							rows[j].setString(idxBSNS_KND,strBSNS_KND);   //업종
							rows[j].setString(idxADDRESS1,strADDRESS1);   //주소
							
							
						}else if (rows[j].getString(idxVENDER_USERGB).equals("K")){
							strVend_CD = "K"+rows[j].getString(idxEMPNO);
						}
						
					    rows[j].setString(idxVEND_CD,strVend_CD);

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
					
					 	//	logger.dbg.println(this,InsertSql.toString());
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
						gsmt.bindColumn(15, idxREMARK);	
						gsmt.bindColumn(16, idxSTATUS);	
		
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1,  idxVEND_NM);	
						gsmt.bindColumn(2,  idxVD_DIRECT);	
						gsmt.bindColumn(3,  idxBSNS_CND);	
						gsmt.bindColumn(4,  idxBSNS_KND);	
						gsmt.bindColumn(5,  idxVD_TELNO);	
						gsmt.bindColumn(6,  idxVD_FAXNO);	
						gsmt.bindColumn(7,  idxPOST_NO1);	
						gsmt.bindColumn(8,  idxPOST_NO2);	
						gsmt.bindColumn(9,  idxADDRESS1);	
						gsmt.bindColumn(10, idxADDRESS2);	
						gsmt.bindColumn(11, idxCOCOMYN);	
						gsmt.bindColumn(12, idxREMARK);	
						gsmt.bindColumn(13, idxSTATUS);	
						gsmt.bindColumn(14, idxVEND_CD);	

						gsmt.executeUpdate();
						gsmt.close();
					
					}
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
				
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