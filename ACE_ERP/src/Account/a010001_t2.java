package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010001_t2 extends HttpServlet{

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

				String str1 = reqGauce.getParameter("v_str1");
				String str2 = reqGauce.getParameter("v_str2");
				String str3 = reqGauce.getParameter("v_str3");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxCMTYPE   = userSet.indexOfColumn("CMTYPE");
				int idxCDCODE    = userSet.indexOfColumn("CDCODE");
				int idxCDNAM    = userSet.indexOfColumn("CDNAM");
				int idxCDREMARK = userSet.indexOfColumn("CDREMARK");
				int idxWRDT     = userSet.indexOfColumn("WRDT");
				int idxWRID     = userSet.indexOfColumn("WRID");
				int idxUPDT     = userSet.indexOfColumn("UPDT");
				int idxUPID     = userSet.indexOfColumn("UPID");
				int idxDSUDT    = userSet.indexOfColumn("DSUDT");
				int idxPSEQ     = userSet.indexOfColumn("PSEQ");
				int idxGBCD     = userSet.indexOfColumn("GBCD");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.COMMDTIL (  																		\n");
				InsertSql.append( " CMTYPE,	CDCODE,	CDNAM,	CDREMARK,	WRDT,	WRID,	DSUDT, PSEQ, GBCD ) 	\n");
				InsertSql.append( " VALUES ( ?,?,?,?,'" + str1 + "','" +str2+"',?,?,? ) 															\n");				

  
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.COMMDTIL SET 		\n");
				UpdateSql.append( "        CDNAM = ?,									\n");
				UpdateSql.append( "        CDREMARK = ?,							\n");
				UpdateSql.append( "        UPDT = '" + str1 + "',						\n");;
				UpdateSql.append( "        UPID = '" + str2 +"',						\n");;
				UpdateSql.append( "        DSUDT= ?,									\n");
				UpdateSql.append( "        PSEQ = ?,									\n");
				UpdateSql.append( "        GBCD = ?									\n");
				UpdateSql.append( " WHERE CMTYPE= ?								\n");
				UpdateSql.append( "   AND CDCODE= ?								\n");


				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.COMMDTIL 		\n");
				DeleteSql.append( "  WHERE CMTYPE= ?								\n");
				DeleteSql.append( "    AND CDCODE= ?								\n");				

				//logger.dbg.println(this,DeleteSql.toString());
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCMTYPE);
						gsmt.bindColumn(2, idxCDCODE);
						gsmt.bindColumn(3, idxCDNAM);
						gsmt.bindColumn(4, idxCDREMARK);
						gsmt.bindColumn(5, idxDSUDT);
						gsmt.bindColumn(6, idxPSEQ);
						gsmt.bindColumn(7, idxGBCD);
						gsmt.executeUpdate();
						gsmt.close();

						if(rows[j].getString(idxCMTYPE).equals("0050")){

								String  sql10 = "  INSERT INTO ACCOUNT.COMMLIST ( "
															+ "  CMTYPE,	CMNAM,	CMLEN,	CMREMARK,	WRDT,	WRID,	DSUDT "
															+ "  ) VALUES ( "
															+ "  '"+rows[j].getString(idxCDCODE)+"',"
															+ "  '"+rows[j].getString(idxCDNAM)+"',"
															+ "  0,"
															+ "  '',"
															+ "  '"+str1+"',"
															+ "  '"+str2+"',"
															+ "  '')";
															
								//logger.dbg.println(this,"sql10" +sql10);

								GauceStatement gsmt10= conn.getGauceStatement(sql10);
								gsmt10.executeUpdate();
								gsmt10.close();
						}

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCDNAM);
						gsmt.bindColumn(2, idxCDREMARK);
						gsmt.bindColumn(3, idxDSUDT);
						gsmt.bindColumn(4, idxPSEQ);
						gsmt.bindColumn(5, idxGBCD);
						gsmt.bindColumn(6, idxCMTYPE);
						gsmt.bindColumn(7, idxCDCODE);
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCMTYPE);
						gsmt.bindColumn(2, idxCDCODE);
						gsmt.executeUpdate();
						gsmt.close();
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