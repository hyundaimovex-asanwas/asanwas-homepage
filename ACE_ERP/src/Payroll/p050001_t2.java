
package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050001_t2 extends HttpServlet{

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
				Statement stmt2 = conn.createStatement();
				ResultSet rs2 = null;

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxSTDYM	= userSet.indexOfColumn("STDYM");
				int idxGRDCD	= userSet.indexOfColumn("GRDCD");
				int idxLOWAMT		= userSet.indexOfColumn("LOWAMT");
				int idxHIGAMT	= userSet.indexOfColumn("HIGAMT");

				int idxSTDAMT		= userSet.indexOfColumn("STDAMT");
				int idxINSAMT1	= userSet.indexOfColumn("INSAMT1");
				int idxINSAMT2		= userSet.indexOfColumn("INSAMT2");
				int idxINSSUM	= userSet.indexOfColumn("INSSUM");

				GauceDataRow[] rows = userSet.getDataRows();

				/*Statement stmt2 = conn.createStatement();
				String sql2 = " SELECT MAX(ZIPSEQ) + 1 ZIPSEQ FROM PAYROLL.HCPOSTNO ";
				ResultSet rs2 = stmt2.executeQuery(sql2);

				int dbl_zipseq = 0;
				if(rs2.next()){ 
					dbl_zipseq = rs2.getInt(1);
				}*/

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				String       sql2 = "";



				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						sql2 = " SELECT STDYM,GRDCD FROM PAYROLL.PWPENTBL WHERE ";
					    sql2 += " STDYM='"+rows[j].getString(idxSTDYM)+"' ";
					    sql2 += " AND GRDCD="+rows[j].getInt(idxGRDCD)+" ";
						rs2 = stmt2.executeQuery(sql2);
							//logger.err.println(this,"2");
						if(rs2.next()){ 

							UpdateSql = new StringBuffer();
							UpdateSql.append( "UPDATE PAYROLL.PWPENTBL SET " );  
							UpdateSql.append( " LOWAMT	= ?, " );
							UpdateSql.append( " HIGAMT	= ?, " );
							UpdateSql.append( " STDAMT	= ?,  " );
							UpdateSql.append( " INSAMT1	= ?, " );
							UpdateSql.append( " INSAMT2	= ?, " );
							UpdateSql.append( " INSSUM	= ?  " );
							UpdateSql.append( " WHERE STDYM = ? " );
							UpdateSql.append( " AND GRDCD = ? " );
							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							//logger.dbg.println(this,UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idxLOWAMT);
							gsmt.bindColumn(2, idxHIGAMT);
							gsmt.bindColumn(3, idxSTDAMT);
							gsmt.bindColumn(4, idxINSAMT1);
							gsmt.bindColumn(5, idxINSAMT2);
							gsmt.bindColumn(6, idxINSSUM);
							gsmt.bindColumn(7, idxSTDYM);
							gsmt.bindColumn(8, idxGRDCD);

							gsmt.executeUpdate(); 
							gsmt.close(); 
							UpdateSql=null;
						}else{


						InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO PAYROLL.PWPENTBL ( " );
						InsertSql.append( "STDYM,GRDCD,LOWAMT,HIGAMT,STDAMT,INSAMT1,INSAMT2,INSSUM " );
						InsertSql.append( ") VALUES( " );
						InsertSql.append( " ?, ?, ?, ?, ?, ?, ?, ?) " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxSTDYM);	   	
						gsmt.bindColumn(2, idxGRDCD);	   		
						gsmt.bindColumn(3, idxLOWAMT);		   	
						gsmt.bindColumn(4, idxHIGAMT);	   		
						gsmt.bindColumn(5, idxSTDAMT);
						gsmt.bindColumn(6, idxINSAMT1);		   	
						gsmt.bindColumn(7, idxINSAMT2);	   		
						gsmt.bindColumn(8, idxINSSUM);
						
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
						}
						sql2="";  rs2.close(); 
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( "UPDATE PAYROLL.PWPENTBL SET " );  
						UpdateSql.append( " LOWAMT	= ?, " );
						UpdateSql.append( " HIGAMT	= ?, " );
						UpdateSql.append( " STDAMT	= ?,  " );
						UpdateSql.append( " INSAMT1	= ?, " );
						UpdateSql.append( " INSAMT2	= ?, " );
						UpdateSql.append( " INSSUM	= ?  " );
						UpdateSql.append( " WHERE STDYM = ? " );
						UpdateSql.append( " AND GRDCD = ? " );
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxLOWAMT);
						gsmt.bindColumn(2, idxHIGAMT);
						gsmt.bindColumn(3, idxSTDAMT);
						gsmt.bindColumn(4, idxINSAMT1);
						gsmt.bindColumn(5, idxINSAMT2);
						gsmt.bindColumn(6, idxINSSUM);
						gsmt.bindColumn(7, idxSTDYM);
						gsmt.bindColumn(8, idxGRDCD);

						gsmt.executeUpdate(); 
						gsmt.close(); 
						UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM PAYROLL.PWPENTBL WHERE STDYM = ? AND GRDCD	= ? " );

						logger.dbg.println(this,"DeleteSql :"+ DeleteSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxSTDYM);
						gsmt.bindColumn(2, idxGRDCD);
						gsmt.executeUpdate();
						gsmt.close();
						DeleteSql=null;
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