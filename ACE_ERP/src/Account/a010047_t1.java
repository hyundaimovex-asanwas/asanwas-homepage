package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010047_t1 extends HttpServlet{
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

				int idxSEQ			= userSet.indexOfColumn("SEQ");
				int idxVEND_CD		= userSet.indexOfColumn("VEND_CD");
				int idxVEND_ID		= userSet.indexOfColumn("VEND_ID");
				int idxEMPNM		= userSet.indexOfColumn("EMPNM");
				int idxEMAIL		= userSet.indexOfColumn("EMAIL");
				int idxDEPTNM		= userSet.indexOfColumn("DEPTNM");
				int idxHPNO			= userSet.indexOfColumn("HPNO");
				int idxTELNO		= userSet.indexOfColumn("TELNO");
				int idxENDDT		= userSet.indexOfColumn("ENDDT");
				int idxBSNS_CND		= userSet.indexOfColumn("BSNS_CND");
				int idxBSNS_KND		= userSet.indexOfColumn("BSNS_KND");
				int idxUSEGB		= userSet.indexOfColumn("USEGB");
				int idxSTATUS		= userSet.indexOfColumn("STATUS");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.CUSTOMER ( 			\n");
				InsertSql.append( " SEQ, VEND_CD, VEND_ID, EMPNM, 			\n");
				InsertSql.append( " EMAIL, DEPTNM, HPNO, TELNO, 			\n");
				InsertSql.append( " ENDDT, USEGB, STATUS,  I_DATE, I_EMPNO  \n");
				InsertSql.append( "	) VALUES( 								\n");
				InsertSql.append( " ?, ?, ?, ?, 							\n");
				InsertSql.append( " ?, ?, ?, ?, 							\n");
				InsertSql.append( " ?, ?, ?, sysdate, '"+str1+"' ) 			\n");

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE ACCOUNT.CUSTOMER SET 			    \n");
				UpdateSql.append( " SEQ		= ?, 							\n");
				UpdateSql.append( " VEND_CD = ?, 							\n");
				UpdateSql.append( " VEND_ID = ?, 							\n");
				UpdateSql.append( " EMPNM	= ?, 							\n");
				UpdateSql.append( " EMAIL	= ?, 							\n");
				UpdateSql.append( " DEPTNM	= ?, 							\n");
				UpdateSql.append( " HPNO	= ?, 							\n");
				UpdateSql.append( " TELNO	= ?, 							\n");
				UpdateSql.append( " ENDDT	= ?, 							\n");
				UpdateSql.append( " USEGB	= ?, 							\n");
				UpdateSql.append( " STATUS	= ?, 							\n");
				UpdateSql.append( " U_DATE	= sysdate, 						\n");
				UpdateSql.append( " U_EMPNO = '"+str1+"' 					\n");
				UpdateSql.append( " WHERE VEND_CD = ? 						\n");
				UpdateSql.append( " AND SEQ = ? 							\n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM ACCOUNT.CUSTOMER  		    \n");
				DeleteSql.append( " WHERE VEND_CD = ? 					    \n");
				DeleteSql.append( " AND SEQ = ? 						    \n");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						//MAX값 SEQ 조회 
						
						Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						sql0.append( " SELECT NVL(MAX(SEQ),0)+1 FROM ACCOUNT.CUSTOMER 	     \n"); 
						sql0.append( "	WHERE VEND_CD ='"+rows[j].getString(idxVEND_CD)+"'	 \n");
						
						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							 intSeq= rs0.getInt(1);
						}
						rs0.close();
						stmt0.close();

					    rows[j].setInt(idxSEQ,intSeq);

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
					
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxSEQ		);			
						gsmt.bindColumn(2,  idxVEND_CD	);	
						gsmt.bindColumn(3,  idxVEND_ID	);	
						gsmt.bindColumn(4,  idxEMPNM	);
						gsmt.bindColumn(5,  idxEMAIL	);		
						gsmt.bindColumn(6,  idxDEPTNM	);		
						gsmt.bindColumn(7,  idxHPNO		);	
						gsmt.bindColumn(8,  idxTELNO	);
						gsmt.bindColumn(9,  idxENDDT	);		
						gsmt.bindColumn(10, idxUSEGB	);
						gsmt.bindColumn(11, idxSTATUS	);
						gsmt.executeUpdate();
						gsmt.close();
						
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxSEQ		);			
						gsmt.bindColumn(2,  idxVEND_CD	);	
						gsmt.bindColumn(3,  idxVEND_ID	);	
						gsmt.bindColumn(4,  idxEMPNM	);
						gsmt.bindColumn(5,  idxEMAIL	);		
						gsmt.bindColumn(6,  idxDEPTNM	);		
						gsmt.bindColumn(7,  idxHPNO		);	
						gsmt.bindColumn(8,  idxTELNO	);
						gsmt.bindColumn(9,  idxENDDT	);		
						gsmt.bindColumn(10, idxUSEGB	);
						gsmt.bindColumn(11, idxSTATUS	);
						gsmt.bindColumn(12, idxVEND_CD	);	
						gsmt.bindColumn(13, idxSEQ		);						
	
		
						gsmt.executeUpdate(); 
						gsmt.close();        
					}
						if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxVEND_CD );			
						gsmt.bindColumn(2,  idxSEQ	);		
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