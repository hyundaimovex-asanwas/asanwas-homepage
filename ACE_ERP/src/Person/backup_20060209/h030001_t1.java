package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.io.PrintStream;
import java.io.PrintWriter;

public class h030001_t1 extends HttpServlet{

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

				String[] strArrCN = new String[]{ "EMPNO","REGDIV","EMPNMK","CARRDIV","RECDIV",
																					"EMPDIV","FRDT","TODT","PAYDIV","RESINO",
																					"PICTURE","GRSTRTDT","STRTDT","DEPTCD","PAYGRD",
																					"JOBGRPH","JOBDTY","GRDDIV","PAYSEQ","FSAMDT",
																					"ENDDT","USESTS","COSTDIV","DPOFFDT","LAMDT",
																					"LRMDT","BIRDT","GLDIV","HOBBY","NMC",
																					"RILIGN","NME","BIRCITY","SPECIAL","OZIPCD",
																					"OADDR01","OADDR02","CZIPCD","CADDR01","CADDR02",
																					"TELNO","HPNO","OFFTELNO","EMAIL","HDFAMNM",
																					"HDFAMRET","HDFAMJOB","LABUNIYN","RELESAMT","MOVESAMT",
																					"MRTDIV","MRTNO","REFCD","PAYBNKCD","PAYACNT",
																					"HOUSDIV","MRYDT","ENGLVL","TOESCR","JPTSCR",
																					"DELFSCR","TOFSCR","DALFSCR","TEPSSCR","ETCLNG",
																					"HWGRDCD","EXGRDCD","PWGRDCD","ACGRDCD","PICFILE",
																					"ORDDT","HITCHYN","RELATNM","RELATGRD","RELATRE",
																					"NOMINNM","NOMINGRD","NOMINRE","HSKSCR",							//79

																					"AFRDT","ATODT","ASSAMT","ASSINST",
																					"ASSGB","ASSNO","RECPAMT","DISDIV","DISGRD",
																					"HOSDT","HOSPITAL","HOSREVIT","HOSMEMO","EYEL",
																					"EYER","HEIGHT","WEIGHT","BLOOD","COLBLNYN",
																					"RHANDYN","MILIDIV","MILIKND","MILIGRD","MILINO",
																					"MILIPLC","MILIFRDT","MILITODT","NMREASON","MILITYPE",
																					"MILISPEC","MILIGBN","MILITGBN","ASSNAME","ASSRELA",
																					"ASSRESINO","ASSTELNO","ASSPOSTNO","ASSADDR",
																					"DISDNM","DISGNM","MILDNM",
																					"MILGNM","MILSNM","MILTNM",
																					"MILHNM","COLBNM","SEX","TRAINYN",									//+=127
																					"JOBKIND","INSCOD","PENCOD"													//51  += 130

				};
        int[] idx = new int[130];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				UpdateSql = new StringBuffer();
				
				String maxCnt = "";
				StringBuffer sql = null;
				Statement stmt = null;
				ResultSet rs = null;

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						String vchk = rows[j].getString(idx[0]);

