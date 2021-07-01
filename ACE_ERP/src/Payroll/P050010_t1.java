package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class P050010_t1 extends HttpServlet{

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

			GauceStatement gsmt=null;

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);


				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1"); //사번

				String strSETTDT ="";

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxSETTDT     = userSet.indexOfColumn("SETTDT");

				GauceDataRow[] rows = userSet.getDataRows();
				strSETTDT  =  rows[0].getString(idxSETTDT);
				strSETTDT = strSETTDT.substring(0,6);
			  StringBuffer DeleteSql = null;
			  StringBuffer InsertSql = null;
 
        

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PWFCARD WHERE SETTDT LIKE '"+strSETTDT+"%'" );

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.PWFCARD " );
				InsertSql.append( "SELECT A.EMPNO,A.APPDT, A.SEQID, " );
				InsertSql.append( "IFNULL(E.DEPTCD,'') AS HEADCD, " );
				InsertSql.append( "IFNULL(D.DEPTCD,'') AS DIVCD, " );
				InsertSql.append( "IFNULL(PAYROLL.FN_DEPTCD(A.EMPNO,A.APPDT),'') DEPTCD, " );
				InsertSql.append( "A.REQAMT, A.MEMBER, IFNULL(PAYROLL.FN_TAXGB(A.EMPNO,A.APPDT),'N') AS TAXGB, A.SALEDT, A.SETTDT, " );
				InsertSql.append( " '"+str1+"' , CURRENT TIMESTAMP,	'"+str1+"' ,	CURRENT TIMESTAMP" );
				InsertSql.append( " FROM PAYROLL.V_PWCARDUP A  " );
				InsertSql.append( " LEFT JOIN PAYROLL.HCDEPT C ON PAYROLL.FN_DEPTCD(A.EMPNO,A.APPDT) = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT ) " );
				InsertSql.append( " LEFT JOIN PAYROLL.HCDEPT D ON D.TREECD = SUBSTR(C.TREECD,1,6)||'00' AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )  " );
				InsertSql.append( " LEFT JOIN PAYROLL.HCDEPT E ON E.TREECD = SUBSTR(C.TREECD,1,4)||'0000' AND E.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT )  " );
				InsertSql.append( " WHERE SETTDT LIKE '"+strSETTDT+"%'        \n" );
   logger.dbg.println(this,str1);
				for (int j = 0; j < 1; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();							
						gsmt.close();   				

						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();							
						gsmt.close();   
					}
				}				
			}
			catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
      
			conn.commit();
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