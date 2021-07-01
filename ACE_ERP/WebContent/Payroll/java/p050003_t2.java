package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050003_t2 extends HttpServlet{

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
						logger.dbg.println(this,"11");

//Table Name	보험등급변경및납부실적		Update:
//COLUMN	ATTRIBUTE	NULL	LABEL
//DROP TABLE PWMEDPAY;			
//CREATE TABLE PWMEDPAY (			
//STRDT	CHAR(4)	NOT NULL,	/*  기준년도*/
//INSCD	CHAR(1)	NOT NULL,	/*  구분코드*/
//RESINO	CHAR(13)	NOT NULL,	/*  주민번호*/
//EMPNO	CHAR(7)	,	/*  사번*/
//MEDSO1	CHAR(4)	,	/*  조합기호*/
//MEDSO2	CHAR(6)	,	/*  연번*/
//MEDSO3	CHAR(6)	,	/*  사업장번호*/
//MEDSO4	CHAR(4)	,	/*  단위사업장*/
//MEDSNO	CHAR(8)	,	/*  건강보험증번호*/
//NAME	CHAR(14)	,	/*  성명*/		
//GETDT	CHAR(8)	,	/*  자격취득일*/		
//MEDAMT1	NUMERIC(15 , 0)	DEFAULT 0,	/*  전년도보험료납부*/		
//MEDAMT2	NUMERIC(15 , 0)	DEFAULT 0,	/*  실납부보험료*/		
//M12100	NUMERIC(15 , 0)	DEFAULT 0,	/*  전년도보수총액*/		
//DUTMON	NUMERIC(2 , 0)	DEFAULT 0,	/*  근무월수*/		
//OGRCD	NUMERIC(3 , 0)	DEFAULT 0,	/*  종전등급*/		
//NGRCD	NUMERIC(3 , 0)	DEFAULT 0,	/*  결정등급*/		
//CHK1	CHAR(1)	,	/*  확인여부*/		
//CHK2	CHAR(1)	,	/*  결정여부*/		
///* Primary key Define */					
//       CONSTRAINT PWMEDPAYPK PRIMARY KEY ( STRDT, INSCD, RESINO)); 					

				//"DEPTNM",	   /* 부서 */
				//"EMPNO",       /*사번*/
				//"EMPNMK",       /*성명*/
				//
				 // "RESINO",	       /* 주민번호 */
				//
				//"MEDSNO",	/* 보험증번호*/
				//
				//"GETDT",	/*  자격취득일*/
				//"MEDAMT1",	/*  전년도보험료납부*/
				//"MEDAMT2",	/* 실납부보험료*/
				//"M12100",	/*  전년도보수총액*/
				//"DUTMON",	/*  개월*/
				//
				 // "NGRCD",	/*  결정등급*/
				//"STRDT",	/*  기준년도*/
				//"INSCD"	/*  구분코드*/
				int idxSTRDT	= userSet.indexOfColumn("STRDT");
				int idxINSCD	= userSet.indexOfColumn("INSCD");
				int idxRESINO	= userSet.indexOfColumn("RESINO");
				int idxGETDT	= userSet.indexOfColumn("GETDT");
				int idxMEDAMT1	= userSet.indexOfColumn("MEDAMT1");

				int idxMEDAMT2	= userSet.indexOfColumn("MEDAMT2");

				int idxM12100	= userSet.indexOfColumn("M12100");
				int idxDUTMON	= userSet.indexOfColumn("DUTMON");
				int idxNGRDCD	= userSet.indexOfColumn("NGRDCD");

				//		logger.dbg.println(this,"11");

				GauceDataRow[] rows = userSet.getDataRows();

				/*Statement stmt2 = conn.createStatement();
				String sql2 = " SELECT MAX(ZIPSEQ) + 1 ZIPSEQ FROM PAYROLL.HCPOSTNO ";
				ResultSet rs2 = stmt2.executeQuery(sql2);

				int dbl_zipseq = 0;
				if(rs2.next()){ 
					dbl_zipseq = rs2.getInt(1);
				}*/

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				//		logger.dbg.println(this,"11");



				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						logger.dbg.println(this,"12");
						/*InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO PAYROLL.PWINDIPN ( " );
						InsertSql.append( "EMPNO,APPYM,INSGB,GRDCD,STDAMT, INSAMT,MEDSNO,GETDT,LOSDT,REPDT " );
						InsertSql.append( ") VALUES( " );
						InsertSql.append( " ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " );

						logger.dbg.println(this,InsertSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxEMPNO);	   	
						gsmt.bindColumn(2, idxAPPYM);	   		
						gsmt.bindColumn(3, idxINSGB);		   	
						gsmt.bindColumn(4, idxGRDCD);	   		
						gsmt.bindColumn(5, idxSTDAMT);
						gsmt.bindColumn(6, idxINSAMT);		   	
						gsmt.bindColumn(7, idxMEDSNO);	   		
						gsmt.bindColumn(8, idxGETDT);
						gsmt.bindColumn(9, idxLOSDT);	   		
						gsmt.bindColumn(10, idxREPDT);
						//gsmt.executeUpdate();
						//gsmt.close();
						InsertSql=null;*/
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					//	logger.dbg.println(this,"13");
						UpdateSql = new StringBuffer();
						UpdateSql.append( "UPDATE PAYROLL.PWMEDPAY SET  " );  
						UpdateSql.append( " GETDT	= ?, " );
						UpdateSql.append( " MEDAMT1	= ?, " );
						UpdateSql.append( " MEDAMT2	= ?, " );
						UpdateSql.append( " M12100	= ?, " );
						UpdateSql.append( " DUTMON	= ?, " );
						UpdateSql.append( " NGRDCD	= ?  " );
						UpdateSql.append( "  WHERE STRDT = ? " );
						UpdateSql.append( " AND INSCD = ? " );
						UpdateSql.append( " AND RESINO = ? " );
						logger.dbg.println(this,UpdateSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxGETDT);
						gsmt.bindColumn(2, idxMEDAMT1);
						gsmt.bindColumn(3, idxMEDAMT2);
						gsmt.bindColumn(4, idxM12100);
						gsmt.bindColumn(5, idxDUTMON);
						gsmt.bindColumn(6, idxNGRDCD);
						gsmt.bindColumn(7, idxSTRDT);
						gsmt.bindColumn(8, idxINSCD);
						gsmt.bindColumn(9, idxRESINO);
						logger.dbg.println(this,"13");

						gsmt.executeUpdate(); 
						gsmt.close(); 
						UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM PAYROLL.PWMEDPAY WHERE STRDT = ? AND INSCD	= ? AND RESINO	= ? " );

						logger.dbg.println(this,"DeleteSql :"+ DeleteSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxSTRDT);
						gsmt.bindColumn(2, idxINSCD);
						gsmt.bindColumn(3, idxRESINO);
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