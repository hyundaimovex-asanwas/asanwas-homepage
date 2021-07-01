
package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h010029_t1 extends HttpServlet{

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
				String  str1	= req.getParameter("v_str1");	// 사번
				String  str2	= req.getParameter("v_str2");	// 날짜
				String  str3	= req.getParameter("v_str3");	// A,B
				logger.dbg.println(this,"STR1"+str1);
				logger.dbg.println(this,"STR2"+str2);
				logger.dbg.println(this,"STR3"+str3);
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxCHK	 = userSet.indexOfColumn("CHK");
				int idxREQDT = userSet.indexOfColumn("APPDT");
				int idxEMPNO = userSet.indexOfColumn("EMPNO");
				int idxEMPNMK = userSet.indexOfColumn("LAZCD");
				int idxSEQ	= userSet.indexOfColumn("DEPTCD");
				int idxDEPTCD = userSet.indexOfColumn("PAYSEQ");
				int idxFRDT = userSet.indexOfColumn("FRDT");
				int idxTODT = userSet.indexOfColumn("TODT");
				int idxSGID = userSet.indexOfColumn("FRTIME");
				int idxSGDT = userSet.indexOfColumn("TOTIME");
				int idxAPDT = userSet.indexOfColumn("DTYREM");
				int idxSUBJECT = userSet.indexOfColumn("SGDT");
				int idxEDUINST = userSet.indexOfColumn("SGNID");
				int idxEDUPLC = userSet.indexOfColumn("AGRDT");
				int idxEDUPLC = userSet.indexOfColumn("AGRID");
				int idxEDUPLC = userSet.indexOfColumn("AMT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();

				UpdateSql = new StringBuffer();

				if (str3.equals("B"))
				{
				UpdateSql.append( " UPDATE PAYROLL.HEDUCATION SET " );
				UpdateSql.append( " APDT = '"+str2+"', APID = '"+str1+"'  " );
				UpdateSql.append( " WHERE APPDT = ? AND EMPNO = ? AND LAZCD = ? " );
				}else if (str3.equals("A")) {
				UpdateSql.append( " UPDATE PAYROLL.HEDUCATION SET " );
				UpdateSql.append( " APDT = '99999999', APID = '"+str1+"'  " );
				UpdateSql.append( " WHERE EMPNO = ? AND SEQ = ? AND REQDT = ? " );
				} else { 
				UpdateSql.append(" SELECT * FROM PAYROLL.HEDUCATION"); }
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HEDUCATION WHERE EMPNO = '2050001' " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
				
						gsmt.executeUpdate();
						gsmt.close();
					}



					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxSEQ);
						gsmt.bindColumn(3, idxREQDT);
						

						gsmt.executeUpdate(); 
						logger.dbg.println(this,"UpdateSql"+UpdateSql.toString());
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
				//		gsmt.bindColumn(1, idxSUBJECT);
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