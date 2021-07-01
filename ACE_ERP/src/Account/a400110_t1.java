package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400110_t1 extends HttpServlet{
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
	 		
	 		
	 		String strEmpid="";  //관리자ID
	 		
			try {
				
				conn = service.getDBConnection();	
				conn.setAutoCommit(false);
				
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String str1 = reqGauce.getParameter("v_str1");				//사용자
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxEMPID      = userSet.indexOfColumn("EMPID");
				int idxEMPNO      = userSet.indexOfColumn("EMPNO");
				int idxS_DATE     = userSet.indexOfColumn("S_DATE");
				int idxE_DATE     = userSet.indexOfColumn("E_DATE");
				int idxUSEGB      = userSet.indexOfColumn("USEGB");
				int idxREMARK     = userSet.indexOfColumn("REMARK");
				int idxWRID       = userSet.indexOfColumn("WRID");
				int idxUPID       = userSet.indexOfColumn("UPID");
								
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;
				
				GauceStatement gsmt= null;
				
				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.SIGNET_MGR (     \n" );
				InsertSql.append( " EMPID, EMPNO, S_DATE, E_DATE, USEGB, \n" );
				InsertSql.append( " REMARK, WRID, WRDT                   \n" );
				InsertSql.append( " )VALUES (                            \n" );
				InsertSql.append( " ?,?,?,?,?,                           \n" );
				InsertSql.append( " ?,?,CURRENT_TIMESTAMP                \n" );
				InsertSql.append( " )                                    \n" );
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.SIGNET_MGR SET  \n" );
				UpdateSql.append( " EMPNO = ?,      \n" );
				UpdateSql.append( " S_DATE = ?,     \n" );
				UpdateSql.append( " E_DATE = ?,     \n" );
				UpdateSql.append( " USEGB = ?,      \n" );
				UpdateSql.append( " REMARK = ?,     \n" );
				UpdateSql.append( " UPID = ?,       \n" );
				UpdateSql.append( " UPDT = CURRENT_TIMESTAMP  \n" );
				UpdateSql.append( " WHERE EMPID  = ? \n" );
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.SIGNET_MGR \n" );
				DeleteSql.append( " WHERE EMPID  = ? \n" );
				
				for (int j = 0; j < rows.length; j++){
					
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
				
						
						//gsmt.setString(idxWRID, str1);		
						/*
						System.out.println("InsertSql.toString()::"+InsertSql.toString());
						System.out.println("idxFDCODE ::"+rows[j].getString(idxFDCODE));
						System.out.println("idxFSDAT  ::"+rows[j].getString(idxFSDAT));
						System.out.println("idxFSNBR  ::"+rows[j].getString(idxFSNBR));
						System.out.println("idxFSSEQ  ::"+rows[j].getString(idxFSSEQ));
						System.out.println("idxATCODE ::"+rows[j].getString(idxATCODE));
						System.out.println("idxPAYDT  ::"+rows[j].getString(idxPAYDT));
						System.out.println("idxENDDT  ::"+rows[j].getString(idxENDDT));
						System.out.println("idxREMARK ::"+rows[j].getString(idxREMARK));
						System.out.println("idxDEAMT  ::"+rows[j].getString(idxDEAMT));
						System.out.println("idxCRAMT  ::"+rows[j].getString(idxCRAMT));
						System.out.println("idxSSDAT  ::"+rows[j].getString(idxSSDAT));
						System.out.println("idxSSNBR  ::"+rows[j].getString(idxSSNBR));
						System.out.println("idxVEND_CD::"+rows[j].getString(idxVEND_CD));
						System.out.println("idxBILLSNO::"+rows[j].getString(idxBILLSNO));
						System.out.println("idxWRID   ::"+rows[j].getString(idxWRID));
						System.out.println("idxUPID   ::"+rows[j].getString(idxUPID));
						*/
						
						//System.out.println(gsmt.getString())
						
						//rows[j].setString(idxWRID,str1);
						//채번시작
						Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						sql0.append( "  SELECT LPAD(NVL(MAX(TO_NUMBER(EMPID)),0)+1,5,0) FROM ACCOUNT.SIGNET_MGR  "); 
						 
						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							strEmpid= rs0.getString(1);
						}
						rs0.close();
						stmt0.close();
						
						
						rows[j].setString(idxEMPID,strEmpid);
						rows[j].setString(idxWRID, str1);
						//채번완료
						gsmt = conn.getGauceStatement(InsertSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEMPID);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.bindColumn(3, idxS_DATE);
						gsmt.bindColumn(4, idxE_DATE);
						gsmt.bindColumn(5, idxUSEGB);
						gsmt.bindColumn(6, idxREMARK);
						gsmt.bindColumn(7, idxWRID);
												
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
					}else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
						
						System.out.println(UpdateSql.toString());
						
						rows[j].setString(idxUPID,str1);
												
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxS_DATE);
						gsmt.bindColumn(3, idxE_DATE);
						gsmt.bindColumn(4, idxUSEGB);
						gsmt.bindColumn(5, idxREMARK);
						gsmt.bindColumn(6, idxUPID);
						gsmt.bindColumn(7, idxEMPID);
						
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
					
			 	   }else if (rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE){
					
						System.out.println(DeleteSql.toString());
						
						rows[j].setString(idxUPID,str1);
												
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxEMPID);
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