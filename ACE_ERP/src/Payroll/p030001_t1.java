package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p030001_t1 extends HttpServlet{

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
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String strYyyy="";
				
				String strINC001="";
				String strEXC001="";

				String strINC002="";
				String strEXC005="";

        int intINC001 =0;
				int intEXC001 =0;

				int intINC002 =0;
				int intEXC005 =0;

				int intP10000=0;
				int intP11000=0;
				int intP12000=0;
				int intP21000=0;
				int intP22000=0;
				int intP29000=0;

				int intP24000=0;
				int intP35000=0;

				int intP23000 = 0;
				int intP37000 = 0;
				int intP28000 = 0;
				int intP39000 = 0;
				int intP32000 = 0;
				int intP34000 = 0;

				int intUBAMT = 0;

				int intWkday=0; //소득근무일수

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPYY    = userSet.indexOfColumn("APPYY");   //귀속년도
				int idxAPPYMD   = userSet.indexOfColumn("APPYMD");  //귀속년도 12월31일
	       

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer SelectSql = null;

				GauceStatement gsmt = null;
				Statement stmt = null;
				ResultSet rs = null;

				//logger.dbg.println(this,"step1");
			
			  /*
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ASTCLOSE (  " );
				InsertSql.append( " FDCODE,  YEAR,    MONTH,   GUBUN,   CLOSEYN, " );
				InsertSql.append( " WRID,    WRDT,    UPID,    UPDT " );
				InsertSql.append( "  ) " );
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,CURRENT TIMESTAMP,?,CURRENT TIMESTAMP)" );	 


				UpdateSql = new StringBuffer();
				UpdateSql.append( "  UPDATE ACCOUNT.ASTCLOSE SET  " );
				UpdateSql.append( "  CLOSEYN =? ," );
				UpdateSql.append( "  UPID =?, " );
				UpdateSql.append( "  UPDT = CURRENT TIMESTAMP " );
				UpdateSql.append( "  WHERE FDCODE = ? " );
				UpdateSql.append( "    AND YEAR = ? " );
				UpdateSql.append( "    AND MONTH = ? " );
				UpdateSql.append( "    AND GUBUN = ? " );
				*/
	    
        //===================================================================================
				for (int j = 0; j < rows.length; j++){
				if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

          strYyyy=rows[j].getString(idxAPPYY);       

					//WORKSTS 초기화 
					DeleteSql = new StringBuffer();
					DeleteSql.append( "  DELETE FROM PAYROLL.PCWRKPAY    \n  " );
					DeleteSql.append( "   WHERE APPDT  = '"+strYyyy+"12' \n  " );
					DeleteSql.append( "     AND PAYDIV = 'Y' \n  " );
					gsmt = conn.getGauceStatement(DeleteSql.toString());
					gsmt.executeUpdate();
					gsmt.close();
          
					//기존데이터 초기화 
          DeleteSql = new StringBuffer();
					DeleteSql.append( "  DELETE FROM PAYROLL.YCPERCOL  \n  " );
					DeleteSql.append( "   WHERE YYYY = ? \n  " );
					gsmt = conn.getGauceStatement(DeleteSql.toString());
					gsmt.setGauceDataRow(rows[j]);
					gsmt.bindColumn(1, idxAPPYY);
					gsmt.executeUpdate();
					gsmt.close();
          gsmt=null;
					DeleteSql =null;



          //연말정산 대상자 생성 
					//일반적인 경우의 소득구분
          InsertSql = new StringBuffer();
					InsertSql.append( " INSERT INTO PAYROLL.YCPERCOL ( \n  " );
					InsertSql.append( " YYYY,	EMPNO,	EMPNMK,	RESINO,	DEPTCD,	FAMCNT,	  \n  " );
					InsertSql.append( " INCYY01,INCYY02,INCYY03,INCYY04,INCYY05,INCYY06, \n  " );
					InsertSql.append( " INCYY07,INCYY08,INCYY09,INCYY10,INCYY11,INCYY12,\n  " );
					InsertSql.append( " FREYY01,FREYY02,FREYY03,FREYY04,FREYY05,FREYY06,\n  " );
					InsertSql.append( " FREYY07,FREYY08,FREYY09,FREYY10,FREYY11,FREYY12,\n  " );
					InsertSql.append( " PROSTS,  \n  " );
					InsertSql.append( " INC01001,	INC02001,	INC03001,	INC04001,	INC05001,	INC06001, \n  " );
					InsertSql.append( " INC07001,	INC08001,	INC09001,	INC10001,	INC11001,	INC12001, \n  " );
					InsertSql.append( " INC01002,	INC02002,	INC03002,	INC04002,	INC05002,	INC06002, \n  " );
					InsertSql.append( " INC07002,	INC08002,	INC09002,	INC10002,	INC11002,	INC12002, \n  " );
					InsertSql.append( " INC01005,	INC02005,	INC03005,	INC04005,	INC05005,	INC06005, \n  " );
					InsertSql.append( " INC07005,	INC08005,	INC09005,	INC10005,	INC11005,	INC12005, \n  " );
					InsertSql.append( " FRE01005,	FRE02005,	FRE03005,	FRE04005,	FRE05005,	FRE06005, \n  " );
					InsertSql.append( " FRE07005,	FRE08005,	FRE09005,	FRE10005,	FRE11005,	FRE12005, \n  " );
					InsertSql.append( " FRE01006,	FRE02006,	FRE03006,	FRE04006,	FRE05006,	FRE06006, \n  " );
          InsertSql.append( " FRE07006,	FRE08006,	FRE09006,	FRE10006,	FRE11006,	FRE12006, \n  " );
					InsertSql.append( " COL01002,	COL02002,	COL03002,	COL04002,	COL05002,	COL06002, \n  " );
					InsertSql.append( " COL07002,	COL08002,	COL09002,	COL10002,	COL11002,	COL12002, \n  " );
					InsertSql.append( " COL01003,	COL02003,	COL03003,	COL04003,	COL05003,	COL06003, \n  " );
					InsertSql.append( " COL07003,	COL08003,	COL09003,	COL10003,	COL11003,	COL12003, \n  " );
					InsertSql.append( " COL01005,	COL02005,	COL03005,	COL04005,	COL05005,	COL06005, \n  " );
					InsertSql.append( " COL07005,	COL08005,	COL09005,	COL10005,	COL11005,	COL12005, \n  " );
					InsertSql.append( " COL01006,	COL02006,	COL03006,	COL04006,	COL05006,	COL06006, \n  " );
					InsertSql.append( " COL07006,	COL08006,	COL09006,	COL10006,	COL11006,	COL12006, \n  " );
					InsertSql.append( " COL01007,	COL02007,	COL03007,	COL04007,	COL05007,	COL06007, \n  " );
					InsertSql.append( " COL07007,	COL08007,	COL09007,	COL10007,	COL11007,	COL12007, \n  " );
					InsertSql.append( " EXC01001,	EXC02001,	EXC03001,	EXC04001,	EXC05001,	EXC06001, \n  " );
					InsertSql.append( " EXC07001,	EXC08001,	EXC09001,	EXC10001,	EXC11001,	EXC12001, \n  " );
					InsertSql.append( " EXC01005,	EXC02005,	EXC03005,	EXC04005,	EXC05005,	EXC06005, \n  " );
					InsertSql.append( " EXC07005,	EXC08005,	EXC09005,	EXC10005,	EXC11005,	EXC12005, \n  " );
          InsertSql.append( " SINC001,  SINC002,  SINC004,  SINC005,  SFRE005,  SFRE006,  \n  " );
					InsertSql.append( " SCOL002,  SCOL003,  SCOL005,  SCOL006,  SCOL007             \n  " );
					InsertSql.append( " ) \n  " );
					InsertSql.append( " SELECT '2010' AS YYYY, A.EMPNO,  A.EMPNMK, A.RESINO, A.DEPTCD, B.P23001 AS FAMCNT,  \n  " );
					InsertSql.append( "         '"+strYyyy+"01','"+strYyyy+"02','"+strYyyy+"03','"+strYyyy+"04','"+strYyyy+"05','"+strYyyy+"06', \n  " );
					InsertSql.append( "         '"+strYyyy+"07','"+strYyyy+"08','"+strYyyy+"09','"+strYyyy+"10','"+strYyyy+"11','"+strYyyy+"12', \n  " );
         	InsertSql.append( "         '"+strYyyy+"01','"+strYyyy+"02','"+strYyyy+"03','"+strYyyy+"04','"+strYyyy+"05','"+strYyyy+"06', \n  " );
					InsertSql.append( "         '"+strYyyy+"07','"+strYyyy+"08','"+strYyyy+"09','"+strYyyy+"10','"+strYyyy+"11','"+strYyyy+"12', \n  " );
					InsertSql.append( "         'C',                                                                                                      \n  " );
					InsertSql.append( "         X.INC01001, X.INC02001, X.INC03001, X.INC04001, X.INC05001, X.INC06001,                                   \n  " );
					InsertSql.append( "         X.INC07001, X.INC08001, X.INC09001, X.INC10001, X.INC11001, X.INC12001,                                   \n  " );
					InsertSql.append( "         X.INC01002, X.INC02002, X.INC03002, X.INC04002, X.INC05002, X.INC06002,                                   \n  " );
					InsertSql.append( "         X.INC07002, X.INC08002, X.INC09002, X.INC10002, X.INC11002, X.INC12002,                                   \n  " );
					InsertSql.append( "         X.COL01002, X.COL02002, X.COL03002, X.COL04002, X.COL05002, X.COL06002,                                   \n  " );
					InsertSql.append( "         X.COL07002, X.COL08002, X.COL09002, X.COL10002, X.COL11002, X.COL12002,                                   \n  " );
					/**
					InsertSql.append( "         X.FRE01005, X.FRE02005, X.FRE03005, X.FRE04005, X.FRE05005, X.FRE06005,                                   \n  " );
					InsertSql.append( "         X.FRE07005, X.FRE08005, X.FRE09005, X.FRE10005, X.FRE11005, X.FRE12005,                                   \n  " );
					InsertSql.append( "         X.FRE01006, X.FRE02006, X.FRE03006, X.FRE04006, X.FRE05006, X.FRE06006,                                   \n  " );
          InsertSql.append( "         X.FRE07006, X.FRE08006, X.FRE09006, X.FRE10006, X.FRE11006, X.FRE12006,                                   \n  " );
					**/
					InsertSql.append( "					CASE WHEN X.FRE01005<200000 THEN X.FRE01005 ELSE 200000 END AS FRE01005, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE02005<200000 THEN X.FRE02005 ELSE 200000 END AS FRE02005, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE03005<200000 THEN X.FRE03005 ELSE 200000 END AS FRE03005, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE04005<200000 THEN X.FRE04005 ELSE 200000 END AS FRE04005, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE05005<200000 THEN X.FRE05005 ELSE 200000 END AS FRE05005, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE06005<200000 THEN X.FRE06005 ELSE 200000 END AS FRE06005, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE07005<200000 THEN X.FRE07005 ELSE 200000 END AS FRE07005, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE08005<200000 THEN X.FRE08005 ELSE 200000 END AS FRE08005, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE09005<200000 THEN X.FRE09005 ELSE 200000 END AS FRE09005, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE10005<200000 THEN X.FRE10005 ELSE 200000 END AS FRE10005, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE11005<200000 THEN X.FRE11005 ELSE 200000 END AS FRE11005, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE12005<200000 THEN X.FRE12005 ELSE 200000 END AS FRE12005, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE01006<100000 THEN X.FRE01006 ELSE 100000 END AS FRE01006, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE02006<100000 THEN X.FRE02006 ELSE 100000 END AS FRE02006, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE03006<100000 THEN X.FRE03006 ELSE 100000 END AS FRE03006, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE04006<100000 THEN X.FRE04006 ELSE 100000 END AS FRE04006, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE05006<100000 THEN X.FRE05006 ELSE 100000 END AS FRE05006, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE06006<100000 THEN X.FRE06006 ELSE 100000 END AS FRE06006, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE07006<100000 THEN X.FRE07006 ELSE 100000 END AS FRE07006, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE08006<100000 THEN X.FRE08006 ELSE 100000 END AS FRE08006, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE09006<100000 THEN X.FRE09006 ELSE 100000 END AS FRE09006, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE10006<100000 THEN X.FRE10006 ELSE 100000 END AS FRE10006, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE11006<100000 THEN X.FRE11006 ELSE 100000 END AS FRE11006, \n  " ); 
					InsertSql.append( "					CASE WHEN X.FRE12006<100000 THEN X.FRE12006 ELSE 100000 END AS FRE12006, \n  " ); 				
					InsertSql.append( "         X.COL01002, X.COL02002, X.COL03002, X.COL04002, X.COL05002, X.COL06002,  \n  " );
					InsertSql.append( "         X.COL07002, X.COL08002, X.COL09002, X.COL10002, X.COL11002, X.COL12002,  \n  " );
					InsertSql.append( "         X.COL01003, X.COL02003, X.COL03003, X.COL04003, X.COL05003, X.COL06003,  \n  " );
					InsertSql.append( "         X.COL07003, X.COL08003, X.COL09003, X.COL10003, X.COL11003, X.COL12003,  \n  " );
					InsertSql.append( "         X.COL01005, X.COL02005, X.COL03005, X.COL04005, X.COL05005, X.COL06005,  \n  " );
					InsertSql.append( "         X.COL07005, X.COL08005, X.COL09005, X.COL10005, X.COL11005, X.COL12005,  \n  " );
					InsertSql.append( "         X.COL01006, X.COL02006, X.COL03006, X.COL04006, X.COL05006, X.COL06006,  \n  " );
					InsertSql.append( "         X.COL07006, X.COL08006, X.COL09006, X.COL10006, X.COL11006, X.COL12006,  \n  " );
					InsertSql.append( "         X.COL01007, X.COL02007, X.COL03007, X.COL04007, X.COL05007, X.COL06007,  \n  " );
					InsertSql.append( "         X.COL07007, X.COL08007, X.COL09007, X.COL10007, X.COL11007, X.COL12007,  \n  " );
					InsertSql.append( "         X.EXC01001, X.EXC02001, X.EXC03001, X.EXC04001, X.EXC05001, X.EXC06001,  \n  " );
					InsertSql.append( "         X.EXC07001, X.EXC08001, X.EXC09001, X.EXC10001, X.EXC11001, X.EXC12001,  \n  " );
					InsertSql.append( "         X.EXC01005, X.EXC02005, X.EXC03005, X.EXC04005, X.EXC05005, X.EXC06005,  \n  " );
					InsertSql.append( "         X.EXC07005, X.EXC08005, X.EXC09005, X.EXC10005, X.EXC11005, X.EXC12005,  \n  " );

					InsertSql.append( "         X.SINC001,  X.SINC002,  X.SINC004,  X.SINC005,  X.SFRE005,  X.SFRE006,   \n  " );
					InsertSql.append( "         X.SCOL002,  X.SCOL003,  X.SCOL005,  X.SCOL006,  X.SCOL007                \n  " );					
					InsertSql.append( "    FROM PAYROLL.YIPERSON A, PAYROLL.PBPAY B,                                                                      \n  " );
					InsertSql.append( "         ( SELECT EMPNO,                                                                                           \n  " );
					InsertSql.append( "        --급여                                                                                                     \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='01'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC01001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='02'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC02001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='03'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC03001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='04'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC04001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='05'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC05001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='06'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC06001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='07'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC07001,      \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='08'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC08001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='09'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC09001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='10'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC10001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='11'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC11001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='12'	AND NSDAY=0 THEN S92000-PX0020+UBAMT ELSE 0 END) AS INC12001,      \n  " );
					InsertSql.append( "        --상여                                                                                                     \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='01'  AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC01002,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='02'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC02002,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='03'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC03002,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='04'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC04002,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='05'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC05002,                 \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='06'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC06002,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='07'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC07002,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='08'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC08002,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='09'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC09002,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='10'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC10002,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='11'	AND NSDAY=0 THEN S92000+UBAMT ELSE 0 END) AS INC11002,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='12'	AND NSDAY=0 THEN S92000-PX0020 ELSE 0 END) AS INC12002,                 \n  " );
					InsertSql.append( "        --비과세차량                                                                                               \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='01' THEN P24000 ELSE 0 END) AS FRE01005,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='02' THEN P24000 ELSE 0 END) AS FRE02005,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='03' THEN P24000 ELSE 0 END) AS FRE03005,      \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='04' THEN P24000 ELSE 0 END) AS FRE04005,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='05' THEN P24000 ELSE 0 END) AS FRE05005,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='06' THEN P24000 ELSE 0 END) AS FRE06005,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='07' THEN P24000 ELSE 0 END) AS FRE07005,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='08' THEN P24000 ELSE 0 END) AS FRE08005,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='09' THEN P24000 ELSE 0 END) AS FRE09005,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='10' THEN P24000 ELSE 0 END) AS FRE10005,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='11' THEN P24000 ELSE 0 END) AS FRE11005,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='12' THEN P24000 ELSE 0 END) AS FRE12005,      \n  " );
					InsertSql.append( "        --비과세식대                                                                                               \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='01' THEN P35000 ELSE 0 END) AS FRE01006,      \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='02' THEN P35000 ELSE 0 END) AS FRE02006,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='03' THEN P35000 ELSE 0 END) AS FRE03006,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='04' THEN P35000 ELSE 0 END) AS FRE04006,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='05' THEN P35000 ELSE 0 END) AS FRE05006,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='06' THEN P35000 ELSE 0 END) AS FRE06006,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='07' THEN P35000 ELSE 0 END) AS FRE07006,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='08' THEN P35000 ELSE 0 END) AS FRE08006,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='09' THEN P35000 ELSE 0 END) AS FRE09006,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='10' THEN P35000 ELSE 0 END) AS FRE10006,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='11' THEN P35000 ELSE 0 END) AS FRE11006,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='12' THEN P35000 ELSE 0 END) AS FRE12006,      \n  " );
          InsertSql.append( "        --소득세                                                                                                   \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='01' THEN T11000 ELSE 0 END) AS COL01002,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='02' THEN T11000 ELSE 0 END) AS COL02002,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='03' THEN T11000 ELSE 0 END) AS COL03002,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='04' THEN T11000 ELSE 0 END) AS COL04002,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='05' THEN T11000 ELSE 0 END) AS COL05002,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='06' THEN T11000 ELSE 0 END) AS COL06002,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='07' THEN T11000 ELSE 0 END) AS COL07002,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='08' THEN T11000 ELSE 0 END) AS COL08002,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='09' THEN T11000 ELSE 0 END) AS COL09002,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='10' THEN T11000 ELSE 0 END) AS COL10002,  \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='11' THEN T11000 ELSE 0 END) AS COL11002,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='12' THEN T11000 ELSE 0 END) AS COL12002,  \n  " );
					InsertSql.append( "        --지방소득세                                                                                               \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='01' THEN T12000 ELSE 0 END) AS COL01003,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='02' THEN T12000 ELSE 0 END) AS COL02003,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='03' THEN T12000 ELSE 0 END) AS COL03003,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='04' THEN T12000 ELSE 0 END) AS COL04003,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='05' THEN T12000 ELSE 0 END) AS COL05003,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='06' THEN T12000 ELSE 0 END) AS COL06003,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='07' THEN T12000 ELSE 0 END) AS COL07003,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='08' THEN T12000 ELSE 0 END) AS COL08003,  \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='09' THEN T12000 ELSE 0 END) AS COL09003,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='10' THEN T12000 ELSE 0 END) AS COL10003,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='11' THEN T12000 ELSE 0 END) AS COL11003,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='12' THEN T12000 ELSE 0 END) AS COL12003,  \n  " );
					InsertSql.append( "        --국민연금                                                                                                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='01' THEN B12000 ELSE 0 END) AS COL01005,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='02' THEN B12000 ELSE 0 END) AS COL02005,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='03' THEN B12000 ELSE 0 END) AS COL03005,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='04' THEN B12000 ELSE 0 END) AS COL04005,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='05' THEN B12000 ELSE 0 END) AS COL05005,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='06' THEN B12000 ELSE 0 END) AS COL06005,  \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='07' THEN B12000 ELSE 0 END) AS COL07005,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='08' THEN B12000 ELSE 0 END) AS COL08005,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='09' THEN B12000 ELSE 0 END) AS COL09005,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='10' THEN B12000 ELSE 0 END) AS COL10005,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='11' THEN B12000 ELSE 0 END) AS COL11005,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='12' THEN B12000 ELSE 0 END) AS COL12005,  \n  " );
					InsertSql.append( "        --건강보험 ( 4월의 경우는 기타공제1,기타공제2 도 포함 건강보험정산)                                        \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='01' THEN B11000 ELSE 0 END) AS COL01006,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='02' THEN B11000 ELSE 0 END) AS COL02006,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='03' THEN B11000 ELSE 0 END) AS COL03006,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='04' THEN B11000-(BX0020+BX0030) ELSE 0 END) AS COL04006,  \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='05' THEN B11000 ELSE 0 END) AS COL05006,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='06' THEN B11000 ELSE 0 END) AS COL06006,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='07' THEN B11000 ELSE 0 END) AS COL07006,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='08' THEN B11000 ELSE 0 END) AS COL08006,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='09' THEN B11000 ELSE 0 END) AS COL09006,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='10' THEN B11000 ELSE 0 END) AS COL10006,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='11' THEN B11000 ELSE 0 END) AS COL11006,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='12' THEN B11000 ELSE 0 END) AS COL12006,  \n  " );
					InsertSql.append( "        --고용보험                                                                                                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='01' THEN B13000 ELSE 0 END) AS COL01007,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='02' THEN B13000 ELSE 0 END) AS COL02007,  \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='03' THEN B13000 ELSE 0 END) AS COL03007,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='04' THEN B13000 ELSE 0 END) AS COL04007,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='05' THEN B13000 ELSE 0 END) AS COL05007,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='06' THEN B13000 ELSE 0 END) AS COL06007,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='07' THEN B13000 ELSE 0 END) AS COL07007,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='08' THEN B13000 ELSE 0 END) AS COL08007,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='09' THEN B13000 ELSE 0 END) AS COL09007,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='10' THEN B13000 ELSE 0 END) AS COL10007,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='11' THEN B13000 ELSE 0 END) AS COL11007,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='12' THEN B13000 ELSE 0 END) AS COL12007,  \n  " );
					InsertSql.append( "        --소득외 급여 (금강산, 개성에서 만근 했을 경우)                                                                                                    \n  " );
					/**
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='01'	AND NSDAY=31 THEN S92000+P31000+UBAMT ELSE 0 END) AS EXC01001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='02'	AND NSDAY=28 THEN S92000+P31000+UBAMT ELSE 0 END) AS EXC02001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='03'	AND NSDAY=31 THEN S92000+P31000+UBAMT ELSE 0 END) AS EXC03001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='04'	AND NSDAY=30 THEN S92000+P31000+UBAMT ELSE 0 END) AS EXC04001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='05'	AND NSDAY=31 THEN S92000+P31000+UBAMT ELSE 0 END) AS EXC05001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='06'	AND NSDAY=30 THEN S92000+P31000+UBAMT ELSE 0 END) AS EXC06001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='07'	AND NSDAY=31 THEN S92000+P31000+UBAMT ELSE 0 END) AS EXC07001,      \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='08'	AND NSDAY=31 THEN S92000+P31000+UBAMT ELSE 0 END) AS EXC08001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='09'	AND NSDAY=30 THEN S92000+P31000+UBAMT ELSE 0 END) AS EXC09001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='10'	AND NSDAY=31 THEN S92000+P31000+UBAMT ELSE 0 END) AS EXC10001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='11'	AND NSDAY=30 THEN S92000+P31000+UBAMT ELSE 0 END) AS EXC11001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='12'	AND NSDAY=31 THEN S92000+P31000-PX0020+UBAMT ELSE 0 END) AS EXC12001,      \n  " );
					*/
          InsertSql.append( "  SUM(CASE WHEN  SUBSTR(APPDT,5,6)='01'    AND NSDAY=31 THEN CASE WHEN PAYDIV IN ('1','4') THEN S92000+P31000+UBAMT  WHEN PAYDIV IN ('T')  THEN S92000 ELSE 0 END ELSE 0 END) AS EXC01001,         \n  " );
					InsertSql.append( "  SUM(CASE WHEN  SUBSTR(APPDT,5,6)='02'    AND NSDAY=28 THEN CASE WHEN PAYDIV IN ('1','4') THEN S92000+P31000+UBAMT  WHEN PAYDIV IN ('T')  THEN S92000 ELSE 0 END ELSE 0 END) AS EXC02001,         \n  " );
					InsertSql.append( "  SUM(CASE WHEN  SUBSTR(APPDT,5,6)='03'    AND NSDAY=31 THEN CASE WHEN PAYDIV IN ('1','4') THEN S92000+P31000+UBAMT  WHEN PAYDIV IN ('T')  THEN S92000 ELSE 0 END ELSE 0 END) AS EXC03001,         \n  " );
					InsertSql.append( "  SUM(CASE WHEN  SUBSTR(APPDT,5,6)='04'    AND NSDAY=30 THEN CASE WHEN PAYDIV IN ('1','4') THEN S92000+P31000+UBAMT  WHEN PAYDIV IN ('T')  THEN S92000 ELSE 0 END ELSE 0 END) AS EXC04001,         \n  " );
					InsertSql.append( "  SUM(CASE WHEN  SUBSTR(APPDT,5,6)='05'    AND NSDAY=31 THEN CASE WHEN PAYDIV IN ('1','4') THEN S92000+P31000+UBAMT  WHEN PAYDIV IN ('T')  THEN S92000 ELSE 0 END ELSE 0 END) AS EXC05001,         \n  " );
					InsertSql.append( "  SUM(CASE WHEN  SUBSTR(APPDT,5,6)='06'    AND NSDAY=30 THEN CASE WHEN PAYDIV IN ('1','4') THEN S92000+P31000+UBAMT  WHEN PAYDIV IN ('T')  THEN S92000 ELSE 0 END ELSE 0 END) AS EXC06001,         \n  " );
					InsertSql.append( "  SUM(CASE WHEN  SUBSTR(APPDT,5,6)='07'    AND NSDAY=31 THEN CASE WHEN PAYDIV IN ('1','4') THEN S92000+P31000+UBAMT  WHEN PAYDIV IN ('T')  THEN S92000 ELSE 0 END ELSE 0 END) AS EXC07001,         \n  " );
					InsertSql.append( "  SUM(CASE WHEN  SUBSTR(APPDT,5,6)='08'    AND NSDAY=31 THEN CASE WHEN PAYDIV IN ('1','4') THEN S92000+P31000+UBAMT  WHEN PAYDIV IN ('T')  THEN S92000 ELSE 0 END ELSE 0 END) AS EXC08001,         \n  " );
					InsertSql.append( "  SUM(CASE WHEN  SUBSTR(APPDT,5,6)='09'    AND NSDAY=30 THEN CASE WHEN PAYDIV IN ('1','4') THEN S92000+P31000+UBAMT  WHEN PAYDIV IN ('T')  THEN S92000 ELSE 0 END ELSE 0 END) AS EXC09001,         \n  " );
					InsertSql.append( "  SUM(CASE WHEN  SUBSTR(APPDT,5,6)='10'    AND NSDAY=31 THEN CASE WHEN PAYDIV IN ('1','4') THEN S92000+P31000+UBAMT  WHEN PAYDIV IN ('T')  THEN S92000 ELSE 0 END ELSE 0 END) AS EXC10001,         \n  " );
					InsertSql.append( "  SUM(CASE WHEN  SUBSTR(APPDT,5,6)='11'    AND NSDAY=30 THEN CASE WHEN PAYDIV IN ('1','4') THEN S92000+P31000+UBAMT  WHEN PAYDIV IN ('T')  THEN S92000 ELSE 0 END ELSE 0 END) AS EXC11001,         \n  " );
					InsertSql.append( "  SUM(CASE WHEN  SUBSTR(APPDT,5,6)='12'    AND NSDAY=31 THEN CASE WHEN PAYDIV IN ('1','4') THEN S92000+P31000-PX0020+UBAMT  WHEN PAYDIV IN ('T')  THEN S92000 ELSE 0 END ELSE 0 END) AS EXC12001,   \n  " );


					InsertSql.append( "        --소득외 상여 (금강산, 개성에서 만근 했을 경우)                                                                                                    \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='01'  AND NSDAY=31 THEN S92000+UBAMT ELSE 0 END) AS EXC01005,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='02'	AND NSDAY=28 THEN S92000+UBAMT ELSE 0 END) AS EXC02005,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='03'	AND NSDAY=31 THEN S92000+UBAMT ELSE 0 END) AS EXC03005,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='04'	AND NSDAY=30 THEN S92000+UBAMT ELSE 0 END) AS EXC04005,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='05'	AND NSDAY=31 THEN S92000+UBAMT ELSE 0 END) AS EXC05005,                 \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='06'	AND NSDAY=30 THEN S92000+UBAMT ELSE 0 END) AS EXC06005,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='07'	AND NSDAY=31 THEN S92000+UBAMT ELSE 0 END) AS EXC07005,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='08'	AND NSDAY=31 THEN S92000+UBAMT ELSE 0 END) AS EXC08005,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='09'	AND NSDAY=30 THEN S92000+UBAMT ELSE 0 END) AS EXC09005,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='10'	AND NSDAY=31 THEN S92000+UBAMT ELSE 0 END) AS EXC10005,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='11'	AND NSDAY=30 THEN S92000+UBAMT ELSE 0 END) AS EXC11005,                 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV = '5' AND SUBSTR(APPDT,5,6)='12'	AND NSDAY=31 THEN S92000-PX0020 ELSE 0 END) AS EXC12005,                 \n  " );					
					InsertSql.append( "        --년간급여/상여/총급여/소득세계  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') THEN S92000 ELSE 0 END) AS SINC001,      \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('5') THEN S92000 ELSE 0 END) AS SINC002,              \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') THEN S92000 ELSE 0 END) AS SINC004,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') THEN T11000 ELSE 0 END) AS SINC005,  \n  " );
          InsertSql.append( "        --비과세차량/비과세식대계 \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') THEN P24000 ELSE 0 END) AS SFRE005,      \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4') THEN P35000 ELSE 0 END) AS SFRE006,      \n  " );
          InsertSql.append( "        --소득세/지역소득세/국민연금/건강보험/고용보험계 \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') THEN T11000 ELSE 0 END) AS SCOL002,  \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') THEN T12000 ELSE 0 END) AS SCOL003,  \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') THEN B12000 ELSE 0 END) AS SCOL005,  \n  " );
          //InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') THEN B11000 ELSE 0 END) AS SCOL006,  \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') THEN B11000 ELSE 0 END)- \n  " );
					InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') AND SUBSTR(APPDT,5,6)='04' THEN (BX0020+BX0030) ELSE 0 END)  AS SCOL006,  \n  " );
          InsertSql.append( "        SUM(CASE WHEN PAYDIV IN ('1','T','4','5') THEN B13000 ELSE 0 END) AS SCOL007   \n  " );
					InsertSql.append( "        FROM PAYROLL.PBPAY                                                                      \n  " );
          InsertSql.append( "       WHERE APPDT LIKE '"+rows[j].getString(idxAPPYY)+"%' \n " );
					//InsertSql.append( "        AND EMPNO ='2010017'                                                                  \n  " );
					InsertSql.append( "       GROUP BY EMPNO                                                                           \n  " );
					InsertSql.append( "     )X                                                                                         \n  " );
					InsertSql.append( "   WHERE B.APPDT = '"+rows[j].getString(idxAPPYY)+"12'                                          \n  " );
					InsertSql.append( "     AND A.EMPNO = B.EMPNO                                                                      \n  " );
					InsertSql.append( "     AND B.PAYDIV IN ('1','4','T')                                                              \n  " );
					InsertSql.append( "     AND (A.ENDDT = '' OR  A.ENDDT >= ? )                                                       \n  " );
					//InsertSql.append( "     AND (B.PAYDIV IN ('1','4','T' ))                                                           \n  " );
					//InsertSql.append( "     AND ((A.ENDDT = '' OR  A.ENDDT > ? )                                                       \n  " );
					//InsertSql.append( "        OR B.EMPNO IN ('1990013','2070012','3040038','3050022','3070015','3070034','3090018'))  \n  " );
					//InsertSql.append( "     AND A.EMPNO ='2010017'                                                                   \n  " );
					InsertSql.append( "     AND A.EMPNO = X.EMPNO                                                                      \n  " );
          
					//logger.dbg.println(this,"nsertSql.toString()::::"+InsertSql.toString());
         
					gsmt = conn.getGauceStatement(InsertSql.toString());
					gsmt.setGauceDataRow(rows[j]);  
					gsmt.bindColumn(1, idxAPPYMD);
					gsmt.executeUpdate();
					gsmt.close();
          gsmt=null;      
					InsertSql=null;

          /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
					//금강산, 개성 소득, 소득외급여 구분하기
					//2010.08 월 부터 나누기
					
					SelectSql = new StringBuffer();
					SelectSql.append( " SELECT JTGB, EMPNO, PAYDIV,APPDT,TRIM(SUBSTR(APPDT,5,6))APPMM,INTEGER(SUBSTR(APPDT,5,6))INTMM,\n" ); 
					SelectSql.append( "       S91000,                                                            \n" ); 
					SelectSql.append( "       CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='12' THEN  S92000-PX0020 ELSE S92000 END AS  S92000,  \n" ); 
					SelectSql.append( "       T11000,T12000,                                                                          \n" ); 
					SelectSql.append( "       P10000,P11000,P12000,P21000,P22000,P29000,                                              \n" ); 
					SelectSql.append( "       P24000,P35000,P31000,P39000,                                                            \n" );
					SelectSql.append( "       P23000,P28000,P32000,P34000,P37000,                                                     \n" ); 
					SelectSql.append( "       PX0020,PX0030,PX0040,UBAMT,                                                             \n" ); 
					SelectSql.append( "       NSDAY, BSDAY, NSDAY+BSDAY+(HJDAY-NSDAY) AS TSDAY,                                       \n" ); 
					SelectSql.append( "       ROUND(CASE WHEN SUBSTR(APPDT,5,2)<'08' THEN P10000*(NSDAY+BSDAY)/(BSDAY*0.7+NSDAY*0.9)  \n" );
					SelectSql.append( "             ELSE P10000*(NSDAY+BSDAY)/(BSDAY+NSDAY*0.85) END,0) ORI_P10000,                   \n" ); 
					SelectSql.append( "       ROUND(CASE WHEN SUBSTR(APPDT,5,2)<'08' THEN P11000*(NSDAY+BSDAY)/(BSDAY*0.7+NSDAY*0.9)  \n" ); 
					SelectSql.append( "       	  ELSE P11000*(NSDAY+BSDAY)/(NSDAY*0.85) END,-1) ORI_P11000,                          \n" ); 
					SelectSql.append( "       ROUND(CASE WHEN SUBSTR(APPDT,5,2)<'08' THEN P12000*(NSDAY+BSDAY)/(BSDAY*0.7+NSDAY*0.9)  \n" ); 
					SelectSql.append( "       	  ELSE P12000*(NSDAY+BSDAY)/(NSDAY*0.85) END,-1) ORI_P12000,                          \n" ); 
					SelectSql.append( "       ROUND(CASE WHEN SUBSTR(APPDT,5,2)<'08' THEN P21000*(NSDAY+BSDAY)/(BSDAY*0.7+NSDAY*0.9)  \n" ); 
					SelectSql.append( "       	  ELSE P21000*(NSDAY+BSDAY)/(NSDAY*0.85) END,-1) ORI_P21000,                          \n" ); 
					SelectSql.append( "       ROUND(CASE WHEN SUBSTR(APPDT,5,2)<'08' THEN P22000*(NSDAY+BSDAY)/(BSDAY*0.7+NSDAY*0.9)  \n" ); 
					SelectSql.append( "       	  ELSE P22000*(NSDAY+BSDAY)/(NSDAY*0.85) END,-1) ORI_P22000,                          \n" ); 
					SelectSql.append( "       ROUND(CASE WHEN SUBSTR(APPDT,5,2)<'08' THEN P29000*(NSDAY+BSDAY)/(BSDAY*0.7+NSDAY*0.9)  \n" ); 
					SelectSql.append( "       	  ELSE P29000*(NSDAY+BSDAY)/(NSDAY*0.85) END,-1) ORI_P29000                           \n" ); 
					SelectSql.append( "  FROM PAYROLL.PBPAY                                                                           \n" ); 
					SelectSql.append( " WHERE SUBSTR(APPDT,1,4) = '"+strYyyy+"'                                                       \n" );
					SelectSql.append( "   AND PAYDIV IN ('1','4','T','5')                                                             \n" ); 
					//SelectSql.append( "   AND EMPNO IN ('2080021','2040075','2090010')                                                \n" ); 
					SelectSql.append( "   AND NSDAY>0 AND ( BSDAY+HJDAY)>0  AND (NSDAY<>BSDAY+HJDAY)                                  \n" ); 

					stmt = conn.createStatement();
					rs = stmt.executeQuery(SelectSql.toString());
       
			    /////////////////////////////////
			    //개성 및 금강산에서 근무한 경우
          ///////////////////////////////// 
 
					while(rs.next()){         
						strINC001="INC"+rs.getString("APPMM")+"001"; //소득급여
						strEXC001="EXC"+rs.getString("APPMM")+"001"; //소득외급여
            strINC002="INC"+rs.getString("APPMM")+"002"; //소득상여
						strEXC005="EXC"+rs.getString("APPMM")+"005"; //소득외상여

						if(!rs.getString(1).equals("0")){ //재택인경우    			   
							
                //소득급여/////////////////////////////////////////////////////////////////////////////////
								if(rs.getInt("INTMM")>=8){ //8월이후 적용
									//^^logger.dbg.println(this,"큰경우::"+rs.getString("APPMM"));
									if(rs.getString("PAYDIV").equals("5")){ //상여일경우
                    intINC002 = (int)Math.round(rs.getDouble("ORI_P10000")*rs.getInt("BSDAY")/rs.getInt("TSDAY"));
										intEXC005 = (int)Math.round(rs.getDouble("S92000")-intINC002);
									}else{ //급여
										intINC001 = (int)Math.round(rs.getDouble("ORI_P10000")*rs.getInt("BSDAY")/rs.getInt("TSDAY"));
										intEXC001 = (int)Math.round(rs.getDouble("S92000")+rs.getInt("P31000")+rs.getInt("UBAMT")-intINC001);
										if(rs.getString("PAYDIV").equals("T")){ 
	                    intEXC001 = rs.getInt("S92000")-intINC001;
										}
									}
								}else{ //8월이전 적용
                  //^^logger.dbg.println(this,"작은경우::"+rs.getString("APPMM"));
									intP10000 = (int)Math.round(rs.getDouble("ORI_P10000")*rs.getInt("BSDAY")/rs.getInt("TSDAY")*7/10); //기본
									intP11000 = (int)Math.round(rs.getDouble("ORI_P11000")*rs.getInt("BSDAY")/rs.getInt("TSDAY")*7/10); //직책
									intP12000 = (int)Math.round(rs.getDouble("ORI_P12000")*rs.getInt("BSDAY")/rs.getInt("TSDAY")*7/10); //시간외
									intP21000 = (int)Math.round(rs.getDouble("ORI_P21000")*rs.getInt("BSDAY")/rs.getInt("TSDAY")*7/10); //근속
									intP22000 = (int)Math.round(rs.getDouble("ORI_P22000")*rs.getInt("BSDAY")/rs.getInt("TSDAY")*7/10); //자기개발
									intP29000 = (int)Math.round(rs.getDouble("ORI_P29000")*rs.getInt("BSDAY")/rs.getInt("TSDAY")*7/10); //남북경협
                  
									intP23000 = (int)Math.round(rs.getDouble("P23000")*rs.getInt("BSDAY")/rs.getInt("TSDAY")); //가족부양비
									intP37000 = (int)Math.round(rs.getDouble("P37000")*rs.getInt("BSDAY")/rs.getInt("TSDAY")); //개인연금
									intP39000 = (int)Math.round(rs.getDouble("P39000")) ;//전월소급

                  if(rs.getString("PAYDIV").equals("5")){ //상여일경우(상여는 특수지 수당없음 ) 
										intINC002 = intP10000+intP11000+intP12000+intP21000+intP22000+intP29000;
										intEXC005 = rs.getInt("S92000")-intINC002;
									}else{ //급여 OK
										intINC001 = intP10000+intP11000+intP12000+intP21000+intP22000+intP29000+intP23000+intP37000+intP39000;
										intEXC001 = rs.getInt("S92000")+rs.getInt("P31000")+rs.getInt("UBAMT")-intINC001;
										if(rs.getString("PAYDIV").equals("T")){ 
	                    intEXC001 = rs.getInt("S92000")-intINC001;
										}
									}
								}
								/////////////////////////////////////////////////////////////////////////////////////////////
          
								if(rs.getString("PAYDIV").equals("5")){ //상여일경우 
									// 상여 소득외 상여
									UpdateSql = new StringBuffer();
									UpdateSql.append( "  UPDATE PAYROLL.YCPERCOL SET  \n" );
									UpdateSql.append( "  "+strINC002+"="+intINC002+", \n");
									UpdateSql.append( "  "+strEXC005+"="+intEXC005+" \n");
									UpdateSql.append( "  WHERE YYYY =  '"+strYyyy+"'  " );
									UpdateSql.append( "    AND EMPNO =  '"+rs.getString("EMPNO")+"' " );

									//^^logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
									gsmt = conn.getGauceStatement(UpdateSql.toString());
									gsmt.executeUpdate();
									gsmt.close();

								}else{//급여일 경우

                  /*
                  logger.dbg.println(this,"재택급여");
                  logger.dbg.println(this,"intP10000::"+intP10000);
									logger.dbg.println(this,"intP11000::"+intP11000);
									logger.dbg.println(this,"intP12000::"+intP12000);
									logger.dbg.println(this,"intP21000::"+intP21000);
									logger.dbg.println(this,"intP22000::"+intP22000);
									logger.dbg.println(this,"intP29000::"+intP29000);

									logger.dbg.println(this,"intP23000::"+intP23000);
									logger.dbg.println(this,"intP37000::"+intP37000);
									logger.dbg.println(this,"intP28000::"+intP28000);
									logger.dbg.println(this,"intUBAMT::"+intUBAMT);

									logger.dbg.println(this,"intINC001::"+intINC001);
									logger.dbg.println(this,"intEXC001::"+intEXC001);
									*/
 
									// 급여 - 소득외급여
									UpdateSql = new StringBuffer();
									UpdateSql.append( "  UPDATE PAYROLL.YCPERCOL SET  \n" );
									UpdateSql.append( "  "+strINC001+"="+intINC001+", \n");
									UpdateSql.append( "  "+strEXC001+"="+intEXC001+" \n");
									UpdateSql.append( "  WHERE YYYY =  '"+strYyyy+"'  " );
									UpdateSql.append( "    AND EMPNO = '"+rs.getString("EMPNO")+"' " );

									//^^logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
									gsmt = conn.getGauceStatement(UpdateSql.toString());
									gsmt.executeUpdate();
									gsmt.close();
								}

						}else{  // 재택이 아닌 경우
							  /***************************************************************************
							  //지점간 이동이 발생한 경우 (재택은 아님) 
						    //특수지  --> 소득외
								//차량유지--> 비과세(20만원초과분만 소득)
                //나머진 모두 근무일수로 일할 계산하여 넣으면 됨.
            		//기본급여 구할 필요없음.
								//유보금도 나눠서 넣으면 됨.
								//소득외 급여 = 급여 - 소득급여  
								****************************************************************************/
                //소득급여
								intWkday  = rs.getInt("TSDAY")-rs.getInt("NSDAY");              						

           			//intP10000 = Math.round(rs.getDouble("P10000")*intWkday/rs.getDouble("TSDAY")); //기본
								intP10000 = (int)Math.round(rs.getDouble("P10000")*intWkday/rs.getDouble("TSDAY")); //기본
								intP11000 = (int)Math.round(rs.getDouble("P11000")*intWkday/rs.getDouble("TSDAY")); //직책
								intP12000 = (int)Math.round(rs.getDouble("P12000")*intWkday/rs.getDouble("TSDAY")); //시간외
								intP21000 = (int)Math.round(rs.getDouble("P21000")*intWkday/rs.getDouble("TSDAY")); //근속
								intP22000 = (int)Math.round(rs.getDouble("P22000")*intWkday/rs.getDouble("TSDAY")); //자기개발
								intP29000 = (int)Math.round(rs.getDouble("P29000")*intWkday/rs.getDouble("TSDAY")); //남북경협

								intP23000 = (int)Math.round(rs.getDouble("P23000")*intWkday/rs.getDouble("TSDAY")); //가족부양
								intP37000 = (int)Math.round(rs.getDouble("P37000")*intWkday/rs.getDouble("TSDAY")); //개인연금
								intP28000 = (int)Math.round(rs.getDouble("P28000")*intWkday/rs.getDouble("TSDAY")); //자격수당
                intP32000 = (int)Math.round(rs.getDouble("P32000")*intWkday/rs.getDouble("TSDAY")); //지역근무
								intP34000 = (int)Math.round(rs.getDouble("P34000")*intWkday/rs.getDouble("TSDAY")); //연차수당

								intUBAMT  = (int)Math.round(rs.getDouble("UBAMT")*intWkday/rs.getDouble("TSDAY")); //유보금액

								//차량유지비 : 20만원까지 비과세- 초과금액 과세
								if(rs.getDouble("P24000")>200000){
                  intP24000 =  rs.getInt("P24000")-200000;
								}else{
                  intP24000=0;
								}

								//식대
								if(rs.getDouble("P35000")>100000){
                  intP35000 =  rs.getInt("P35000")-100000;
								}else{
                  intP35000=0;
								}
								
								if(rs.getString("PAYDIV").equals("5")){ //상여일경우 
									//^^logger.dbg.println(this,"상여");

                  intINC002 = intP10000+intP11000+intP12000+intP21000+intP22000+intP29000+intUBAMT;

                  //소득외 급여 = 소득급여 + 특수지수당 + 유보금액 - 소득급여 
									//( 유보금액 중 오류발생하는 것 모두 맞춰야함. )
									intEXC005 = rs.getInt("S92000")+rs.getInt("UBAMT")-intINC002;
                  
									/*

									logger.dbg.println(this,"재택아닌상여");

									logger.dbg.println(this,"intP10000::"+intP10000);
									logger.dbg.println(this,"intP11000::"+intP11000);
									logger.dbg.println(this,"intP12000::"+intP12000);
									logger.dbg.println(this,"intP21000::"+intP21000);
									logger.dbg.println(this,"intP22000::"+intP22000);
									logger.dbg.println(this,"intP29000::"+intP29000);
									logger.dbg.println(this,"intUBAMT::"+intUBAMT);

									logger.dbg.println(this,"intINC002::"+intINC002);
									logger.dbg.println(this,"intEXC005::"+intEXC005);
                  */

									// 급여 소득외급여
									UpdateSql = new StringBuffer();
									UpdateSql.append( "  UPDATE PAYROLL.YCPERCOL SET  \n" );
									UpdateSql.append( "  "+strINC002+"="+intINC002+", \n");
									UpdateSql.append( "  "+strEXC005+"="+intEXC005+" \n");
									UpdateSql.append( "  WHERE YYYY =  '"+strYyyy+"'  " );
									UpdateSql.append( "    AND EMPNO =  '"+rs.getString("EMPNO")+"' " );

									//logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
									gsmt = conn.getGauceStatement(UpdateSql.toString());
									gsmt.executeUpdate();
									gsmt.close();

								}else{ //급여일경우

									intINC001 = intP10000+intP11000+intP12000+intP21000+intP22000+intP29000
														+ intP23000+intP37000+intP28000+intP32000+intP34000+intUBAMT;

                  //소득외 급여 = 소득급여 + 특수지수당 + 유보금액 - 소득급여 
									//( 유보금액 중 오류발생하는 것 모두 맞춰야함. )
									intEXC001 = rs.getInt("S92000")+rs.getInt("P31000")+rs.getInt("UBAMT")-intINC001;
									if(rs.getString("PAYDIV").equals("T")){ 
	                   intEXC001 = rs.getInt("S92000")-intINC001;
									}

                  /* 
                  logger.dbg.println(this,"재택아닌급여");
									logger.dbg.println(this,"intP10000::"+intP10000);
									logger.dbg.println(this,"intP11000::"+intP11000);
									logger.dbg.println(this,"intP12000::"+intP12000);
									logger.dbg.println(this,"intP21000::"+intP21000);
									logger.dbg.println(this,"intP22000::"+intP22000);
									logger.dbg.println(this,"intP29000::"+intP29000);

									logger.dbg.println(this,"intP23000::"+intP23000);
									logger.dbg.println(this,"intP37000::"+intP37000);
									logger.dbg.println(this,"intP28000::"+intP28000);
									logger.dbg.println(this,"intP32000::"+intP32000);
									logger.dbg.println(this,"intP34000::"+intP34000);
									logger.dbg.println(this,"intUBAMT::"+intUBAMT);

									logger.dbg.println(this,"intINC001::"+intINC001);
									logger.dbg.println(this,"intEXC001::"+intEXC001);
                  */

									UpdateSql = new StringBuffer();
									UpdateSql.append( "  UPDATE PAYROLL.YCPERCOL SET  \n" );
									UpdateSql.append( "  "+strINC001+"="+intINC001+", \n" );
									UpdateSql.append( "  "+strEXC001+"="+intEXC001+"  \n" );
									UpdateSql.append( "  WHERE YYYY =  '"+strYyyy+"'  \n" );
									UpdateSql.append( "    AND EMPNO = '"+rs.getString("EMPNO")+"' " );

									//logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
									gsmt = conn.getGauceStatement(UpdateSql.toString());
									gsmt.executeUpdate();
									gsmt.close();
								}
						}
					}
					rs.close();
					stmt.close();

          //해당년도 합계금액 UPDATE 
					UpdateSql = new StringBuffer();
					UpdateSql.append( "  UPDATE PAYROLL.YCPERCOL SET  \n" );
					UpdateSql.append( "  INC01004 = INC01001+INC01002+INC01003,  \n" );    //월별 총급여 
					UpdateSql.append( "  INC02004 = INC02001+INC02002+INC02003,  \n" );
					UpdateSql.append( "  INC03004 = INC03001+INC03002+INC03003,  \n" );
					UpdateSql.append( "  INC04004 = INC04001+INC04002+INC04003,  \n" );
					UpdateSql.append( "  INC05004 = INC05001+INC05002+INC05003,  \n" );
					UpdateSql.append( "  INC06004 = INC06001+INC06002+INC06003,  \n" );
					UpdateSql.append( "  INC07004 = INC07001+INC07002+INC07003,  \n" );
					UpdateSql.append( "  INC08004 = INC08001+INC08002+INC08003,  \n" );
					UpdateSql.append( "  INC09004 = INC09001+INC09002+INC09003,  \n" );
					UpdateSql.append( "  INC10004 = INC10001+INC10002+INC10003,  \n" );
					UpdateSql.append( "  INC11004 = INC11001+INC11002+INC11003,  \n" );
					UpdateSql.append( "  INC12004 = INC12001+INC12002+INC12003,  \n" );
					UpdateSql.append( "  SFRE005  = FRE01005+FRE02005+FRE03005+FRE04005+FRE05005+FRE06005+FRE07005+FRE08005+FRE09005+FRE10005+FRE11005+FRE12005,  \n" ); //년간차량비과세합계
          UpdateSql.append( "  SFRE006  = FRE01006+FRE02006+FRE03006+FRE04006+FRE05006+FRE06006+FRE07006+FRE08006+FRE09006+FRE10006+FRE11006+FRE12006,  \n" ); //년간식대비과세합계
					UpdateSql.append( "  SINC001=INC01001+INC02001+INC03001+INC04001+INC05001+INC06001+INC07001+INC08001+INC09001+INC10001+INC11001+INC12001,   \n" ); //년간급여계
					UpdateSql.append( "  SINC002=INC01002+INC02002+INC03002+INC04002+INC05002+INC06002+INC07002+INC08002+INC09002+INC10002+INC11002+INC12002,   \n" ); //년간상여계
					UpdateSql.append( "  SINC003=INC01003+INC02003+INC03003+INC04003+INC05003+INC06003+INC07003+INC08003+INC09003+INC10003+INC11003+INC12003,   \n" ); //년간인정상여계
					UpdateSql.append( "  SINC004=INC01001+INC02001+INC03001+INC04001+INC05001+INC06001+INC07001+INC08001+INC09001+INC10001+INC11001+INC12001    \n" ); //년간총급여계
					UpdateSql.append( "         +INC01002+INC02002+INC03002+INC04002+INC05002+INC06002+INC07002+INC08002+INC09002+INC10002+INC11002+INC12002    \n" );
          UpdateSql.append( "         +INC01003+INC02003+INC03003+INC04003+INC05003+INC06003+INC07003+INC08003+INC09003+INC10003+INC11003+INC12003,   \n" );
					UpdateSql.append( "  SINC005=INC01005+INC02005+INC03005+INC04005+INC05005+INC06005+INC07005+INC08005+INC09005+INC10005+INC11005+INC12005    \n" ); //년간소득세계 
					UpdateSql.append( "  WHERE YYYY = '"+strYyyy+"' \n" );
					
   				//logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
					gsmt = conn.getGauceStatement(UpdateSql.toString());
					gsmt.executeUpdate();
					gsmt.close();


					//계약직 북측근무수당 존재하는 사람의 소득외 급여에서 북측근무수당만큼 차감함.

					SelectSql = new StringBuffer();
					SelectSql.append( " SELECT JTGB, EMPNO, PAYDIV,APPDT,TRIM(SUBSTR(APPDT,5,6))APPMM,INTEGER(SUBSTR(APPDT,5,6))INTMM,\n" ); 
					SelectSql.append( "       S91000,                                                            \n" ); 
					SelectSql.append( "       CASE WHEN PAYDIV IN ('1','T','4') AND SUBSTR(APPDT,5,6)='12' THEN  S92000 -PX0020 ELSE S92000 END AS  S92000,  \n" ); 
					SelectSql.append( "       T11000,T12000,                                                                          \n" ); 
					SelectSql.append( "       P10000,P11000,P12000,P21000,P22000,P29000,                                              \n" ); 
					SelectSql.append( "       P24000,P35000,P31000,P39000,                                                            \n" );
					SelectSql.append( "       P23000,P28000,P32000,P34000,P37000,                                                     \n" ); 
					SelectSql.append( "       PX0020,PX0030,PX0040,UBAMT,                                                             \n" ); 
					SelectSql.append( "       NSDAY, BSDAY, NSDAY+BSDAY+(HJDAY-NSDAY) AS TSDAY,                                       \n" ); 
					SelectSql.append( "       ROUND(CASE WHEN SUBSTR(APPDT,5,2)<'08' THEN P10000*(NSDAY+BSDAY)/(BSDAY*0.7+NSDAY*0.9)  \n" );
					SelectSql.append( "             ELSE P10000*(NSDAY+BSDAY)/(BSDAY+NSDAY*0.85) END,0) ORI_P10000,                   \n" ); 
					SelectSql.append( "       ROUND(CASE WHEN SUBSTR(APPDT,5,2)<'08' THEN P11000*(NSDAY+BSDAY)/(BSDAY*0.7+NSDAY*0.9)  \n" ); 
					SelectSql.append( "       	  ELSE P11000*(NSDAY+BSDAY)/(NSDAY*0.85) END,-1) ORI_P11000,                          \n" ); 
					SelectSql.append( "       ROUND(CASE WHEN SUBSTR(APPDT,5,2)<'08' THEN P12000*(NSDAY+BSDAY)/(BSDAY*0.7+NSDAY*0.9)  \n" ); 
					SelectSql.append( "       	  ELSE P12000*(NSDAY+BSDAY)/(NSDAY*0.85) END,-1) ORI_P12000,                          \n" ); 
					SelectSql.append( "       ROUND(CASE WHEN SUBSTR(APPDT,5,2)<'08' THEN P21000*(NSDAY+BSDAY)/(BSDAY*0.7+NSDAY*0.9)  \n" ); 
					SelectSql.append( "       	  ELSE P21000*(NSDAY+BSDAY)/(NSDAY*0.85) END,-1) ORI_P21000,                          \n" ); 
					SelectSql.append( "       ROUND(CASE WHEN SUBSTR(APPDT,5,2)<'08' THEN P22000*(NSDAY+BSDAY)/(BSDAY*0.7+NSDAY*0.9)  \n" ); 
					SelectSql.append( "       	  ELSE P22000*(NSDAY+BSDAY)/(NSDAY*0.85) END,-1) ORI_P22000,                          \n" ); 
					SelectSql.append( "       ROUND(CASE WHEN SUBSTR(APPDT,5,2)<'08' THEN P29000*(NSDAY+BSDAY)/(BSDAY*0.7+NSDAY*0.9)  \n" ); 
					SelectSql.append( "       	  ELSE P29000*(NSDAY+BSDAY)/(NSDAY*0.85) END,-1) ORI_P29000                           \n" ); 
					SelectSql.append( "  FROM PAYROLL.PBPAY                                                                           \n" ); 
					SelectSql.append( " WHERE SUBSTR(APPDT,1,4) = '"+strYyyy+"'                                                       \n" );
					SelectSql.append( "   AND PAYDIV IN ('1','4','T','5')                                                             \n" ); 
					//SelectSql.append( "   AND EMPNO IN ('2080021','2040075','2090010')                                                \n" ); 
					SelectSql.append( "   AND NSDAY>0 AND ( BSDAY+HJDAY)>0  AND (NSDAY<>BSDAY+HJDAY)                                  \n" ); 








				 } //getJobType
			}  //for j 
     			
			} //try
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::");
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
      conn.commit();
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