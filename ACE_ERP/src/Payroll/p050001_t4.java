package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050001_t4 extends HttpServlet{


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


				int idxDEPTNM	= userSet.indexOfColumn("DEPTNM");
				int idxEMPNO	= userSet.indexOfColumn("EMPNO");
				int idxEMPNMK	= userSet.indexOfColumn("EMPNMK");
				int idxAPPYM	= userSet.indexOfColumn("APPYM");
				int idxINSGB	= userSet.indexOfColumn("INSGB");
				int idxPERAMT	= userSet.indexOfColumn("PERAMT");
				int idxSUPAMT	= userSet.indexOfColumn("SUPAMT");


				GauceDataRow[] rows = userSet.getDataRows();


				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				String       sql2 = "";



				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						sql2 = " SELECT APPYM,EMPNO,INSGB FROM PAYROLL.PWSURETY WHERE ";
					    sql2 += " APPYM='"+rows[j].getString(idxAPPYM)+"' ";
					    sql2 += " AND EMPNO='"+rows[j].getString(idxEMPNO)+"' ";
					    sql2 += " AND INSGB='"+rows[j].getString(idxINSGB)+"' ";

						rs2 = stmt2.executeQuery(sql2);
						if(rs2.next()){ 

							UpdateSql = new StringBuffer();
							UpdateSql.append( "UPDATE PAYROLL.PWSURETY SET " );  
							UpdateSql.append( " PERAMT	= ?, " );
					//		UpdateSql.append( " SUPAMT	= ?  " );
							UpdateSql.append( " WHERE APPYM = ? "  );
							UpdateSql.append( "  AND EMPNO= ?  "  );
							UpdateSql.append( "  AND INSGB = ? "  );
							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

							//logger.dbg.println(this,UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idxPERAMT);
					//		gsmt.bindColumn(2, idxSUPAMT);
							gsmt.bindColumn(2, idxAPPYM);
							gsmt.bindColumn(3, idxEMPNO);
							gsmt.bindColumn(4, idxINSGB);	   		
		
							gsmt.executeUpdate(); 
							gsmt.close(); 
							UpdateSql=null;
						}else{

						InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO PAYROLL.PWSURETY ( " );
						InsertSql.append( "APPYM,EMPNO,INSGB,PERAMT" );
						InsertSql.append( ") VALUES( " );
						InsertSql.append( " ?, ?,?, ? ) " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxAPPYM);	   	
						gsmt.bindColumn(2, idxEMPNO);	   		
						gsmt.bindColumn(3, idxINSGB);	//5로 값이 들어감   		
						gsmt.bindColumn(4, idxPERAMT);		   	
					//	gsmt.bindColumn(5, idxSUPAMT);	   		
						


						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
						}
						sql2=null;  rs2.close(); 
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( "UPDATE PAYROLL.PWSURETY SET " );  
						UpdateSql.append( " PERAMT	= ?, " );
					//	UpdateSql.append( " SUPAMT	= ?  " );
						UpdateSql.append( " WHERE APPYM = ? "  );
						UpdateSql.append( "  AND EMPNO= ?  "  );
						UpdateSql.append( "  AND INSGB = ? "  );
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

						//logger.dbg.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxPERAMT);
				//		gsmt.bindColumn(2, idxSUPAMT);
						gsmt.bindColumn(2, idxAPPYM);
						gsmt.bindColumn(3, idxEMPNO);
						gsmt.bindColumn(4, idxINSGB);	   		
	
						gsmt.executeUpdate(); 
						gsmt.close(); 
						UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM PAYROLL.PWSURETY WHERE APPYM = ? AND EMPNO	= ? AND INSGB	= ? " );

						//logger.dbg.println(this,"DeleteSql :"+ DeleteSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxAPPYM);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.bindColumn(3, idxINSGB);
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