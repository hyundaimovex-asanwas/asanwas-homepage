package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050002_t2 extends HttpServlet{

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

				int idxEMPNO	= userSet.indexOfColumn("EMPNO");
				int idxAPPYM	= userSet.indexOfColumn("APPYM");
				int idxRESINO	= userSet.indexOfColumn("RESINO");
				int idxGRDCD	= userSet.indexOfColumn("GRDCD");
				int idxSTDAMT	= userSet.indexOfColumn("STDAMT");
				int idxINSAMT	= userSet.indexOfColumn("INSAMT");
				int idxMEDSNO	= userSet.indexOfColumn("MEDSNO");
				int idxGETDT	= userSet.indexOfColumn("GETDT");
				int idxLOSDT	= userSet.indexOfColumn("LOSDT");
				int idxREPDT	= userSet.indexOfColumn("REPDT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.PWINDIPN_Y ( " );
				InsertSql.append( "EMPNO,APPYM,GRDCD,RESINO,STDAMT, INSAMT,MEDSNO,GETDT,LOSDT,REPDT " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( " ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.PWINDIPN_Y SET  " );  
				UpdateSql.append( " GRDCD	= ?, " );
				UpdateSql.append( " STDAMT	= ?, " );
				UpdateSql.append( " INSAMT	= ?, " );
				UpdateSql.append( " MEDSNO	= ?, " );
				UpdateSql.append( " GETDT	= ?, " );
				UpdateSql.append( " LOSDT	= ?, " );
				UpdateSql.append( " REPDT	= ?  " );
				UpdateSql.append( "  WHERE EMPNO = ? " );
				UpdateSql.append( " AND APPYM = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PWINDIPN_Y WHERE EMPNO = ? AND APPYM	= ? " );

				for (int j = 0; j < rows.length; j++){
					

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEMPNO);	   	
						gsmt.bindColumn(2, idxAPPYM);	   		
						gsmt.bindColumn(3, idxGRDCD);	   		
						gsmt.bindColumn(4, idxRESINO);	   		
						gsmt.bindColumn(5, idxSTDAMT);
						gsmt.bindColumn(6, idxINSAMT);		   	
						gsmt.bindColumn(7, idxMEDSNO);	   		
						gsmt.bindColumn(8, idxGETDT);
						gsmt.bindColumn(9, idxLOSDT);	   		
						gsmt.bindColumn(10, idxREPDT);
						gsmt.executeUpdate();
						gsmt.close();

						 /* sql2 = " SELECT EMPNO,APPYM,RESINO FROM PAYROLL.PWINDIPN_Y WHERE ";
					    sql2 += " EMPNO='"+rows[j].getString(idxEMPNO)+"' ";
					    sql2 += " AND APPYM='"+rows[j].getString(idxAPPYM)+"' ";
					    sql2 += " AND RESINO='"+rows[j].getString(idxRESINO)+"' ";
						rs2 = stmt2.executeQuery(sql2);
							//logger.err.println(this,"2");
						if(rs2.next()){ 

							UpdateSql = new StringBuffer();
							UpdateSql.append( "UPDATE PAYROLL.PWINDIPN_Y SET  " );  
							UpdateSql.append( " GRDCD	= ?, " );
							UpdateSql.append( " STDAMT	= ?, " );
							UpdateSql.append( " INSAMT	= ?, " );
							UpdateSql.append( " MEDSNO	= ?, " );
							UpdateSql.append( " GETDT	= ?, " );
							UpdateSql.append( " LOSDT	= ?, " );
							UpdateSql.append( " REPDT	= ?  " );
							UpdateSql.append( "  WHERE EMPNO = ? " );
							UpdateSql.append( " AND APPYM = ? " );
							UpdateSql.append( " AND RESINO = ? " );
							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idxGRDCD);
							gsmt.bindColumn(2, idxSTDAMT);
							gsmt.bindColumn(3, idxINSAMT);
							gsmt.bindColumn(4, idxMEDSNO);
							gsmt.bindColumn(5, idxGETDT);
							gsmt.bindColumn(6, idxLOSDT);
							gsmt.bindColumn(7, idxREPDT);
							gsmt.bindColumn(8, idxEMPNO);
							gsmt.bindColumn(9, idxAPPYM);
							gsmt.bindColumn(10, idxRESINO);
							gsmt.executeUpdate(); 
							gsmt.close(); 
							UpdateSql=null;
/*
						}else{/
					
						//logger.dbg.println(this,InsertSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEMPNO);	   	
						gsmt.bindColumn(2, idxAPPYM);	   		
						gsmt.bindColumn(3, idxGRDCD);	   		
						gsmt.bindColumn(4, idxRESINO);	   		
						gsmt.bindColumn(5, idxSTDAMT);
						gsmt.bindColumn(6, idxINSAMT);		   	
						gsmt.bindColumn(7, idxMEDSNO);	   		
						gsmt.bindColumn(8, idxGETDT);
						gsmt.bindColumn(9, idxLOSDT);	   		
						gsmt.bindColumn(10, idxREPDT);
						gsmt.executeUpdate();
						gsmt.close();
						//InsertSql=null;
					//	}
					//	sql2=null;  rs2.close(); 
*/
					}
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxGRDCD);
						gsmt.bindColumn(2, idxSTDAMT);
						gsmt.bindColumn(3, idxINSAMT);
						gsmt.bindColumn(4, idxMEDSNO);
						gsmt.bindColumn(5, idxGETDT);
						gsmt.bindColumn(6, idxLOSDT);
						gsmt.bindColumn(7, idxREPDT);
						gsmt.bindColumn(8, idxEMPNO);
						gsmt.bindColumn(9, idxAPPYM);
						//logger.dbg.println(this,"13");

						gsmt.executeUpdate(); 
						gsmt.close(); 
						//UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						//logger.dbg.println(this,"DeleteSql :"+ DeleteSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxAPPYM);
						gsmt.executeUpdate();
						gsmt.close();
						//DeleteSql=null;
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