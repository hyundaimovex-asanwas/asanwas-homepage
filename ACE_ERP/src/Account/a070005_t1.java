package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a070005_t1 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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

				String str1 = reqGauce.getParameter("v_str1");    //지점
				String str2 = reqGauce.getParameter("v_str2");    //부서
				String str3 = reqGauce.getParameter("v_str3");    //입금일자FROM
				String str4 = reqGauce.getParameter("v_str4");    //입금일자TO

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxACDATE	= userSet.indexOfColumn("ACDATE");
				int idxPYAMT	= userSet.indexOfColumn("PYAMT");    
				int idxREMARK	= userSet.indexOfColumn("REMARK");
				int idxSEQNO	= userSet.indexOfColumn("SEQNO");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.AFUNDPAY ( " );
				InsertSql.append( " FDCODE, DEPTCD, ACDATE, PYAMT, REMARK, SEQNO) " );
				InsertSql.append( " VALUES ( '" + str1 + "', '" + str2 + "' , ?,?,?, " );
				InsertSql.append( " (SELECT nvl(MAX(SEQNO),0)+1 FROM ACCOUNT.AFUNDPAY WHERE " );
				InsertSql.append( " FDCODE = '" + str1 + "'" );
				InsertSql.append( " AND DEPTCD = '" + str2 + "'" );
				InsertSql.append( " AND ACDATE = ? )) " );
  
				//update statement
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.AFUNDPAY SET PYAMT = ?, REMARK = ? " );		
				UpdateSql.append( " WHERE FDCODE = '" + str1 + "'" );
				UpdateSql.append( " AND DEPTCD = '" + str2 + "'" );
				UpdateSql.append( " AND ACDATE = ? " );
				UpdateSql.append( " AND SEQNO = ? " );

				//delet statement
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.AFUNDPAY " );	
				DeleteSql.append( " WHERE FDCODE = '" + str1 + "'" );
				DeleteSql.append( " AND DEPTCD = '" + str2 + "'" );
				DeleteSql.append( " AND ACDATE BETWEEN '" + str3 + "' AND '" + str4 + "'" );
				DeleteSql.append( " AND SEQNO = ? ");

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxACDATE);
						gsmt.bindColumn(2, idxPYAMT);
						gsmt.bindColumn(3, idxREMARK);
						gsmt.bindColumn(4, idxACDATE);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxPYAMT);
						gsmt.bindColumn(2, idxREMARK);
		             	gsmt.bindColumn(3, idxACDATE);
						gsmt.bindColumn(4, idxSEQNO);
						gsmt.executeUpdate();
						gsmt.close();          
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxSEQNO);
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