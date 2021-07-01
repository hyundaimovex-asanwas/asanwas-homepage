package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h080001_t9 extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] strArrCN = new String[]{ "EMPNO","REQDT","SEQ","SUBJECT","FRDT",
																					"TODT","EDUDAY","EDUPLC","EDUINST","SGDT",
																					"SGID","APDT","APID","MEMO"
																				};
        int[] idx = new int[14];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.T_HEDUCATION " );
				InsertSql.append( " ( " );
				InsertSql.append( " EMPNO,REQDT,SEQ,SUBJECT,FRDT, ");
				InsertSql.append( " TODT,EDUDAY,EDUPLC,EDUINST,SGDT,");
				InsertSql.append( " SGID,APDT,APID,MEMO ");
				InsertSql.append( " ) ");
				InsertSql.append( "  VALUES " );
				InsertSql.append( " ( " );
				InsertSql.append( " '" + str1 + "',?,?,?,?,  " );
				InsertSql.append( " ?,?,?,?,?,  " );
				InsertSql.append( " ?,?,?,?  " );
				InsertSql.append( " ) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.T_HIASSUR " );
				UpdateSql.append( "		 SET SUBJECT = ?, ");
				UpdateSql.append( "		     FRDT = ?, ");
				UpdateSql.append( "		     TODT = ?, ");
				UpdateSql.append( "		     EDUDAY = ?, ");
				UpdateSql.append( "		     EDUPLC = ?, ");
				UpdateSql.append( "		     EDUINST = ?, ");
				UpdateSql.append( "		     SGDT = ?, ");
				UpdateSql.append( "		     SGID = ?, ");
				UpdateSql.append( "		     APDT = ?, ");
				UpdateSql.append( "		     APID = ?, ");
				UpdateSql.append( "		     MEMO = ?" );
				UpdateSql.append( "	 WHERE EMPNO = ? " );
				UpdateSql.append( "	   AND REQDT = ? ");
				UpdateSql.append( "		 AND SEQ = ? ");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM PAYROLL.T_HIASSUR " );
				DeleteSql.append( "	 WHERE EMPNO = ? " );
				UpdateSql.append( "	   AND REQDT = ? ");
				UpdateSql.append( "		 AND SEQ = ? ");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for (int k=1;k<idx.length;k++) gsmt.bindColumn(k, idx[k]);

						gsmt.executeUpdate(); 
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for (int k=3;k<idx.length;k++) gsmt.bindColumn(k, idx[k]);
						gsmt.bindColumn(12, idx[0]);
						gsmt.bindColumn(13, idx[1]);
						gsmt.bindColumn(14, idx[2]);

						gsmt.executeUpdate(); 
						gsmt.close();

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);

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