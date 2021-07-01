package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h080002_t6 extends HttpServlet{

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

				if (str1==null) str1 = "";

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] strArrCN = new String[]{ "EMPNO","ORDDT","SEQ","DEPTCD",
																					"JOBKIND","BASICPAY"
																				};
        int[] idx = new int[6];
				for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				StringBuffer UpdateSql2 = null;

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.T_HOORDER " );
				UpdateSql.append( "		SET  ");
				UpdateSql.append( "			  DEPTCD = ?, JOBKIND = ?, BASICPAY = ? ");
				UpdateSql.append( "	WHERE EMPNO = ? " );
				UpdateSql.append( "	  AND ORDDT = ? " );
				UpdateSql.append( "	  AND SEQ = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM PAYROLL.T_HOORDER " );
				DeleteSql.append( "	 WHERE EMPNO = ? AND ORDDT = ? AND SEQ = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						String strOrddt = rows[j].getString(idx[1]);
						int maxCnt = 0;

						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT MAX(SEQ)+1 CNT ");
						sql.append( "   FROM PAYROLL.T_HOORDER ");
						sql.append( "  WHERE EMPNO = '" + str1 + "'" );
						sql.append( "    AND ORDDT = '" + strOrddt + "'" );

						Statement stmt = conn.createStatement();
						ResultSet rs = stmt.executeQuery(sql.toString());

						while (rs.next())	{
							maxCnt = rs.getInt(1);
						}

						if (rs!=null)	rs.close();
						if (stmt!=null) stmt.close();

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO PAYROLL.T_HOORDER " );
						InsertSql.append( " ( " );
						InsertSql.append( " EMPNO,ORDDT,SEQ,DEPTCD, ");
						InsertSql.append( " JOBKIND, BASICPAY ");
						InsertSql.append( " ) ");
						InsertSql.append( "  VALUES " );
						InsertSql.append( " ( " );
						InsertSql.append( " '" + str1 + "',?," + maxCnt + ",?,  " );
						InsertSql.append( " ?,?  " );
						InsertSql.append( " ) " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[1]);
						gsmt.bindColumn(2, idx[3]);
						gsmt.bindColumn(3, idx[4]);
						gsmt.bindColumn(4, idx[5]);
						gsmt.executeUpdate(); 
						gsmt.close();
						InsertSql = null;

						//인사 - 직종 저장
						StringBuffer InsertSql3 = null;
						InsertSql3 = new StringBuffer();
						InsertSql3.append( " UPDATE PAYROLL.T_HIPERSON " );
						InsertSql3.append( "	SET JOBKIND = ? " );
						InsertSql3.append( " WHERE EMPNO = '"+str1+"' " );

						GauceStatement gsmt3 = conn.getGauceStatement(InsertSql3.toString());
						gsmt3.setGauceDataRow(rows[j]);

						gsmt3.bindColumn(1, idx[4]);

						gsmt3.executeUpdate(); 
						gsmt3.close();
						
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						for (int k=3;k<idx.length;k++) gsmt.bindColumn(k-2, idx[k]);
						gsmt.bindColumn(4, idx[0]);
						gsmt.bindColumn(5, idx[1]);
						gsmt.bindColumn(6, idx[2]);
						gsmt.executeUpdate(); 
						gsmt.close();

						//인사 - 부서,직위,호봉 저장
						UpdateSql2 = new StringBuffer();
						UpdateSql2.append( " UPDATE PAYROLL.T_HIPERSON " );
						UpdateSql2.append( "	 SET JOBKIND = ? " );
						UpdateSql2.append( " WHERE EMPNO = '"+str1+"' " );

						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);

						gsmt2.bindColumn(1, idx[4]);

						gsmt2.executeUpdate(); 
						gsmt2.close();

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