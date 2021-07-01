
package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h010025_t1 extends HttpServlet{

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
				String  str1	= req.getParameter("v_str1");  // d : 신청날짜
				String  str2	= req.getParameter("v_str2"); //       현재날짜
				String  str3	= req.getParameter("v_str3");  // 순번
				String  str4	= req.getParameter("v_str4");    // 사번
                
			    

				conn = service.getDBConnection();

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxEMPNO = userSet.indexOfColumn("EMPNO");
				int idxREQDT = userSet.indexOfColumn("REQDT");
				int idxSEQ = userSet.indexOfColumn("SEQ");
				int idxSUBJECT = userSet.indexOfColumn("SUBJECT");
				int idxFRDT = userSet.indexOfColumn("FRDT");
				int idxTODT = userSet.indexOfColumn("TODT");
				int idxEDUDAY = userSet.indexOfColumn("EDUDAY");
				int idxEDUPLC = userSet.indexOfColumn("EDUPLC");
				int idxEDUINST = userSet.indexOfColumn("EDUINST");
//				int idxSGDT = userSet.indexOfColumn("SGDT");
//				int idxSGID = userSet.indexOfColumn("SGID");
//				int idxAPDT = userSet.indexOfColumn("APDT");
//				int idxAPID = userSet.indexOfColumn("APID");
				int idxMEMO = userSet.indexOfColumn("MEMO");

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				StringBuffer SelectSql = null;
				SelectSql = new StringBuffer();
				
				SelectSql.append(" SELECT MAX(SEQ)+1 FROM PAYROLL.HEDUCATION WHERE EMPNO = '"+str4+"' AND REQDT='"+str2+"' ");
	
				Statement stmt = null;
				stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(SelectSql.toString());
				int sNo = 0;
	    		if(rs.next()){
					 sNo = rs.getInt(1);
					}	
				if( sNo < 1) sNo = 1;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO PAYROLL.HEDUCATION (  ");
				InsertSql.append( " EMPNO, REQDT, SEQ, SUBJECT, FRDT,  ");
				InsertSql.append( " TODT, EDUDAY, EDUPLC, EDUINST, MEMO  ");
				InsertSql.append( ") values (  ");
				InsertSql.append( " '"+str4+"', '"+str2+"',"+sNo+",?,?, ");
				InsertSql.append( " ?,?,?,?,?) ");

	
				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.HEDUCATION SET " );
				UpdateSql.append( " SUBJECT = ?, FRDT =?, \n  " );
				UpdateSql.append( " TODT = ?, EDUDAY = ?, EDUPLC = ?, EDUINST = ?,  \n  " );
				UpdateSql.append( " MEMO = ? " );
				UpdateSql.append( " WHERE EMPNO = '"+str4+"' AND SEQ = ? AND REQDT = ? " );
//				UpdateSql.append( " WHERE EMPNO = '"+str4+"' AND SEQ = ? AND REQDT = '"+str2+"' " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HEDUCATION WHERE EMPNO = '"+str4+"' AND SEQ = ? AND REQDT = ? " );

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
	//					gsmt.bindColumn(1, idxREQDT);
						gsmt.bindColumn(1, idxSUBJECT);
						gsmt.bindColumn(2, idxFRDT);
						gsmt.bindColumn(3, idxTODT);
						gsmt.bindColumn(4, idxEDUDAY);
						gsmt.bindColumn(5, idxEDUPLC);
						gsmt.bindColumn(6, idxEDUINST);
	//					gsmt.bindColumn(7, idxSGDT);
	//					gsmt.bindColumn(8, idxSGID);
	//					gsmt.bindColumn(9, idxAPDT);
	//					gsmt.bindColumn(10, idxAPID);
						gsmt.bindColumn(7, idxMEMO);
						logger.dbg.println(this,"str4"+str4.toString());
						logger.dbg.println(this,"InsertSql"+InsertSql.toString());
					//	logger.dbg.println(this,"sNo"+sNo.toInteger());
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxSUBJECT);
						gsmt.bindColumn(2, idxFRDT);
						gsmt.bindColumn(3, idxTODT);
						gsmt.bindColumn(4, idxEDUDAY);
						gsmt.bindColumn(5, idxEDUPLC);
						gsmt.bindColumn(6, idxEDUINST);
	//					gsmt.bindColumn(7, idxSGDT);
	//					gsmt.bindColumn(8, idxSGID);
	//					gsmt.bindColumn(9, idxAPDT);
	//					gsmt.bindColumn(10, idxAPID);
						gsmt.bindColumn(7, idxMEMO);
						gsmt.bindColumn(8, idxSEQ);
						gsmt.bindColumn(9, idxREQDT);
logger.dbg.println(this,"UpdateSql"+UpdateSql.toString());
						gsmt.executeUpdate(); 
						gsmt.close();         
                                    
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxSEQ);
						gsmt.bindColumn(2, idxREQDT);
						logger.dbg.println(this,"DeleteSql"+DeleteSql.toString());
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