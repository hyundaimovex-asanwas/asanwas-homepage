package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040091_t1 extends HttpServlet{
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

			double  dblSeq = 0 ;
			String strVend_CD="";

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				String str1 = reqGauce.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				int idxBS_ID  	    = userSet.indexOfColumn("BS_ID");
				int idxVEND_ID  	= userSet.indexOfColumn("C_VEND_ID");
				int idxVEND_CD  	= userSet.indexOfColumn("C_VEND_CD");
				int idxSEQ       	= userSet.indexOfColumn("C_SEQ");
				int idxEMPNM     	= userSet.indexOfColumn("C_EMPNM");
				int idxDEPTNM   	= userSet.indexOfColumn("C_DEPTNM");
				int idxEMAIL     	= userSet.indexOfColumn("C_EMAIL");
				int idxHPNO     	= userSet.indexOfColumn("C_HPNO");
				int idxTELNO    	= userSet.indexOfColumn("C_TELNO");
				int idxENDDT    	= userSet.indexOfColumn("C_ENDDT");
				int idxUSEGB    	= userSet.indexOfColumn("C_USEGB");;
				
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer UpdateSql2 = null;
				
				GauceStatement gsmt =null;
				GauceStatement gsmt2 =null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.CUSTOMER ( 			" );
				InsertSql.append( "VEND_CD,VEND_ID, SEQ, EMPNM, DEPTNM,  	" );
				InsertSql.append( "EMAIL,HPNO,TELNO,ENDDT, USEGB, 			" );
				InsertSql.append( "I_EMPNO, I_DATE   									" );
				InsertSql.append( "	) VALUES( 												" );
				InsertSql.append( " ?, ?, ?, ?, ?, 											" );
				InsertSql.append( " ?, ?, ?, ?, ?, 											" );
				InsertSql.append( " '"+str1+"', sysdate ) 									" );
				

				UpdateSql = new StringBuffer();
								
				DeleteSql = new StringBuffer();
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						sql0.append( " SELECT NVL(MAX(SEQ),0)+1 AS SEQ 							"); 
						sql0.append( "	 FROM ACCOUNT.CUSTOMER  									");
						sql0.append( "  WHERE VEND_CD = '"+rows[j].getString(idxVEND_CD)+"'	");
						sql0.append( "    AND VEND_ID  = '"+rows[j].getString(idxVEND_ID)+"'		");

						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							dblSeq= rs0.getInt(1);
						}
						rs0.close();
						stmt0.close();

					    rows[j].setDouble(idxSEQ,dblSeq);

						gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxVEND_CD);
						gsmt.bindColumn(2,  idxVEND_ID);	
						gsmt.bindColumn(3,  idxSEQ);	
						gsmt.bindColumn(4,  idxEMPNM);	
						gsmt.bindColumn(5,  idxDEPTNM);	
						gsmt.bindColumn(6,  idxEMAIL);	
						gsmt.bindColumn(7,  idxHPNO);	
						gsmt.bindColumn(8,  idxTELNO);	
						gsmt.bindColumn(9,  idxENDDT);	
						gsmt.bindColumn(10, idxUSEGB);	

						gsmt.executeUpdate();
						gsmt.close();
						
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					
					
					}
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						
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