package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p030007_t1 extends HttpServlet{

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

				int idxYYYY			= userSet.indexOfColumn("YYYY");			//�ͼӳ⵵
				int idxEMPNO		= userSet.indexOfColumn("EMPNO");			//���
				int idxINDNO		= userSet.indexOfColumn("INDNO");			//�Ƿ����ڵ�
				int idxINDNAME  = userSet.indexOfColumn("INDNAME");		//�Ƿ�����
				int idxCARDCNT  = userSet.indexOfColumn("CARDCNT");		//ī��Ǽ�
				int idxCARDAMT  = userSet.indexOfColumn("CARDAMT");		//ī��ݾ�
				int idxCASHCNT  = userSet.indexOfColumn("CASHCNT");		//���ݰǼ�
				int idxCASHAMT  = userSet.indexOfColumn("CASHAMT");		//���ݱݾ�
				int idxRELATION = userSet.indexOfColumn("RELATION");	//����
				int idxJUMINNO  = userSet.indexOfColumn("JUMINNO");		//�ֹι�ȣ
				int idxEMPCHK		= userSet.indexOfColumn("EMPCHK");		//���ο���

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.YCINDIPN ( ");
				InsertSql.append( " YYYY,			EMPNO,		INDNO,		INDNAME,  CARDCNT, ");
				InsertSql.append( " CARDAMT,  CASHCNT,  CASHAMT,  RELATION, JUMINNO, EMPCHK ");
				InsertSql.append( ") VALUES( " );
				InsertSql.append( " ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) " );
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.YCINDIPN SET ");
				UpdateSql.append( " INDNAME = ?, ");
				UpdateSql.append( " CARDCNT = ?, ");
				UpdateSql.append( " CARDAMT = ?, ");
				UpdateSql.append( " CASHCNT = ?, ");
				UpdateSql.append( " CASHAMT = ?, ");
				UpdateSql.append( " RELATION = ?, ");
				UpdateSql.append( " EMPCHK= ? ");
				UpdateSql.append( " WHERE YYYY = ? AND EMPNO = ? AND INDNO = ? AND JUMINNO = ? ");

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.YCINDIPN WHERE YYYY = ? AND EMPNO = ? AND INDNO = ? AND JUMINNO = ? ");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxYYYY);
						gsmt.bindColumn(2,  idxEMPNO);
						gsmt.bindColumn(3,  idxINDNO);
						gsmt.bindColumn(4,  idxINDNAME);
						gsmt.bindColumn(5,  idxCARDCNT);
						gsmt.bindColumn(6,  idxCARDAMT);
						gsmt.bindColumn(7,  idxCASHCNT);
						gsmt.bindColumn(8,  idxCASHAMT);
						gsmt.bindColumn(9,  idxRELATION);
						gsmt.bindColumn(10, idxJUMINNO);
						gsmt.bindColumn(11, idxEMPCHK);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idxINDNAME);
						gsmt.bindColumn(2,  idxCARDCNT);
						gsmt.bindColumn(3,  idxCARDAMT);
						gsmt.bindColumn(4,  idxCASHCNT);
						gsmt.bindColumn(5,  idxCASHAMT);
						gsmt.bindColumn(6,  idxRELATION);
						gsmt.bindColumn(7,  idxEMPCHK);
						gsmt.bindColumn(8,	idxYYYY);
						gsmt.bindColumn(9,	idxEMPNO);
						gsmt.bindColumn(10, idxINDNO);
						gsmt.bindColumn(11, idxJUMINNO);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxYYYY);
						gsmt.bindColumn(2,  idxEMPNO);
						gsmt.bindColumn(3,  idxINDNO);
						gsmt.bindColumn(4,  idxJUMINNO);
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