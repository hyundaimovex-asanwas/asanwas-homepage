package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p010003_t1 extends HttpServlet{

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

				String str1 = req.getParameter("v_str1");

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxSTDYM		= userSet.indexOfColumn("STDYM");		//기분년월
				int idxCDDIV		= userSet.indexOfColumn("CDDIV");		//구분
				int idxPAYGRD		= userSet.indexOfColumn("PAYGRD");	//직위
				int idxPAYSEQ		= userSet.indexOfColumn("PAYSEQ");	//호봉
				int idxAMT			= userSet.indexOfColumn("AMT");			//금액

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				String       sql2 = "";
				String       sql3 = "";

				InsertSql = new StringBuffer();
				InsertSql.append( "INSERT INTO PAYROLL.PCPAYTBL ( " );
				InsertSql.append( "STDYM,	CDDIV, PAYGRD, PAYSEQ, AMT " );
				InsertSql.append( ") VALUES( " );
				InsertSql.append( "?, ?, ?, ?, ? ) " );

				UpdateSql = new StringBuffer();
				UpdateSql.append( "UPDATE PAYROLL.PCPAYTBL SET " );
				UpdateSql.append( " AMT = ? " );
				UpdateSql.append( " WHERE STDYM = ? AND CDDIV = ? AND PAYGRD = ? AND PAYSEQ = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.PCPAYTBL WHERE STDYM = ? AND CDDIV = ? AND PAYGRD = ? " ); //AND PAYSEQ = ? 
                 
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
                   
						sql2 = " SELECT STDYM,CDDIV,PAYGRD,PAYSEQ FROM PAYROLL.PCPAYTBL WHERE ";
					    sql2 += "STDYM='"+rows[j].getString(0)+"' ";
					    sql2 += "AND CDDIV='"+rows[j].getString(1)+"' ";
					    sql2 += "AND PAYGRD='"+rows[j].getString(2)+"' ";
					    sql2 += "AND PAYSEQ='"+rows[j].getString(3)+"' ";
						rs2 = stmt2.executeQuery(sql2);
						if(rs2.next()){ 


							sql3 = " UPDATE PAYROLL.PCPAYTBL SET AMT = "+rows[j].getInt(4) +" WHERE  ";
							sql3 += " STDYM='"+rows[j].getString(0)+"' ";
							sql3 += " AND CDDIV='"+rows[j].getString(1)+"' ";
							sql3 += " AND PAYGRD='"+rows[j].getString(2)+"' ";
							sql3 += " AND PAYSEQ='"+rows[j].getString(3)+"' ";
							GauceStatement gsmt3 = conn.getGauceStatement(sql3);
						 
							gsmt3.executeUpdate();
							gsmt3.close();

							sql3="";   gsmt3=null; 

						}else{
							if (str1.equals("I"))	{
								
								GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
								gsmt.setGauceDataRow(rows[j]);

								gsmt.bindColumn(1, idxSTDYM);
								gsmt.bindColumn(2, idxCDDIV);
								gsmt.bindColumn(3, idxPAYGRD);
								gsmt.bindColumn(4, idxPAYSEQ);
								gsmt.bindColumn(5, idxAMT);

								gsmt.executeUpdate();
								gsmt.close();
							
							}else if (str1.equals("U"))	{
							
								GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
								gsmt.setGauceDataRow(rows[j]);
								
								gsmt.bindColumn(1, idxAMT);
								gsmt.bindColumn(2, idxSTDYM);
								gsmt.bindColumn(3, idxCDDIV);
								gsmt.bindColumn(4, idxPAYGRD);
								gsmt.bindColumn(5, idxPAYSEQ);

								gsmt.executeUpdate(); 
								gsmt.close();
							}else {
								GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
								gsmt.setGauceDataRow(rows[j]);

								gsmt.bindColumn(1, idxSTDYM);
								gsmt.bindColumn(2, idxCDDIV);
								gsmt.bindColumn(3, idxPAYGRD);
								gsmt.bindColumn(4, idxPAYSEQ);
								gsmt.bindColumn(5, idxAMT);

								gsmt.executeUpdate();
								gsmt.close();
							}
						}
								sql2=null;  rs2.close(); 

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxAMT);
						gsmt.bindColumn(2, idxSTDYM);
						gsmt.bindColumn(3, idxCDDIV);
						gsmt.bindColumn(4, idxPAYGRD);
						gsmt.bindColumn(5, idxPAYSEQ);
						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idxSTDYM);
						gsmt.bindColumn(2, idxCDDIV);
						gsmt.bindColumn(3, idxPAYGRD);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
				if (stmt2 != null) try { stmt2.close(); } catch (Exception e) {}
				if (rs2 != null) try {rs2.close();} catch (Exception e) {}
			} catch(Exception e) {
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
		  	logger.err.println(this,e);
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