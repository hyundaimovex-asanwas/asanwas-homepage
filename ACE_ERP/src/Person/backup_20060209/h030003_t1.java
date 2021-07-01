package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h030003_t1 extends HttpServlet{

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

				String[] strArrCN = new String[]{ "EMPNO","EMPNMK", "PAYGNM","DEPTNM","CERTINO",
																					"CERDATE","CERKIND","CERUSE","CERNUM","CERETC",
																					"OADDR","CADDR","RESINO","STRTDT","ENDDT",
																					"CURDT","CERPLC","CERFR","CERTO","CERDAT",
																					"DEPTCD","PAYGRD","PREDEPT","JOBDTYNM","ORDDT",
																					"RCVNM"
																				};

				int[] idx = new int[26];

				for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				UpdateSql = new StringBuffer();

				Statement stmt = null;
				ResultSet rs = null;

				String strEmpno = "";
				String strCertino = "";
				String strCerkind	= "";
				String strCeruse	= "";
				String strCernum	= "";
				String strCeretc	= "";
				String strCerplc	= "";
				String strCerfr		= "";
				String strCerto		= "";
				String strDeptcd	= "";
				String strPaygrd	= "";
				String strPredept = "";
				String strJobdtynm  = "";
				String strOrddt	 = "";
				String strRcvnm	 = "";

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						strEmpno    = rows[j].getString(idx[0]);
						strCerkind	= rows[j].getString(idx[6]);
						strCeruse		= rows[j].getString(idx[7]);
						strCernum		= rows[j].getString(idx[8]);
						strCeretc		= rows[j].getString(idx[9]);
						strCerplc		= rows[j].getString(idx[16]);
						strCerfr		= rows[j].getString(idx[17]);
						strCerto		= rows[j].getString(idx[18]);
						strDeptcd		= rows[j].getString(idx[20]);
						strPaygrd		= rows[j].getString(idx[21]);
						strPredept  = rows[j].getString(idx[22]);
						strJobdtynm = rows[j].getString(idx[23]);
						strOrddt		= rows[j].getString(idx[24]);
						strRcvnm		= rows[j].getString(idx[25]);

						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT CAST(MAX(CERTINO) AS INTEGER)+1 CNT ");
						sql.append( " FROM PAYROLL.HICERTI ");
            sql.append( " WHERE CERKIND  = '" + strCerkind + "' ");
            sql.append( " AND SUBSTR(CERDATE,1,4) = SUBSTR('" + str1 + "',1,4) ");

						//sql.append( "  WHERE EMPNO = '" + strEmpno + "' ");
						//sql.append( "      AND SUBSTR(CERDATE,1,6) = SUBSTR('" + str1 + "',1,6) ");

						stmt = conn.createStatement();

						rs = stmt.executeQuery(sql.toString());

						while (rs.next())	{
							strCertino = rs.getInt(1) + "";
						}

						if (strCertino==null||strCertino.length()<8) strCertino = str1.substring(0,4) + "0001";
						else strCertino = strCertino + "";

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO PAYROLL.HICERTI " );
						InsertSql.append( " ( " );
						InsertSql.append( "		EMPNO, CERTINO, CERDATE, CERKIND, CERUSE, " );
						InsertSql.append( "		CERNUM, CERETC, CERPLC, CERFR, CERTO, " );
						InsertSql.append( "		DEPTCD,PAYGRD,PREDEPT,JOBDTYNM,ORDDT, " );
						InsertSql.append( "   RCVNM " );
						InsertSql.append( " ) " );
						InsertSql.append( "  VALUES " );
						InsertSql.append( " ( " );
						InsertSql.append( " '" + strEmpno + "','" + strCertino + "','" + str1 + "','" + strCerkind + "','" + strCeruse + "', " );
						InsertSql.append( " " + strCernum + ",'" + strCeretc + "','" + strCerplc +"','" + strCerfr + "','" + strCerto + "', ");
						InsertSql.append( " '" + strDeptcd + "','" + strPaygrd + "','" + strPredept +"','" + strJobdtynm + "','" + strOrddt + "', ");
						InsertSql.append( " '" + strRcvnm + "' " );
						InsertSql.append( " ) " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate(); 
						gsmt.close();

						InsertSql=null;
						strCertino = "";

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						strEmpno    = rows[j].getString(idx[0]);
						strCertino   = rows[j].getString(idx[4]);

						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM PAYROLL.HICERTI ");
						DeleteSql.append( "  WHERE EMPNO = '" + strEmpno + "' ");
						DeleteSql.append( "    AND CERTINO = '" + strCertino + "' ");

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();
						DeleteSql=null;
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