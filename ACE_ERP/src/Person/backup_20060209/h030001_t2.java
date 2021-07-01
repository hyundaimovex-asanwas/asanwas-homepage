package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h030001_t2 extends HttpServlet{

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

				String[] strArrCN = new String[]{ "EMPNO","SEQ","RESINO","FAMNM","REFCD",
																					"SCHNM","CMPNM","LSTEDC","LIVEYN","GETYN",
																					"PAYYN","DISYN","SPTYN","MEDINYN","EDUEXYN"
																				};
        int[] idx = new int[15];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				UpdateSql = new StringBuffer();
				
				int maxCnt = 0;

				StringBuffer sql = new StringBuffer();
				sql.append( " SELECT MAX(SEQ)+1 CNT FROM PAYROLL.HIFAMILY WHERE EMPNO = '" + str1 + "'" );

				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql.toString());

				while (rs.next())	{
					maxCnt = rs.getInt(1);
				}

				if (rs!=null)	rs.close();
				if (stmt!=null) stmt.close();

				if (maxCnt==0) maxCnt = 0;

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO PAYROLL.HIFAMILY " );
						InsertSql.append( " ( " );
						InsertSql.append( " EMPNO,SEQ,RESINO,FAMNM,REFCD, ");
						InsertSql.append( " SCHNM,CMPNM,LSTEDC,LIVEYN,GETYN, ");
						InsertSql.append( " PAYYN,DISYN,SPTYN,MEDINYN,EDUEXYN " );
						InsertSql.append( " ) " );
						InsertSql.append( "  VALUES " );
						InsertSql.append( " ( " );
						InsertSql.append( " '" + str1 + "'," + maxCnt + ",?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?) " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[2]);
						gsmt.bindColumn(2, idx[3]);
						gsmt.bindColumn(3, idx[4]);
						gsmt.bindColumn(4, idx[5]);
						gsmt.bindColumn(5, idx[6]);
						gsmt.bindColumn(6, idx[7]);
						gsmt.bindColumn(7, idx[8]);
						gsmt.bindColumn(8, idx[9]);
						gsmt.bindColumn(9, idx[10]);
						gsmt.bindColumn(10, idx[11]);
						gsmt.bindColumn(11, idx[12]);
						gsmt.bindColumn(12, idx[13]);
						gsmt.bindColumn(13, idx[14]);
						gsmt.executeUpdate(); 
						gsmt.close();
						maxCnt++;
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE PAYROLL.HIFAMILY " );
						UpdateSql.append( "		 SET RESINO = ?, " );
						UpdateSql.append( "				 FAMNM = ?, ");
						UpdateSql.append( "				 REFCD = ?, ");
						UpdateSql.append( "				 SCHNM = ?, ");
						UpdateSql.append( "				 CMPNM = ?, ");
						UpdateSql.append( "				 LSTEDC = ?, ");
						UpdateSql.append( "				 LIVEYN = ?, ");
						UpdateSql.append( "				 GETYN = ?, ");
						UpdateSql.append( "				 PAYYN = ?, ");
						UpdateSql.append( "				 DISYN = ?, ");
						UpdateSql.append( "				 SPTYN = ?, ");
						UpdateSql.append( "				 MEDINYN = ?, ");
						UpdateSql.append( "				 EDUEXYN = ? ");
						UpdateSql.append( "  WHERE EMPNO = ? " );
						UpdateSql.append( "    AND SEQ = ? " );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[2]);
						gsmt.bindColumn(2, idx[3]);
						gsmt.bindColumn(3, idx[4]);
						gsmt.bindColumn(4, idx[5]);
						gsmt.bindColumn(5, idx[6]);
						gsmt.bindColumn(6, idx[7]);
						gsmt.bindColumn(7, idx[8]);
						gsmt.bindColumn(8, idx[9]);
						gsmt.bindColumn(9, idx[10]);
						gsmt.bindColumn(10, idx[11]);
						gsmt.bindColumn(11, idx[12]);
						gsmt.bindColumn(12, idx[13]);
						gsmt.bindColumn(13, idx[14]);
						gsmt.bindColumn(14, idx[0]);
						gsmt.bindColumn(15, idx[1]);
						gsmt.executeUpdate(); 
						gsmt.close();

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM PAYROLL.HIFAMILY ");
						DeleteSql.append( "  WHERE EMPNO = '" + str1 + "' ");
						DeleteSql.append( "    AND SEQ = ? ");

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[1]);
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
