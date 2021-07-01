package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h020001_t1 extends HttpServlet{

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
				GauceDataSet userCarr = reqGauce.getGauceDataSet("CARRER");

				String[] strArrCN = new String[]{ "INFODIV", "INFO", "CARRDIV", "RFRDT", "RTODT", 
																					"IFRDT", "ITODT", "PFRDT", "PTODT", "RMEMO", 
																					"IMEMO", "PMEMO", "NORMEMO"
																				}; 
        int[] idx = new int[13];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				String[] strArrCN2 = new String[]{ "INFODIV", "SEQ", "MAJORCD" }; 
        int[] idx2 = new int[3];
        for (int d=0; d<strArrCN2.length; d++) {
  				idx2[d] = userCarr.indexOfColumn(strArrCN2[d]);
				}

				GauceDataRow[] rows2 = userCarr.getDataRows();

				StringBuffer InsertSql	= null;
				StringBuffer UpdateSql	= null;
				StringBuffer DeleteSql	= null;
				StringBuffer InsertCarr = null;

				InsertSql		= new StringBuffer();
				
				int maxCnt = 0;
				String maxTot = "";
				String maxVal = "";
				StringBuffer sql = new StringBuffer();
				sql.append( " SELECT SUBSTR(MAX(INFODIV),5,2) MAXVAL FROM PAYROLL.HRINFO WHERE SUBSTR(INFODIV,1,4) = '" + str1 + "'");

				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql.toString());

				while (rs.next())	{
					maxTot = rs.getString(1);
				}

				if (maxTot==null) {
					maxVal = str1 + "01";
				} else {
					maxCnt = Integer.parseInt(maxTot) + 1;
					if (maxCnt<10) maxVal = str1 + "0" + maxCnt;
					else maxVal = str1 + maxCnt;
				}

				if (rs!=null)	rs.close();
				if (stmt!=null) stmt.close();

				InsertSql.append( " INSERT INTO PAYROLL.HRINFO " );
				InsertSql.append( " ( " );
				InsertSql.append( " INFODIV, INFO, CARRDIV, RFRDT, RTODT, "); 
				InsertSql.append( " IFRDT, ITODT, PFRDT, PTODT, RMEMO, "); 
				InsertSql.append( " IMEMO, PMEMO, NORMEMO " );
				InsertSql.append( " ) " );
				InsertSql.append( "  VALUES " );
				InsertSql.append( " ( " );
				InsertSql.append( " '" + maxVal + "',?,?,?,?, " );
				InsertSql.append( " ?,?,?,?,?, " );
				InsertSql.append( " ?,?,? " );
				InsertSql.append( " ) " );

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						for (int k=1;k<13;k++) gsmt.bindColumn(k, idx[k]);
						gsmt.executeUpdate(); 
						gsmt.close();

						for (int f = 0; f < rows2.length; f++){
							if(rows2[f].getJobType() == GauceDataRow.TB_JOB_INSERT) {
								InsertCarr	= new StringBuffer();
								InsertCarr.append(" INSERT INTO PAYROLL.HRMAJOR ( " );
								InsertCarr.append("			INFODIV, SEQ, MAJORCD ) ");
								InsertCarr.append(" VALUES ( ");
								InsertCarr.append("			'" + maxVal + "'," + f + ",? ) ");
								
								GauceStatement gstmt = conn.getGauceStatement(InsertCarr.toString());
								gstmt.setGauceDataRow(rows2[f]);
								gstmt.bindColumn(1, idx2[2]);
								gstmt.executeUpdate(); 
								gstmt.close();
								InsertCarr=null;
							}
						}
					}
	
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
	
						String strInfodiv = rows[j].getString(idx[0]);
	
						UpdateSql		= new StringBuffer();
						UpdateSql.append( " UPDATE PAYROLL.HRINFO " );
						UpdateSql.append( "    SET INFO = ?, " );
						UpdateSql.append( "        CARRDIV = ?, " );
						UpdateSql.append( "        RFRDT = ?, " );
						UpdateSql.append( "        RTODT = ?, " );	
						UpdateSql.append( "        IFRDT = ?, " );	
						UpdateSql.append( "        ITODT = ?, " );
						UpdateSql.append( "        PFRDT = ?, " );
						UpdateSql.append( "        PTODT = ?, " );
						UpdateSql.append( "        RMEMO = ?, " );
						UpdateSql.append( "        IMEMO = ?, " );
						UpdateSql.append( "        PMEMO = ?, " );
						UpdateSql.append( "        NORMEMO = ? " );
						UpdateSql.append( "  WHERE INFODIV = '" + strInfodiv + "' " );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						for (int t=1;t<13;t++) gsmt.bindColumn(t, idx[t]);
						gsmt.executeUpdate();
						gsmt.close();
						UpdateSql=null;
	
						StringBuffer query = new StringBuffer();
						int maxSeq = 0;

						query.append( " SELECT MAX(SEQ)+1 FROM PAYROLL.HRMAJOR WHERE INFODIV = '" + strInfodiv + "' ");

						stmt = conn.createStatement();
						rs = stmt.executeQuery(query.toString());

						while (rs.next())	{
							maxSeq = rs.getInt(1);
						}
						
						if (maxSeq<1) maxSeq = 0;
						else maxSeq = maxSeq;

						for (int f = 0; f < rows2.length; f++){
							if(rows2[f].getJobType() == GauceDataRow.TB_JOB_INSERT) {
								InsertCarr	= new StringBuffer();
								InsertCarr.append(" INSERT INTO PAYROLL.HRMAJOR ( " );
								InsertCarr.append("			INFODIV, SEQ, MAJORCD ) ");
								InsertCarr.append(" VALUES ( ");
								InsertCarr.append("			'" + strInfodiv + "'," + maxSeq + ",? ) ");
								
								GauceStatement gstmt = conn.getGauceStatement(InsertCarr.toString());
								gstmt.setGauceDataRow(rows2[f]);
								gstmt.bindColumn(1, idx2[2]);
								gstmt.executeUpdate(); 
								gstmt.close();
								InsertCarr=null;
								maxSeq++;
							}

							if(rows2[f].getJobType() == GauceDataRow.TB_JOB_DELETE) {
								InsertCarr	= new StringBuffer();
								InsertCarr.append(" DELETE FROM PAYROLL.HRMAJOR  " );
								InsertCarr.append("	 WHERE INFODIV = '" + strInfodiv + "' ");
								InsertCarr.append("    AND SEQ = ? ");
								
								GauceStatement gstmt = conn.getGauceStatement(InsertCarr.toString());
								gstmt.setGauceDataRow(rows2[f]);
								gstmt.bindColumn(1, idx2[1]);
								gstmt.executeUpdate(); 
								gstmt.close();
								InsertCarr=null;
							}
						}
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						String strInfodiv = rows[j].getString(idx[0]);	

						DeleteSql		= new StringBuffer();
						DeleteSql.append( " DELETE FROM PAYROLL.HRINFO " );
						DeleteSql.append( "  WHERE INFODIV = '" + strInfodiv + "' " );
						
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						DeleteSql=null;
	
						DeleteSql		= new StringBuffer();
						DeleteSql.append( " DELETE FROM PAYROLL.HRMAJOR " );
						DeleteSql.append( "  WHERE INFODIV = '" + strInfodiv + "' " );
						
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();
						DeleteSql=null;
					}
				}

				if (stmt!=null) stmt.close();
				if (rs!=null)	rs.close();

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