						if (vchk.equals("")) {
							maxCnt = "0000";
							sql = new StringBuffer();
							sql.append( " SELECT MAX(SUBSTR(EMPNO,4,4)) CNT FROM PAYROLL.HIPERSON WHERE SUBSTR(EMPNO,2,2) = '" + str1 + "'" );

							stmt = conn.createStatement();
							rs = stmt.executeQuery(sql.toString());

							while (rs.next())	{
								maxCnt = rs.getString(1);
							}

							if (rs!=null)	rs.close();
							if (stmt!=null) stmt.close();

							if (maxCnt!=null){
								if (!maxCnt.equals("0000")) {
									int ichk = Integer.parseInt(maxCnt);
									ichk++;
									if (ichk<10) maxCnt = "2" + str1 + "000" + ichk;
									else if (ichk<100 && ichk>9) maxCnt = "2" + str1 + "00" + ichk;
									else if (ichk<1000 && ichk>99) maxCnt = "2" + str1 + "0" + ichk;
									else if (ichk>999) maxCnt = "2" + str1 + ichk;
								} else {
									maxCnt = "2" + str1 + "0001";
								}
							} else {
									maxCnt = "2" + str1 + "0001";
							}
						} else {
							maxCnt = vchk;
						}

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO PAYROLL.HIPERSON " );
						InsertSql.append( " ( " );
						InsertSql.append( " EMPNO,REGDIV,EMPNMK,CARRDIV,RECDIV, " );
						InsertSql.append( " EMPDIV,FRDT,TODT,PAYDIV,RESINO, " );
						InsertSql.append( " PICTURE,GRSTRTDT,STRTDT,DEPTCD,PAYGRD, " );
						InsertSql.append( " JOBGRPH,JOBDTY,GRDDIV,PAYSEQ,FSAMDT, " );
						InsertSql.append( " ENDDT,USESTS,COSTDIV,DPOFFDT,LAMDT, " );
						InsertSql.append( " LRMDT,BIRDT,GLDIV,HOBBY,NMC, " );
						InsertSql.append( " RILIGN,NME,BIRCITY,SPECIAL,OZIPCD, " );
						InsertSql.append( " OADDR01,OADDR02,CZIPCD,CADDR01,CADDR02, " );
						InsertSql.append( " TELNO,HPNO,OFFTELNO,EMAIL,HDFAMNM, " );
						InsertSql.append( " HDFAMRET,HDFAMJOB,LABUNIYN,RELESAMT,MOVESAMT, " );
						InsertSql.append( " MRTDIV,MRTNO,REFCD,PAYBNKCD,PAYACNT, " );
						InsertSql.append( " HOUSDIV,MRYDT,ENGLVL,TOESCR,JPTSCR, " );
						InsertSql.append( " DELFSCR,TOFSCR,DALFSCR,TEPSSCR,ETCLNG, " );
						InsertSql.append( " HWGRDCD,EXGRDCD,PWGRDCD,ACGRDCD,PICFILE, " );
						InsertSql.append( " ORDDT,HITCHYN,RELATNM,RELATGRD,RELATRE, ");
						InsertSql.append( " NOMINNM,NOMINGRD,NOMINRE,HSKSCR,SEX, " );
						InsertSql.append( " TRAINYN, JOBKIND, INSCOD, PENCOD " );
						InsertSql.append( " ) " );
						InsertSql.append( "  VALUES " );
						InsertSql.append( " ( " );
						InsertSql.append( " '" + maxCnt + "',?,?,?,?, " );
//						InsertSql.append( " '" + rows[j].getString(idx[0]) + "',?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?) " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for (int s=1;s<79;s++) {
							if (s==69) {
								InputStream nst_file = (InputStream) rows[j].getInputStream(idx[s]);
								gsmt.setBinaryStream(s, nst_file, nst_file.available() );	 //첨부파일
							} else {
								gsmt.bindColumn(s, idx[s]);
							}
						}

						gsmt.bindColumn(79, idx[125]);
						gsmt.bindColumn(80, idx[126]);
						gsmt.bindColumn(81, idx[127]);
						gsmt.bindColumn(82, idx[128]);
						gsmt.bindColumn(83, idx[129]);
						gsmt.executeUpdate(); 
						gsmt.close();
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE PAYROLL.HIPERSON " );
						UpdateSql.append( "		 SET REGDIV = ?, EMPNMK = ?, CARRDIV = ?, RECDIV = ?, " );
						UpdateSql.append( "				 EMPDIV = ?,FRDT = ?,TODT = ?,PAYDIV = ?,RESINO = ?, " );
						UpdateSql.append( "				 PICTURE = ?,GRSTRTDT = ?,STRTDT = ?,DEPTCD = ?,PAYGRD = ?, " );
						UpdateSql.append( "				 JOBGRPH = ?,JOBDTY = ?,GRDDIV = ?,PAYSEQ = ?,FSAMDT = ?, " );
						UpdateSql.append( "				 ENDDT = ?,USESTS = ?,COSTDIV = ?,DPOFFDT = ?,LAMDT = ?, " );
						UpdateSql.append( "				 LRMDT = ?,BIRDT = ?,GLDIV = ?,HOBBY = ?,NMC = ?, " );
						UpdateSql.append( "				 RILIGN = ?,NME = ?,BIRCITY = ?,SPECIAL = ?,OZIPCD = ?, " );
						UpdateSql.append( "				 OADDR01 = ?,OADDR02 = ?,CZIPCD = ?,CADDR01 = ?,CADDR02 = ?, " );
						UpdateSql.append( "				 TELNO = ?,HPNO = ?,OFFTELNO = ?,EMAIL = ?,HDFAMNM = ?, " );
						UpdateSql.append( "				 HDFAMRET = ?,HDFAMJOB = ?,LABUNIYN = ?,RELESAMT = ?,MOVESAMT = ?, " );
						UpdateSql.append( "				 MRTDIV = ?,MRTNO = ?,REFCD = ?,PAYBNKCD = ?,PAYACNT = ?, " );
						UpdateSql.append( "				 HOUSDIV = ?,MRYDT = ?,ENGLVL = ?,TOESCR = ?,JPTSCR = ?, " );
						UpdateSql.append( "				 DELFSCR = ?,TOFSCR = ?,DALFSCR = ?,TEPSSCR = ?,ETCLNG = ?, " );
						UpdateSql.append( "				 HWGRDCD = ?,EXGRDCD = ?,PWGRDCD = ?,ACGRDCD = ?, " );
						UpdateSql.append( "				 ORDDT = ?,HITCHYN = ?,RELATNM = ?,RELATGRD = ?,RELATRE = ?, ");
						UpdateSql.append( "				 NOMINNM = ?,NOMINGRD = ?,NOMINRE = ?, HSKSCR = ?, SEX = ?, ");
						UpdateSql.append( "				 TRAINYN = ?, JOBKIND = ?,INSCOD = ?,PENCOD = ? ");
						UpdateSql.append( " WHERE EMPNO = ? " );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for (int s=1;s<79;s++) {
							if (s>69) gsmt.bindColumn(s-1, idx[s]);
							else if (s<69) gsmt.bindColumn(s, idx[s]);
						}
						gsmt.bindColumn(78, idx[125]);
						gsmt.bindColumn(79, idx[126]);
						gsmt.bindColumn(80, idx[127]);
						gsmt.bindColumn(81, idx[128]);
						gsmt.bindColumn(82, idx[129]);
						gsmt.bindColumn(83, idx[0]);

						gsmt.executeUpdate(); 
						gsmt.close();

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM PAYROLL.HIPERSON ");
						DeleteSql.append( "  WHERE EMPNO = ? ");

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
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