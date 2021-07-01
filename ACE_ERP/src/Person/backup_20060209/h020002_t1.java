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

public class h020002_t1 extends HttpServlet{

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

				GauceDataSet userSet1 = reqGauce.getGauceDataSet("USER");
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("EDUC");
				GauceDataSet userSet3 = reqGauce.getGauceDataSet("CARR");
				GauceDataSet userSet4 = reqGauce.getGauceDataSet("FAMI");
				GauceDataSet userSet5 = reqGauce.getGauceDataSet("LICE");
				GauceDataSet userSet6 = reqGauce.getGauceDataSet("SELF");

				/////////////////////////////////////////////////////////////////////////
				//	인사기본
				/////////////////////////////////////////////////////////////////////////
				String[] strArrCN1 = new String[]{ "INFODIV","RESINO","WRDT","WRNO","NMK",
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
																					"LCSCD","PROSTS","CARYEAR","PICFILE","HSKSCR"
																				}; 
        int[] idx1 = new int[70];
        for (int i=0; i<strArrCN1.length; i++) {
  				idx1[i] = userSet1.indexOfColumn(strArrCN1[i]);
				}

				GauceDataRow[] rows1 = userSet1.getDataRows();

				/////////////////////////////////////////////////////////////////////////
				//	학력사항
				/////////////////////////////////////////////////////////////////////////
				String[] strArrCN2 = new String[]{ "INFODIV","RESINO","SEQ","EDCCD","GRAYY",
																					 "SCHNM","CITY","PGCCD","EDCDIV","AVRUNI",
																					 "PERFECT"
																				}; 
        int[] idx2 = new int[11];
        for (int i=0; i<strArrCN2.length; i++) {
  				idx2[i] = userSet2.indexOfColumn(strArrCN2[i]);
				}

				GauceDataRow[] rows2 = userSet2.getDataRows();

				/////////////////////////////////////////////////////////////////////////
				//	경력사항
				/////////////////////////////////////////////////////////////////////////
				String[] strArrCN3 = new String[]{ "INFODIV","RESINO","SEQ","FRDT","ENDDT",
																					 "COMNM","POSINM","DUTYNM"
																				}; 
        int[] idx3 = new int[8];
        for (int i=0; i<strArrCN3.length; i++) {
  				idx3[i] = userSet3.indexOfColumn(strArrCN3[i]);
				}

				GauceDataRow[] rows3 = userSet3.getDataRows();

				/////////////////////////////////////////////////////////////////////////
				//	가족사항
				/////////////////////////////////////////////////////////////////////////
				String[] strArrCN4 = new String[]{ "INFODIV","RESINO","SEQ","REFCD","FAMNM",
																					 "RESINOF","SCHNM","CMPNM","LSTEDC"
																				}; 
        int[] idx4 = new int[9];
        for (int i=0; i<strArrCN4.length; i++) {
  				idx4[i] = userSet4.indexOfColumn(strArrCN4[i]);
				}

				GauceDataRow[] rows4 = userSet4.getDataRows();

				/////////////////////////////////////////////////////////////////////////
				//	자격증정보
				/////////////////////////////////////////////////////////////////////////
				String[] strArrCN5 = new String[]{ "INFODIV","RESINO","SEQ","LCSTYPE","LCSCD",
																					 "LCSNO","GETDT","CHGDT","ISSPART"
																				}; 
        int[] idx5 = new int[9];
        for (int i=0; i<strArrCN5.length; i++) {
  				idx5[i] = userSet5.indexOfColumn(strArrCN5[i]);
				}

				GauceDataRow[] rows5 = userSet5.getDataRows();

				/////////////////////////////////////////////////////////////////////////
				//	자기소개서
				/////////////////////////////////////////////////////////////////////////
				String[] strArrCN6 = new String[]{ "INFODIV", "RESINO", "GROWTH", "SCHOOL", "CAREER", 
																					 "AMBITION"
																				}; 
        int[] idx6 = new int[6];
        for (int i=0; i<strArrCN6.length; i++) {
  				idx6[i] = userSet6.indexOfColumn(strArrCN6[i]);
				}

