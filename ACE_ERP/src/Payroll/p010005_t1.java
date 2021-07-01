package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p010005_t1 extends HttpServlet{

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

				int idxAPPYM		= userSet.indexOfColumn("APPYM");
				int idxFRAMT		= userSet.indexOfColumn("FRAMT");
				int idxTOAMT		= userSet.indexOfColumn("TOAMT");
				int idxFAMILY1		= userSet.indexOfColumn("FAMILY1");
				int idxFAMILY2		= userSet.indexOfColumn("FAMILY2");
				int idxFAMILY3		= userSet.indexOfColumn("FAMILY3");
				int idxFAMILY4		= userSet.indexOfColumn("FAMILY4");
				int idxFAMILY5		= userSet.indexOfColumn("FAMILY5");
				int idxFAMILY6		= userSet.indexOfColumn("FAMILY6");
				int idxFAMILY7		= userSet.indexOfColumn("FAMILY7");
				int idxFAMILY8		= userSet.indexOfColumn("FAMILY8");
				int idxFAMILY9		= userSet.indexOfColumn("FAMILY9");
				int idxFAMILY10		= userSet.indexOfColumn("FAMILY10");
				int idxFAMILY11		= userSet.indexOfColumn("FAMILY11");
                int idxFAMILY23		= userSet.indexOfColumn("FAMILY23");
                int idxFAMILY24		= userSet.indexOfColumn("FAMILY24");
                int idxFAMILY25		= userSet.indexOfColumn("FAMILY25");
                int idxFAMILY26		= userSet.indexOfColumn("FAMILY26");
                int idxFAMILY27		= userSet.indexOfColumn("FAMILY27");
                int idxFAMILY28		= userSet.indexOfColumn("FAMILY28");
                int idxFAMILY29		= userSet.indexOfColumn("FAMILY29");
                int idxFAMILY30		= userSet.indexOfColumn("FAMILY30");
                int idxFAMILY31		= userSet.indexOfColumn("FAMILY31");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.PWTAXTBL ( " );
				InsertSql.append( " APPYM, FRAMT, TOAMT, FAMILY1, FAMILY2, ");
				InsertSql.append( " FAMILY3, FAMILY4, FAMILY5, FAMILY6, FAMILY7, ");
				InsertSql.append( " FAMILY8, FAMILY9, FAMILY10, FAMILY11, ");
                InsertSql.append( " FAMILY23, FAMILY24, FAMILY25, FAMILY26, FAMILY27, ");
                InsertSql.append( " FAMILY28, FAMILY29, FAMILY30, FAMILY31 ");
				InsertSql.append( ") VALUES ( " );
				InsertSql.append( "?, ?, ?, ?, ?,  ?, ?, ?, ?, ? , ?, ?, ?, ?, ) " );
                InsertSql.append( "?, ?, ?, ?, ?,  ?, ?, ?, ? ) " );

				StringBuffer UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.PWTAXTBL SET " );
				UpdateSql.append( " TOAMT = ?,  " );
				UpdateSql.append( " FAMILY1 = ?,  " );
				UpdateSql.append( " FAMILY2 = ?, " );
				UpdateSql.append( " FAMILY3 = ?,  " );
				UpdateSql.append( " FAMILY4 = ?,  " );
				UpdateSql.append( " FAMILY5 = ?, " );
				UpdateSql.append( " FAMILY6 = ?,  " );
				UpdateSql.append( " FAMILY7 = ?,  " );
				UpdateSql.append( " FAMILY8 = ?, " );
				UpdateSql.append( " FAMILY9 = ?,  " );
				UpdateSql.append( " FAMILY10 = ?,  " );
				UpdateSql.append( " FAMILY11 = ?, " );
UpdateSql.append( " FAMILY23 = ?, " );
UpdateSql.append( " FAMILY24 = ?, " );
UpdateSql.append( " FAMILY25 = ?, " );
UpdateSql.append( " FAMILY26 = ?, " );
UpdateSql.append( " FAMILY27 = ?, " );
UpdateSql.append( " FAMILY28 = ?, " );
UpdateSql.append( " FAMILY29 = ?, " );
UpdateSql.append( " FAMILY30 = ?, " );
UpdateSql.append( " FAMILY31 = ? " );

				UpdateSql.append( " WHERE APPYM = ? AND FRAMT = ? " );

				StringBuffer DeleteSql =new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PWTAXTBL WHERE APPYM = ? AND FRAMT = ?  " );

				String sql2 = "";

				for (int j = 0; j < rows.length; j++)	{

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						sql2 = " SELECT APPYM,FRAMT FROM PAYROLL.PWTAXTBL WHERE ";
						sql2 += " APPYM='"+rows[j].getString(0)+"' ";
						sql2 += " AND FRAMT="+rows[j].getInt(1)+" ";
						rs2 = stmt2.executeQuery(sql2);

						if(rs2.next()){ 

							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);
							
							gsmt.bindColumn(1, idxTOAMT);
							gsmt.bindColumn(2, idxFAMILY1);
							gsmt.bindColumn(3, idxFAMILY2);	
							gsmt.bindColumn(4, idxFAMILY3);	
							gsmt.bindColumn(5, idxFAMILY4);	
							gsmt.bindColumn(6, idxFAMILY5);	
							gsmt.bindColumn(7, idxFAMILY6);	
							gsmt.bindColumn(8, idxFAMILY7);	
							gsmt.bindColumn(9, idxFAMILY8);	
							gsmt.bindColumn(10, idxFAMILY9);	
							gsmt.bindColumn(11, idxFAMILY10);
							gsmt.bindColumn(12, idxFAMILY11);
gsmt.bindColumn(13, idxFAMILY23);
gsmt.bindColumn(14, idxFAMILY24);
gsmt.bindColumn(15, idxFAMILY25);
gsmt.bindColumn(16, idxFAMILY26);
gsmt.bindColumn(17, idxFAMILY27);
gsmt.bindColumn(18, idxFAMILY28);
gsmt.bindColumn(19, idxFAMILY29);
gsmt.bindColumn(20, idxFAMILY30);
gsmt.bindColumn(21, idxFAMILY31);
							gsmt.bindColumn(22, idxAPPYM);
							gsmt.bindColumn(23, idxFRAMT);	
							gsmt.executeUpdate(); 
							gsmt.close(); 
						}else{

							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idxAPPYM);
							gsmt.bindColumn(2, idxFRAMT);	
							gsmt.bindColumn(3, idxTOAMT);
							gsmt.bindColumn(4, idxFAMILY1);
							gsmt.bindColumn(5, idxFAMILY2);	
							gsmt.bindColumn(6, idxFAMILY3);	
							gsmt.bindColumn(7, idxFAMILY4);	
							gsmt.bindColumn(8, idxFAMILY5);	
							gsmt.bindColumn(9, idxFAMILY6);	
							gsmt.bindColumn(10, idxFAMILY7);	
							gsmt.bindColumn(11, idxFAMILY8);	
							gsmt.bindColumn(12, idxFAMILY9);	
							gsmt.bindColumn(13, idxFAMILY10);
							gsmt.bindColumn(14, idxFAMILY11);
gsmt.bindColumn(15, idxFAMILY23);
gsmt.bindColumn(16, idxFAMILY24);
gsmt.bindColumn(17, idxFAMILY25);
gsmt.bindColumn(18, idxFAMILY26);
gsmt.bindColumn(19, idxFAMILY27);
gsmt.bindColumn(20, idxFAMILY28);
gsmt.bindColumn(21, idxFAMILY29);
gsmt.bindColumn(22, idxFAMILY30);
gsmt.bindColumn(23, idxFAMILY31);
							gsmt.executeUpdate();
							gsmt.close();
						}
						sql2=null;  rs2.close(); 
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						

						gsmt.bindColumn(1, idxTOAMT);
						gsmt.bindColumn(2, idxFAMILY1);
						gsmt.bindColumn(3, idxFAMILY2);	
						gsmt.bindColumn(4, idxFAMILY3);	
						gsmt.bindColumn(5, idxFAMILY4);	
						gsmt.bindColumn(6, idxFAMILY5);	
						gsmt.bindColumn(7, idxFAMILY6);	
						gsmt.bindColumn(8, idxFAMILY7);	
						gsmt.bindColumn(9, idxFAMILY8);	
						gsmt.bindColumn(10, idxFAMILY9);	
						gsmt.bindColumn(11, idxFAMILY10);
						gsmt.bindColumn(12, idxFAMILY11);
gsmt.bindColumn(13, idxFAMILY23);
gsmt.bindColumn(14, idxFAMILY24);
gsmt.bindColumn(15, idxFAMILY25);
gsmt.bindColumn(16, idxFAMILY26);
gsmt.bindColumn(17, idxFAMILY27);
gsmt.bindColumn(18, idxFAMILY28);
gsmt.bindColumn(19, idxFAMILY29);
gsmt.bindColumn(20, idxFAMILY30);
gsmt.bindColumn(21, idxFAMILY31);
							gsmt.bindColumn(22, idxAPPYM);
							gsmt.bindColumn(23, idxFRAMT);	
						gsmt.executeUpdate(); 
						gsmt.close(); 
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxAPPYM	);
						gsmt.bindColumn(2, idxFRAMT	);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
						InsertSql=null; 
						UpdateSql=null; 
						DeleteSql=null;
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