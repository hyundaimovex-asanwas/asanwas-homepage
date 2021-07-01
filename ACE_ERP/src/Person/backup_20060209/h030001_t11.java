package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h030001_t11 extends HttpServlet{

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

				String[] strArrCN = new String[]{ "EMPNO","SEQ","RECDT","REWGB","REWKIND"
																				};
        int[] idx = new int[5];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;


				int maxCnt = 0;
				StringBuffer sql = new StringBuffer();
				sql.append( " SELECT MAX(SEQ)+1 CNT ");
				sql.append( "   FROM PAYROLL.HIREWARD ");
				sql.append( "  WHERE EMPNO = '" + str1 + "'" );

				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql.toString());

				while (rs.next())	{
					maxCnt = rs.getInt(1);
				}

				if (rs!=null)	rs.close();
				if (stmt!=null) stmt.close();

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.HIREWARD " );
				InsertSql.append( " ( " );
				InsertSql.append( " EMPNO,SEQ,RECDT,REWGB,REWKIND ");
				InsertSql.append( " ) ");
				InsertSql.append( "  VALUES " );
				InsertSql.append( " ( " );
				InsertSql.append( " '" + str1 + "'," + maxCnt + ",?,?,?  " );
				InsertSql.append( " ) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.HIREWARD " );
				UpdateSql.append( "		 SET RECDT = ? ,REWGB = ?, REWKIND = ?  " );
				UpdateSql.append( "	 WHERE EMPNO = ? " );
				UpdateSql.append( "	   AND SEQ = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM PAYROLL.HIREWARD " );
				DeleteSql.append( "	 WHERE EMPNO = ? " );
				DeleteSql.append( "	   AND SEQ = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[2]);
						gsmt.bindColumn(2, idx[3]);
						gsmt.bindColumn(3, idx[4]);
						gsmt.executeUpdate(); 
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						for (int k=2;k<idx.length;k++) gsmt.bindColumn(k, idx[k]);
						gsmt.bindColumn(4, idx[0]);
						gsmt.bindColumn(5, idx[1]);
						gsmt.executeUpdate(); 
						gsmt.close();

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( " " );

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.executeUpdate();
						gsmt.close();
					}

				}
			}

			catch(Exception e){
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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