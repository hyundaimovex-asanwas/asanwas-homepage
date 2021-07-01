package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060013_t1 extends HttpServlet{

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

				int idxCHKOUT                         = userSet.indexOfColumn("CHKOUT");
				int idxEVAYM                          = userSet.indexOfColumn("EVAYM");
				int idxEMPNOH                         = userSet.indexOfColumn("EMPNOH");
				int idxEMPNMKH                        = userSet.indexOfColumn("EMPNMKH");
				int idxEMPNO                          = userSet.indexOfColumn("EMPNO");
				int idxEMPNMK                         = userSet.indexOfColumn("EMPNMK");
				int idxEVASEQ                         = userSet.indexOfColumn("EVASEQ");
				int idxDEPTCD                         = userSet.indexOfColumn("DEPTCD");
				int idxDEPTNM                         = userSet.indexOfColumn("DEPTNM");
				int idxSTRTDT                         = userSet.indexOfColumn("STRTDT");
				int idxPAYGRD                         = userSet.indexOfColumn("PAYGRD");
				int idxPAYGRDNM                       = userSet.indexOfColumn("PAYGRDNM");
				int idxOLDEMPNOH                      = userSet.indexOfColumn("OLDEMPNOH");
				int idxOLDEVASEQ                      = userSet.indexOfColumn("OLDEVASEQ");

				GauceDataRow[] rows = userSet.getDataRows();
				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
      
			  
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.HVHEMPS( EVAYM,EMPNOH,EMPNO,EVASEQ,DEPTCD,DEPTNM,PAYGRD) " );
				InsertSql.append( "                                 values  (?,?,?,?,?,?,?)" );
        
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.HVHEMPS SET EMPNOH=?,EVASEQ=?, DEPTCD=?,DEPTNM=?, PAYGRD=?" );
			    UpdateSql.append( "  WHERE EVAYM = ?" );
				UpdateSql.append( "    AND  EMPNOH =?" );
				UpdateSql.append( "    AND  EMPNO = ?" );
				UpdateSql.append( "    AND  EVASEQ =?" );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "  DELETE FROM PAYROLL.HVHEMPS " );
				DeleteSql.append( "  WHERE  EVAYM = ?  " );
				DeleteSql.append( "    AND  EMPNOH = ?  " );
				DeleteSql.append( "    AND  EMPNO = ?  " );
				DeleteSql.append( "    AND  EVASEQ = ?  " );
			
				// logger.dbg.println(this, InsertSql.toString());
        
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
	            
				/* 	 
					String  Insert = " INSERT INTO PAYROLL.HVHEMPS ( "
														 + " EVAYM,EMPNOH,EMPNO,EVASEQ,DEPTCD,SUBSTR(DEPTNM,1,20)DEPTNM,PAYGRD" 
													   + " ) "
														 + " VALUES ( "
														 + " '"+rows[j].getString(idxEVAYM)+"',"
														 + " '"+rows[j].getString(idxEMPNOH)+"',"
														 + " '"+rows[j].getString(idxEMPNO)+"',"
														 + " "+rows[j].getDouble(idxEVASEQ)+","
														 + " '"+rows[j].getString(idxDEPTCD)+"'," 
														 + " '"+rows[j].getString(idxDEPTNM)+"',"
														 + " '"+rows[j].getString(idxPAYGRD)+"'" 
														 + " ) ";

						     logger.dbg.println(this,"Insert"+Insert);

								GauceStatement gsmt  = conn.getGauceStatement(Insert.toString());
							   	gsmt.executeUpdate();
						        gsmt.close();
              */
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEVAYM);
						gsmt.bindColumn(2, idxEMPNOH);
						gsmt.bindColumn(3, idxEMPNO);
						gsmt.bindColumn(4, idxEVASEQ);
						gsmt.bindColumn(5, idxDEPTCD);
						gsmt.bindColumn(6, idxDEPTNM);
						gsmt.bindColumn(7, idxPAYGRD);
						
            			gsmt.executeUpdate();
	
						gsmt.close();
          
					}
  
			
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
								 
                        gsmt.bindColumn(1, idxEMPNOH);
						gsmt.bindColumn(2, idxEVASEQ);
						gsmt.bindColumn(3, idxDEPTCD);
						gsmt.bindColumn(4, idxDEPTNM);
						gsmt.bindColumn(5, idxPAYGRD);
						gsmt.bindColumn(6, idxEVAYM);
						gsmt.bindColumn(7, idxOLDEMPNOH);
						gsmt.bindColumn(8, idxEMPNO);
						gsmt.bindColumn(9, idxOLDEVASEQ);
						gsmt.executeUpdate(); 
						gsmt.close();       
                                              
					}   
					
				
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEVAYM);
						gsmt.bindColumn(2, idxEMPNOH);
						gsmt.bindColumn(3, idxEMPNO);
						gsmt.bindColumn(4, idxEVASEQ);
						
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