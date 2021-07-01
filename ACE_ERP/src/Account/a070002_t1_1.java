package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a070002_t1_1 extends HttpServlet{
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


				String str1 = reqGauce.getParameter("v_str1");	//����
				String str2 = reqGauce.getParameter("v_str2");  //����
		
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxSTATDIV	= userSet.indexOfColumn("STATDIV");
				int idxSTDATE	= userSet.indexOfColumn("STDATE");
				int idxFDCODE	= userSet.indexOfColumn("FDCODE");
				int idxACDATE	= userSet.indexOfColumn("ACDATE");
				int idxDEPTCD	= userSet.indexOfColumn("DEPTCD");
				int idxREMCODE	= userSet.indexOfColumn("REMCODE");
				int idxAMTDIV	= userSet.indexOfColumn("AMTDIV");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE ACCOUNT.AFUNDDAY SET " );
				UpdateSql.append( " STATDIV  = '" + str1 + "',"  );
				UpdateSql.append( " STDATE  = '" + str2 + "'"  );
				UpdateSql.append( " WHERE FDCODE = ? " );
				UpdateSql.append( "	   AND ACDATE = ?" );
				UpdateSql.append( "	   AND DEPTCD = ?" );
				UpdateSql.append( "	   AND REMCODE = ?" );
				UpdateSql.append( "	   AND AMTDIV = ?" );

		
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxFDCODE);
						gsmt.bindColumn(2, idxACDATE);
						gsmt.bindColumn(3, idxDEPTCD);
						gsmt.bindColumn(4, idxREMCODE);
						gsmt.bindColumn(5, idxAMTDIV);
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