				GauceDataRow[] rows6 = userSet6.getDataRows();

				StringBuffer InsertSql1 = null;
				StringBuffer InsertSql2 = null;
				StringBuffer InsertSql3 = null;
				StringBuffer InsertSql4 = null;
				StringBuffer InsertSql5 = null;
				StringBuffer InsertSql6 = null;

				StringBuffer UpdateSql1 = null;
				StringBuffer UpdateSql2 = null;
				StringBuffer UpdateSql3 = null;
				StringBuffer UpdateSql4 = null;
				StringBuffer UpdateSql5 = null;
				StringBuffer UpdateSql6 = null;

				StringBuffer DeleteSql1 = null;
				StringBuffer DeleteSql2 = null;
				StringBuffer DeleteSql3 = null;
				StringBuffer DeleteSql4 = null;
				StringBuffer DeleteSql5 = null;
				StringBuffer DeleteSql6 = null;

				InsertSql1 = new StringBuffer();
				InsertSql2 = new StringBuffer();
				InsertSql3 = new StringBuffer();
				InsertSql4 = new StringBuffer();
				InsertSql5 = new StringBuffer();
				InsertSql6 = new StringBuffer();

				UpdateSql1 = new StringBuffer();
				UpdateSql2 = new StringBuffer();
				UpdateSql3 = new StringBuffer();
				UpdateSql4 = new StringBuffer();
				UpdateSql5 = new StringBuffer();
				UpdateSql6 = new StringBuffer();

				DeleteSql1 = new StringBuffer();
				DeleteSql2 = new StringBuffer();
				DeleteSql3 = new StringBuffer();
				DeleteSql4 = new StringBuffer();
				DeleteSql5 = new StringBuffer();
				DeleteSql6 = new StringBuffer();
				

if (rows1.length>0) {
				/////////////////////////////////////////////////////////////////////////
				// 기본사항
				/////////////////////////////////////////////////////////////////////////
				int maxCnt = 0;
				StringBuffer sql = null;
				Statement stmt = null;
				ResultSet rs = null;

				int typ = rows1[0].getInt(idx1[3]);
				if (typ <1)	{
					maxCnt = 0;
					sql = new StringBuffer();
					sql.append( " SELECT MAX(WRNO) CNT FROM PAYROLL.HRPERSON WHERE INFODIV = '" + str1 + "'" );

					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql.toString());

					while (rs.next())	{
						maxCnt = rs.getInt(1);
					}

					if (rs!=null)	rs.close();
					if (stmt!=null) stmt.close();

					if (maxCnt<1) maxCnt = 1;
					else maxCnt++;
				} else {
					maxCnt = typ;
				}

