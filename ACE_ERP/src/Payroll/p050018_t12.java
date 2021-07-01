package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050018_t12 extends HttpServlet{

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

				String str1 = req.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxEMPNO	= userSet.indexOfColumn("EMPNO");		//사번 1
				int idxAPPDT	= userSet.indexOfColumn("APPDT");			//대출일 2
				int idxAPLDT	= userSet.indexOfColumn("APLDT");			//상환일 3
				int idxAPLCNT	= userSet.indexOfColumn("APLCNT");		//상환횟수 4
				int idxAPPAMT	= userSet.indexOfColumn("APPAMT");		//대출금 5
				int idxAPBAMT	= userSet.indexOfColumn("APBAMT");		//상환전잔액 6
				int idxAPLAMT	= userSet.indexOfColumn("APLAMT");		//상환원금 7
				int idxAPJAMT	= userSet.indexOfColumn("APJAMT");		//상환후잔액 8
				int idxRATAMT	= userSet.indexOfColumn("RATAMT");		//상환이자 9
				int idxCALAMT	= userSet.indexOfColumn("CALAMT");		//상환이자 10
				int idxREASON	= userSet.indexOfColumn("REASON");		//대출사유 11

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;


				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.PWCOLOAN (																						\n");
				InsertSql.append( " EMPNO, APPDT, APLDT, APLCNT, APPAMT, APBAMT, APLAMT, APJAMT, RATAMT, CALAMT, REASON	\n");
				InsertSql.append( ") VALUES(																															\n");
				InsertSql.append( " ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? )																								\n");
  

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.PWCOLOAN SET										\n");
				UpdateSql.append( " APLCNT= ?,																		\n");
				UpdateSql.append( " APPAMT= ?,																	\n");
				UpdateSql.append( " APBAMT= ?,																	\n");
				UpdateSql.append( " APLAMT= ?,																	\n");
				UpdateSql.append( " APJAMT= ?,																		\n");
				UpdateSql.append( " RATAMT= ?,																	\n");
				UpdateSql.append( " CALAMT= ?,																	\n");
				UpdateSql.append( " REASON= ?																		\n");
				UpdateSql.append( " WHERE EMPNO = ? AND APPDT = ? AND APLDT = ?					\n");


				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PWCOLOAN WHERE EMPNO = '"+ str1 +"'			\n");


				for (int j = 0; j < rows.length; j++){
						
					if(j>=1) {
						if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idxEMPNO);
							gsmt.bindColumn(2, idxAPPDT);
							gsmt.bindColumn(3, idxAPLDT);
							gsmt.bindColumn(4, idxAPLCNT);
							gsmt.bindColumn(5, idxAPPAMT);
							gsmt.bindColumn(6, idxAPBAMT);
							gsmt.bindColumn(7, idxAPLAMT);
							gsmt.bindColumn(8, idxAPJAMT);
							gsmt.bindColumn(9, idxRATAMT);			
							gsmt.bindColumn(10, idxCALAMT);									
							gsmt.bindColumn(11, idxREASON);
							gsmt.executeUpdate();
							gsmt.close();
						}
					}

					if(j<1) {
						if(rows[j].getJobType() != GauceDataRow.TB_JOB_UPDATE) {
							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idxAPLCNT);
							gsmt.bindColumn(2, idxAPPAMT);
							gsmt.bindColumn(3, idxAPBAMT);
							gsmt.bindColumn(4, idxAPLAMT);
							gsmt.bindColumn(5, idxAPJAMT);
							gsmt.bindColumn(6, idxRATAMT);			
							gsmt.bindColumn(7, idxCALAMT);									
							gsmt.bindColumn(8, idxREASON);
							gsmt.bindColumn(9, idxEMPNO);
							gsmt.bindColumn(10, idxAPPDT);
							gsmt.bindColumn(11, idxAPLDT);

							gsmt.executeUpdate(); 
							gsmt.close();         

						}
					}
						

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());

						//logger.dbg.println(this,DeleteSql.toString());

						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);

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