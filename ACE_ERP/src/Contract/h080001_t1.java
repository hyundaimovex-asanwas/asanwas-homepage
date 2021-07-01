package Contract;

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

public class h080001_t1 extends HttpServlet{

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
				String str2 = reqGauce.getParameter("v_str2");

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
																					"NOMINNM","NOMINGRD","NOMINRE","HSKSCR","GYGB",						//80[index-79]

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
																					"MILHNM","COLBNM",
																					"PAYAMT","SEX",																			//48	= 128[index-127]

																					"JOBKIND","INSCOD","PENCOD"													//index-128~130
																				};

        //int[] idx = new int[81];
        //for (int i=0; i<79; i++) {
				int[] idx = new int[85];
        for (int i=0; i<83; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				idx[80] = userSet.indexOfColumn(strArrCN[126]);   //PAYAMT
				idx[81] = userSet.indexOfColumn(strArrCN[127]);   //SEX
				idx[82] = userSet.indexOfColumn(strArrCN[128]);   //JOBKIND
				idx[83] = userSet.indexOfColumn(strArrCN[129]);   //INSCOD
				idx[84] = userSet.indexOfColumn(strArrCN[130]);   //PENCOD

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
							maxCnt = "0000";	//신규 empno를 param으로 "" 받을경우
							sql = new StringBuffer();	//년도"05"의 값을 조건으로 max값으로 다음 사번을 받는다.
							sql.append( " SELECT MAX(SUBSTR(EMPNO,4,4)) CNT FROM PAYROLL.T_HIPERSON " );
              sql.append( " WHERE SUBSTR(EMPNO,1,1)= '" + str2 + "' AND SUBSTR(EMPNO,2,2) = '" + str1 + "'" );
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
									if (ichk<10) maxCnt = str2 + str1 + "000" + ichk;	//2+05+000+2
									else if (ichk<100 && ichk>9) maxCnt = str2 + str1 + "00" + ichk;
									else if (ichk<1000 && ichk>99) maxCnt = str2 + str1 + "0" + ichk;
									else if (ichk>999) maxCnt = str2 + str1 + ichk;
								} else {
									maxCnt = str2 + str1 + "0001";
								}
							} else {
									maxCnt = str2 + str1 + "0001";
							}
						} else {
							maxCnt = vchk;
						}

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO PAYROLL.T_HIPERSON " );
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
						InsertSql.append( " NOMINNM,NOMINGRD,NOMINRE,HSKSCR, GYGB, PAYAMT, " );
						InsertSql.append( " SEX, JOBKIND, INSCOD, PENCOD " );
						InsertSql.append( " ) " );
						InsertSql.append( "  VALUES " );
						InsertSql.append( " ( " );
						InsertSql.append( " '" + maxCnt + "',?,?,?,?, " );
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
						InsertSql.append( " ?,?,?,?,?) " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for (int s=1;s<idx.length;s++) {

							if (s==69) {
								InputStream nst_file = (InputStream) rows[j].getInputStream(idx[s]);
								gsmt.setBinaryStream(s, nst_file, nst_file.available() );	 //첨부파일
							} else {
								gsmt.bindColumn(s, idx[s]);
							}
						}

						gsmt.executeUpdate(); 
						gsmt.close();
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE PAYROLL.T_HIPERSON " );
						UpdateSql.append( "		 SET REGDIV = ?, EMPNMK = ?, CARRDIV = ?, RECDIV = ?, " );						//4-4
						UpdateSql.append( "				 EMPDIV = ?,FRDT = ?,TODT = ?,PAYDIV = ?,RESINO = ?, " );					//5-9
						UpdateSql.append( "				 PICTURE = ?,GRSTRTDT = ?,STRTDT = ?,DEPTCD = ?,PAYGRD = ?, " );	//5-14
						UpdateSql.append( "				 JOBGRPH = ?,JOBDTY = ?,GRDDIV = ?,PAYSEQ = ?,FSAMDT = ?, " );		//5-19
						UpdateSql.append( "				 ENDDT = ?,USESTS = ?,COSTDIV = ?,DPOFFDT = ?,LAMDT = ?, " );			//5-24
						UpdateSql.append( "				 LRMDT = ?,BIRDT = ?,GLDIV = ?,HOBBY = ?,NMC = ?, " );						//5-29
						UpdateSql.append( "				 RILIGN = ?,NME = ?,BIRCITY = ?,SPECIAL = ?,OZIPCD = ?, " );			//5-34
						UpdateSql.append( "				 OADDR01 = ?,OADDR02 = ?,CZIPCD = ?,CADDR01 = ?,CADDR02 = ?, " );	//5-39
						UpdateSql.append( "				 TELNO = ?,HPNO = ?,OFFTELNO = ?,EMAIL = ?,HDFAMNM = ?, " );			//5-44
						UpdateSql.append( "				 HDFAMRET = ?,HDFAMJOB = ?,LABUNIYN = ?,RELESAMT = ?,MOVESAMT = ?, " );	//5-49
						UpdateSql.append( "				 MRTDIV = ?,MRTNO = ?,REFCD = ?,PAYBNKCD = ?,PAYACNT = ?, " );		//5-54
						UpdateSql.append( "				 HOUSDIV = ?,MRYDT = ?,ENGLVL = ?,TOESCR = ?,JPTSCR = ?, " );			//5-59
						UpdateSql.append( "				 DELFSCR = ?,TOFSCR = ?,DALFSCR = ?,TEPSSCR = ?,ETCLNG = ?, " );	//5-64
						UpdateSql.append( "				 HWGRDCD = ?,EXGRDCD = ?,PWGRDCD = ?,ACGRDCD = ?, " );						//4-68
						UpdateSql.append( "				 ORDDT = ?,HITCHYN = ?,RELATNM = ?,RELATGRD = ?,RELATRE = ?, ");	//5-73
						UpdateSql.append( "				 NOMINNM = ?,NOMINGRD = ?,NOMINRE = ?, HSKSCR = ?, GYGB = ?, PAYAMT = ?, ");//5-79
						UpdateSql.append( "				 SEX = ?,JOBKIND = ?,INSCOD = ?,PENCOD = ? ");										//1-83
						UpdateSql.append( "  WHERE EMPNO = ? " );																										//1-83

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for (int s=1;s<80;s++) {
							
							if (s>69){	//이미지 처리
								gsmt.bindColumn(s-1, idx[s]);	
							}else if (s<69){ 
								gsmt.bindColumn(s, idx[s]);	
							}
						}

						gsmt.bindColumn(79, idx[80]);	//PAYAMT
						gsmt.bindColumn(80, idx[81]);	//SEX
						gsmt.bindColumn(81, idx[82]);	//JOBKIND
						gsmt.bindColumn(82, idx[83]);	//INSCOD
						gsmt.bindColumn(83, idx[84]);	//PENCOD
						gsmt.bindColumn(84, idx[0]);	//EMPNO

						gsmt.executeUpdate(); 
						gsmt.close();

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM PAYROLL.T_HIPERSON ");
						DeleteSql.append( " WHERE EMPNO = ? ");

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