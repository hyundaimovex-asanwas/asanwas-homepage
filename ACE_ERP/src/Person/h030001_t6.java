package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h030001_t6 extends HttpServlet{

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

				String[] strArrCN = new String[]{ "EMPNO","AFRDT","ATODT","ASSAMT","ASSINST",
																					"ASSGB","ASSNO","RECPAMT","DISDIV","DISGRD",
																					"HOSDT","HOSPITAL","HOSREVIT","HOSMEMO","EYEL",
																					"EYER","HEIGHT","WEIGHT","BLOOD","COLBLNYN",
																					"RHANDYN","MILIDIV","MILIKND","MILIGRD","MILINO",
																					"MILIPLC","MILIFRDT","MILITODT","NMREASON","MILITYPE",
																					"MILISPEC","MILIGBN","MILITGBN","ASSNAME","ASSRELA",
																					"ASSRESINO","ASSTELNO","ASSPOSTNO","ASSADDR"
																				};
        int[] idx = new int[39];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.HIASSUR " );
				InsertSql.append( " ( " );
				InsertSql.append( " EMPNO,FRDT,TODT,ASSAMT,ASSINST, ");
				InsertSql.append( " ASSGB,ASSNO,RECPAMT,DISDIV,DISGRD, ");
				InsertSql.append( " HOSDT,HOSPITAL,HOSREVIT,HOSMEMO,EYEL, ");
				InsertSql.append( " EYER,HEIGHT,WEIGHT,BLOOD,COLBLNYN, ");
				InsertSql.append( " RHANDYN,MILIDIV,MILIKND,MILIGRD,MILINO, ");
				InsertSql.append( " MILIPLC,MILIFRDT,MILITODT,NMREASON,MILITYPE, ");
				InsertSql.append( " MILISPEC,MILIGBN,MILITGBN,ASSNAME,ASSRELA, ");
				InsertSql.append( " ASSRESINO,ASSTELNO,ASSPOSTNO,ASSADDR ");
				InsertSql.append( " ) ");
				InsertSql.append( "  VALUES " );
				InsertSql.append( " ( " );
				InsertSql.append( " '" + str1 + "',?,?,?,?,  " );
				InsertSql.append( " ?,?,?,?,?,  " );
				InsertSql.append( " ?,?,?,?,?,  " );
				InsertSql.append( " ?,?,?,?,?,  " );
				InsertSql.append( " ?,?,?,?,?,  " );
				InsertSql.append( " ?,?,?,?,?,  " );
				InsertSql.append( " ?,?,?,?,?,  " );
				InsertSql.append( " ?,?,?,?  " );
				InsertSql.append( " ) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.HIASSUR " );
				UpdateSql.append( "		 SET FRDT = ?, TODT = ?, ASSAMT = ?, ASSINST = ?,  " );
				UpdateSql.append( "				 ASSGB = ?, ASSNO = ?, RECPAMT = ?, DISDIV = ?, DISGRD = ?,  " );
				UpdateSql.append( "				 HOSDT = ?, HOSPITAL = ?, HOSREVIT = ?, HOSMEMO = ?, EYEL = ?,  " );
				UpdateSql.append( "				 EYER = ?, HEIGHT = ?, WEIGHT = ?, BLOOD = ?, COLBLNYN = ?,  " );
				UpdateSql.append( "				 RHANDYN = ?, MILIDIV = ?, MILIKND = ?, MILIGRD = ?, MILINO = ?,  " );
				UpdateSql.append( "				 MILIPLC = ?, MILIFRDT = ?, MILITODT = ?, NMREASON = ?, MILITYPE = ?,  " );
				UpdateSql.append( "				 MILISPEC = ?, MILIGBN = ?, MILITGBN = ?,ASSNAME = ?, ASSRELA = ?, ");
				UpdateSql.append( "				 ASSRESINO = ?, ASSTELNO = ?, ASSPOSTNO = ?, ASSADDR = ? " );
				UpdateSql.append( "	 WHERE EMPNO = ? " );

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

						for (int k=1;k<idx.length;k++) gsmt.bindColumn(k, idx[k]);
						gsmt.bindColumn(39, idx[0]);

						gsmt.executeUpdate(); 
						gsmt.close();

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( " " );

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
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