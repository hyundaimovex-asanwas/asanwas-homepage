package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060005_t1 extends HttpServlet{

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
				
				int idxTOTAVG	= userSet.indexOfColumn("TOTAVG");
				int idxGRADE	= userSet.indexOfColumn("GRADE");     //고과등급
				int idxGRADE2	= userSet.indexOfColumn("GRADE2");    //본부장 고과등급 조정
				int idxGRADE3	= userSet.indexOfColumn("GRADE3");    //대표이사  고과등급 조정
				int idxEVAYM	= userSet.indexOfColumn("EVAYM");
				int idxEMPNO	= userSet.indexOfColumn("EMPNO");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer UpdateSql = null;
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.HVEMP SET " );
				UpdateSql.append( " TOTAVG = ? " );
				UpdateSql.append( " ,GRADE = ? " );
				UpdateSql.append( " ,GRADE2 = ? " );
				UpdateSql.append( " ,GRADE3 = ? " );
				UpdateSql.append( " WHERE EVAYM = ? and EMPNO = ?" );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxTOTAVG);
						gsmt.bindColumn(2, idxGRADE);
						gsmt.bindColumn(3, idxGRADE2);
						gsmt.bindColumn(4, idxGRADE3);
						gsmt.bindColumn(5, idxEVAYM);
						gsmt.bindColumn(6, idxEMPNO);
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