				InsertSql1.append( " INSERT INTO PAYROLL.HRPERSON " );
				InsertSql1.append( " ( " );
				InsertSql1.append( " INFODIV,RESINO,WRDT,WRNO,NMK,             " );
				InsertSql1.append( " PHOTO,BIRDT,GLDIV,HOBBY,NMC,              " );
				InsertSql1.append( " RILIGN,NME,BIRCITY,SPECIAL,OZIPCD,        " );
				InsertSql1.append( " OADDR1,OADDR2,CZIPCD,CADDR1,CADDR2,       " );
				InsertSql1.append( " TELNO,HPNO,EMAIL,EYEL,EYER,               " );
				InsertSql1.append( " HEIGHT,WEIGHT,BLOOD,RGHANDYN,MILIDIV,     " );
				InsertSql1.append( " MILIKND,MILIGRD,MILINO,MILIPLC,MILIFRDT,  " );
				InsertSql1.append( " MILITODT,NMREASON,MRYDT,DISDIV,DISGRD,    " );
				InsertSql1.append( " MILITYPE,MRTDIV,MRTNO,REFCD,MILISPEC,     " );
				InsertSql1.append( " ENGLVL,TOESCR,JPTSCR,DELFSCR,TOFSCR,      " );
				InsertSql1.append( " DALFSCR,TEPSSCR,ETCLNG,HWGRDCD,EXGRDCD,   " );
				InsertSql1.append( " PWGRDCD,ACGRDCD,INTDT,INTTM,INTATTYN,     " );
				InsertSql1.append( " PASSDT,AMDT,EMPNO,AMKIND,LCSTYPE,         " );
				InsertSql1.append( " LCSCD,PROSTS,CARYEAR,PICFILE,HSKSCR       " );
				InsertSql1.append( " ) " );
				InsertSql1.append( "  VALUES " );
				InsertSql1.append( " ( " );
				InsertSql1.append( " ?,?,?," + maxCnt + ",?,?,?,?,?,?, " );
				InsertSql1.append( " ?,?,?,?,?,?,?,?,?,?, " );
				InsertSql1.append( " ?,?,?,?,?,?,?,?,?,?, " );
				InsertSql1.append( " ?,?,?,?,?,?,?,?,?,?, " );
				InsertSql1.append( " ?,?,?,?,?,?,?,?,?,?, " );
				InsertSql1.append( " ?,?,?,?,?,?,?,?,?,?, " );
				InsertSql1.append( " ?,?,?,?,?,?,?,?,?,? " );
				InsertSql1.append( " ) " );

				UpdateSql1.append( " UPDATE PAYROLL.HRPERSON " );
				UpdateSql1.append( "		SET WRDT = ?,WRNO = ?,NMK = ?,             " );
				UpdateSql1.append( "				PHOTO = ?,BIRDT = ?,GLDIV = ?,HOBBY = ?,NMC = ?,              " );
				UpdateSql1.append( "				RILIGN = ?,NME = ?,BIRCITY = ?,SPECIAL = ?,OZIPCD = ?,        " );
				UpdateSql1.append( "				OADDR1 = ?,OADDR2 = ?,CZIPCD = ?,CADDR1 = ?,CADDR2 = ?,       " );
				UpdateSql1.append( "				TELNO = ?,HPNO = ?,EMAIL = ?,EYEL = ?,EYER = ?,               " );
				UpdateSql1.append( "				HEIGHT = ?,WEIGHT = ?,BLOOD = ?,RGHANDYN = ?,MILIDIV = ?,     " );
				UpdateSql1.append( "				MILIKND = ?,MILIGRD = ?,MILINO = ?,MILIPLC = ?,MILIFRDT = ?,  " );
				UpdateSql1.append( "				MILITODT = ?,NMREASON = ?,MRYDT = ?,DISDIV = ?,DISGRD = ?,    " );
				UpdateSql1.append( "				MILITYPE = ?,MRTDIV = ?,MRTNO = ?,REFCD = ?,MILISPEC = ?,     " );
				UpdateSql1.append( "				ENGLVL = ?,TOESCR = ?,JPTSCR = ?,DELFSCR = ?,TOFSCR = ?,      " );
				UpdateSql1.append( "				DALFSCR = ?,TEPSSCR = ?,ETCLNG = ?,HWGRDCD = ?,EXGRDCD = ?,   " );
				UpdateSql1.append( "				PWGRDCD = ?,ACGRDCD = ?,INTDT = ?,INTTM = ?,INTATTYN = ?,     " );
				UpdateSql1.append( "				PASSDT = ?,AMDT = ?,EMPNO = ?,AMKIND = ?,LCSTYPE = ?,         " );
				UpdateSql1.append( "				LCSCD = ?,PROSTS = ?,CARYEAR = ?,HSKSCR = ?  " );
				UpdateSql1.append( "  WHERE INFODIV = ? " );
				UpdateSql1.append( "    AND RESINO = ? " );

