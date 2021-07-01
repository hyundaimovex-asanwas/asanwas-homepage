package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h080010_t1 extends HttpServlet{

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

			GauceStatement gsmt  = null;

			int intSeq = 0;

			try {
				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] strArrCN = new String[]{ "EMPNO","ORDDT","SEQ","ORDCD","DEPTCD",
																					"PAYGRD","PAYSEQ","ENDDT","APPDT","GRDDIV"
																					//"EMPNMK",
																				};
       // logger.dbg.println(this,"11");

        int[] idx = new int[10];
        // logger.dbg.println(this,"22");

        for (int i=0; i<10; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.T_HOORDER " );
				InsertSql.append( " ( " );
				InsertSql.append( " EMPNO,ORDDT,SEQ,ORDCD,DEPTCD, ");
				//InsertSql.append( " PAYGRD,PAYSEQ,ENDDT,APPDT,GRDDIV ");
				InsertSql.append( " PAYGRD,PAYSEQ,ENDDT,APPDT,GRDDIV ");
				InsertSql.append( " ) ");
				InsertSql.append( "  VALUES " );
				InsertSql.append( " ( " );
				InsertSql.append( " ?,?,?,?,?,  " );
				InsertSql.append( " ?,?,?,?,?  " );
				InsertSql.append( " ) " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {



						Statement stmt1 = conn.createStatement();
						StringBuffer sql1 = new StringBuffer();


						Statement stmt2 = conn.createStatement();
						StringBuffer sql2 = new StringBuffer();
				 

						String Ordcd;
						Ordcd= rows[j].getString(idx[3]);
				 
							 //logger.dbg.println(this, "Ordcd	::"+rows[j].getString(idx[3]));
				 
						
							if(!Ordcd.equals("C2")&&!Ordcd.equals("C4")&&!Ordcd.equals("D1")&&!Ordcd.equals("D8")&&!Ordcd.equals("D5")&&!Ordcd.equals("D4")&&!Ordcd.equals("F2")){

							sql1.append( "UPDATE PAYROLL.T_HOORDER SET ENDDT=REPLACE(CHAR(DATE(SUBSTRING('"+rows[j].getString(idx[1])+"',1,4)||'-'||SUBSTRING('"+rows[j].getString(idx[1])+"',5,2)||'-'||SUBSTRING('"+rows[j].getString(idx[1])+"',7,2)) -1 DAY, ISO),'-','')\n"); 
							sql1.append( "WHERE EMPNO ='"+rows[j].getString(idx[0])+"'\n"); 
							sql1.append( "	AND ORDDT=( SELECT MAX(ORDDT) \n");
							sql1.append( "              FROM PAYROLL.T_HOORDER \n");
							sql1.append( "              WHERE EMPNO='"+rows[j].getString(idx[0])+"' AND ORDDT<='"+rows[j].getString(idx[1])+"'  AND ORDCD NOT IN ('C2','C4','D1','D8','D5','D4','F2') AND APPDT<>'' )\n"); 
							sql1.append( "	AND SEQ=(SELECT  COALESCE(MAX(SEQ),0)				 \n"); 
							sql1.append( "			 FROM PAYROLL.T_HOORDER						 \n");
							sql1.append( "           WHERE ORDDT=(								 \n"); 
							sql1.append( "							SELECT MAX(ORDDT)            \n");
							sql1.append( "							FROM PAYROLL.T_HOORDER       \n");
							sql1.append( "							WHERE EMPNO='"+rows[j].getString(idx[0])+"' AND ORDDT<='"+rows[j].getString(idx[1])+"'  AND ORDCD NOT IN ('C2','C4','D1','D8','D5','D4','F2') AND APPDT<>'')\n"); 
							sql1.append( "			  AND EMPNO='"+rows[j].getString(idx[0])+"'  AND ORDCD NOT IN ('C2','C4','D1','D8','D5','D4','F2') AND APPDT<>'' )\n"); 
							sql1.append( "	AND ORDCD NOT IN ('C2','C4','D1','D8','D5','D4','F2')  AND APPDT<>'' \n"); 
							stmt1.close();

						//	logger.dbg.println(this,sql1.toString());

							gsmt = conn.getGauceStatement(sql1.toString());
							gsmt.setGauceDataRow(rows[j]);
							gsmt.executeUpdate(); 
							gsmt.close();
							


						//	 logger.dbg.println(this, "Ordcd	::"+rows[j].getString(idx[3]));
				 
					
							sql2.append( "UPDATE PAYROLL.T_HOORDER SET ENDDT='"+rows[j].getString(idx[1])+"'\n"); 
							sql2.append( "WHERE EMPNO ='"+rows[j].getString(idx[0])+"'\n"); 
							sql2.append( "	AND ORDDT='"+rows[j].getString(idx[1])+"' \n");
							sql2.append( "	AND SEQ=(SELECT  COALESCE(MAX(SEQ),0)				 \n"); 
							sql2.append( "			 FROM PAYROLL.T_HOORDER						 \n");
							sql2.append( "           WHERE ORDDT=(								 \n"); 
							sql2.append( "							SELECT MAX(ORDDT)            \n");
							sql2.append( "							FROM PAYROLL.T_HOORDER       \n");
							sql2.append( "							WHERE EMPNO='"+rows[j].getString(idx[0])+"' AND ORDDT='"+rows[j].getString(idx[1])+"'  AND ORDCD NOT IN ('C2','C4','D1','D8','D5','D4') AND APPDT<>'')\n"); 
							sql2.append( "			  AND EMPNO='"+rows[j].getString(idx[0])+"'  AND ORDCD NOT IN ('C2','C4','D1','D8','D5','D4') AND APPDT<>'' )\n"); 
							sql2.append( "	AND ORDCD NOT IN ('C2','C4','D1','D8','D5','D4')  AND APPDT<>'' \n"); 


							stmt2.close();

						//	logger.dbg.println(this,sql2.toString());

							gsmt = conn.getGauceStatement(sql2.toString());
							gsmt.setGauceDataRow(rows[j]);
							gsmt.executeUpdate(); 
							gsmt.close(); 

							

						}

            //MAX값 SEQ 조회 
						Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						sql0.append( " SELECT COALESCE(MAX(SEQ),0)+1 FROM PAYROLL.T_HOORDER "); 
						sql0.append( "	WHERE EMPNO ='"+rows[j].getString(idx[0])+"'"); 
						sql0.append( "	  AND ORDDT='"+rows[j].getString(idx[1])+"'"); 
						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							 intSeq= rs0.getInt(1);
						}
						rs0.close();
						stmt0.close();

						rows[j].setInt(idx[2],intSeq);

						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						int s=1;
						for (int k=0;k<10;k++) {
							gsmt.bindColumn(s, idx[k]);	
							s++;
						}
						//gsmt.bindColumn(9, idx[10]);

					//	logger.dbg.println(this,"ok::");

						gsmt.executeUpdate(); 
						gsmt.close();
					}

					//logger.dbg.println(this,"66");


					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

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