package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h080001_t7 extends HttpServlet{

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

				String[] strArrCN = new String[]{ "EMPNO","ORDDT","SEQ","ORDCD","DEPTCD",
																					"PAYGRD","PAYSEQ","ENDDT","APPDT","JOBKIND",
																					"BASICPAY","GRDDIV"
																				};
        int[] idx = new int[12];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer UpdateSql2 = null;
			
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM PAYROLL.T_HOORDER " );
				DeleteSql.append( "	 WHERE EMPNO = ? " );
				DeleteSql.append( "	   AND ORDDT = ? " );
				DeleteSql.append( "	   AND SEQ = ? " );

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
						InsertSql.append( " EMPNO,ORDDT,SEQ,ORDCD,DEPTCD, ");
						InsertSql.append( " PAYGRD,PAYSEQ,ENDDT,APPDT,JOBKIND, ");
						InsertSql.append( " BASICPAY,GRDDIV ");
						InsertSql.append( " ) ");
						InsertSql.append( "  VALUES " );
						InsertSql.append( " ( " );
						InsertSql.append( " '" + str1 + "',?," + maxCnt + ",?,?,  " );
						InsertSql.append( " ?,?,?,?,?,  " );
						InsertSql.append( " ?,?  " );
						InsertSql.append( " ) " );
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idx[1]);
						gsmt.bindColumn(2, idx[3]);
						gsmt.bindColumn(3, idx[4]);
						gsmt.bindColumn(4, idx[5]);
						gsmt.bindColumn(5, idx[6]);
						gsmt.bindColumn(6, idx[7]);
						gsmt.bindColumn(7, idx[8]);
						gsmt.bindColumn(8, idx[9]);
						gsmt.bindColumn(9, idx[10]);
						gsmt.bindColumn(10, idx[11]);
						gsmt.executeUpdate(); 
						gsmt.close();
						InsertSql = null;

						//�λ� - �μ�,����,ȣ��,���� ����
						StringBuffer InsertSql3 = null;
						InsertSql3 = new StringBuffer();
						InsertSql3.append( " UPDATE PAYROLL.T_HIPERSON " );
						InsertSql3.append( "	SET DEPTCD = ?, PAYGRD = ?, PAYSEQ = ?, GRDDIV = ?, ORDDT = ?  " );
						InsertSql3.append( " WHERE EMPNO = '"+str1+"' " );

						GauceStatement gsmt3 = conn.getGauceStatement(InsertSql3.toString());
						gsmt3.setGauceDataRow(rows[j]);

						gsmt3.bindColumn(1, idx[4]);
						gsmt3.bindColumn(2, idx[5]);
						gsmt3.bindColumn(3, idx[6]);
						gsmt3.bindColumn(4, idx[11]);
						gsmt3.bindColumn(5, idx[1]);

						gsmt3.executeUpdate(); 
						gsmt3.close();
						InsertSql3=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE PAYROLL.T_HOORDER " );
						UpdateSql.append( "		 SET ORDCD = ?, DEPTCD = ?, ");
						UpdateSql.append( "				 PAYGRD = ?, PAYSEQ = ?, ENDDT = ?, APPDT = ?, JOBKIND = ?, ");
						UpdateSql.append( "				 BASICPAY = ?, GRDDIV = ? " );
						UpdateSql.append( "	 WHERE EMPNO = ? " );
						UpdateSql.append( "	   AND ORDDT = ? " );
						UpdateSql.append( "	   AND SEQ = ? " );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for (int k=3;k<idx.length;k++) {
							gsmt.bindColumn(k-2, idx[k]);
						}
						gsmt.bindColumn(10,  idx[0]);
						gsmt.bindColumn(11, idx[1]);
						gsmt.bindColumn(12, idx[2]);
						gsmt.executeUpdate(); 
						gsmt.close();

						//�λ� - �μ�,����,ȣ��,���� ����
						UpdateSql2 = new StringBuffer();
						UpdateSql2.append( " UPDATE PAYROLL.T_HIPERSON " );
						UpdateSql2.append( "	  SET DEPTCD = ?, PAYGRD = ?, PAYSEQ = ?, GRDDIV = ?, ORDDT = ? " );
						UpdateSql2.append( " WHERE  EMPNO = '"+str1+"' " );

						//�λ� - �μ�,����,ȣ�� ����
						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.bindColumn(1, idx[4]);
						gsmt2.bindColumn(2, idx[5]);
						gsmt2.bindColumn(3, idx[6]);
						gsmt2.bindColumn(4, idx[11]);
						gsmt2.bindColumn(5, idx[1]);
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