package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h060004_t1 extends HttpServlet{

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

				int idxEVAYM                               = userSet.indexOfColumn("EVAYM");
				int idxGRPCD	                             = userSet.indexOfColumn("GRPCD");
				int idxDIVCD	                             = userSet.indexOfColumn("DIVCD");
				int idxDIVNM                               = userSet.indexOfColumn("DIVNM");
				int idxJOBGRPH                             = userSet.indexOfColumn("JOBGRPH");
				int idxJOBGRPNM                            = userSet.indexOfColumn("JOBGRPNM");
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
				int idxEMPNOH	                              = userSet.indexOfColumn("EMPNOH");
				int idxEMPNO  	                            = userSet.indexOfColumn("EMPNO");
				int idxEVASEQ                               = userSet.indexOfColumn("EVASEQ");

				GauceDataRow[] rows = userSet.getDataRows();
				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.HVSCORE ( EVAYM,EMPNOH,EMPNO,EVASEQ,GRPCD,DIVCD,JOBGRPH,PRTSEQ,SCR,SCRGBN) " );
				InsertSql.append( "                                 VALUES  (?,?,?,?,?,?,?,?,?,?)" );
  
				DeleteSql = new StringBuffer();
				DeleteSql.append( "  DELETE  FROM PAYROLL.HVSCORE " );
				DeleteSql.append( "   WHERE  EVAYM = ?  " );
				DeleteSql.append( "     AND  EMPNOH = ?  " );
				DeleteSql.append( "     AND  EMPNO = ?  " );
				DeleteSql.append( "     AND  EVASEQ = ?  " );
				DeleteSql.append( "     AND  GRPCD = ?  " );
				DeleteSql.append( "     AND  DIVCD = ?  " );
				DeleteSql.append( "     AND  JOBGRPH = ?  " );
				DeleteSql.append( "     AND  PRTSEQ = ?  " );
        
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

						String sql = " SELECT SUM(SCR) SCR FROM PAYROLL.HVSCORE " +
												 " WHERE EVAYM = '"+strEVAYM+"' AND EMPNO = '"+strEMPNO+"' AND Evaseq = "+intEvaseq+" AND EMPNOH='"+strEMPNOH+"' ";

						ResultSet rs = stmt.executeQuery(sql); 
            if(rs.next()){
							 //logger.dbg.println(this,"rs.getDouble(1)" + rs.getDouble(1));
							 dblSCR =  rs.getDouble(1);
						}
						//String strEvaym = rows[j].getString(idxEVAYM);
            //UPDATE
					  UpdateSql = new StringBuffer();
				    UpdateSql.append( " UPDATE PAYROLL.HVEMP SET " );
						if (intEvaseq == 1) UpdateSql.append( " SCR1= " +dblSCR +"" );
						else if(intEvaseq == 2) UpdateSql.append( " SCR2= "+dblSCR +"" );
						else if(intEvaseq == 3) UpdateSql.append( " SCR3= "+dblSCR +"" );
						else if(intEvaseq == 4) UpdateSql.append( " SCR4= "+dblSCR +"" );
						UpdateSql.append( " WHERE EVAYM = ? " );
						UpdateSql.append( " AND EMPNO = ?" );

            //logger.dbg.println(this,"UpdateSql.toString()" + UpdateSql.toString());
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