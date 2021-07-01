package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a070007_t1 extends HttpServlet{
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

				String str1 = reqGauce.getParameter("v_str1");				//지점
				String str2 = reqGauce.getParameter("v_str2");              //일자

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxCDCODE = userSet.indexOfColumn("CDCODE");
				int idxQUANTY = userSet.indexOfColumn("QUANTY");
				int idxACAMT  = userSet.indexOfColumn("ACAMT");
				int idxREMARK = userSet.indexOfColumn("REMARK");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer MakeSql   = null;

				//make statement
				MakeSql = new StringBuffer();
				MakeSql.append(" INSERT INTO ACCOUNT.ACASHSUR ");
				MakeSql.append(" (SELECT '" + str1 + "', '" + str2 + "', CDCODE,0,0,'','','' ");
				MakeSql.append(" FROM ACCOUNT.COMMDTIL WHERE CMTYPE='0055' AND DSUDT IS NULL) ");

				//insert statement
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ACASHSUR  ( " );
				InsertSql.append( " FDCODE,  ACDATE,  CASHUNIT,  QUANTY, ACAMT, REMARK) " );
				InsertSql.append( " VALUES ( '" + str1 + "', '" + str2 + "', ?, ?, ?, ?) " );
  
				//update statement
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ACASHSUR SET  QUANTY = ?, ACAMT= ? , REMARK= ? " );
				UpdateSql.append( " WHERE CASHUNIT = ? " );
				UpdateSql.append( " AND FDCODE = '" + str1 + "'" );
				UpdateSql.append( " AND ACDATE = '" + str2 + "'" );

				//delete statement
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ACASHSUR " );
				DeleteSql.append( " WHERE FDCODE = '" + str1 + "'" );
				DeleteSql.append( " AND ACDATE = '" + str2 + "'" );
				
				//data exist check
				Statement stmt = conn.createStatement();
				String SelectSql = " SELECT CASHUNIT FROM ACCOUNT.ACASHSUR WHERE " +
								   		" FDCODE = '" + str1 + "'" +
								   		" AND ACDATE = '" + str2 + "'";
				
				//System.out.println("SelectSql"+SelectSql);

				ResultSet rs = stmt.executeQuery(SelectSql);
				if(rs.next()) {
				} else {
					GauceStatement gsmt = conn.getGauceStatement(MakeSql.toString());
					gsmt.executeUpdate();
					gsmt.close();
				}

				for (int j = 0; j < rows.length; j++){
	
					String g_CDCODE = rows[j].getString(1);
					int g_ACAMT  = rows[j].getInt(3) * rows[j].getInt(4);
					
					//System.out.println("UpdateSql"+UpdateSql.toString());

					GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
					gsmt.setGauceDataRow(rows[j]);
					gsmt.bindColumn(1, idxQUANTY);
					gsmt.setInt(2,g_ACAMT);
					gsmt.bindColumn(3, idxREMARK);
					gsmt.bindColumn(4, idxCDCODE);
					gsmt.executeUpdate();
					gsmt.close();
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