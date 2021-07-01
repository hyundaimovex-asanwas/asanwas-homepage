package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050018_t11 extends HttpServlet{

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

				int idxEMPNO	= userSet.indexOfColumn("EMPNO");		//���
				int idxAPPDT	= userSet.indexOfColumn("APPDT");			//������
				int idxAPLDT	= userSet.indexOfColumn("APLDT");			//��ȯ��
				int idxAPPAMT	= userSet.indexOfColumn("APPAMT");		//�����
				int idxREASON	= userSet.indexOfColumn("REASON");		//�������

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "	INSERT INTO PAYROLL.PWCOLOAN (													\n");
				InsertSql.append( "	EMPNO, APPDT, APLDT, APPAMT, REASON												\n");
				InsertSql.append( "	) VALUES(																						\n");
				InsertSql.append( "	?, ?, ?, ? , ?)																					\n");
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( "	 UPDATE PAYROLL.PWCOLOAN														\n");
				UpdateSql.append( "	 SET																							\n");
				UpdateSql.append( "  APPAMT= ?, 																				\n");
				UpdateSql.append( "  REASON =?																				\n");
				UpdateSql.append( "  WHERE EMPNO = ? AND APPDT = ? AND APLDT = ?							\n");

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PWCOLOAN													\n");
				DeleteSql.append( "WHERE EMPNO = ? AND APPDT = ?													\n");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxAPPDT);
						gsmt.bindColumn(3, idxAPLDT);
						gsmt.bindColumn(4, idxAPPAMT);
						gsmt.bindColumn(5, idxREASON);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxAPPAMT);
						gsmt.bindColumn(2, idxREASON);
						gsmt.bindColumn(3, idxEMPNO);
						gsmt.bindColumn(4, idxAPPDT);
						gsmt.bindColumn(5, idxAPLDT);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxAPPDT);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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