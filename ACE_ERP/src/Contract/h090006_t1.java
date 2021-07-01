package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h090006_t1 extends HttpServlet{

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

				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPDT  = userSet.indexOfColumn("APPDT");	//신청일자
				int idxLAZCD  = userSet.indexOfColumn("LAZCD");
				int idxDEPTCD = userSet.indexOfColumn("DEPTCD");
				int idxPAYSEQ = userSet.indexOfColumn("PAYSEQ");
				int idxFRDT	  = userSet.indexOfColumn("FRDT");
				int idxTODT   = userSet.indexOfColumn("TODT");
				//int idxFRTIME = userSet.indexOfColumn("FRTIME");
				//int idxTOTIME = userSet.indexOfColumn("TOTIME");
				int idxDTYREM = userSet.indexOfColumn("DTYREM");
				int idxSGNID  = userSet.indexOfColumn("SGNID");
				int idxAMT    = userSet.indexOfColumn("AMT");

			//	logger.dbg.println(this, "1");

				GauceDataRow[] rows = userSet.getDataRows();

				

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
	
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.HLDUTY (  ");
				InsertSql.append( " APPDT, EMPNO, LAZCD, DEPTCD, PAYSEQ, ");
				InsertSql.append( " FRDT, TODT, DTYREM,  ");
				InsertSql.append( " SGNID, AMT  ");
				InsertSql.append( ") values (  ");
				InsertSql.append( " '"+str1+"', '"+str2+"', ?, ?, ?, ");
				InsertSql.append( " ?, ?, ?, ");
				InsertSql.append( " '"+str3+"', ?) ");
	
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.HLDUTY SET " );
				UpdateSql.append( " TODT =?, DTYREM = ?, SGNID = '"+str3+"', AMT = ? " );
				UpdateSql.append( " WHERE APPDT = ? AND EMPNO = '"+str2+"' AND LAZCD = ? AND FRDT = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HLDUTY WHERE APPDT = ? AND EMPNO = '"+str2+"' AND LAZCD = ? AND FRDT = ? " );

				//logger.dbg.println(this, "2");
				for (int j = 0; j < rows.length; j++){

			//	logger.dbg.println(this,"idxAPPDT...========================>" + rows[j].getString(idxAPPDT));
			
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxLAZCD);
						gsmt.bindColumn(2, idxDEPTCD);
						gsmt.bindColumn(3, idxPAYSEQ);
						gsmt.bindColumn(4, idxFRDT);
						gsmt.bindColumn(5, idxTODT);
						gsmt.bindColumn(6, idxDTYREM);
						gsmt.bindColumn(7, idxAMT);
						
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxTODT);
						gsmt.bindColumn(2, idxDTYREM);
						gsmt.bindColumn(3, idxAMT);
						gsmt.bindColumn(4, idxAPPDT);
						gsmt.bindColumn(5, idxLAZCD);
						gsmt.bindColumn(6, idxFRDT);

						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
            logger.dbg.println(this, "3");
						gsmt.bindColumn(1, idxAPPDT);
						gsmt.bindColumn(2, idxLAZCD);
						gsmt.bindColumn(3, idxFRDT);
						
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