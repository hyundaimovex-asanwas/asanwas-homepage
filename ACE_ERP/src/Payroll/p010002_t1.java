package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p010002_t1 extends HttpServlet{

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
				String str2 = req.getParameter("v_str2");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxEMPNO		= userSet.indexOfColumn("EMPNO");
				int idxPAYDIV		= userSet.indexOfColumn("PAYDIV");
				int idxPBDIV		= userSet.indexOfColumn("PBDIV");
				int idxPAYCD		= userSet.indexOfColumn("PAYCD");
				int idxFRDT			= userSet.indexOfColumn("FRDT");
				int idxTODT			= userSet.indexOfColumn("TODT");
				int idxPAYAMT		= userSet.indexOfColumn("PAYAMT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.PCEXCEPT ( " );
				InsertSql.append( "EMPNO, PAYDIV, PBDIV, PAYCD, FRDT, TODT, PAYAMT " );
				InsertSql.append( ") VALUES ( " );
				InsertSql.append( "?, ?, ?, ?,'"+str1+"01"+"', '"+str2+"31"+"',? ) " );
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.PCEXCEPT SET " );
				UpdateSql.append( " FRDT = ?, " );
				UpdateSql.append( " TODT = ?,  " );
				UpdateSql.append( " PAYAMT = ?  " );
				UpdateSql.append( " WHERE EMPNO = ? AND PAYDIV = ? AND PBDIV = ? AND PAYCD = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PCEXCEPT WHERE EMPNO = ? AND PAYDIV = ? AND PBDIV = ? AND PAYCD = ? " );
 
				for (int j = 0; j < rows.length; j++) {

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
										
						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxPAYDIV);
						gsmt.bindColumn(3, idxPBDIV);
						gsmt.bindColumn(4, idxPAYCD);
						gsmt.bindColumn(5, idxPAYAMT);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxFRDT);
						gsmt.bindColumn(2, idxTODT);
						gsmt.bindColumn(3, idxPAYAMT);
						gsmt.bindColumn(4, idxEMPNO);
						gsmt.bindColumn(5, idxPAYDIV);
						gsmt.bindColumn(6, idxPBDIV);
						gsmt.bindColumn(7, idxPAYCD);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxPAYDIV);
						gsmt.bindColumn(3, idxPBDIV);
						gsmt.bindColumn(4, idxPAYCD);
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