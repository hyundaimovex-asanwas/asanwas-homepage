package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400040_t1 extends HttpServlet{
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
				
				System.out.println("# a400040_t1 START : \n" );
				
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
       
				GauceStatement gsmt = null;
				GauceStatement gsmt2 = null;
				
				String strUserid = reqGauce.getParameter("v_str1");

				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");     //실적표
				GauceDataSet userSet2  = reqGauce.getGauceDataSet("USER2");   //입출금내역
				
				int idxREPTDT  = userSet.indexOfColumn("REPTDT");
				int idxSEQ     = userSet.indexOfColumn("SEQ");
				int idxRSTSEQ  = userSet.indexOfColumn("RSTSEQ");
				int idxDEDATE  = userSet.indexOfColumn("DEDATE");
				int idxINOUTGB = userSet.indexOfColumn("INOUTGB");
				int idxREMARK  = userSet.indexOfColumn("REMARK");
				int idxPLAMT   = userSet.indexOfColumn("PLAMT");
				int idxREAMT   = userSet.indexOfColumn("REAMT");
				int idxCUAMT   = userSet.indexOfColumn("CUAMT");
				int idxWRID    = userSet.indexOfColumn("WRID");
				int idxWRDT    = userSet.indexOfColumn("WRDT");
				int idxUPID    = userSet.indexOfColumn("UPID");
				int idxUPDT    = userSet.indexOfColumn("UPDT");
				int idxACCTNO  = userSet.indexOfColumn("ACCTNO");
				
				
				//입출금내역
				int idxACCTNO2  = userSet2.indexOfColumn("ACCTNO");
				int idxDEALDT2  = userSet2.indexOfColumn("DEALDT");
				int idxRESYN2   = userSet2.indexOfColumn("RESYN");
				int idxUPID2    = userSet2.indexOfColumn("WRID");
                
				GauceDataRow[] rows  = userSet.getDataRows();
				GauceDataRow[] rows2 = userSet2.getDataRows();
				
				StringBuffer mergesql  = null;
				StringBuffer DeleteSql  = null;
				StringBuffer UpdateSql2  = null;
				
				
				mergesql = new StringBuffer();
				mergesql.append( " MERGE INTO ACCOUNT.ACREPLAN MC \n ");
				mergesql.append( " USING DUAL \n ");
				mergesql.append( " ON (  MC.REPTDT = ? AND MC.SEQ =? ) \n ");
				mergesql.append( " WHEN MATCHED THEN \n ");
				mergesql.append( " UPDATE SET MC.RSTSEQ=? ,\n ");
				mergesql.append( "            MC.DEDATE=?, \n ");
				mergesql.append( "            MC.INOUTGB=?,\n ");
				mergesql.append( "            MC.REMARK=?, \n ");
				mergesql.append( "            MC.PLAMT=?,  \n ");
				mergesql.append( "            MC.REAMT=?, \n ");
				mergesql.append( "            MC.CUAMT=?, \n ");
				mergesql.append( "            MC.ACCTNO=?, \n ");
				mergesql.append( "            MC.UPID=?,  \n ");
				mergesql.append( "            MC.UPDT= CURRENT_TIMESTAMP   \n ");
				mergesql.append( " WHEN NOT MATCHED THEN \n ");
				mergesql.append( " INSERT ( REPTDT,SEQ,RSTSEQ,DEDATE,INOUTGB, \n ");
				mergesql.append( "          REMARK,PLAMT,REAMT,CUAMT,ACCTNO,  \n ");
				mergesql.append( "          WRID,WRDT ) \n ");
				mergesql.append( " VALUES ( ?,  ?,  ?,  ?,  ?,      \n ");
				mergesql.append( "          ?,  ?,  ?,  ?,  ?,      \n ");
				mergesql.append( "          ?,  CURRENT_TIMESTAMP ) \n ");
				
				UpdateSql2 = new StringBuffer();
				UpdateSql2.append( " UPDATE ACCOUNT.ACDEPOSIT SET \n ");
				UpdateSql2.append( "        RESYN =?, \n ");
				UpdateSql2.append( "        UPID =?,  \n ");
				UpdateSql2.append( "        UPDT =CURRENT_TIMESTAMP \n ");
				UpdateSql2.append( "  WHERE ACCTNO = ? \n ");
				UpdateSql2.append( "    AND DEALDT  =? \n ");
				
				
				System.out.println("# a400040_t1 START : \n "  + mergesql.toString());
				                
				for (int j = 0; j < rows.length; j++){
					//////////////////////////////////////////////////////////////////////////
					//if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
				      	System.out.println("# a400040_t1 START : 1 \n ");
					   
						rows[j].setString(idxWRID, strUserid);
						
						System.out.println("# a400040_t1 START : 2 \n ");
						
						//신규 생성 - A
						gsmt = conn.getGauceStatement(mergesql.toString());
						
						System.out.println("# a400040_t1 START : 3 \n ");
						gsmt.setGauceDataRow(rows[j]);
						
						System.out.println("# a400040_t1 START : 4 \n ");
						
						gsmt.bindColumn(1,  idxREPTDT);   
						gsmt.bindColumn(2,  idxSEQ);
						gsmt.bindColumn(3,  idxRSTSEQ);   
						gsmt.bindColumn(4,  idxDEDATE);
						gsmt.bindColumn(5,  idxINOUTGB);   
						gsmt.bindColumn(6,  idxREMARK);   
						gsmt.bindColumn(7,  idxPLAMT);
						gsmt.bindColumn(8,  idxREAMT);   
						gsmt.bindColumn(9,  idxCUAMT);
						gsmt.bindColumn(10, idxACCTNO);
						gsmt.bindColumn(11, idxWRID);    
						
						System.out.println("# a400040_t1 START : 5 \n ");
						
						
						gsmt.bindColumn(12, idxREPTDT);   
						gsmt.bindColumn(13, idxSEQ);
						gsmt.bindColumn(14, idxRSTSEQ);   
						gsmt.bindColumn(15, idxDEDATE);
						gsmt.bindColumn(16, idxINOUTGB);   
						gsmt.bindColumn(17, idxREMARK);   
						gsmt.bindColumn(18, idxPLAMT);
						gsmt.bindColumn(19, idxREAMT);   
						gsmt.bindColumn(20, idxCUAMT);
						gsmt.bindColumn(21, idxACCTNO);
						gsmt.bindColumn(22, idxWRID);    
						
						System.out.println("# a400040_t1 START 8888 : \n " );
						
						gsmt.executeUpdate();
						gsmt.close();

						System.out.println("# a400040_t1 end 9999: \n " );
						gsmt=null;
					//}
				} //for
				
				
				for (int i = 0; i < rows2.length; i++){
					//////////////////////////////////////////////////////////////////////////
					//if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
				      	System.out.println("# a400040_t1 UPDATE START : 1 \n ");
					   
						rows2[i].setString(idxUPID2, strUserid);
						
						System.out.println("UpdateSql2.toString()::"+UpdateSql2.toString());
						//신규 생성 - A
						gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						System.out.println("#1  \n " );
						gsmt2.setGauceDataRow(rows2[i]);
						System.out.println("#2  \n " );
						gsmt2.bindColumn(1, idxRESYN2);
						System.out.println("#3  \n " );
						gsmt2.bindColumn(2, idxUPID2); 
						System.out.println("#5  \n " );
						gsmt2.bindColumn(3, idxACCTNO2);
						System.out.println("#6  \n " );
						gsmt2.bindColumn(4, idxDEALDT2);   
						
						System.out.println("# a400040_t1 UPDATE end 888: \n " );
						
						gsmt2.executeUpdate();
						gsmt2.close();

						System.out.println("# a400040_t1 UPDATE end 9999: \n " );
						gsmt2=null;
					//}
				} //for
				
				
				
			}//try
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