package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h020005_t1 extends HttpServlet{

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

				String[] strArrCN = new String[]{ "INFODIV","RESINO","WRDT","WRNO","NMK",
																					"PHOTO","BIRDT","GLDIV","HOBBY","NMC",
																					"RILIGN","NME","BIRCITY","SPECIAL","OZIPCD",
																					"OADDR1","OADDR2","CZIPCD","CADDR1","CADDR2",
																					"TELNO","HPNO","EMAIL","EYEL","EYER",
																					"HEIGHT","WEIGHT","BLOOD","RGHANDYN","MILIDIV",
																					"MILIKND","MILIGRD","MILINO","MILIPLC","MILIFRDT",
																					"MILITODT","NMREASON","MRYDT","DISDIV","DISGRD",
																					"MILITYPE","MRTDIV","MRTNO","REFCD","MILISPEC",
																					"ENGLVL","TOESCR","JPTSCR","DELFSCR","TOFSCR",
																					"DALFSCR","TEPSSCR","ETCLNG","HWGRDCD","EXGRDCD",
																					"PWGRDCD","ACGRDCD","INTDT","INTTM","INTATTYN",
																					"PASSDT","AMDT","EMPNO","AMKIND","LCSTYPE",
																					"LCSCD","PROSTS","BCHK","OADDR"
																				}; 
        int[] idx = new int[69];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer CancelSql = null;

				InsertSql = new StringBuffer();
				DeleteSql = new StringBuffer();
				CancelSql = new StringBuffer();

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						String vstr1		= rows[j].getString(idx[0]);
						String vstr2		= rows[j].getString(idx[1]);

						String strStat   = rows[j].getString(idx[66]);
						String strFlag   = rows[j].getString(idx[67]);
						String strAtt		= rows[j].getString(idx[59]);

						String striDt		= rows[j].getString(idx[57]);
						String striTm		= rows[j].getString(idx[58]);
						String strpDt		= rows[j].getString(idx[60]);

						if (strFlag.equals("T")) {
							if (strStat.equals("1")) strStat = "2";
							else if (strStat.equals("2")) strStat = "3";
						} else {
							strStat = "1";

							if (!strAtt.equals("0")) {
								strStat = "4";
								striDt = "";
								striTm = "";
								strpDt = "";
							} else {
								strStat = "1";
							}
						}

						UpdateSql = new StringBuffer();
						UpdateSql.append( "UPDATE PAYROLL.HRPERSON " );
						UpdateSql.append( "   SET PROSTS = '" + strStat + "', " );
						UpdateSql.append( "       INTDT = '" + striDt+ "', " );
						UpdateSql.append( "       INTTM = '" + striTm+ "', " );
						UpdateSql.append( "       INTATTYN = '" + strAtt + "', " );
						UpdateSql.append( "       PASSDT = '" + strpDt + "' " );
						UpdateSql.append( " WHERE INFODIV = '" + vstr1 + "' " );
						UpdateSql.append( "   AND RESINO = '" + vstr2 + "' " );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate(); 
						gsmt.close();
						UpdateSql = null;

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						String strStat    = rows[j].getString(idx[66]);
						String strFlag    = rows[j].getString(idx[67]);

						CancelSql.append( "UPDATE PAYROLL.HRPERSON " );
						if (strStat.equals("3")) {
							CancelSql.append( "   SET PROSTS = '2', " );
							CancelSql.append( "       PASSDT = '' " );
						} else if (strStat.equals("2")) {
							CancelSql.append( "   SET PROSTS = '1', " );
							CancelSql.append( "       INTDT = '', " );
							CancelSql.append( "       INTTM = '' " );
						}

						CancelSql.append( " WHERE INFODIV = ? " );
						CancelSql.append( "   AND RESINO = ? " );

						GauceStatement gsmt = conn.getGauceStatement(CancelSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.executeUpdate();
						gsmt.close();
						CancelSql=null;
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