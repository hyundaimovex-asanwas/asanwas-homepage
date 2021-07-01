
package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h010018_t1 extends HttpServlet{

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
				String  str1	= req.getParameter("v_str1");   // 신청일자
				String  str2	= req.getParameter("v_str2");   // 사번
				String  str3	= req.getParameter("v_str3");   // 결재자
				String  str4	= req.getParameter("v_str4");   // 승인자
                
				logger.dbg.println(this,"str1-"+str1);	    
				logger.dbg.println(this,"str2-"+str2);
				logger.dbg.println(this,"str3-"+str3);
				logger.dbg.println(this,"str4-"+str4);

				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPDT  = userSet.indexOfColumn("APPDT");	//신청일자
//				int idxEMPNO  = userSet.indexOfColumn("EMPNO");	//사번
				int idxLAZCD  = userSet.indexOfColumn("LAZCD");
				int idxDEPTCD = userSet.indexOfColumn("DEPTCD");
				int idxPAYSEQ = userSet.indexOfColumn("PAYSEQ");
				int idxFRDT	  = userSet.indexOfColumn("FRDT");
				int idxTODT   = userSet.indexOfColumn("TODT");
				int idxFRTIME = userSet.indexOfColumn("FRTIME");
				int idxTOTIME = userSet.indexOfColumn("TOTIME");
				int idxDTYREM = userSet.indexOfColumn("DTYREM");
			//	int idxCLOSYN = userSet.indexOfColumn("CLOSYN");
			//	int idxSGDT   = userSet.indexOfColumn("SGDT");
				int idxSGNID  = userSet.indexOfColumn("SGNID");
			//	int idxAGRDT  = userSet.indexOfColumn("AGRDT");
				//int idxAGRID  = userSet.indexOfColumn("AGRID");
			//	int idxPAYDT  = userSet.indexOfColumn("PAYDT");
				int idxAMT    = userSet.indexOfColumn("AMT");


				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
	
				logger.dbg.println(this, "test1");

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.HLDUTY (  ");
				InsertSql.append( " APPDT, EMPNO, LAZCD, DEPTCD, PAYSEQ, ");
				InsertSql.append( " FRDT, TODT, FRTIME, TOTIME, DTYREM,  ");
				InsertSql.append( " SGNID, AMT  ");
				InsertSql.append( ") values (  ");
				InsertSql.append( " '"+str1+"', '"+str2+"', ?, ?, ?, ");
				InsertSql.append( " ?, ?, ?, ?, ?, ");
				InsertSql.append( " '"+str3+"', ?) ");

				logger.dbg.println(this, "test2");

//				logger.dbg.println(this, InsertSql.toString());
	
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.HLDUTY SET " );
				UpdateSql.append( " FRDT = ?, TODT =?, FRTIME = ?, TOTIME = ?, DTYREM = ?, SGNID = '"+str3+"', AMT = ? " );
				UpdateSql.append( " WHERE APPDT = ? AND EMPNO = '"+str2+"' AND LAZCD = ? " );

	//			logger.dbg.println(this, UpdateSql.toString());

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HLDUTY WHERE APPDT = ? AND EMPNO = '"+str2+"' AND LAZCD = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxLAZCD);
						gsmt.bindColumn(2, idxDEPTCD);
						gsmt.bindColumn(3, idxPAYSEQ);
						gsmt.bindColumn(4, idxFRDT);
						gsmt.bindColumn(5, idxTODT);
						gsmt.bindColumn(6, idxFRTIME);
						gsmt.bindColumn(7, idxTOTIME);
						gsmt.bindColumn(8, idxDTYREM);
						gsmt.bindColumn(9, idxAMT);

						logger.dbg.println(this,"Insert : "+InsertSql.toString());
						
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxFRDT);
						gsmt.bindColumn(2, idxTODT);
						gsmt.bindColumn(3, idxFRTIME);
						gsmt.bindColumn(4, idxTOTIME);
						gsmt.bindColumn(5, idxDTYREM);
						gsmt.bindColumn(6, idxAMT);
						gsmt.bindColumn(7, idxAPPDT);
						gsmt.bindColumn(8, idxLAZCD);

						logger.dbg.println(this,"Update : "+UpdateSql.toString());
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						logger.dbg.println(this,"DeleteSql");
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxAPPDT);
						gsmt.bindColumn(2, idxLAZCD);
						logger.dbg.println(this,"Delete : "+DeleteSql.toString());
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