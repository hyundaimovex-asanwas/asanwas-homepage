package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a070007_t2 extends HttpServlet{
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
				String str3 = reqGauce.getParameter("v_str3");              //마감및 마감취소구분
				
				/**201609008 JYS  사용안함.

				StringBuffer InsertSql  = null;
				StringBuffer MakeSql    = null;
				StringBuffer DeleteSql  = null;

				//insert statement
				
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ASURVEND " );
				InsertSql.append( " SELECT '" + str1 + "', '" + str2 + "', A.CASHUNIT, B.ACAMT AS BEFORE, " );
				InsertSql.append( " CASE WHEN B.ACAMT<A.ACAMT THEN A.ACAMT-B.ACAMT ELSE 0 END AS INC, " );
				InsertSql.append( " CASE WHEN B.ACAMT>A.ACAMT THEN B.ACAMT-A.ACAMT ELSE 0 END AS DEC, " );
				InsertSql.append( " A.ACAMT,'','' " );
				InsertSql.append( " FROM ACCOUNT.ACASHSUR A INNER JOIN ACCOUNT.ACASHSUR B " );
				InsertSql.append( " ON A.FDCODE=B.FDCODE AND A.CASHUNIT=B.CASHUNIT " );
				InsertSql.append( " AND B.ACDATE=(SELECT MAX(C.ACDATE) FROM ACCOUNT.ACASHSUR C " );
				InsertSql.append( " WHERE C.ACDATE<'" + str2 + "') ");
				InsertSql.append( " WHERE A.ACDATE = '" + str2 + "' ");
				InsertSql.append( " AND A.FDCODE = '" + str1 + "' ");

				//MakeSql statement
				MakeSql = new StringBuffer();
				MakeSql.append( " INSERT INTO ACCOUNT.ASURVEND " );
				MakeSql.append( " SELECT '" + str1 + "', '" + str2 + "', CASHUNIT, 0 AS BEFORE, " );
				MakeSql.append( " ACAMT AS INC, 0 AS DEC, ACAMT,'','' " );
				MakeSql.append( " FROM ACCOUNT.ACASHSUR " );
				MakeSql.append( " WHERE FDCODE = '" + str1 + "' ");
				MakeSql.append( " AND ACDATE = '" + str2 + "' ");
  
				//delet statement
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.ASURVEND " );
				DeleteSql.append( " WHERE FDCODE = '" + str1 + "'" );
				DeleteSql.append( " AND ACDATE = '" + str2 + "'" );
				
				if (str3.equals("A")) {
					//data exist check
					Statement stmt = conn.createStatement();
					String SelectSql = " SELECT CASHUNIT FROM ACCOUNT.ACASHSUR WHERE " +
									   		" FDCODE = '" + str1 + "'" +
									   		" AND ACDATE < '" + str2 + "'";

					ResultSet rs = stmt.executeQuery(SelectSql);
	
					if(rs.next()) {
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.executeUpdate();
						gsmt.close();
					} else {
						GauceStatement gsmt = conn.getGauceStatement(MakeSql.toString());
						gsmt.executeUpdate();
						gsmt.close();
					}
				} else if(str3.equals("D")) {
					GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
					gsmt.executeUpdate();
					gsmt.close();
				}
				*/
				
				StringBuffer UpdateSql  = null;
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.ACASHSUR " );
				UpdateSql.append( "    SET REMARK ='"+str3+"' ");
				UpdateSql.append( " WHERE FDCODE = '"+str1+"' " );
				UpdateSql.append( "   AND ACDATE = '"+str2+"' " );
				
				GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
				gsmt.executeUpdate();
				gsmt.close();
				
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