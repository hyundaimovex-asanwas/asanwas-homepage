package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class p020001_t1 extends HttpServlet{
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
				//String  str1	= req.getParameter("v_str1");

				String[] strArrCN = new String[]{
										  "EMPNO","REGDIV","EMPNMK","CARRDIV","RECDIV",         
                                          "EMPDIV","FRDT","TODT","PAYDIV","RESINO",             
                                          "PICTURE","GRSTRTDT","STRTDT","DEPTCD","PAYGRD",
                                          "JOBGRPH","JOBDTY","GRDDIV","PAYSEQ","FSAMDT",
                                          "ENDDT","USESTS","COSTDIV","DPOFFDT","LAMDT",
                                          "LRMDT","BIRDT","GLDIV","HOBBY","NMC",
                                          "RILIGN","NME","BIRCITY","SPECIAL","OZIPCD",
                                          "OADDR01","OADDR02","CZIPCD","CADDR01","CADDR02",
                                          "TELNO","HPNO","OFFTELNO","EMAIL","HDFAMNM",
                                          "HDFAMRET","HDFAMJOB","LABUNIYN","RELESAMT","MOVESAMT",
                                          "MRTDIV","MRTNO","REFCD","PAYBNKCD","PAYACNT",
                                          "HOUSDIV","MRYDT","ENGLVL","TOESCR","JPTSCR",
                                          "DELFSCR","TOFSCR","DALFSCR","TEPSSCR","ETCLNG",
                                          "HWGRDCD","EXGRDCD","PWGRDCD","ACGRDCD","DEPTNM",
										  "PAYGNM","DEPTPNM","CADDR","WRKDAT","PERAGE",

					                      "PICFILE","ORDDT","HITCHYN","RELATNM","RELATGRD",
					                      "RELATRE","NOMINNM","NOMINGRD","NOMINRE"
				};




				int idxEMPNO	= userSet.indexOfColumn("EMPNO");
				int idxPAYBNKCD	= userSet.indexOfColumn("PAYBNKCD");
				int idxPAYACNT	= userSet.indexOfColumn("PAYACNT");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;




				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO PAYROLL.HIPERSON " );
						InsertSql.append( " ( " );
						InsertSql.append( " PAYBNKCD,PAYACNT " );
						InsertSql.append( " ) " );
						InsertSql.append( "  VALUES " );
						InsertSql.append( " ( " );
						InsertSql.append( " ?,? " );        
						InsertSql.append( " ) " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
                        gsmt.bindColumn(1, idxPAYBNKCD);
                        gsmt.bindColumn(2, idxPAYACNT);
						gsmt.executeUpdate(); 
						gsmt.close();
						InsertSql=null;

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE PAYROLL.HIPERSON " );
						UpdateSql.append( " SET " );
						UpdateSql.append( " PAYBNKCD=?,PAYACNT=? " );

						//UpdateSql.append( "  WHERE EMPNO = '" + Empno + "' " );
						UpdateSql.append( "  WHERE EMPNO = ? " );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
                        gsmt.bindColumn(1, idxPAYBNKCD);
                        gsmt.bindColumn(2, idxPAYACNT);
                        gsmt.bindColumn(3, idxEMPNO);
						gsmt.executeUpdate(); 
						gsmt.close();  
						UpdateSql=null;
                                   
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						DeleteSql = new StringBuffer();
						DeleteSql.append( " " );

					/*	GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.executeUpdate();
						gsmt.close();*/
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
			logger.err.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}