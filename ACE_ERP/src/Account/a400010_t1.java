package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400010_t1 extends HttpServlet{
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
	 		
	 		
	 		String strAcctcd="";  //계좌코드
	 		
			try {
				
				conn = service.getDBConnection();	
				conn.setAutoCommit(false);
				
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String str1 = reqGauce.getParameter("v_str1");				//사용자
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxACCTNO    = userSet.indexOfColumn("ACCTNO");
				int idxBANKCD    = userSet.indexOfColumn("BANKCD");
				int idxACCTCD    = userSet.indexOfColumn("ACCTCD");
				int idxBRCHCD    = userSet.indexOfColumn("BRCHCD");
				int idxBRCHNM    = userSet.indexOfColumn("BRCHNM");
				int idxACCTUSE   = userSet.indexOfColumn("ACCTUSE");
				int idxACCTGB    = userSet.indexOfColumn("ACCTGB");
				int idxDEPOGB    = userSet.indexOfColumn("DEPOGB");
				int idxINRATE    = userSet.indexOfColumn("INRATE");
				int idxREMARK    = userSet.indexOfColumn("REMARK");
				int idxSTATUS    = userSet.indexOfColumn("STATUS");
				int idxENDDAT    = userSet.indexOfColumn("ENDDAT");
				int idxTEAM      = userSet.indexOfColumn("TEAM");
				int idxRESULT    = userSet.indexOfColumn("RESULT");
				int idxRSTREMARK = userSet.indexOfColumn("RSTREMARK");
				int idxRSTSEQ    = userSet.indexOfColumn("RSTSEQ");
				int idxCOSTCD    = userSet.indexOfColumn("COSTCD");
				int idxWRID      = userSet.indexOfColumn("WRID");
				int idxWRDT      = userSet.indexOfColumn("WRDT");
				int idxUPID      = userSet.indexOfColumn("UPID");
				int idxUPDT      = userSet.indexOfColumn("UPDT");
							
								
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				
				GauceStatement gsmt= null;
				
				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ACCTINFO (        \n" );
				InsertSql.append( " ACCTNO,BANKCD,ACCTCD, BRCHCD,ACCTUSE, \n" );
				InsertSql.append( " ACCTGB, DEPOGB, INRATE,REMARK, STATUS,ENDDAT,  \n" );
				InsertSql.append( " TEAM,  RESULT,RSTREMARK, RSTSEQ, COSTCD,  \n" );
				InsertSql.append( " WRID,WRDT                             \n" );
				InsertSql.append( " )VALUES (                             \n" );
				InsertSql.append( " ?,?,?,?,?,                            \n" );
				InsertSql.append( " ?,?,?,?,?,?                           \n" );
				InsertSql.append( " ?,?,?,?,?,                            \n" );
				InsertSql.append( " ?,SYSDATE                             \n" );
				InsertSql.append( " )                                     \n" );
				
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ACCTINFO SET  \n" );
				UpdateSql.append( " ACCTCD = ?,      \n" );
				UpdateSql.append( " BRCHCD = ?,      \n" );
				UpdateSql.append( " ACCTUSE = ?,     \n" );
				UpdateSql.append( " ACCTGB = ?,      \n" );
				UpdateSql.append( " DEPOGB = ?,      \n" );
				UpdateSql.append( " INRATE = ?,      \n" );
				UpdateSql.append( " REMARK = ?,      \n" );
				UpdateSql.append( " STATUS = ?,      \n" );
				UpdateSql.append( " ENDDAT = ?,      \n" );
				UpdateSql.append( " TEAM = ?,        \n" );
				UpdateSql.append( " RESULT = ?,      \n" );
				UpdateSql.append( " RSTREMARK = ?,   \n" );
				UpdateSql.append( " RSTSEQ = ?,      \n" );
				UpdateSql.append( " COSTCD = ?,      \n" );
				UpdateSql.append( " UPID = ?,        \n" );
				UpdateSql.append( " UPDT = SYSDATE   \n" );
				UpdateSql.append( " WHERE ACCTNO = ? \n" );
				UpdateSql.append( "   AND BANKCD = ? \n" );
				
				
				
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
						sql0.append( "  SELECT LPAD(MAX(TO_NUMBER(CDCODE))+1,4,0)   "); 
						sql0.append( "	 FROM ACCOUNT.COMMDTIL WHERE CMTYPE ='0023' "); 
						sql0.append( "	  AND TO_NUMBER(CDCODE)<1000                 "); 
						 
						//System.out.println("1sql0"+sql0.toString());
						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							strAcctcd= rs0.getString(1);
						}
						rs0.close();
						stmt0.close();
						
						
						rows[j].setString(idxACCTCD,strAcctcd);
						rows[j].setString(idxWRID,str1);
						
						//채번완료
						
						// 공통코드 처리시작
						StringBuffer sql1 = new StringBuffer();
						  
					    sql1.append( " MERGE INTO ACCOUNT.COMMDTIL MC \n ");
					    sql1.append( " USING DUAL \n ");
					    sql1.append( " ON (  MC.CMTYPE = '0023' AND MC.CDCODE =? AND MC.CDNAM = ? ) \n ");
					    sql1.append( " WHEN NOT MATCHED THEN \n ");
					    sql1.append( "      INSERT (  CMTYPE, CDCODE, CDNAM, CDREMARK, 	WRDT,	WRID )  \n ");
					    sql1.append( "      VALUES (  '0023', ?,  ?,  ?, TO_CHAR(SYSDATE, 'YYYYMMDD'), ? )  \n ");
						      
					    
					    GauceStatement gsmt1 = conn.getGauceStatement(sql1.toString());
					    
					    gsmt1.setGauceDataRow(rows[j]);
						gsmt1.bindColumn(1, idxACCTCD);
						gsmt1.bindColumn(2, idxACCTNO);
						gsmt1.bindColumn(3, idxACCTCD);
						gsmt1.bindColumn(4, idxACCTNO);
						gsmt1.bindColumn(5, idxBRCHNM);
						gsmt1.bindColumn(6, idxWRID);
					    
						gsmt1.executeUpdate();
						gsmt1.close(); 
										
						// 공통코드 처리완료
						
						System.out.println("idxWRID::"+rows[j].getString(idxWRID));
						
						gsmt = conn.getGauceStatement(InsertSql.toString());
						
						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxACCTNO);
						gsmt.bindColumn(2, idxBANKCD);
						gsmt.bindColumn(3, idxACCTCD);
						gsmt.bindColumn(4, idxBRCHCD);
						gsmt.bindColumn(5, idxACCTUSE);
						gsmt.bindColumn(6, idxACCTGB);
						gsmt.bindColumn(7, idxDEPOGB);
						gsmt.bindColumn(8, idxINRATE);
						gsmt.bindColumn(9, idxREMARK);
						gsmt.bindColumn(10, idxSTATUS);
						gsmt.bindColumn(11,idxENDDAT);
						gsmt.bindColumn(12,idxTEAM);
						gsmt.bindColumn(13,idxRESULT);
						gsmt.bindColumn(14,idxRSTREMARK);
						gsmt.bindColumn(15,idxRSTSEQ);
						gsmt.bindColumn(16,idxCOSTCD);
						gsmt.bindColumn(17,idxWRID);
												
						gsmt.executeUpdate();
						gsmt.close();
						gsmt = null;
						
					}else if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE){
						
						System.out.println(UpdateSql.toString());
						
						rows[j].setString(idxUPID,str1);
												
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxACCTCD);
						gsmt.bindColumn(2, idxBRCHCD);
						gsmt.bindColumn(3, idxACCTUSE);
						gsmt.bindColumn(4, idxACCTGB);
						gsmt.bindColumn(5, idxDEPOGB);
						gsmt.bindColumn(6, idxINRATE);
						gsmt.bindColumn(7, idxREMARK);
						gsmt.bindColumn(8, idxSTATUS);
						gsmt.bindColumn(9, idxENDDAT);
						gsmt.bindColumn(10, idxTEAM);
						gsmt.bindColumn(11,idxRESULT);
						gsmt.bindColumn(12,idxRSTREMARK);
						gsmt.bindColumn(13,idxRSTSEQ);
						gsmt.bindColumn(14,idxCOSTCD);
						gsmt.bindColumn(15,idxUPID);
						gsmt.bindColumn(16,idxACCTNO);
						gsmt.bindColumn(17,idxBANKCD);
						
						
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