package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a070007_t4 extends HttpServlet{
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

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1");				//사용자
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE = userSet.indexOfColumn("FDCODE");
				int idxACDATE = userSet.indexOfColumn("ACDATE");
				int idxAJDTFR = userSet.indexOfColumn("AJDTFR");
				int idxAJDTTO = userSet.indexOfColumn("AJDTTO");
				int idxWRID   = userSet.indexOfColumn("WRID");
				int idxUPID   = userSet.indexOfColumn("UPID");
				int idxOFDCODE = userSet.indexOfColumn("OFDCODE");
				int idxOACDATE = userSet.indexOfColumn("OACDATE");
				
								
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				
				GauceStatement gsmt= null;
				
				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ACASHDTAJ (FDCODE,ACDATE,AJDTFR,AJDTTO,WRID,WRDT)   \n" );
				InsertSql.append( " VALUES ( ?, ?, ?, ?, ?, SYSDATE )  \n" );
				
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ACASHDTAJ SET  \n" );
				UpdateSql.append( " FDCODE = ?,      \n" );
				UpdateSql.append( " ACDATE = ?,      \n" );
				UpdateSql.append( " AJDTFR = ?,      \n" );
				UpdateSql.append( " AJDTTO = ?,      \n" );
				UpdateSql.append( " UPID = ?,        \n" );
				UpdateSql.append( " UPDT = SYSDATE   \n" );
				UpdateSql.append( " WHERE FDCODE = ? \n" );
				UpdateSql.append( "   AND ACDATE = ? \n" );
				
			
		
				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
				
						/*
						//gsmt.setString(idxWRID, str1);		
						System.out.println("InsertSql.toString()::"+InsertSql.toString());
						
						System.out.println("idxFDCODE::"+rows[j].getString(idxFDCODE));
						System.out.println("idxACDATE::"+rows[j].getString(idxACDATE));
						System.out.println("idxAJDTFR::"+rows[j].getString(idxAJDTFR));
						System.out.println("idxAJDTTO::"+rows[j].getString(idxAJDTTO));
						System.out.println("idxOFDCODE::"+rows[j].getString(idxOFDCODE));
						System.out.println("idxOACDATE::"+rows[j].getString(idxOACDATE));
						System.out.println("idxWRID::"+rows[j].getString(idxWRID));
						
						//System.out.println(gsmt.getString())
						*/
						rows[j].setString(idxWRID,str1);
						
						gsmt = conn.getGauceStatement(InsertSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxFDCODE);
						gsmt.bindColumn(2, idxACDATE);
						gsmt.bindColumn(3, idxAJDTFR);
						gsmt.bindColumn(4, idxAJDTTO);
						gsmt.bindColumn(5, idxWRID);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
					}else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
						/*
						//gsmt.setString(idxUPID, str1);
						
						rows[j].setString(idxUPID,str1);
						
                        System.out.println("InsertSql.toString()::"+UpdateSql.toString());
						
						System.out.println("idxFDCODE::"+rows[j].getString(idxFDCODE));
						System.out.println("idxACDATE::"+rows[j].getString(idxACDATE));
						System.out.println("idxAJDTFR::"+rows[j].getString(idxAJDTFR));
						System.out.println("idxAJDTTO::"+rows[j].getString(idxAJDTTO));
						System.out.println("idxOFDCODE::"+rows[j].getString(idxOFDCODE));
						System.out.println("idxOACDATE::"+rows[j].getString(idxOACDATE));
						System.out.println("idxUPID::"+rows[j].getString(idxUPID));
						*/
						
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxFDCODE);
						gsmt.bindColumn(2, idxACDATE);
						gsmt.bindColumn(3, idxAJDTFR);
						gsmt.bindColumn(4, idxAJDTTO);
						gsmt.bindColumn(5, idxUPID);
						gsmt.bindColumn(6, idxOFDCODE);
						gsmt.bindColumn(7, idxOACDATE);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
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
			
			System.out.println(e);
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}