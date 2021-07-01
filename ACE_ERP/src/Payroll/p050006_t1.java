package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050006_t1 extends HttpServlet{

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
						//logger.dbg.println(this,"11");

				//DROP TABLE PWALLOW;			
				//CREATE TABLE PWALLOW (			
				//EMPNO	CHAR(7) 	NOT NULL,	/*  사번*/
				//ALLOWGB	VARCHAR(4)	NOT NULL,	/*  수당구분*/
				//FRDT	CHAR(6)	NOT NULL,	/*  시작년월*/
				//TODT	CHAR(6)	,	/*  종료년월*/
				//DEPTCD	CHAR(4)	,	/*  부서*/
				//ALLOWAMT	NUMERIC(9,0)	DEFAULT 0,	/*  수당액*/
				//ETC	VARCHAR(30)	,	/*  비고*/
				///* Primary key Define */			
			   //CONSTRAINT PWALLOWPK PRIMARY KEY ( EMPNO, ALLOWGB, FRDT)); 			


				int idxEMPNO	= userSet.indexOfColumn("EMPNO"); 
				int idxALLOWGB	= userSet.indexOfColumn("ALLOWGB");   
				int idxFRDT	= userSet.indexOfColumn("FRDT");      
				int idxTODT	= userSet.indexOfColumn("TODT"); 
				int idxDEPTCD	= userSet.indexOfColumn("DEPTCD");
				int idxALLOWAMT	= userSet.indexOfColumn("ALLOWAMT");
				int idxETC	= userSet.indexOfColumn("ETC");

						//logger.dbg.println(this,"11");

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

						//logger.dbg.println(this,"11");



				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						logger.dbg.println(this,"12");
						InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO PAYROLL.PWALLOW ( " );
						InsertSql.append( " EMPNO,ALLOWGB,FRDT,TODT,DEPTCD,ALLOWAMT,ETC " );
						InsertSql.append( ") VALUES( " );
						InsertSql.append( " ?,?,?,?,?,?,? ) " );

						//logger.dbg.println(this,InsertSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxEMPNO);	   	
						gsmt.bindColumn(2, idxALLOWGB);	   		
						gsmt.bindColumn(3, idxFRDT);	   		
						gsmt.bindColumn(4, idxTODT);	   		
						gsmt.bindColumn(5, idxDEPTCD);
						gsmt.bindColumn(6, idxALLOWAMT);	   		
						gsmt.bindColumn(7, idxETC);
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						//logger.dbg.println(this,"13");
						UpdateSql = new StringBuffer();
						UpdateSql.append( "UPDATE PAYROLL.PWALLOW SET  " );  
						UpdateSql.append( " TODT	= ?, " );
						UpdateSql.append( " DEPTCD	= ?, " );
						UpdateSql.append( " ALLOWAMT	= ?, " );
						UpdateSql.append( " ETC	= ? " );
						UpdateSql.append( "  WHERE EMPNO = ? " );
						UpdateSql.append( "  AND ALLOWGB = ? " );
						UpdateSql.append( "  AND FRDT = ? " );
						//logger.dbg.println(this,UpdateSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxTODT);
						gsmt.bindColumn(2, idxDEPTCD);
						gsmt.bindColumn(3, idxALLOWAMT);
						gsmt.bindColumn(4, idxETC);
						gsmt.bindColumn(5, idxEMPNO);
						gsmt.bindColumn(6, idxALLOWGB);
						gsmt.bindColumn(7, idxFRDT);

						gsmt.executeUpdate(); 
						gsmt.close(); 
						UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM PAYROLL.PWALLOW WHERE EMPNO = ? AND ALLOWGB = ? AND FRDT = ? " );

						//logger.dbg.println(this,"DeleteSql :"+ DeleteSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxALLOWGB);
						gsmt.bindColumn(3, idxFRDT);
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