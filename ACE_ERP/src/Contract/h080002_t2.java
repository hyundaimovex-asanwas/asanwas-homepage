package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h080002_t2 extends HttpServlet{

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

				String[] strArrCN = new String[]{ "EMPNO","STDYY","SEQ","FRDT","ENDDT",
																					"ETC"
																				};
        int[] idx = new int[6];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.T_HIHOLID " );
				InsertSql.append( " ( " );
				InsertSql.append( " EMPNO,STDYY,SEQ,FRDT,ENDDT,ETC ");
				InsertSql.append( " ) ");
				InsertSql.append( "  VALUES " );
				InsertSql.append( " ( " );
				InsertSql.append( " '" + str1 + "',?,?,?,?,?  " );
				InsertSql.append( " ) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.T_HIHOLID " );
				UpdateSql.append( "		 SET FRDT = ?, ");
				UpdateSql.append( "		     ENDDT = ?, ");
				UpdateSql.append( "		     ETC = ? ");
				UpdateSql.append( "	 WHERE EMPNO = ? ");
				UpdateSql.append( "	   AND STDYY = ? ");
				UpdateSql.append( "	   AND SEQ = ? ");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM PAYROLL.T_HIHOLID " );
				DeleteSql.append( "	 WHERE EMPNO = ? " );
				DeleteSql.append( "	   AND STDYY = ? ");
				DeleteSql.append( "	   AND SEQ = ? ");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[1]);
						gsmt.bindColumn(2, idx[2]);
						gsmt.bindColumn(3, idx[3]);
						gsmt.bindColumn(4, idx[4]);
						gsmt.bindColumn(5, idx[5]);

						gsmt.executeUpdate(); 
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[3]);
						gsmt.bindColumn(2, idx[4]);
						gsmt.bindColumn(3, idx[5]);
						gsmt.bindColumn(4, idx[0]);
						gsmt.bindColumn(5, idx[1]);
						gsmt.bindColumn(6, idx[2]);

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