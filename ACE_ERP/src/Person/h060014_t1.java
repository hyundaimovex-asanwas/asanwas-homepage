package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060014_t1 extends HttpServlet{

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

				conn.setAutoCommit(false);
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxEVAYM                                = userSet.indexOfColumn("EVAYM");
				int idxGRPCD	                            = userSet.indexOfColumn("GRPCD");
				int idxDIVCD	                            = userSet.indexOfColumn("DIVCD");
				int idxDIVNM                                = userSet.indexOfColumn("DIVNM");
				int idxJOBGRPH                              = userSet.indexOfColumn("JOBGRPH");
				int idxJOBGRPNM                             = userSet.indexOfColumn("JOBGRPNM");
				int idxPRTSEQ                               = userSet.indexOfColumn("PRTSEQ");
				int idxGRPITEM                              = userSet.indexOfColumn("GRPITEM");
				int idxGRPNM                                = userSet.indexOfColumn("GRPNM");
				int idxASKITEM                              = userSet.indexOfColumn("ASKITEM");
				int idxSCRGBN                               = userSet.indexOfColumn("SCRGBN");
				int idxESCR                                 = userSet.indexOfColumn("ESCR");
				int idxGSCR                                 = userSet.indexOfColumn("GSCR");
				int idxMSCR                                 = userSet.indexOfColumn("MSCR");
				int idxLSCR                                 = userSet.indexOfColumn("LSCR");
				int idxPSCR                                 = userSet.indexOfColumn("PSCR");
				int idxSCR                                  = userSet.indexOfColumn("SCR");
				int idxEMPNOH	                            = userSet.indexOfColumn("EMPNOH");
				int idxEMPNO  	                            = userSet.indexOfColumn("EMPNO");
				int idxEVASEQ                               = userSet.indexOfColumn("EVASEQ");

				GauceDataRow[] rows = userSet.getDataRows();
				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.HVSCORES ( EVAYM,EMPNOH,EMPNO,EVASEQ,GRPCD,DIVCD,JOBGRPH,PRTSEQ,SCR,SCRGBN) " );
				InsertSql.append( "                                 VALUES  (?,?,?,?,?,?,?,?,?,?)" );
 
//logger.dbg.println(this,InsertSql.toString());
			
				DeleteSql = new StringBuffer();
				DeleteSql.append( "  DELETE  FROM PAYROLL.HVSCORES " );
				DeleteSql.append( "   WHERE  EVAYM = ?  " );
				DeleteSql.append( "     AND  EMPNOH = ?  " );
				DeleteSql.append( "     AND  EMPNO = ?  " );
				DeleteSql.append( "     AND  EVASEQ = ?  " );
				DeleteSql.append( "     AND  GRPCD = ?  " );
				DeleteSql.append( "     AND  DIVCD = ?  " );
				DeleteSql.append( "     AND  JOBGRPH = ?  " );
				DeleteSql.append( "     AND  PRTSEQ = ?  " );
      
	//logger.dbg.println(this,DeleteSql.toString());	
			
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

					  //DELETE
						GauceStatement gsmt0 = conn.getGauceStatement(DeleteSql.toString());
						gsmt0.setGauceDataRow(rows[j]);
						gsmt0.bindColumn(1, idxEVAYM);
						gsmt0.bindColumn(2, idxEMPNOH);
						gsmt0.bindColumn(3, idxEMPNO);
						gsmt0.bindColumn(4, idxEVASEQ);
						gsmt0.bindColumn(5, idxGRPCD);
						gsmt0.bindColumn(6, idxDIVCD);
						gsmt0.bindColumn(7, idxJOBGRPH);
						gsmt0.bindColumn(8, idxPRTSEQ);
						gsmt0.executeUpdate();
						gsmt0.close();

            //INSERT
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxEVAYM);
						gsmt.bindColumn(2, idxEMPNOH);
						gsmt.bindColumn(3, idxEMPNO);
						gsmt.bindColumn(4, idxEVASEQ);
						gsmt.bindColumn(5, idxGRPCD);
						gsmt.bindColumn(6, idxDIVCD);
						gsmt.bindColumn(7, idxJOBGRPH);
						gsmt.bindColumn(8, idxPRTSEQ);
						gsmt.bindColumn(9, idxSCR);
						gsmt.bindColumn(10, idxSCRGBN);

						gsmt.executeUpdate();
						gsmt.close();
			
					}//if
				}//for

                if(rows[0].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					  	//SELECT 
						String strEVAYM = rows[0].getString(idxEVAYM);
						String strEMPNO = rows[0].getString(idxEMPNO); 
						int intEvaseq = rows[0].getInt(idxEVASEQ);
						String strEMPNOH = rows[0].getString(idxEMPNOH);
						double dblSCR=0;

						Statement stmt = conn.createStatement();

						String sql = " SELECT SUM(SCR) SCR FROM PAYROLL.HVSCORES " +
												 " WHERE EVAYM = '"+strEVAYM+"' AND EMPNO = '"+strEMPNO+"' AND Evaseq = "+intEvaseq+" AND EMPNOH='"+strEMPNOH+"' ";
           //   logger.dbg.println(this,sql.toString());
						ResultSet rs = stmt.executeQuery(sql); 
            if(rs.next()){
							//  logger.dbg.println(this,"rs.getDouble(1)" + rs.getDouble(1));
							 dblSCR =  rs.getDouble(1);
						}
				        	//	String strEvaym = rows[j].getString(idxEVAYM);
          
			//UPDATE

					  UpdateSql = new StringBuffer();
				    UpdateSql.append( " UPDATE PAYROLL.HVEMPS SET " );
						    if (intEvaseq == 1) UpdateSql.append( " SCR1= "+dblSCR +"" );
						else if(intEvaseq == 2) UpdateSql.append( " SCR2= "+dblSCR +"" );
						else if(intEvaseq == 3) UpdateSql.append( " SCR3= "+dblSCR +"" );
						else if(intEvaseq == 4) UpdateSql.append( " SCR4= "+dblSCR +"" );
	                    else if(intEvaseq == 5) UpdateSql.append( " SCR5= "+dblSCR +"" );
						else if(intEvaseq == 6) UpdateSql.append( " SCR6= "+dblSCR +"" );
						else if(intEvaseq == 7) UpdateSql.append( " SCR7= "+dblSCR +"" );
				        else if(intEvaseq == 8) UpdateSql.append( " SCR8= "+dblSCR +"" );
						else if(intEvaseq == 9) UpdateSql.append( " SCR9= "+dblSCR +"" );
						else if(intEvaseq == 10) UpdateSql.append( " SCR10= "+dblSCR +"" );
			         	else if(intEvaseq == 11) UpdateSql.append( " SCR11= "+dblSCR +"" );
				        else if(intEvaseq == 12) UpdateSql.append( " SCR12= "+dblSCR +"" );
						else if(intEvaseq == 13) UpdateSql.append( " SCR13= "+dblSCR +"" );
						else if(intEvaseq == 14) UpdateSql.append( " SCR14= "+dblSCR +"" );
	                    else if(intEvaseq == 15) UpdateSql.append( " SCR15= "+dblSCR +"" );
						else if(intEvaseq == 16) UpdateSql.append( " SCR16= "+dblSCR +"" );
						else if(intEvaseq == 17) UpdateSql.append( " SCR17= "+dblSCR +"" );
				        else if(intEvaseq == 18) UpdateSql.append( " SCR18= "+dblSCR +"" );
						else if(intEvaseq == 19) UpdateSql.append( " SCR19= "+dblSCR +"" );
						else if(intEvaseq == 20) UpdateSql.append( " SCR20= "+dblSCR +"" );
			         	else if(intEvaseq == 21) UpdateSql.append( " SCR21= "+dblSCR +"" );
						else if(intEvaseq == 22) UpdateSql.append( " SCR22= "+dblSCR +"" );
						else if(intEvaseq == 23) UpdateSql.append( " SCR23= "+dblSCR +"" );
						else if(intEvaseq == 24) UpdateSql.append( " SCR24= "+dblSCR +"" );
	                    else if(intEvaseq == 25) UpdateSql.append( " SCR25= "+dblSCR +"" );
						else if(intEvaseq == 26) UpdateSql.append( " SCR26= "+dblSCR +"" );
						else if(intEvaseq == 27) UpdateSql.append( " SCR27= "+dblSCR +"" );
				        else if(intEvaseq == 28) UpdateSql.append( " SCR28= "+dblSCR +"" );
						else if(intEvaseq == 29) UpdateSql.append( " SCR29= "+dblSCR +"" );
						else if(intEvaseq == 30) UpdateSql.append( " SCR30= "+dblSCR +"" );
	                    else if(intEvaseq == 31) UpdateSql.append( " SCR31= "+dblSCR +"" );
						else if(intEvaseq == 32) UpdateSql.append( " SCR32= "+dblSCR +"" );
						else if(intEvaseq == 33) UpdateSql.append( " SCR33= "+dblSCR +"" );
						else if(intEvaseq == 34) UpdateSql.append( " SCR34= "+dblSCR +"" );
	                    else if(intEvaseq == 35) UpdateSql.append( " SCR35= "+dblSCR +"" );
						else if(intEvaseq == 36) UpdateSql.append( " SCR36= "+dblSCR +"" );
						else if(intEvaseq == 37) UpdateSql.append( " SCR37= "+dblSCR +"" );
				        else if(intEvaseq == 38) UpdateSql.append( " SCR38= "+dblSCR +"" );
						else if(intEvaseq == 39) UpdateSql.append( " SCR39= "+dblSCR +"" );
						else if(intEvaseq == 40) UpdateSql.append( " SCR40= "+dblSCR +"" );
			         	else if(intEvaseq == 41) UpdateSql.append( " SCR41= "+dblSCR +"" );
						else if(intEvaseq == 42) UpdateSql.append( " SCR42= "+dblSCR +"" );
						else if(intEvaseq == 43) UpdateSql.append( " SCR43= "+dblSCR +"" );
						else if(intEvaseq == 44) UpdateSql.append( " SCR44= "+dblSCR +"" );
	                    else if(intEvaseq == 45) UpdateSql.append( " SCR45= "+dblSCR +"" );
						else if(intEvaseq == 46) UpdateSql.append( " SCR46= "+dblSCR +"" );
						else if(intEvaseq == 47) UpdateSql.append( " SCR47= "+dblSCR +"" );
				        else if(intEvaseq == 48) UpdateSql.append( " SCR48= "+dblSCR +"" );
						else if(intEvaseq == 49) UpdateSql.append( " SCR49= "+dblSCR +"" );
						else if(intEvaseq == 50) UpdateSql.append( " SCR50= "+dblSCR +"" );
	                    else if(intEvaseq == 51) UpdateSql.append( " SCR51= "+dblSCR +"" );
						else if(intEvaseq == 52) UpdateSql.append( " SCR52= "+dblSCR +"" );
						else if(intEvaseq == 53) UpdateSql.append( " SCR53= "+dblSCR +"" );
						else if(intEvaseq == 54) UpdateSql.append( " SCR54= "+dblSCR +"" );
	                    else if(intEvaseq == 55) UpdateSql.append( " SCR55= "+dblSCR +"" );
						else if(intEvaseq == 56) UpdateSql.append( " SCR56= "+dblSCR +"" );
						else if(intEvaseq == 57) UpdateSql.append( " SCR57= "+dblSCR +"" );
				        else if(intEvaseq == 58) UpdateSql.append( " SCR58= "+dblSCR +"" );
						else if(intEvaseq == 59) UpdateSql.append( " SCR59= "+dblSCR +"" );
						else if(intEvaseq == 60) UpdateSql.append( " SCR60= "+dblSCR +"" );
						UpdateSql.append( " WHERE EVAYM = ? " );
						UpdateSql.append( " AND EMPNO = ?" );
                   // logger.dbg.println(this,UpdateSql.toString());
               //  logger.dbg.println(this,"UpdateSql.toString()" + UpdateSql.toString());
                        GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql.toString());
						gsmt2.setGauceDataRow(rows[0]);
						//컬럼지정
						gsmt2.bindColumn(1, idxEVAYM);
						gsmt2.bindColumn(2, idxEMPNO);
						gsmt2.executeUpdate();
						gsmt2.close();
				}//if
			}//try
			catch(Exception e){
				logger.dbg.println(this,"7r"); 
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}//catch
            conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}//try
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}//catch
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}//finally
	}//public
}//public