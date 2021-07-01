package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p030002_t2 extends HttpServlet{

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

				
				int  idxEMPNO			= userSet.indexOfColumn("EMPNO");
				int  idxAPPDT			= userSet.indexOfColumn("APPDT");
				int  idxRELAT1  = userSet.indexOfColumn("RELAT1");
				int  idxFAMNM1  = userSet.indexOfColumn("FAMNM1");
				int  idxRESINO1 = userSet.indexOfColumn("RESINO1");
				int  idxREF1  = userSet.indexOfColumn("REF1");
				int  idxREF2  = userSet.indexOfColumn("REF2");
				int  idxREF3  = userSet.indexOfColumn("REF3");
				int  idxREF4  = userSet.indexOfColumn("REF4");
				int  idxREF11  = userSet.indexOfColumn("REF11");
				int  idxREF12  = userSet.indexOfColumn("REF12");
				int  idxREF13  = userSet.indexOfColumn("REF13");
				int  idxREF14  = userSet.indexOfColumn("REF14");
				int  idxREF15  = userSet.indexOfColumn("REF15");
				int  idxREF21  = userSet.indexOfColumn("REF21");
				int  idxREF22  = userSet.indexOfColumn("REF22");
				int  idxREF23  = userSet.indexOfColumn("REF23");
				int  idxREF24  = userSet.indexOfColumn("REF24");
				int  idxREF25  = userSet.indexOfColumn("REF25");
				
			
			
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				InsertSql = new StringBuffer();																						
				InsertSql.append( "  " );		
			
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.YCPRSN SET ");
				UpdateSql.append( " RELAT1=?,		RESINO1=?,		");
				UpdateSql.append( " REF1=?,			REF2=?,		REF3=?,		REF4=?,		");
				UpdateSql.append( " REF11=?,		REF12=?,		REF13=?,		REF14=?,		REF15=?,		");
				UpdateSql.append( " REF21=?,		REF22=?,		REF23=?,		REF24=?,		REF25=?	");
				UpdateSql.append( " WHERE EMPNO = ? 	AND  APPDT = ?	AND FAMNM1 = ? ");
			
				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE from  PAYROLL.YCPRSN ");
			  DeleteSql.append( " WHERE  EMPNO = ? AND  APPDT = ? AND  FAMNM1 = ? ");

			for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					  GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
            gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();
					}
				
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,idxRELAT1);
						gsmt.bindColumn(2,idxRESINO1);
						gsmt.bindColumn(3,idxREF1);
						gsmt.bindColumn(4,idxREF2);
						gsmt.bindColumn(5,idxREF3);
						gsmt.bindColumn(6,idxREF4);
						gsmt.bindColumn(7,idxREF11);
						gsmt.bindColumn(8,idxREF12);
						gsmt.bindColumn(9,idxREF13);
						gsmt.bindColumn(10,idxREF14);
						gsmt.bindColumn(11,idxREF15);
						gsmt.bindColumn(12,idxREF21);
						gsmt.bindColumn(13,idxREF22);
						gsmt.bindColumn(14,idxREF23);
						gsmt.bindColumn(15,idxREF24);
						gsmt.bindColumn(16,idxREF25);
						gsmt.bindColumn(17,idxEMPNO);
						gsmt.bindColumn(18,idxAPPDT);
						gsmt.bindColumn(19,idxFAMNM1);
					
						gsmt.executeUpdate(); 
						gsmt.close();       
					}      
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxEMPNO);
						gsmt.bindColumn(2,  idxAPPDT);
						gsmt.bindColumn(2,  idxFAMNM1);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}

/*
			GauceDataSet user2Set = req.getGauceDataSet("USER2");
			if (user2Set != null) {
				if (req.isBuilderRequest()) {
					user2Set.setUsage(true);
					user2Set.addDataColumn(new GauceDataColumn("deptno", GauceDataColumn.TB_INT));
					user2Set.addDataColumn(new GauceDataColumn("dname", GauceDataColumn.TB_STRING));
					user2Set.addDataColumn(new GauceDataColumn("loc", GauceDataColumn.TB_STRING));
					res.write(user2Set);
				}

				int idxDeptno = user2Set.indexOfColumn("deptno");
				int idxDname = user2Set.indexOfColumn("dname");
				int idxLoc = user2Set.indexOfColumn("loc");
				GauceDataRow[] rows = user2Set.getDataRows();
				for (int j = 0; j < rows.length; j++) {
						if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
								String query = "insert into dept(deptno, dname, loc) values(?, ?, ?)";
								GauceStatement gsmt = conn.getGauceStatement(query);
								gsmt.setGauceDataRow(rows[j]);
								gsmt.bindColumn(1, idxDeptno);
								gsmt.bindColumn(2, idxDname);
								gsmt.bindColumn(3, idxLoc);
								gsmt.executeUpdate();
								gsmt.close();
						}
						if (rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
								String query = "update dept set deptno =?, dname = ?, loc = ? where deptno = ?";
								GauceStatement gsmt = conn.getGauceStatement(query);
								gsmt.setGauceDataRow(rows[j]);
								gsmt.bindColumn(1, idxDeptno);
								gsmt.bindColumn(2, idxDname);
								gsmt.bindColumn(3, idxLoc);
								gsmt.bindColumn(4, idxDeptno);
								gsmt.executeUpdate();
								gsmt.close();
						}
						if (rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
								String query = "delete from dept where deptno = ?";
								GauceStatement gsmt = conn.getGauceStatement(query);
								gsmt.setGauceDataRow(rows[j]);
								gsmt.bindColumn(1, idxDeptno);
								gsmt.executeUpdate();
								gsmt.close();
						}
				}
			}
*/

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