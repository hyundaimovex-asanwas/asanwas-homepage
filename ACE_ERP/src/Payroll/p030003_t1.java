package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p030003_t1 extends HttpServlet{

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

				int idxYYYY      = userSet.indexOfColumn("YYYY");
				int idxEMPNO     = userSet.indexOfColumn("EMPNO");
				int idxWKRESINO  = userSet.indexOfColumn("WKRESINO");
				int idxWKNM      = userSet.indexOfColumn("WKNM");
				int idxSTRTDT2   = userSet.indexOfColumn("STRTDT2");
				int idxENDDT2    = userSet.indexOfColumn("ENDDT2");
				int idxBP11000   = userSet.indexOfColumn("BP11000");
				int idxBP12000   = userSet.indexOfColumn("BP12000");
				int idxBP13000   = userSet.indexOfColumn("BP13000");
				int idxBP10SUM   = userSet.indexOfColumn("BP10SUM");
				int idxBP21000   = userSet.indexOfColumn("BP21000");
				int idxBP22000   = userSet.indexOfColumn("BP22000");
				int idxBP23000   = userSet.indexOfColumn("BP23000");
				int idxBP31000   = userSet.indexOfColumn("BP31000");
				int idxBP32000   = userSet.indexOfColumn("BP32000");
				int idxBP33000   = userSet.indexOfColumn("BP33000");
				int idxBP41000   = userSet.indexOfColumn("BP41000");
				int idxBP42000   = userSet.indexOfColumn("BP42000");
				int idxBP43000   = userSet.indexOfColumn("BP43000");
				int idxBP40SUM   = userSet.indexOfColumn("BP40SUM");
				int idxEMPNMK    = userSet.indexOfColumn("EMPNMK");
				int idxPAYGRD    = userSet.indexOfColumn("PAYGRD");
				int idxPAYNM     = userSet.indexOfColumn("PAYNM  ");
				int idxDEPTCD    = userSet.indexOfColumn("DEPTCD");
				int idxDEPTNM    = userSet.indexOfColumn("DEPTNM");
				int idxSTRTDT    = userSet.indexOfColumn("STRTDTM");
				int idxENDDT     = userSet.indexOfColumn("ENDDT");  

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer sql = null;

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.YCBEFOFF SET  " );
				UpdateSql.append( " WKNM=?, STRTDT=?,ENDDT=?,");
        UpdateSql.append( " BP11000=?,	BP12000=?,	BP13000=?,	BP10SUM=?, " );
				UpdateSql.append( " BP21000=?,	BP22000=?,	BP23000=?,	BP31000=?,	BP32000=?, " );
				UpdateSql.append( " BP33000=?,	BP41000=?,	BP42000=?,	BP43000=?,	BP40SUM=? ");
			  UpdateSql.append( " WHERE YYYY = ?  " );
				UpdateSql.append( " AND EMPNO = ?  " );
				UpdateSql.append( " AND WKRESINO = ?  " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "  DELETE from  PAYROLL.YCBEFOFF " );
			  DeleteSql.append( "  WHERE YYYY = ?  " );
				DeleteSql.append( "  AND EMPNO = ?  " );
				DeleteSql.append( "  AND WKRESINO = ?  " );

			for (int j = 0; j < rows.length; j++){

            //총급여계
				    double strBP10SUM = rows[j].getDouble(idxBP11000)+ rows[j].getDouble(idxBP12000)+rows[j].getDouble(idxBP13000);
					  rows[j].setDouble(idxBP10SUM, strBP10SUM);		
						
						//세액계
						double strBP40SUM = rows[j].getDouble(idxBP41000)+ rows[j].getDouble(idxBP42000)+rows[j].getDouble(idxBP43000);
					  rows[j].setDouble(idxBP40SUM, strBP40SUM);		
           
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
						String strYYYY = rows[j].getString(idxYYYY);
						String strEMPNO = rows[j].getString(idxEMPNO);
						int maxCnt = 0;
				    Statement stmt = null;
				    ResultSet rs = null;  

						sql = new StringBuffer();
						sql.append( " SELECT IFNULL(MAX(SEQ),0)+1 " );
            sql.append( " FROM PAYROLL.YCBEFOFF ");  
						sql.append( " WHERE YYYY = '" +strYYYY+ "'");  
						sql.append( "   AND EMPNO ='" +strEMPNO+"'");  
			
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while (rs.next())	{
							maxCnt = rs.getInt(1);
						}

						if (rs!=null)	rs.close();
						if (stmt!=null) stmt.close();

            InsertSql = new StringBuffer();																						
						InsertSql.append( " INSERT INTO PAYROLL.YCBEFOFF " );		
						InsertSql.append( " ( YYYY,	EMPNO,	WKRESINO,	WKNM,	STRTDT, " );
						InsertSql.append( "   ENDDT,	BP11000,	BP12000,	BP13000,	BP10SUM, " );
						InsertSql.append( "   BP21000,	BP22000,	BP23000,	BP31000,	BP32000,	 " );
						InsertSql.append( "   BP33000,	BP41000,	BP42000,	BP43000,	BP40SUM, PAYGRD, DEPTCD, SEQ ) " );
						InsertSql.append( "  VALUES  (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,"+ maxCnt +")" ); 
		
					  GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
            gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxYYYY);
						gsmt.bindColumn(2,  idxEMPNO);
						gsmt.bindColumn(3,  idxWKRESINO);	
 				  	gsmt.bindColumn(4,  idxWKNM);
						gsmt.bindColumn(5,  idxSTRTDT2);
						gsmt.bindColumn(6,  idxENDDT2);
						gsmt.bindColumn(7,  idxBP11000);
						gsmt.bindColumn(8,  idxBP12000);
						gsmt.bindColumn(9,  idxBP13000);
						gsmt.bindColumn(10, idxBP10SUM);
						gsmt.bindColumn(11, idxBP21000);
						gsmt.bindColumn(12, idxBP22000);
						gsmt.bindColumn(13, idxBP23000);
						gsmt.bindColumn(14, idxBP31000);
						gsmt.bindColumn(15, idxBP32000);
						gsmt.bindColumn(16, idxBP33000);
						gsmt.bindColumn(17, idxBP41000);
						gsmt.bindColumn(18, idxBP42000);
						gsmt.bindColumn(19, idxBP43000);
						gsmt.bindColumn(20, idxBP40SUM);       
						gsmt.bindColumn(21, idxPAYGRD);
						gsmt.bindColumn(22, idxDEPTCD);      

						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxWKNM);
						gsmt.bindColumn(2,  idxSTRTDT2);
						gsmt.bindColumn(3,  idxENDDT2);
						gsmt.bindColumn(4,  idxBP11000);
						gsmt.bindColumn(5,  idxBP12000);
						gsmt.bindColumn(6,  idxBP13000);
						gsmt.bindColumn(7, idxBP10SUM);
						gsmt.bindColumn(8, idxBP21000);
						gsmt.bindColumn(9, idxBP22000);
						gsmt.bindColumn(10, idxBP23000);
						gsmt.bindColumn(11, idxBP31000);
						gsmt.bindColumn(12, idxBP32000);
						gsmt.bindColumn(13, idxBP33000);
						gsmt.bindColumn(14, idxBP41000);
						gsmt.bindColumn(15, idxBP42000);
						gsmt.bindColumn(16, idxBP43000);
						gsmt.bindColumn(17, idxBP40SUM);
						gsmt.bindColumn(18,  idxYYYY);
						gsmt.bindColumn(19,  idxEMPNO);
						gsmt.bindColumn(20,  idxWKRESINO);

						gsmt.executeUpdate(); 
						gsmt.close();       
                                    
					}      
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxYYYY);
						gsmt.bindColumn(2,  idxEMPNO);
						gsmt.bindColumn(3,  idxWKRESINO);
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