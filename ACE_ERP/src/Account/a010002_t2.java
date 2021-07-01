package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010002_t2 extends HttpServlet{
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

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1");
				String str2 = reqGauce.getParameter("v_str2");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
          
				int idxATCODE  = userSet.indexOfColumn("ATCODE");       		
				int idxARSEQ   = userSet.indexOfColumn("ARSEQ");
				int idxCDCODE  = userSet.indexOfColumn("CDCODE");
				int idxARDEYN  = userSet.indexOfColumn("ARDEYN");
				int idxARCRYN   = userSet.indexOfColumn("ARCRYN");
				int idxARBALDIV = userSet.indexOfColumn("ARBALDIV");
				int idxCDNAM    = userSet.indexOfColumn("CDNAM");
				int idxWRDT     = userSet.indexOfColumn("WRDT");
				int idxWRID     = userSet.indexOfColumn("WRID");
				int idxUPDT     = userSet.indexOfColumn("UPDT");
				int idxUPID     = userSet.indexOfColumn("UPID");
				int idxDSUDT    = userSet.indexOfColumn("DSUDT");
				int idxTYPE     = userSet.indexOfColumn("TYPE");

                
				GauceDataRow[] rows = userSet.getDataRows();


				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ACTREFCODE ( 																			\n");
				InsertSql.append( " ATCODE,	ARSEQ,	CDCODE, ARDEYN,	ARCRYN, ARBALDIV,  WRDT,	WRID,	DSUDT, TYPE ) 	\n");
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,'" + str1 + "','" +str2+"',?,?) 																\n");				

				//logger.dbg.println(this,InsertSql.toString());

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ACTREFCODE SET 	\n");
				UpdateSql.append( "        CDCODE = ?,								\n");
				UpdateSql.append( "        ARDEYN = ?,								\n");
				UpdateSql.append( "        ARCRYN = ?,								\n");
				UpdateSql.append( "        ARBALDIV = ?,								\n");
				UpdateSql.append( "        UPDT = '" + str1 + "',						\n");
				UpdateSql.append( "        UPID = '" + str2 +"',						\n");
				UpdateSql.append( "        DSUDT= ?,									\n");
				UpdateSql.append( "        TYPE = ?										\n");
				UpdateSql.append( " WHERE ATCODE= ?								\n");
				UpdateSql.append( "   AND ARSEQ= ?									\n");				

				//logger.dbg.println(this,UpdateSql.toString());

				DeleteSql = new StringBuffer();
				
				DeleteSql.append( " DELETE FROM ACCOUNT.ACTREFCODE 		\n");
				DeleteSql.append( "  WHERE ATCODE= ?									\n");
				DeleteSql.append( "    AND ARSEQ= ?										\n");

				
				//logger.dbg.println(this,DeleteSql.toString());
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {							

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxATCODE);
						gsmt.bindColumn(2, idxARSEQ);
						gsmt.bindColumn(3, idxCDCODE);
						gsmt.bindColumn(4, idxARDEYN);
						gsmt.bindColumn(5, idxARCRYN);
						gsmt.bindColumn(6, idxARBALDIV);
						gsmt.bindColumn(7, idxDSUDT);
						gsmt.bindColumn(8, idxTYPE);
						gsmt.executeUpdate();
						gsmt.close();
					}

				
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCDCODE);
						gsmt.bindColumn(2, idxARDEYN);
						gsmt.bindColumn(3, idxARCRYN);
						gsmt.bindColumn(4, idxARBALDIV);
						gsmt.bindColumn(5, idxDSUDT);
						gsmt.bindColumn(6, idxTYPE);
						gsmt.bindColumn(7, idxATCODE);
						gsmt.bindColumn(8, idxARSEQ);
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxATCODE);
						gsmt.bindColumn(2, idxARSEQ);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
				logger.err.println(this,e);
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

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