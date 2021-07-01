package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050005_t1 extends HttpServlet{

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

				//"DEPTNM",	   /* 부서 */
				//"EMPNO",       /*사번*/
				//"EMPNMK",      /*성명*/
				//"FRDT",        /*가입일*/
				//"TODT",        /*종료일*/
				//"DIV",       /*연금코드*/
				//"DIVNM",       /*연금종류*/
				//"PERAMT",      /*본인부담*/
				//"SUPAMT"       /*회사지원*/

				//DROP TABLE PWINDPEN;			
				//CREATE TABLE PWINDPEN (			
				//EMPNO	CHAR(7) 	NOT NULL,	/*  사번*/
				//FRDT	CHAR(8)	NOT NULL,	/*  가입일*/
				//TODT	CHAR(8)	NOT NULL,	/*  종료일*/
				//DIV	VARCHAR(4)	NOT NULL,	/*  연금종류*/
				//PERAMT	NUMERIC(7, 0)	DEFAULT 0,	/*  본인부담*/
				//SUPAMT	NUMERIC(7, 0)	DEFAULT 0,	/*  회사지원*/
				///* Primary key Define */			
			   //CONSTRAINT PWINDPENPK PRIMARY KEY ( EMPNO)); 			


				int idxEMPNO	= userSet.indexOfColumn("EMPNO");  //사번
				int idxFRDT	= userSet.indexOfColumn("FRDT");       //가입일
				int idxTODT	= userSet.indexOfColumn("TODT");       //종료일
				int idxDIV	= userSet.indexOfColumn("DIV");        //연금종류코드
				int idxPERAMT	= userSet.indexOfColumn("PERAMT"); //본인부담
				int idxSUPAMT	= userSet.indexOfColumn("SUPAMT"); //회사지원

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

						logger.dbg.println(this,"11");



				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						logger.dbg.println(this,"12");
						InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO PAYROLL.PWINDPEN ( " );
						InsertSql.append( "EMPNO,FRDT,TODT,DIV,PERAMT,SUPAMT " );
						InsertSql.append( ") VALUES( " );
						InsertSql.append( " ?,?,?,?,?,?) " );

						logger.dbg.println(this,InsertSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxEMPNO);	   	
						gsmt.bindColumn(2, idxFRDT);	   		
						gsmt.bindColumn(3, idxTODT);	   		
						gsmt.bindColumn(4, idxDIV);	   		
						gsmt.bindColumn(5, idxPERAMT);	   		
						gsmt.bindColumn(6, idxSUPAMT);
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						logger.dbg.println(this,"13");
						UpdateSql = new StringBuffer();
						UpdateSql.append( "UPDATE PAYROLL.PWINDPEN SET  " );  
						UpdateSql.append( " TODT	= ?, " );
						UpdateSql.append( " DIV	= ?, " );
						UpdateSql.append( " PERAMT	= ?, " );
						UpdateSql.append( " SUPAMT	= ? " );
						UpdateSql.append( "  WHERE EMPNO = ? " );
						UpdateSql.append( "  WHERE FRDT = ? " );
						logger.dbg.println(this,UpdateSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxTODT);
						gsmt.bindColumn(2, idxDIV);
						gsmt.bindColumn(3, idxPERAMT);
						gsmt.bindColumn(4, idxSUPAMT);
						gsmt.bindColumn(5, idxEMPNO);
						gsmt.bindColumn(6, idxFRDT);

						gsmt.executeUpdate(); 
						gsmt.close(); 
						UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM PAYROLL.PWINDPEN WHERE EMPNO = ? AND FRDT = ? " );

						logger.dbg.println(this,"DeleteSql :"+ DeleteSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxFRDT);
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