				DeleteSql1.append( " DELETE FROM PAYROLL.HRPERSON ");
				DeleteSql1.append( "  WHERE INFODIV = ? ");
				DeleteSql1.append( "    AND RESINO = ? ");

				for (int j = 0; j < rows1.length; j++){

					if(rows1[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql1.toString());
						gsmt.setGauceDataRow(rows1[j]);
						int cnt = 1;
						for (int k=0;k<68;k++) {
							if (k!=3) {
								gsmt.bindColumn(cnt, idx1[k]);
								cnt++;
							}
						}

						InputStream nst_file = (InputStream) rows1[j].getInputStream(idx1[68]);
						gsmt.setBinaryStream(68, nst_file, nst_file.available() );	 //첨부파일
						gsmt.bindColumn(69, idx1[69]);

						gsmt.executeUpdate(); 
						gsmt.close();
					}

					if(rows1[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql1.toString());
						gsmt.setGauceDataRow(rows1[j]);
						int cnt = 1;
						for (int k=2;k<68;k++) {
							gsmt.bindColumn(cnt, idx1[k]);
							cnt++;
						}

						gsmt.bindColumn(67, idx1[69]);
						gsmt.bindColumn(68, idx1[0]);
						gsmt.bindColumn(69, idx1[1]);

						gsmt.executeUpdate();
					}    
						
					if(rows1[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql1.toString());
						gsmt.setGauceDataRow(rows1[j]);
						gsmt.bindColumn(1, idx1[0]);
						gsmt.bindColumn(2, idx1[1]);
						gsmt.executeUpdate();
						gsmt.close();
					}

				}
}

if (rows2.length>0) {
				/////////////////////////////////////////////////////////////////////////
				// 학력사항
				/////////////////////////////////////////////////////////////////////////
				InsertSql2.append( " INSERT INTO PAYROLL.HREDUC " );
				InsertSql2.append( " ( " );
				InsertSql2.append( "		INFODIV,RESINO,SEQ,EDCCD,GRAYY, ");
				InsertSql2.append( "		SCHNM,CITY,PGCCD,EDCDIV,AVRUNI, " );
				InsertSql2.append( "		PERFECT  " );
				InsertSql2.append( " ) " );
				InsertSql2.append( "  VALUES " );
				InsertSql2.append( " ( " );
				InsertSql2.append( " ?,?,?,?,?, ?,?,?,?,?, " );
				InsertSql2.append( " ? " );
				InsertSql2.append( " ) " );

				UpdateSql2.append( " UPDATE PAYROLL.HREDUC ");
				UpdateSql2.append( "    SET EDCCD = ?, ");
				UpdateSql2.append( "				GRAYY = ?, ");
				UpdateSql2.append( "				SCHNM = ?, ");
				UpdateSql2.append( "				CITY = ?, ");
				UpdateSql2.append( "				PGCCD = ?, ");
				UpdateSql2.append( "				EDCDIV = ?, ");
				UpdateSql2.append( "				AVRUNI = ?, ");
				UpdateSql2.append( "				PERFECT = ? ");
				UpdateSql2.append( "	WHERE INFODIV = ? ");
				UpdateSql2.append( "		AND RESINO = ? ");
				UpdateSql2.append( "		AND SEQ = ? ");

				DeleteSql2.append( " DELETE FROM PAYROLL.HREDUC ");
				DeleteSql2.append( "	WHERE INFODIV = ? ");
				DeleteSql2.append( "		AND RESINO = ? ");
				DeleteSql2.append( "		AND SEQ = ? ");

				for (int j = 0; j < rows2.length; j++){

					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql2.toString());
						gsmt.setGauceDataRow(rows2[j]);
						int cnt = 1;
						for (int k=0;k<idx2.length;k++) {
							gsmt.bindColumn(cnt, idx2[k]);
							cnt++;
						}
						gsmt.executeUpdate(); 
					}

					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql2.toString());
						gsmt.setGauceDataRow(rows2[j]);
						int cnt = 1;
						for (int k=3;k<idx2.length;k++) {
							gsmt.bindColumn(cnt, idx2[k]);
							cnt++;
						}
						gsmt.bindColumn(9, idx2[0]);
						gsmt.bindColumn(10, idx2[1]);
						gsmt.bindColumn(11, idx2[2]);
						gsmt.executeUpdate();
					}    
						
					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql2.toString());
						gsmt.setGauceDataRow(rows2[j]);
						gsmt.bindColumn(1, idx2[0]);
						gsmt.bindColumn(2, idx2[1]);
						gsmt.bindColumn(3, idx2[2]);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
}

