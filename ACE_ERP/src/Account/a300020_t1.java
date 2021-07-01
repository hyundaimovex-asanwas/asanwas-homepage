package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a300020_t1 extends HttpServlet{
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
				int idxJOBDT  = userSet.indexOfColumn("JOBDT");
				int idxENDDT  = userSet.indexOfColumn("ENDDT");
				int idxREMARK = userSet.indexOfColumn("REMARK");
				int idxDEAMT  = userSet.indexOfColumn("DEAMT");
				int idxCRAMT  = userSet.indexOfColumn("CRAMT");
				int idxWRID   = userSet.indexOfColumn("WRID");
				int idxUPID   = userSet.indexOfColumn("UPID");	
				int idxENDYM  = userSet.indexOfColumn("ENDYM");	
				int idxGUBUN  = userSet.indexOfColumn("GUBUN");	
								
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				
				GauceStatement gsmt= null;
				
				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ABILLSSUM (        \n" );
				InsertSql.append( " FDCODE, JOBDT, ENDDT,  REMARK,         \n" );
				InsertSql.append( " DEAMT,  CRAMT, ENDYM,  WRID,   WRDT,   \n" );
				InsertSql.append( " GUBUN                                  \n" );
				InsertSql.append( " )VALUES (                              \n" );
				InsertSql.append( " ?,?,?,?,                               \n" );
				InsertSql.append( " ?,?,?,?,SYSDATE,                       \n" );
				InsertSql.append( " ?                                      \n" );
				InsertSql.append( " )                                      \n" );
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ABILLSSUM SET  \n" );
				UpdateSql.append( " REMARK = ?,     \n" );
				UpdateSql.append( " UPID = ?,        \n" );
				UpdateSql.append( " UPDT = SYSDATE   \n" );
				UpdateSql.append( " WHERE FDCODE = ? \n" );
				UpdateSql.append( "   AND JOBDT = ?  \n" );
				UpdateSql.append( "   AND ENDDT = ?  \n" );
				UpdateSql.append( "   AND GUBUN = ?  \n" );
				
				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
				
						
						//gsmt.setString(idxWRID, str1);
						/*
						System.out.println("InsertSql.toString()::"+InsertSql.toString());
						
						System.out.println("idxFDCODE ::"+rows[j].getString(idxFDCODE));
						System.out.println("idxJOBDT  ::"+rows[j].getString(idxJOBDT));
						System.out.println("idxENDDT  ::"+rows[j].getString(idxENDDT));
						System.out.println("idxREMARK ::"+rows[j].getString(idxREMARK));
						System.out.println("idxDEAMT  ::"+rows[j].getString(idxDEAMT));
						System.out.println("idxCRAMT  ::"+rows[j].getString(idxCRAMT));
						System.out.println("idxENDYM  ::"+rows[j].getString(idxENDYM));
						System.out.println("idxWRID   ::"+rows[j].getString(idxWRID));
						System.out.println("idxUPID   ::"+rows[j].getString(idxUPID));
						System.out.println("idxGUBUN  ::"+rows[j].getString(idxGUBUN));
						*/
						
						//System.out.println(gsmt.getString())
						
						rows[j].setString(idxWRID,str1);
						rows[j].setString(idxENDYM,rows[j].getString(idxENDDT).substring(0,6));
						
						//System.out.println("idxENDDT::"+rows[j].getString(idxENDDT).substring(0,6));
						
						gsmt = conn.getGauceStatement(InsertSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxFDCODE);
						gsmt.bindColumn(2, idxJOBDT);
						gsmt.bindColumn(3, idxENDDT);
						gsmt.bindColumn(4, idxREMARK);
						gsmt.bindColumn(5, idxDEAMT);
						gsmt.bindColumn(6, idxCRAMT);
						gsmt.bindColumn(7, idxENDYM);
						gsmt.bindColumn(8, idxWRID);
						gsmt.bindColumn(9, idxGUBUN);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
					}else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
						
						//gsmt.setString(idxUPID, str1);
						
						rows[j].setString(idxUPID,str1);
						
						/*
                        System.out.println("InsertSql.toString()::"+UpdateSql.toString());
						System.out.println("idxFDCODE::"+rows[j].getString(idxFDCODE));
						System.out.println("idxUPID::"+rows[j].getString(idxUPID));
						*/
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxREMARK);
						gsmt.bindColumn(2, idxUPID);
						gsmt.bindColumn(3, idxFDCODE);
						gsmt.bindColumn(4, idxJOBDT);
						gsmt.bindColumn(5, idxENDDT);
						gsmt.bindColumn(6, idxGUBUN);
						
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
					}
				
				}
				
			}
			catch(Exception e){
				System.out.println("ERROR000::"+e);
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			conn.commit(); 
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			
			System.out.println("ERROR::"+e);
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}