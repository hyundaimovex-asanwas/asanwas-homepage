package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.http.*;

public class a040058_t6 extends HttpServlet{
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
	 		
	 		Integer int_Seq=0;

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				String str1 = reqGauce.getParameter("v_str1");			

				GauceStatement gsmt=null;
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				int idxTAXNBR    = userSet.indexOfColumn("TAXNBR");        //
				int idxSEQ       = userSet.indexOfColumn("SEQ");           //
				int idxTAXSTS    = userSet.indexOfColumn("TAXSTS");        //
				int idxSB_REASON = userSet.indexOfColumn("SB_REASON");     //

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
						Statement stmt= conn.createStatement();
						StringBuffer sql = new StringBuffer();
						
						sql.append( " SELECT NVL(MAX(SEQ),0)+1 SEQ	FROM ACCOUNT.ATTAXHIS WHERE TAXNBR ='"+rows[j].getString(idxTAXNBR)+"' ");
						
						ResultSet rs = stmt.executeQuery(sql.toString()); 
						if(rs.next()){
							int_Seq= rs.getInt(1);
						}
						rs.close();
						stmt.close();
						
						rows[j].setInt(idxSEQ,int_Seq);
						
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.ATTAXHIS (               \n" );
						InsertSql.append( " TAXNBR, SEQ, TAXSTS, SB_REASON, WRDT,WRID    \n" );
						InsertSql.append( " ) VALUES (                                   \n" );
						InsertSql.append( " ?,?,?,?,CURRENT_TIMESTAMP,'"+str1+"'         \n" );
						InsertSql.append( " )                                            \n" );
				
						gsmt = conn.getGauceStatement(InsertSql.toString());
				
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxTAXNBR);
						gsmt.bindColumn(2, idxSEQ);
						gsmt.bindColumn(3, idxTAXSTS);
						gsmt.bindColumn(4, idxSB_REASON);

						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;    
						InsertSql=null;
					}//if
				}//for
			}
			catch(Exception e)
				{
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				logger.err.println(this,e.toString()); //
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