if (rows3.length>0) {
				/////////////////////////////////////////////////////////////////////////
				// 경력사항
				/////////////////////////////////////////////////////////////////////////
				InsertSql3.append( " INSERT INTO PAYROLL.HRCAREER " );
				InsertSql3.append( " ( " );
				InsertSql3.append( "		INFODIV,RESINO,SEQ,FRDT,ENDDT, ");
				InsertSql3.append( "		COMNM,POSINM,DUTYNM  " );
				InsertSql3.append( " ) " );
				InsertSql3.append( "  VALUES " );
				InsertSql3.append( " ( " );
				InsertSql3.append( " ?,?,?,?,?, ?,?,? " );
				InsertSql3.append( " ) " );

				UpdateSql3.append( " UPDATE PAYROLL.HRCAREER ");
				UpdateSql3.append( "    SET FRDT = ?, ");
				UpdateSql3.append( "				ENDDT = ?, ");
				UpdateSql3.append( "				COMNM = ?, ");
				UpdateSql3.append( "				POSINM = ?, ");
				UpdateSql3.append( "				DUTYNM = ? ");
				UpdateSql3.append( "	WHERE INFODIV = ? ");
				UpdateSql3.append( "		AND RESINO = ? ");
				UpdateSql3.append( "		AND SEQ = ? ");

				DeleteSql3.append( " DELETE FROM PAYROLL.HRCAREER ");
				DeleteSql3.append( "	WHERE INFODIV = ? ");
				DeleteSql3.append( "		AND RESINO = ? ");
				DeleteSql3.append( "		AND SEQ = ? ");

				for (int j = 0; j < rows3.length; j++){

					if(rows3[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql3.toString());
						gsmt.setGauceDataRow(rows3[j]);

						int cnt = 1;
						for (int k=0;k<idx3.length;k++) {
							gsmt.bindColumn(cnt, idx3[k]);
							cnt++;
						}
						gsmt.executeUpdate(); 
						gsmt.close();

					}

					if(rows3[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql3.toString());
						gsmt.setGauceDataRow(rows3[j]);
						int cnt = 1;
						for (int k=3;k<idx3.length;k++) {
							gsmt.bindColumn(cnt, idx3[k]);
							cnt++;
						}
						gsmt.bindColumn(6, idx3[0]);
						gsmt.bindColumn(7, idx3[1]);
						gsmt.bindColumn(8, idx3[2]);
						gsmt.executeUpdate();

					}    
						
					if(rows3[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql3.toString());
						gsmt.setGauceDataRow(rows3[j]);
						gsmt.bindColumn(1, idx3[0]);
						gsmt.bindColumn(2, idx3[1]);
						gsmt.bindColumn(3, idx3[2]);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
}

if (rows4.length>0) {
				/////////////////////////////////////////////////////////////////////////
				// 가족사항
				/////////////////////////////////////////////////////////////////////////
				InsertSql4.append( " INSERT INTO PAYROLL.HRFAMILY " );
				InsertSql4.append( " ( " );
				InsertSql4.append( "		INFODIV,RESINO,SEQ,REFCD,FAMNM, ");
				InsertSql4.append( "		RESINOF,SCHNM,CMPNM,LSTEDC  " );
				InsertSql4.append( " ) " );
				InsertSql4.append( "  VALUES " );
				InsertSql4.append( " ( " );
				InsertSql4.append( " ?,?,?,?,?, ?,?,?,? " );
				InsertSql4.append( " ) " );

				UpdateSql4.append( " UPDATE PAYROLL.HRFAMILY ");
				UpdateSql4.append( "    SET REFCD = ?, ");
				UpdateSql4.append( "				FAMNM = ?, ");
				UpdateSql4.append( "				RESINOF = ?, ");
				UpdateSql4.append( "				SCHNM = ?, ");
				UpdateSql4.append( "				CMPNM = ?, ");
				UpdateSql4.append( "				LSTEDC = ? ");
				UpdateSql4.append( "	WHERE INFODIV = ? ");
				UpdateSql4.append( "		AND RESINO = ? ");
				UpdateSql4.append( "		AND SEQ = ? ");

				DeleteSql4.append( " DELETE FROM PAYROLL.HRFAMILY ");
				DeleteSql4.append( "	WHERE INFODIV = ? ");
				DeleteSql4.append( "		AND RESINO = ? ");
				DeleteSql4.append( "		AND SEQ = ? ");

				for (int j = 0; j < rows4.length; j++){

					if(rows4[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql4.toString());
						gsmt.setGauceDataRow(rows4[j]);

						int cnt = 1;
						for (int k=0;k<idx4.length;k++) {
							gsmt.bindColumn(cnt, idx4[k]);
							cnt++;
						}
						gsmt.executeUpdate(); 
						gsmt.close();

					}

					if(rows4[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql4.toString());
						gsmt.setGauceDataRow(rows4[j]);
						int cnt = 1;
						for (int k=3;k<idx4.length;k++) {
							gsmt.bindColumn(cnt, idx4[k]);
							cnt++;
						}
						gsmt.bindColumn(7, idx4[0]);
						gsmt.bindColumn(8, idx4[1]);
						gsmt.bindColumn(9, idx4[2]);
						gsmt.executeUpdate();

					}    
						
					if(rows4[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql4.toString());
						gsmt.setGauceDataRow(rows4[j]);
						gsmt.bindColumn(1, idx4[0]);
						gsmt.bindColumn(2, idx4[1]);
						gsmt.bindColumn(3, idx4[2]);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
}

if (rows5.length>0) {
				/////////////////////////////////////////////////////////////////////////
				// 자격증정보
				/////////////////////////////////////////////////////////////////////////
				InsertSql5.append( " INSERT INTO PAYROLL.HRLICENS " );
				InsertSql5.append( " ( " );
				InsertSql5.append( "		INFODIV,RESINO,SEQ,LCSTYPE,LCSCD, ");
				InsertSql5.append( "		LCSNO,GETDT,CHGDT,ISSPART  " );
				InsertSql5.append( " ) " );
				InsertSql5.append( "  VALUES " );
				InsertSql5.append( " ( " );
				InsertSql5.append( " ?,?,?,?,?, ?,?,?,? " );
				InsertSql5.append( " ) " );

				UpdateSql5.append( " UPDATE PAYROLL.HRLICENS ");
				UpdateSql5.append( "    SET LCSTYPE = ?, ");
				UpdateSql5.append( "				LCSCD = ?, ");
				UpdateSql5.append( "				LCSNO = ?, ");
				UpdateSql5.append( "				GETDT = ?, ");
				UpdateSql5.append( "				CHGDT = ?, ");
				UpdateSql5.append( "				ISSPART = ? ");
				UpdateSql5.append( "	WHERE INFODIV = ? ");
				UpdateSql5.append( "		AND RESINO = ? ");
				UpdateSql5.append( "		AND SEQ = ? ");

				DeleteSql5.append( " DELETE FROM PAYROLL.HRLICENS ");
				DeleteSql5.append( "	WHERE INFODIV = ? ");
				DeleteSql5.append( "		AND RESINO = ? ");
				DeleteSql5.append( "		AND SEQ = ? ");

				for (int j = 0; j < rows5.length; j++){

					if(rows5[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql5.toString());
						gsmt.setGauceDataRow(rows5[j]);

						int cnt = 1;
						for (int k=0;k<idx5.length;k++) {
							gsmt.bindColumn(cnt, idx5[k]);
							cnt++;
						}
						gsmt.executeUpdate(); 
						gsmt.close();

					}

					if(rows5[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql5.toString());
						gsmt.setGauceDataRow(rows5[j]);
						int cnt = 1;
						for (int k=3;k<idx5.length;k++) {
							gsmt.bindColumn(cnt, idx5[k]);
							cnt++;
						}
						gsmt.bindColumn(7, idx5[0]);
						gsmt.bindColumn(8, idx5[1]);
						gsmt.bindColumn(9, idx5[2]);
						gsmt.executeUpdate();

					}    
						
					if(rows5[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql5.toString());
						gsmt.setGauceDataRow(rows5[j]);
						gsmt.bindColumn(1, idx5[0]);
						gsmt.bindColumn(2, idx5[1]);
						gsmt.bindColumn(3, idx5[2]);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
}			

if (rows6.length>0) {
				/////////////////////////////////////////////////////////////////////////
				// 자기소개서
				/////////////////////////////////////////////////////////////////////////
				InsertSql6.append( " INSERT INTO PAYROLL.HRSELF " );
				InsertSql6.append( " ( " );
				InsertSql6.append( "		INFODIV,RESINO,GROWTH,SCHOOL,CAREER,AMBITION ");
				InsertSql6.append( " ) " );
				InsertSql6.append( "  VALUES " );
				InsertSql6.append( " ( " );
				InsertSql6.append( " ?,?,?,?,?,? " );
				InsertSql6.append( " ) " );

				UpdateSql6.append( " UPDATE PAYROLL.HRSELF ");
				UpdateSql6.append( "    SET GROWTH = ?, ");
				UpdateSql6.append( "				SCHOOL = ?, ");
				UpdateSql6.append( "				CAREER = ?, ");
				UpdateSql6.append( "				AMBITION = ? ");
				UpdateSql6.append( "	WHERE INFODIV = ? ");
				UpdateSql6.append( "		AND RESINO = ? ");

				DeleteSql6.append( " DELETE FROM PAYROLL.HRSELF ");
				DeleteSql6.append( "	WHERE INFODIV = ? ");
				DeleteSql6.append( "		AND RESINO = ? ");

				for (int j = 0; j < rows6.length; j++){

					if(rows6[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql6.toString());
						gsmt.setGauceDataRow(rows6[j]);

						int cnt = 1;
						for (int k=0;k<idx6.length;k++) {
							gsmt.bindColumn(cnt, idx6[k]);
							cnt++;
						}
						gsmt.executeUpdate(); 
						gsmt.close();

					}

					if(rows6[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql6.toString());
						gsmt.setGauceDataRow(rows6[j]);
						gsmt.bindColumn(1, idx6[2]);
						gsmt.bindColumn(2, idx6[3]);
						gsmt.bindColumn(3, idx6[4]);
						gsmt.bindColumn(4, idx6[5]);
						gsmt.bindColumn(5, idx6[0]);
						gsmt.bindColumn(6, idx6[1]);
						gsmt.executeUpdate();

					}    
						
					if(rows6[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql6.toString());
						gsmt.setGauceDataRow(rows6[j]);
						gsmt.bindColumn(1, idx6[0]);
						gsmt.bindColumn(2, idx6[1]);
						gsmt.executeUpdate();
						gsmt.close();
					}
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