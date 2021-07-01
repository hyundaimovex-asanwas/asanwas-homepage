package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class a500030_t1 extends HttpServlet{
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
			String strVend_SEQ="";


			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String str1 = reqGauce.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxSEQ_NEW       = 1;	
				
				int idxVEND_CD  	 = userSet.indexOfColumn("VEND_CD");
				int idxVEND_NM  	 = userSet.indexOfColumn("VEND_NM");
				int idxVEND_ID  	 = userSet.indexOfColumn("VEND_ID");
				int idxSEQ  	 	 = userSet.indexOfColumn("SEQ");				
				int idxBANK_CD 		 = userSet.indexOfColumn("BANK_CD");
				int idxBANK_NM 		 = userSet.indexOfColumn("BANK_NM");
				int idxACCT_NO 		 = userSet.indexOfColumn("ACCT_NO");
				int idxACCT_AUTH 	 = userSet.indexOfColumn("ACCT_AUTH");
				int idxREASON 		 = userSet.indexOfColumn("REASON");
				int idxGUBUN 		 = userSet.indexOfColumn("GUBUN");
				int idxSTATUS 		 = userSet.indexOfColumn("STATUS");
				int idxUSEYN 		 = userSet.indexOfColumn("USEYN");
				int idxD_DATE 		 = userSet.indexOfColumn("D_DATE");
				int idxREJECT_REASON = userSet.indexOfColumn("REJECT_REASON");
				int idxI_EMPNO 		 = userSet.indexOfColumn("I_EMPNO");
				int idxI_DATE  		 = userSet.indexOfColumn("I_DATE");
				int idxU_EMPNO 		 = userSet.indexOfColumn("U_EMPNO");
				int idxU_DATE  		 = userSet.indexOfColumn("U_DATE");				


				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				
				InsertSql.append( "INSERT INTO ACCOUNT.ACCTNO ( 								\n");
				InsertSql.append( "VEND_CD,VEND_NM,VEND_ID,SEQ, BANK_CD, BANK_NM,  			    \n");
				InsertSql.append( "ACCT_NO,ACCT_AUTH,REASON,GUBUN,STATUS,						\n");
				InsertSql.append( "USEYN,D_DATE,REJECT_REASON,									\n");				
				InsertSql.append( "I_EMPNO,I_DATE, U_EMPNO, U_DATE                              \n");
				InsertSql.append( "	) VALUES( 													\n");
				InsertSql.append( " ?, ?, ?, ?, ?, ?,											\n");
				InsertSql.append( " ?, ?, ?, ?, ?, 												\n");
				InsertSql.append( " ?, ?, ?,  													\n");				
				InsertSql.append( " '"+str1+"', sysdate, '"+str1+"', sysdate ) 					\n");
				
				
				UpdateSql = new StringBuffer();
				
				UpdateSql.append( " UPDATE ACCOUNT.ACCTNO SET 									\n");				

				UpdateSql.append( "  VEND_NM = ? 												\n");
				UpdateSql.append( " ,VEND_ID = ? 												\n");
				UpdateSql.append( " ,BANK_CD = ? 												\n");
				UpdateSql.append( " ,BANK_NM = ? 												\n");
				UpdateSql.append( " ,ACCT_NO = ? 												\n");
				UpdateSql.append( " ,ACCT_AUTH = ? 												\n");
				UpdateSql.append( " ,REASON = ? 												\n");
				UpdateSql.append( " ,GUBUN = ? 													\n");
				UpdateSql.append( " ,STATUS = ? 												\n");
				UpdateSql.append( " ,USEYN = ? 													\n");				
				UpdateSql.append( " ,D_DATE = ? 												\n");
				UpdateSql.append( " ,REJECT_REASON = ? 											\n");
				UpdateSql.append( " ,U_EMPNO = '"+str1+"'										\n");
				UpdateSql.append( " ,U_DATE =	sysdate 										\n");
				UpdateSql.append( "  WHERE  VEND_CD = ? 										\n");	
				UpdateSql.append( "       AND  SEQ  = ? 										\n");					
				
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ACCTNO 									\n");				
				DeleteSql.append( "  WHERE  VEND_CD = ? 										\n");	
				DeleteSql.append( "  		AND  SEQ  = ? 										\n");	

				
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {


						Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						
						sql0.append( " SELECT CASE WHEN MAX(VEND_CD) IS NULL THEN '1'                		\n"); 
						sql0.append( "        ELSE TO_CHAR(MAX(SEQ)+1) END  								\n");
						sql0.append( "   FROM ACCOUNT.ACCTNO                                    			\n");
						sql0.append( "	WHERE VEND_CD ='"+rows[j].getString(idxVEND_CD)+"'					\n");						
						
						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						
						if(rs0.next()){
							
							strSeq= rs0.getString(1);
							
							strVend_SEQ = strSeq;
						}
						
						rs0.close();
						stmt0.close();

					    rows[j].setString(idxSEQ_NEW, strVend_SEQ);						

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxVEND_CD);	
						gsmt.bindColumn(2,  idxVEND_NM);	
						gsmt.bindColumn(3,  idxVEND_ID);	
						gsmt.bindColumn(4,  idxSEQ_NEW);	
						gsmt.bindColumn(5,  idxBANK_CD);	
						gsmt.bindColumn(6,  idxBANK_NM);	
						gsmt.bindColumn(7,  idxACCT_NO);	
						gsmt.bindColumn(8,  idxACCT_AUTH);	
						gsmt.bindColumn(9,  idxREASON);	
						gsmt.bindColumn(10, idxGUBUN);	
						gsmt.bindColumn(11, idxSTATUS);	
						gsmt.bindColumn(12, idxUSEYN);	
						gsmt.bindColumn(13, idxD_DATE);	
						gsmt.bindColumn(14, idxREJECT_REASON);	

						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1,  idxVEND_NM);	
						gsmt.bindColumn(2,  idxVEND_ID);	
						gsmt.bindColumn(3,  idxBANK_CD);	
						gsmt.bindColumn(4,  idxBANK_NM);	
						gsmt.bindColumn(5,  idxACCT_NO);	
						gsmt.bindColumn(6,  idxACCT_AUTH);	
						gsmt.bindColumn(7,  idxREASON);	
						gsmt.bindColumn(8,  idxGUBUN);	
						gsmt.bindColumn(9,  idxSTATUS);	
						gsmt.bindColumn(10, idxUSEYN);	
						gsmt.bindColumn(11, idxD_DATE);	
						gsmt.bindColumn(12, idxREJECT_REASON);	
						gsmt.bindColumn(13, idxVEND_CD);	
						gsmt.bindColumn(14, idxSEQ);
						
						gsmt.executeUpdate();
						gsmt.close();

					}
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
	
						gsmt.bindColumn(1, idxVEND_CD);	
						gsmt.bindColumn(2, idxSEQ);
						
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