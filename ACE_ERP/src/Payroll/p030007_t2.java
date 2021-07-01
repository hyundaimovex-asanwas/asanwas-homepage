package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p030007_t2 extends HttpServlet{

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

				int idxYYYY			= userSet.indexOfColumn("YYYY");			//귀속년도
				int idxEMPNO		= userSet.indexOfColumn("EMPNO");			//사번
				int idxGIVDATE	= userSet.indexOfColumn("GIVDATE");		//기부년월
				int idxGIVCOD   = userSet.indexOfColumn("GIVCOD");		//코드
				int idxGIVTYPE  = userSet.indexOfColumn("GIVTYPE");		//유형
				int idxGIVGMOK  = userSet.indexOfColumn("GIVGMOK");		//과목
				int idxGIVJYO   = userSet.indexOfColumn("GIVJYO");		//적요
				int idxGIVCOMP  = userSet.indexOfColumn("GIVCOMP");		//상호
				int idxGIVSAUP  = userSet.indexOfColumn("GIVSAUP");		//사업자번호
				int idxGIVAMT   = userSet.indexOfColumn("GIVAMT");		//금액
				int idxGIVCNT   = userSet.indexOfColumn("GIVCNT");		//건수
				int idxGIVREF		= userSet.indexOfColumn("GIVREF");		//비고

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.YCGIBU ( ");
				InsertSql.append( " YYYY,			EMPNO,	 GIVDATE,	 GIVCOD,  GIVTYPE, ");
				InsertSql.append( " GIVGMOK,  GIVJYO,  GIVCOMP,  GIVSAUP, GIVAMT,  GIVCNT,  GIVREF");
				InsertSql.append( ") VALUES( " );
				InsertSql.append( " ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) " );
				
				UpdateSql = new StringBuffer();                      
				UpdateSql.append( "UPDATE PAYROLL.YCGIBU SET "); 	 
				UpdateSql.append( " GIVTYPE	= ?, ");								 
				UpdateSql.append( " GIVGMOK = ?, ");								 
				UpdateSql.append( " GIVJYO	= ?, ");								
				UpdateSql.append( " GIVCOMP = ?, ");								 
				UpdateSql.append( " GIVSAUP = ?, ");								 
				UpdateSql.append( " GIVAMT	= ?, ");								
				UpdateSql.append( " GIVCNT	= ?, ");								
				UpdateSql.append( " GIVREF  = ?  ");								 
				UpdateSql.append( " WHERE YYYY = ? AND EMPNO = ? AND GIVDATE = ? AND GIVCOD = ? ");

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.YCGIBU WHERE YYYY = ? AND EMPNO = ? AND GIVDATE = ? AND GIVCOD = ? ");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxYYYY);
						gsmt.bindColumn(2,  idxEMPNO);
						gsmt.bindColumn(3,  idxGIVDATE);
						gsmt.bindColumn(4,  idxGIVCOD);
						gsmt.bindColumn(5,  idxGIVTYPE);
						gsmt.bindColumn(6,  idxGIVGMOK);
						gsmt.bindColumn(7,  idxGIVJYO);
						gsmt.bindColumn(8,  idxGIVCOMP);
						gsmt.bindColumn(9,  idxGIVSAUP);
						gsmt.bindColumn(10, idxGIVAMT);
						gsmt.bindColumn(11, idxGIVCNT);
						gsmt.bindColumn(12, idxGIVREF);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxGIVTYPE);
						gsmt.bindColumn(2,  idxGIVGMOK);
						gsmt.bindColumn(3,  idxGIVJYO);
						gsmt.bindColumn(4,  idxGIVCOMP);
						gsmt.bindColumn(5,  idxGIVSAUP);
						gsmt.bindColumn(6,	idxGIVAMT);
						gsmt.bindColumn(7,	idxGIVCNT);
						gsmt.bindColumn(8,	idxGIVREF);
						gsmt.bindColumn(9,  idxYYYY);
						gsmt.bindColumn(10, idxEMPNO);
						gsmt.bindColumn(11, idxGIVDATE);
						gsmt.bindColumn(12, idxGIVCOD);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxYYYY);
						gsmt.bindColumn(2,  idxEMPNO);
						gsmt.bindColumn(3,  idxGIVDATE);
						gsmt.bindColumn(4,  idxGIVCOD);
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