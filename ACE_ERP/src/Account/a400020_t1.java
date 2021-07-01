package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400020_t1 extends HttpServlet{
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
       
				GauceStatement gsmt = null;
				GauceStatement gsmt2 = null;
				GauceStatement gsmt3 = null;
				
				String strUserid = reqGauce.getParameter("v_str1");

				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");
				
				int idxACCTNO          = userSet.indexOfColumn("ACCTNO");
				int idxDEALDT          = userSet.indexOfColumn("DEALDT");
				int idxACCTCD          = userSet.indexOfColumn("ACCTCD");
				int idxREMARK          = userSet.indexOfColumn("REMARK");
				int idxINAMT           = userSet.indexOfColumn("INAMT");
				int idxOUTAMT          = userSet.indexOfColumn("OUTAMT");
				int idxBALAMT          = userSet.indexOfColumn("BALAMT");
				int idxFINAMT          = userSet.indexOfColumn("FINAMT");
				int idxFOUTAMT         = userSet.indexOfColumn("FOUTAMT");
				int idxFBALAMT         = userSet.indexOfColumn("FBALAMT");
				int idxCURUNIT         = userSet.indexOfColumn("CURUNIT");
				int idxEXRATE          = userSet.indexOfColumn("EXRATE");
				int idxTRISSUE         = userSet.indexOfColumn("TRISSUE");
				int idxDEDATE          = userSet.indexOfColumn("DEDATE");
				int idxDETIME          = userSet.indexOfColumn("DETIME");
				int idxRESULT          = userSet.indexOfColumn("RESULT");
				int idxRSTREMARK       = userSet.indexOfColumn("RSTREMARK");
				int idxRSTSEQ          = userSet.indexOfColumn("RSTSEQ");
				int idxTEAM            = userSet.indexOfColumn("TEAM");
				int idxINRATE          = userSet.indexOfColumn("INRATE");
				int idxCOSTCD          = userSet.indexOfColumn("COSTCD");
				int idxWRID            = userSet.indexOfColumn("WRID");
				                
				GauceDataRow[] rows  = userSet.getDataRows();
				
				StringBuffer mergesql  = null;
				StringBuffer DeleteSql  = null;
				

				mergesql = new StringBuffer();
				mergesql.append( " MERGE INTO ACCOUNT.ACDEPOSIT MC \n ");
				mergesql.append( " USING DUAL \n ");
				mergesql.append( " ON (  MC.ACCTNO = ? AND MC.DEALDT =? ) \n ");
				mergesql.append( " WHEN NOT MATCHED THEN \n ");
				mergesql.append( " INSERT ( ACCTNO, DEALDT,   ACCTCD, REMARK, INAMT,   \n ");
				mergesql.append( "          OUTAMT, BALAMT,   FINAMT, FOUTAMT,FBALAMT, \n ");
				mergesql.append( "          CURUNIT,EXRATE,   TRISSUE,DEDATE, DETIME,\n ");
				mergesql.append( "          RESULT, RSTREMARK,RSTSEQ, TEAM,   INRATE, COSTCD, \n ");
				mergesql.append( "          WRID,   WRDT ) \n ");
				mergesql.append( " VALUES ( ?,  ?,  ?,  ?,  ?,   \n ");
				mergesql.append( "          ?,  ?,  ?,  ?,  ?,   \n ");
				mergesql.append( "          ?,  ?,  ?,  ?,  ?,   \n ");
				mergesql.append( "          ?,  ?,  ?,  ?,  ?, ?,  \n ");
				mergesql.append( "          ?,  CURRENT_TIMESTAMP )   \n ");
				
				                
				for (int j = 0; j < rows.length; j++){
					//////////////////////////////////////////////////////////////////////////
					//if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					
						rows[j].setString(idxWRID, strUserid);
						
						//신규 생성 - A
						gsmt = conn.getGauceStatement(mergesql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxACCTNO);   
						gsmt.bindColumn(2,  idxDEALDT);
						gsmt.bindColumn(3,  idxACCTNO);   
						gsmt.bindColumn(4,  idxDEALDT);
						gsmt.bindColumn(5,  idxACCTCD);   
						gsmt.bindColumn(6,  idxREMARK);
						gsmt.bindColumn(7,  idxINAMT);   
						gsmt.bindColumn(8,  idxOUTAMT);
						gsmt.bindColumn(9,  idxBALAMT);   
						gsmt.bindColumn(10, idxFINAMT);
						gsmt.bindColumn(11, idxFOUTAMT);   
						gsmt.bindColumn(12, idxFBALAMT);
						gsmt.bindColumn(13, idxCURUNIT);   
						gsmt.bindColumn(14, idxEXRATE);
						gsmt.bindColumn(15, idxTRISSUE);   
						gsmt.bindColumn(16, idxDEDATE);
						gsmt.bindColumn(17, idxDETIME);
						gsmt.bindColumn(18, idxRESULT);   
						gsmt.bindColumn(19, idxRSTREMARK);
						gsmt.bindColumn(20, idxRSTSEQ);   
						gsmt.bindColumn(21, idxTEAM);
						gsmt.bindColumn(22, idxINRATE);   
						gsmt.bindColumn(23, idxCOSTCD);
						gsmt.bindColumn(24, idxWRID);
						
						gsmt.executeUpdate();
						gsmt.close();

						gsmt=null;
					//}
				} //for
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