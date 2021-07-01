package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010006_t5 extends HttpServlet{
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

				//String str1 = reqGauce.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxBANCOD      = userSet.indexOfColumn("BANCOD");
				int idxBNKNUM      = userSet.indexOfColumn("BNKNUM");
				int idxBNKNAM      = userSet.indexOfColumn("BNKNAM");
				int idxACCTNONM    = userSet.indexOfColumn("ACCTNONM");
				int idxACCTNM      = userSet.indexOfColumn("ACCTNM");
				int idxATCODE      = userSet.indexOfColumn("ATCODE");
				int idxCOSTCD      = userSet.indexOfColumn("COSTCD");
				int idxEMPNO       = userSet.indexOfColumn("EMPNO");
				int idxTELNO       = userSet.indexOfColumn("TELNO");
				int idxFAXNO       = userSet.indexOfColumn("FAXNO");
				int idxHPNO        = userSet.indexOfColumn("HPNO");
				int idxOPENDT      = userSet.indexOfColumn("OPENDT");
				int idxDIRECT      = userSet.indexOfColumn("DIRECT");
				int idxCZIPCD      = userSet.indexOfColumn("CZIPCD");
				int idxCADDR01     = userSet.indexOfColumn("CADDR01");
				int idxCADDR02     = userSet.indexOfColumn("CADDR02");
				int idxDELDATE     = userSet.indexOfColumn("DELDATE");
				int idxDELNAME     = userSet.indexOfColumn("DELNAME");
				int idxCRTDATE     = userSet.indexOfColumn("CRTDATE");
				int idxCRTNAME     = userSet.indexOfColumn("CRTNAME");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.BANKACC (  									\n");
				InsertSql.append( " BANCOD,  BNKNUM,  BNKNAM, ACCTNONM, ACCTNM,  			\n");
				InsertSql.append( " ATCODE, COSTCD, EMPNO, TELNO, FAXNO, 						\n");
				InsertSql.append( " HPNO, OPENDT, DIRECT, CZIPCD, CADDR01, 						\n");
				InsertSql.append( " CADDR02, DELDATE, DELNAME, CRTDATE, CRTNAME )			\n");
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,? ) 					\n");
				


				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.BANKACC SET 										\n");
				UpdateSql.append( "        BNKNAM = ?,															\n");
				UpdateSql.append( "        ACCTNONM = ?,														\n");				
				UpdateSql.append( "        ACCTNM = ?,															\n");
				UpdateSql.append( "        ATCODE = ?,															\n");
				UpdateSql.append( "        COSTCD = ?,															\n");
				UpdateSql.append( "        EMPNO = ?,																\n");
				UpdateSql.append( "        TELNO = ?,																\n");
				UpdateSql.append( "        FAXNO = ?,																\n");
				UpdateSql.append( "        HPNO = ?,																\n");
				UpdateSql.append( "        OPENDT = ?,															\n");
				UpdateSql.append( "        DIRECT = ?,																\n");
				UpdateSql.append( "        CZIPCD = ?,																\n");
				UpdateSql.append( "        CADDR01 = ?,															\n");
				UpdateSql.append( "        CADDR02 = ?,															\n");
				UpdateSql.append( "        DELDATE = ?,															\n");
				UpdateSql.append( "        DELNAME = ?,															\n");
				UpdateSql.append( "        CRTDATE = ?,															\n");
				UpdateSql.append( "        CRTNAME = ? 															\n");
				UpdateSql.append( " WHERE RTRIM(BANCOD) = ? AND RTRIM(BNKNUM) = ? 		\n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.BANKACC 									\n");
				DeleteSql.append( "  WHERE RTRIM(BANCOD) = ? AND RTRIM(BNKNUM) = ? 		\n");

				//logger.dbg.println(this,InsertSql.toString()); //로고 남기기
				//logger.dbg.println(this,UpdateSql.toString());
				//logger.dbg.println(this,DeleteSql.toString());

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxBANCOD);
						gsmt.bindColumn(2, idxBNKNUM);
						gsmt.bindColumn(3, idxBNKNAM);
						gsmt.bindColumn(4, idxACCTNONM);
						gsmt.bindColumn(5, idxACCTNM);
						gsmt.bindColumn(6, idxATCODE);
						gsmt.bindColumn(7, idxCOSTCD);
						gsmt.bindColumn(8, idxEMPNO);
						gsmt.bindColumn(9, idxTELNO);
						gsmt.bindColumn(10, idxFAXNO);
						gsmt.bindColumn(11, idxHPNO);
						gsmt.bindColumn(12, idxOPENDT);
						gsmt.bindColumn(13, idxDIRECT);
						gsmt.bindColumn(14, idxCZIPCD);
						gsmt.bindColumn(15, idxCADDR01);
						gsmt.bindColumn(16, idxCADDR02);
						gsmt.bindColumn(17, idxDELDATE);
						gsmt.bindColumn(18, idxDELNAME);
						gsmt.bindColumn(19, idxCRTDATE);						
						gsmt.bindColumn(20, idxCRTNAME);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1, idxBNKNAM);
						gsmt.bindColumn(2, idxACCTNONM);
						gsmt.bindColumn(3, idxACCTNM);
						gsmt.bindColumn(4, idxATCODE);
						gsmt.bindColumn(5, idxCOSTCD);
						gsmt.bindColumn(6, idxEMPNO);
						gsmt.bindColumn(7, idxTELNO);
						gsmt.bindColumn(8, idxFAXNO);
						gsmt.bindColumn(9, idxHPNO);
						gsmt.bindColumn(10, idxOPENDT);
						gsmt.bindColumn(11, idxDIRECT);
						gsmt.bindColumn(12, idxCZIPCD);
						gsmt.bindColumn(13, idxCADDR01);
						gsmt.bindColumn(14, idxCADDR02);
						gsmt.bindColumn(15, idxDELDATE);
						gsmt.bindColumn(16, idxDELNAME);
						gsmt.bindColumn(17, idxCRTDATE);
						gsmt.bindColumn(18, idxCRTNAME);
						gsmt.bindColumn(19, idxBANCOD);
						gsmt.bindColumn(20, idxBNKNUM);
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxBANCOD);
						gsmt.bindColumn(2, idxBNKNUM);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
				logger.err.println(this,e.toString()); //
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