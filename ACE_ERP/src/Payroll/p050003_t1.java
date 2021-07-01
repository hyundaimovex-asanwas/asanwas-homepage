package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p050003_t1 extends HttpServlet{

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
						//logger.dbg.println(this,"11");
				//"DEPTNM",	   /* 부서 */
				//"EMPNO",       /*사번*/
				// "EMPNMK",       /*성명*/

				//"MEDSNO",	       /* 증번호 */
				//"M12300",	/* 납부보험료*/
				//
				//"Y12000",	/*  년간보수*/
				//"DUTMON",	/*  개월(근무월수)*/
				//"M12000",	/* 월보수*/
				//"S12000",	/*  월표준*/
				//"OGRDCD",	/*  현등급*/
				//				"STDYM",	/*  년월*/   INSCD"	/*  보험구분*/

				//"NGRDCD"	/*  신등급*/

				int idxEMPNO	= userSet.indexOfColumn("EMPNO");
				int idxM12300	= userSet.indexOfColumn("M12300");
				int idxY12000	= userSet.indexOfColumn("Y12000");
				int idxDUTMON	= userSet.indexOfColumn("DUTMON");
				int idxM12000	= userSet.indexOfColumn("M12000");

				int idxS12000	= userSet.indexOfColumn("S12000");

				int idxOGRDCD	= userSet.indexOfColumn("OGRDCD");
				int idxNGRDCD	= userSet.indexOfColumn("NGRDCD");
				int idxSTDYM	= userSet.indexOfColumn("STDYM");
				int idxINSCD	= userSet.indexOfColumn("INSCD");
						//logger.dbg.println(this,"11");

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

						//logger.dbg.println(this,"11");



				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						//logger.dbg.println(this,"12");
						/*InsertSql = new StringBuffer();
						InsertSql.append( "INSERT INTO PAYROLL.PWINDIPN ( " );
						InsertSql.append( "EMPNO,APPYM,INSGB,GRDCD,STDAMT, INSAMT,MEDSNO,GETDT,LOSDT,REPDT " );
						InsertSql.append( ") VALUES( " );
						InsertSql.append( " ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " );

						//logger.dbg.println(this,InsertSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idxEMPNO);	   	
						gsmt.bindColumn(2, idxAPPYM);	   		
						gsmt.bindColumn(3, idxINSGB);		   	
						gsmt.bindColumn(4, idxGRDCD);	   		
						gsmt.bindColumn(5, idxSTDAMT);
						gsmt.bindColumn(6, idxINSAMT);		   	
						gsmt.bindColumn(7, idxMEDSNO);	   		
						gsmt.bindColumn(8, idxGETDT);
						gsmt.bindColumn(9, idxLOSDT);	   		
						gsmt.bindColumn(10, idxREPDT);
						//gsmt.executeUpdate();
						//gsmt.close();
						InsertSql=null;*/
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						//logger.dbg.println(this,"13");
						UpdateSql = new StringBuffer();
						UpdateSql.append( "UPDATE PAYROLL.PWINSPAY SET  " );  
						UpdateSql.append( " M12300	= ?, " );
						UpdateSql.append( " Y12000	= ?, " );
						UpdateSql.append( " DUTMON	= ?, " );
						UpdateSql.append( " M12000	= ?, " );
						UpdateSql.append( " S12000	= ?, " );
						UpdateSql.append( " OGRDCD	= ?, " );
						UpdateSql.append( " NGRDCD	= ?  " );
						UpdateSql.append( "  WHERE EMPNO = ? " );
						UpdateSql.append( " AND STDYM = ? " );
						UpdateSql.append( " AND INSCD = ? " );
						//logger.dbg.println(this,UpdateSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxM12300);
						gsmt.bindColumn(2, idxY12000);
						gsmt.bindColumn(3, idxY12000);
						gsmt.bindColumn(4, idxDUTMON);
						gsmt.bindColumn(5, idxM12000);
						gsmt.bindColumn(6, idxOGRDCD);
						gsmt.bindColumn(7, idxNGRDCD);
						gsmt.bindColumn(8, idxEMPNO);
						gsmt.bindColumn(9, idxSTDYM);
						gsmt.bindColumn(10, idxINSCD);
						//logger.dbg.println(this,"13");

						gsmt.executeUpdate(); 
						gsmt.close(); 
						UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "DELETE FROM PAYROLL.PWINSPAY WHERE EMPNO = ? AND STDYM	= ? AND INSCD	= ? " );

						//logger.dbg.println(this,"DeleteSql :"+ DeleteSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						//logger.dbg.println(this,DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxEMPNO);
						gsmt.bindColumn(2, idxSTDYM);
						gsmt.bindColumn(3, idxINSCD);
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