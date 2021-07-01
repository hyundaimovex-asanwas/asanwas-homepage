package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h100003_t1 extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxSTDYM		= userSet.indexOfColumn("STDYM");		//적용년월
				int idxPAYGRD		= userSet.indexOfColumn("PAYGRD");	//직위
				int idxPAYSEQ		= userSet.indexOfColumn("PAYSEQ");	//호봉
				int idxBASAMT		= userSet.indexOfColumn("BASAMT");	//기본급
				int idxECTAMT		= userSet.indexOfColumn("ECTAMT");	//시간외
				int idxMONAMT		= userSet.indexOfColumn("MONAMT");	//월급여
				int idxTIMAMT		= userSet.indexOfColumn("TIMAMT");	//시급  
				int idxSAGAMT		= userSet.indexOfColumn("SAGAMT");	//상여  
				int idxYERAMT		= userSet.indexOfColumn("YERAMT");	//연봉  

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.T_PCPAYTBL ( " );
				InsertSql.append( "STDYM,	PAYGRD, PAYSEQ, BASAMT, ECTAMT, MONAMT, TIMAMT, SAGAMT, YERAMT " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( "?, ?, ?, ?, ?, ?, ?, ?, ? ) " );
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.T_PCPAYTBL SET " );
				UpdateSql.append( " BASAMT = ?, " );
				UpdateSql.append( " ECTAMT = ?, " );
				UpdateSql.append( " MONAMT = ?, " );
				UpdateSql.append( " TIMAMT = ?, " );
				UpdateSql.append( " SAGAMT = ?, " );
				UpdateSql.append( " YERAMT = ?  " );
				UpdateSql.append( " WHERE STDYM = ? AND PAYGRD = ? AND PAYSEQ = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.T_PCPAYTBL WHERE STDYM = ? AND PAYGRD = ? " ); //AND PAYSEQ = ? 

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxSTDYM);
						gsmt.bindColumn(2, idxPAYGRD);
						gsmt.bindColumn(3, idxPAYSEQ);
						gsmt.bindColumn(4, idxBASAMT);
						gsmt.bindColumn(5, idxECTAMT);
						gsmt.bindColumn(6, idxMONAMT);
						gsmt.bindColumn(7, idxTIMAMT);
						gsmt.bindColumn(8, idxSAGAMT);
						gsmt.bindColumn(9, idxYERAMT);

						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxBASAMT);
						gsmt.bindColumn(2, idxECTAMT);
						gsmt.bindColumn(3, idxMONAMT);
						gsmt.bindColumn(4, idxTIMAMT);
						gsmt.bindColumn(5, idxSAGAMT);
						gsmt.bindColumn(6, idxYERAMT);
						gsmt.bindColumn(7, idxSTDYM);
						gsmt.bindColumn(8, idxPAYGRD);
						gsmt.bindColumn(9, idxPAYSEQ);

						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxSTDYM);
						gsmt.bindColumn(2, idxPAYGRD);
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