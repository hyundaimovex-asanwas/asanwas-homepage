package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050004_t1 extends HttpServlet{

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
					//	logger.dbg.println(this,"11");

				//"EMPNO",	   /* 사번 */
				//"APPYM",       /*년월*/
				//"RESINO",      /*가족주민번호*/
				//"SCHYEAR",      /*학년*/
				//"SCHNM",	   /* 학교명 */
				//"APPDT",       /*신청일*/
				//"APPAMT",      /*신청금액*/
				//"REQREM",      /*신청내역*/
				//"PAYAMT"      /*확정금액*/

				int idxEMPNO	= userSet.indexOfColumn("EMPNO");
				int idxAPPYM	= userSet.indexOfColumn("APPYM");
				int idxRESINO	= userSet.indexOfColumn("RESINO");
				int idxSCHYEAR	= userSet.indexOfColumn("SCHYEAR");
				int idxSCHNM	= userSet.indexOfColumn("SCHNM");

				int idxAPPDT	= userSet.indexOfColumn("APPDT");
				int idxAPPAMT	= userSet.indexOfColumn("APPAMT");
				int idxREQREM	= userSet.indexOfColumn("REQREM");
				int idxPAYAMT	= userSet.indexOfColumn("PAYAMT");
						//logger.dbg.println(this,"11");

				GauceDataRow[] rows = userSet.getDataRows();
			//DROP TABLE PWSCHREQ;			
			//CREATE TABLE PWSCHREQ (			
			//EMPNO	CHAR(7) 	NOT NULL,	/*  사번*/
			//APPYM	CHAR(6)	NOT NULL,	/*  년월*/
			//RESINO	CHAR(13)	NOT NULL,	/*  주민번호*/
			//SCHYEAR	CHAR(1)	,	/*  학년*/
			//SCHNM	VARCHAR(40)	,	/*  학교명*/
			//APPDT	CHAR(8)	,	/*  신청일*/
			//APPAMT	NUMERIC(7,0)	DEFAULT 0,	/*  신청금액*/
			//REQREM	VARCHAR(40)	,	/*  신청내역*/
			//PROYM	CHAR(6)	,	/*  지급예정년월*/
			//PAYAMT	NUMERIC(7,0)	DEFAULT 0,	/*  지급금액*/
			//PAYDT	CHAR(8)	,	/*  지급일자*/
			///* Primary key Define */			
//       CONSTRAINT PWSCHREQPK PRIMARY KEY ( EMPNO, APPYM, RESINO)); 


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

						//logger.dbg.println(this,"11");



				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						//logger.dbg.println(this,"12");
						InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO PAYROLL.PWSCHREQ ( " );
						InsertSql.append( "EMPNO,APPYM,RESINO,SCHYEAR,SCHNM, APPDT,APPAMT,REQREM,PAYAMT " );
						InsertSql.append( ") VALUES( " );
						InsertSql.append( " ?,?,?,?,?, ?,?,?,? ) " );

						//logger.dbg.println(this,InsertSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxEMPNO);	   	
						gsmt.bindColumn(2, idxAPPYM);	   		
						gsmt.bindColumn(3, idxRESINO);	   		
						gsmt.bindColumn(4, idxSCHYEAR);	   		
						gsmt.bindColumn(5, idxSCHNM);
						gsmt.bindColumn(6, idxAPPDT);		   	
						gsmt.bindColumn(7, idxAPPAMT);	   		
						gsmt.bindColumn(8, idxREQREM);
						gsmt.bindColumn(9, idxPAYAMT);	   		
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						//logger.dbg.println(this,"13");
						UpdateSql = new StringBuffer();
						UpdateSql.append( "UPDATE PAYROLL.PWSCHREQ SET  " );  
						UpdateSql.append( " SCHYEAR	= ?, " );
						UpdateSql.append( " SCHNM	= ?, " );
						UpdateSql.append( " APPYM	= ?, " );
						UpdateSql.append( " APPAMT	= ?, " );
						UpdateSql.append( " REQREM	= ?, " );
						UpdateSql.append( " PAYAMT	= ?  " );
						UpdateSql.append( "  WHERE EMPNO = ? " );
						UpdateSql.append( " AND APPDT = ? " );
						UpdateSql.append( " AND RESINO = ? " );
						//logger.dbg.println(this,UpdateSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxSCHYEAR);
						gsmt.bindColumn(2, idxSCHNM);
						gsmt.bindColumn(3, idxAPPYM);
						gsmt.bindColumn(4, idxAPPAMT);
						gsmt.bindColumn(5, idxREQREM);
						gsmt.bindColumn(6, idxPAYAMT);
						gsmt.bindColumn(7, idxEMPNO);
						gsmt.bindColumn(8, idxAPPDT);
						gsmt.bindColumn(9, idxRESINO);
						//logger.dbg.println(this,"13");

						gsmt.executeUpdate(); 
						gsmt.close(); 
						UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM PAYROLL.PWSCHREQ WHERE EMPNO = ? AND  APPDT	= ? AND RESINO	= ? " );

						//logger.dbg.println(this,"DeleteSql :"+ DeleteSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxAPPDT);
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