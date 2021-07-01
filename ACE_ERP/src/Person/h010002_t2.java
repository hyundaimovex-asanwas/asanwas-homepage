package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h010002_t2 extends HttpServlet{

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

				int idxORDCD	= userSet.indexOfColumn("ORDCD");
				int idxORDNM	= userSet.indexOfColumn("ORDNM");
				int idxCHKITEM	= userSet.indexOfColumn("CHKITEM");
				int idxORDDIV	= userSet.indexOfColumn("ORDDIV");
				int idxUSEYN	= userSet.indexOfColumn("USEYN");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.HCORDCOD ( " );
				InsertSql.append( "ORDCD,ORDNM,CHKITEM,ORDDIV,USEYN " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( " ?, ?, ?, ?, ? ) " );
  
				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.HCORDCOD SET " );  
				UpdateSql.append( " ORDNM	= ?, " );
				UpdateSql.append( " CHKITEM	= ?, " );
				UpdateSql.append( " ORDDIV	= ?, " );
				UpdateSql.append( " USEYN	= ?  " );
				UpdateSql.append( " WHERE ORDCD = ? " );

				//logger.dbg.println(this, "test_i_02 ");

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HCORDCOD WHERE ORDCD = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						//logger.dbg.println(this,InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxORDCD);    	
						gsmt.bindColumn(2, idxORDNM);	   	
						gsmt.bindColumn(3, idxCHKITEM);	   	
						gsmt.bindColumn(4, idxORDDIV);		   	
						gsmt.bindColumn(5, idxUSEYN);	   	
						
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxORDNM);
						gsmt.bindColumn(2, idxCHKITEM);
						gsmt.bindColumn(3, idxORDDIV);
						gsmt.bindColumn(4, idxUSEYN);
						gsmt.bindColumn(5, idxORDCD);

						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxORDCD);
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