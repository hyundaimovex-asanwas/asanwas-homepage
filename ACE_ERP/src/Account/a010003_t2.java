package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010003_t2 extends HttpServlet{
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

				int idxCOCODE      = userSet.indexOfColumn("COCODE");
				int idxCONAME      = userSet.indexOfColumn("CONAME");
				int idxCOROWNO     = userSet.indexOfColumn("COROWNO");
				int idxCOSANG      = userSet.indexOfColumn("COSANG");
				int idxCOMANAGER   = userSet.indexOfColumn("COMANAGER");
			
				int idxCOID        = userSet.indexOfColumn("COID");
				int idxCOTEL	     = userSet.indexOfColumn("COTEL");
				int idxCOFAX       = userSet.indexOfColumn("COFAX");
				int idxCOUPTAI     = userSet.indexOfColumn("COUPTAI");

				int idxCOJONMOCK   = userSet.indexOfColumn("COJONMOCK");
				int idxCOADDRNO    = userSet.indexOfColumn("COADDRNO");
				int idxCOADDR1     = userSet.indexOfColumn("COADDR1");
				int idxCOADDR2     = userSet.indexOfColumn("COADDR2");

				int idxCOSTRDAT    = userSet.indexOfColumn("COSTRDAT");
				int idxCOMON       = userSet.indexOfColumn("COMON");
				int idxCOENDDAT    = userSet.indexOfColumn("COENDDAT");
				int idxCOTAXCOD    = userSet.indexOfColumn("COTAXCOD");

				int idxCOTAXNAM    = userSet.indexOfColumn("COTAXNAM");
				int idxWRDT        = userSet.indexOfColumn("WRDT");
				int idxWRID        = userSet.indexOfColumn("WRID");
				int idxUPDT        = userSet.indexOfColumn("UPDT");

				int idxUPID        = userSet.indexOfColumn("UPID");
				int idxDSUDT       = userSet.indexOfColumn("DSUDT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.COMPANY          (  											\n");
				InsertSql.append( " COCODE, CONAME, COROWNO, COSANG,  COMANAGER,   					\n");
				InsertSql.append( " COID, COTEL, COFAX, COUPTAI,            												\n");
				InsertSql.append( " COJONMOCK, COADDRNO, COADDR1, COADDR2,  								\n");
				InsertSql.append( " COSTRDAT, COMON, COENDDAT, COTAXCOD,    									\n");
				InsertSql.append( " COTAXNAM, WRDT, WRID, DSUDT	         )  										\n");
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,'" + str1 + "','" +str2+"',? ) 		\n");

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.COMPANY SET	 													\n");
				UpdateSql.append( "	       CONAME = ?,																			\n");			
				UpdateSql.append( "        COROWNO = ?,																		\n");
				UpdateSql.append( "        COSANG = ?,																			\n");
				UpdateSql.append( "        COMANAGER = ?,																		\n");
				UpdateSql.append( "        COID = ?,																				\n");
				UpdateSql.append( "        COTEL = ?,																				\n");
				UpdateSql.append( "        COFAX = ?,																				\n");
				UpdateSql.append( "        COUPTAI = ?,																			\n");
				UpdateSql.append( "        COJONMOCK = ?,																		\n");
				UpdateSql.append( "        COADDRNO = ?,																		\n");
				UpdateSql.append( "        COADDR1 = ?,																			\n");
				UpdateSql.append( "        COADDR2 = ?,																			\n");
				UpdateSql.append( "        COSTRDAT = ?,																		\n");
				UpdateSql.append( "        COMON = ?,																			\n");
				UpdateSql.append( "        COENDDAT = ?,																		\n");
				UpdateSql.append( "        COTAXCOD = ?,																		\n");
				UpdateSql.append( "        COTAXNAM = ?,																		\n");
				UpdateSql.append( "        UPDT = '" + str1 + "',																	\n");
				UpdateSql.append( "        UPID = '" + str2 + "',																	\n");
				UpdateSql.append( "        DSUDT = ? 																				\n");
				UpdateSql.append( " WHERE COCODE = ? 																		\n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.COMPANY 													\n");
				DeleteSql.append( " WHERE COCODE= ? 																		\n");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
			
						gsmt.bindColumn(1,  idxCOCODE);
						gsmt.bindColumn(2,  idxCONAME);
						gsmt.bindColumn(3,  idxCOROWNO);
						gsmt.bindColumn(4,  idxCOSANG);
						gsmt.bindColumn(5,  idxCOMANAGER);
						gsmt.bindColumn(6,  idxCOID);
						gsmt.bindColumn(7,  idxCOTEL);
						gsmt.bindColumn(8,  idxCOFAX);
						gsmt.bindColumn(9,  idxCOUPTAI);
						gsmt.bindColumn(10,  idxCOJONMOCK);
						gsmt.bindColumn(11, idxCOADDRNO);
						gsmt.bindColumn(12, idxCOADDR1);
						gsmt.bindColumn(13, idxCOADDR2);
						gsmt.bindColumn(14, idxCOSTRDAT);
						gsmt.bindColumn(15, idxCOMON);
						gsmt.bindColumn(16, idxCOENDDAT);
						gsmt.bindColumn(17, idxCOTAXCOD);
						gsmt.bindColumn(18, idxCOTAXNAM);
						gsmt.bindColumn(19, idxDSUDT);


						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxCONAME);
						gsmt.bindColumn(2,  idxCOROWNO);
						gsmt.bindColumn(3,  idxCOSANG);
						gsmt.bindColumn(4,  idxCOMANAGER);
						gsmt.bindColumn(5,  idxCOID);

						gsmt.bindColumn(6,  idxCOTEL);
						gsmt.bindColumn(7,  idxCOFAX);
						gsmt.bindColumn(8,  idxCOUPTAI);
						gsmt.bindColumn(9,  idxCOJONMOCK);

						gsmt.bindColumn(10,  idxCOADDRNO);
						gsmt.bindColumn(11, idxCOADDR1);
						gsmt.bindColumn(12, idxCOADDR2);
						gsmt.bindColumn(13, idxCOSTRDAT);

						gsmt.bindColumn(14, idxCOMON);
						gsmt.bindColumn(15, idxCOENDDAT);
						gsmt.bindColumn(16, idxCOTAXCOD);
						gsmt.bindColumn(17, idxCOTAXNAM);

						gsmt.bindColumn(18, idxDSUDT);
						gsmt.bindColumn(19, idxCOCODE);

						
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxCOCODE);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
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