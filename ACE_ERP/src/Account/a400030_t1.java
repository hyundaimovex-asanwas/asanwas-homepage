package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a400030_t1 extends HttpServlet{
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
				
				System.out.println("# a400030_t1 START : \n" );
				
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
       
				GauceStatement gsmt = null;
				
				String strUserid = reqGauce.getParameter("v_str1");

				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");
							
				int idxDEDATE            = userSet.indexOfColumn("DEDATE");
				int idxACCTNO            = userSet.indexOfColumn("ACCTNO");
				int idxACCTCD            = userSet.indexOfColumn("ACCTCD");
				int idxREMARK            = userSet.indexOfColumn("REMARK");
				int idxBALAMTS           = userSet.indexOfColumn("BALAMTS");
				int idxFBALAMTS          = userSet.indexOfColumn("FBALAMTS");
				int idxCURUNIT           = userSet.indexOfColumn("CURUNIT");
				int idxACCTUSE           = userSet.indexOfColumn("ACCTUSE");
				int idxACCTGB            = userSet.indexOfColumn("ACCTGB");
				int idxBRCHCD            = userSet.indexOfColumn("BRCHCD");
				int idxDEPOGB            = userSet.indexOfColumn("DEPOGB");
				int idxINRATE            = userSet.indexOfColumn("INRATE");
				int idxCHKBOX            = userSet.indexOfColumn("CHKBOX");
				int idxWRID              = userSet.indexOfColumn("WRID");
				int idxUPID              = userSet.indexOfColumn("UPID");

				                
				GauceDataRow[] rows  = userSet.getDataRows();
				
				StringBuffer mergesql  = null;
				StringBuffer DeleteSql  = null;
				

				mergesql = new StringBuffer();
				mergesql.append( " MERGE INTO ACCOUNT.ACDPSUM MC \n ");
				mergesql.append( " USING DUAL \n ");
				mergesql.append( " ON (  MC.DEDATE = ? AND MC.ACCTNO =? ) \n ");
				mergesql.append( " WHEN MATCHED THEN \n ");
				mergesql.append( " UPDATE SET MC.BALAMTS=? ,\n ");
				mergesql.append( "            MC.FBALAMTS=?,  \n ");
				mergesql.append( "            MC.UPID=?,  \n ");
				mergesql.append( "            MC.UPDT= CURRENT_TIMESTAMP   \n ");
				mergesql.append( " WHEN NOT MATCHED THEN \n ");
				mergesql.append( " INSERT ( DEDATE,   ACCTNO, ACCTCD,  REMARK, BALAMTS, \n ");
				mergesql.append( "          FBALAMTS, CURUNIT,ACCTUSE, ACCTGB, BRCHCD,  DEPOGB,  \n ");
				mergesql.append( "          INRATE, CHKBOX,   WRID,  WRDT ) \n ");
				mergesql.append( " VALUES ( ?,  ?,  ?,  ?,  ?,   \n ");
				mergesql.append( "          ?,  ?,  ?,  ?,  ?,  ?,  \n ");
				mergesql.append( "          ?,  ?,  ?,  CURRENT_TIMESTAMP )   \n ");
				
				
				System.out.println("# a400030_t1 START : \n "  + mergesql.toString());
				                
				for (int j = 0; j < rows.length; j++){
					//////////////////////////////////////////////////////////////////////////
					//if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					
						rows[j].setString(idxWRID, strUserid);
						
						//신규 생성 - A
						gsmt = conn.getGauceStatement(mergesql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxDEDATE);   
						gsmt.bindColumn(2,  idxACCTNO);
						
						gsmt.bindColumn(3,  idxBALAMTS);   
						gsmt.bindColumn(4,  idxFBALAMTS);   
						gsmt.bindColumn(5,  idxWRID);
						
						gsmt.bindColumn(6,  idxDEDATE);   
						gsmt.bindColumn(7,  idxACCTNO);   
						gsmt.bindColumn(8,  idxACCTCD);   
						gsmt.bindColumn(9,  idxREMARK);   
						gsmt.bindColumn(10,  idxBALAMTS);   
						gsmt.bindColumn(11,  idxFBALAMTS);   
						gsmt.bindColumn(12,  idxCURUNIT);   
						gsmt.bindColumn(13, idxACCTUSE);   
						gsmt.bindColumn(14, idxACCTGB);
						gsmt.bindColumn(15, idxBRCHCD);
						gsmt.bindColumn(16, idxDEPOGB);   
						gsmt.bindColumn(17, idxINRATE);   
						gsmt.bindColumn(18, idxCHKBOX);   
						gsmt.bindColumn(19, idxWRID);    
						
						System.out.println("# a400030_t1 START : \n " );
						
						gsmt.executeUpdate();
						gsmt.close();

						System.out.println("# a400030_t1 end : \n " );
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