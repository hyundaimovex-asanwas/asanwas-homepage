package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010080_t1 extends HttpServlet{
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

			int intSeq = 0;
			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				String str1 = reqGauce.getParameter("v_str1");
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxCHK      	= userSet.indexOfColumn("CHK");
				int idxVEND_CD  	= userSet.indexOfColumn("VEND_CD");
				int idxVEND_NM  	= userSet.indexOfColumn("VEND_NM");
				int idxVEND_ID  	= userSet.indexOfColumn("VEND_ID");
				int idxVD_DIRECT	= userSet.indexOfColumn("VD_DIRECT");
				int idxBSNS_CND 	= userSet.indexOfColumn("BSNS_CND");
				int idxBSNS_KND 	= userSet.indexOfColumn("BSNS_KND");
				int idxUSE_TAG_1 	= userSet.indexOfColumn("USE_TAG_1");
				int idxVEND_SEQ 	= userSet.indexOfColumn("VEND_SEQ");
				int idxMINOR_CD 	= userSet.indexOfColumn("MINOR_CD");
				int idxPOST_NO   	= userSet.indexOfColumn("POST_NO");
				int idxADDRESS1 	= userSet.indexOfColumn("ADDRESS1");
				int idxADDRESS2 	= userSet.indexOfColumn("ADDRESS2");
				int idxUSE_TAG  	= userSet.indexOfColumn("USE_TAG");
				int idxCLOSE_DT  	= userSet.indexOfColumn("CLOSE_DT");
				int idxIPT_MAN   	= userSet.indexOfColumn("IPT_MAN");
				int idxUPT_MAN     	= userSet.indexOfColumn("UPT_MAN");
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.MINORPLACE ( 				      \n");
				InsertSql.append( " VEND_CD,VEND_SEQ,MINOR_CD,POST_NO,ADDRESS1, ADDRESS2, \n");
				InsertSql.append( " USE_TAG,CLOSE_DT, VD_DIRECT,                          \n");
				InsertSql.append( " IPT_MAN,IPT_YMD,UPT_MAN,UPT_YMD                       \n");
				InsertSql.append( "	) VALUES( 		   									  \n");
				InsertSql.append( " ?, ?, ?, ?, ?, ?,								      \n");
				InsertSql.append( " ?, ?, ?,              								  \n");
				InsertSql.append( " '"+str1+"', sysdate, '"+str1+"', sysdate			  \n");
				InsertSql.append( " ) 				                        			  \n");
				
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.MINORPLACE SET 	\n");				
				UpdateSql.append( "  MINOR_CD = ? 											\n");
				UpdateSql.append( " ,POST_NO= ? 											\n");
				UpdateSql.append( " ,ADDRESS1 = ? 											\n");
				UpdateSql.append( " ,ADDRESS2 = ? 											\n");
				UpdateSql.append( " ,USE_TAG = ? 											\n");
				UpdateSql.append( " ,CLOSE_DT = ? 											\n");
				UpdateSql.append( " ,VD_DIRECT = ? 											\n");
				UpdateSql.append( " ,UPT_MAN = '"+str1+"'									\n");
				UpdateSql.append( " ,UPT_YMD = sysdate  									\n");
				UpdateSql.append( "  WHERE  VEND_CD = ? 									\n");	
				UpdateSql.append( "    AND  VEND_SEQ = ? 							  		\n");	
				
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.MINORPLACE 		\n");				
				DeleteSql.append( "  WHERE  VEND_CD = ? 									\n");	
				DeleteSql.append( "    AND  VEND_SEQ = ? 									\n");	

				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						
						sql0.append( " SELECT NVL(MAX(VEND_SEQ),0)+1    \n"); 
						sql0.append( "   FROM ACCOUNT.MINORPLACE        \n");
						sql0.append( "  WHERE VEND_CD = '"+rows[j].getString(idxVEND_CD)+"'\n");
						
						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							intSeq= rs0.getInt(1);
						}
						rs0.close();
						stmt0.close();

					    rows[j].setInt(idxVEND_SEQ,intSeq);

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxVEND_CD);	
						gsmt.bindColumn(2,  idxVEND_SEQ);	
						gsmt.bindColumn(3,  idxMINOR_CD);	
						gsmt.bindColumn(4,  idxPOST_NO);	
						gsmt.bindColumn(5,  idxADDRESS1);	
						gsmt.bindColumn(6,  idxADDRESS2);	
						gsmt.bindColumn(7,  idxUSE_TAG);	
						gsmt.bindColumn(8,  idxCLOSE_DT);
						gsmt.bindColumn(9,  idxVD_DIRECT);
						
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxMINOR_CD);	
						gsmt.bindColumn(2,  idxPOST_NO);	
						gsmt.bindColumn(3,  idxADDRESS1);	
						gsmt.bindColumn(4,  idxADDRESS2);	
						gsmt.bindColumn(5,  idxUSE_TAG);	
						gsmt.bindColumn(6,  idxCLOSE_DT);	
						gsmt.bindColumn(7,  idxVD_DIRECT);
						gsmt.bindColumn(8,  idxVEND_CD);	
						gsmt.bindColumn(9,  idxVEND_SEQ);	
						
						gsmt.executeUpdate();
						gsmt.close();
					
					}
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
	
						gsmt.bindColumn(1, idxVEND_CD);	
						gsmt.bindColumn(2, idxVEND_SEQ);

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