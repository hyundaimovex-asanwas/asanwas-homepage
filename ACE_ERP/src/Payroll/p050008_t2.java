package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050008_t2 extends HttpServlet{

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

				String str1 = req.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxEMPNO	= userSet.indexOfColumn("EMPNO");		//���
				int idxAPPDAY	= userSet.indexOfColumn("APPDAY");	//������
				int idxAPLDAY	= userSet.indexOfColumn("APLDAY");	//��ȯ��
				int idxAPPAMT	= userSet.indexOfColumn("APPAMT");	//�����
				int idxAPPCNT	= userSet.indexOfColumn("APPCNT");	//��ȯȽ��
				int idxAPJAMT	= userSet.indexOfColumn("APJAMT");	//�����ܾ�
				int idxAPLRAT	= userSet.indexOfColumn("APLRAT");	//��ȯ����
				int idxAPLAMT	= userSet.indexOfColumn("APLAMT");	//��ȯ����
				int idxREASON	= userSet.indexOfColumn("REASON");	//��ȯ����

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.PWRONPAY ( " );
				InsertSql.append( " EMPNO, APPDAY, APLDAY, APPAMT, APPCNT, APJAMT, APLRAT, APLAMT, REASON " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( " ?, ?, ?, ?, ?, ?, ?, ?, ? ) " );
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.PWRONPAY SET " );
				UpdateSql.append( " APPAMT= ?, " );
				UpdateSql.append( " APPCNT= ?, " );
				UpdateSql.append( " APJAMT= ?, " );
				UpdateSql.append( " APLRAT= ?, " );
				UpdateSql.append( " APLAMT= ?, " );
				UpdateSql.append( " REASON= ? " );
				UpdateSql.append( " WHERE EMPNO = ? AND APPDAY = ? AND APLDAY = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PWRONPAY WHERE EMPNO = '"+ str1 +"' " );

				for (int j = 0; j < rows.length; j++){
						
					if(j>=1) {
						if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idxEMPNO);
							gsmt.bindColumn(2, idxAPPDAY);
							gsmt.bindColumn(3, idxAPLDAY);
							gsmt.bindColumn(4, idxAPPAMT);
							gsmt.bindColumn(5, idxAPPCNT);
							gsmt.bindColumn(6, idxAPJAMT);
							gsmt.bindColumn(7, idxAPLRAT);
							gsmt.bindColumn(8, idxAPLAMT);
							gsmt.bindColumn(9, idxREASON);
							gsmt.executeUpdate();
							gsmt.close();
						}
					}

					if(j<1) {
						if(rows[j].getJobType() != GauceDataRow.TB_JOB_UPDATE) {
							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idxAPPAMT);
							gsmt.bindColumn(2, idxAPPCNT);
							gsmt.bindColumn(3, idxAPJAMT);
							gsmt.bindColumn(4, idxAPLRAT);
							gsmt.bindColumn(5, idxAPLAMT);
							gsmt.bindColumn(6, idxREASON);
							gsmt.bindColumn(7, idxEMPNO);
							gsmt.bindColumn(8, idxAPPDAY);
							gsmt.bindColumn(9, idxAPLDAY);
							gsmt.executeUpdate(); 
							gsmt.close();         
						}
					}
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						//gsmt.bindColumn(1, idxEMPNO);
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