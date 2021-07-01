package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class astFinish_popup_t1 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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

				int intcnt=0;       
     
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE    = userSet.indexOfColumn("FDCODE");  //첫번째 인덱스
				int idxYEAR      = userSet.indexOfColumn("YEAR");   
				int idxMONTH     = userSet.indexOfColumn("MONTH");   
				int idxGUBUN     = userSet.indexOfColumn("GUBUN");   
				int idxCLOSEYN   = userSet.indexOfColumn("CLOSEYN");
				int idxWRID      = userSet.indexOfColumn("WRID");    
				int idxUPID      = userSet.indexOfColumn("UPID");    

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
			
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.ASTCLOSE (  										\n");
				InsertSql.append( " FDCODE,  YEAR,    MONTH,   GUBUN,   CLOSEYN, 							\n");
				InsertSql.append( " WRID,    WRDT,    UPID,    UPDT 										\n");
				InsertSql.append( "  ) 																		\n");
				InsertSql.append( " VALUES ( ?,?,?,?,?,?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP)				\n");	 

				UpdateSql = new StringBuffer();
				UpdateSql.append( "  UPDATE ACCOUNT.ASTCLOSE SET  		\n");
				UpdateSql.append( "  CLOSEYN =? ,									\n");
				UpdateSql.append( "  UPID =?, 											\n");
				UpdateSql.append( "  UPDT = CURRENT_TIMESTAMP 				\n");
				UpdateSql.append( "  WHERE FDCODE = ? 							\n");
				UpdateSql.append( "    AND YEAR = ? 									\n");
				UpdateSql.append( "    AND MONTH = ? 								\n");
				UpdateSql.append( "    AND GUBUN = ? 								\n");
	    
        //===================================================================================
				for (int j = 0; j < rows.length; j++){

				if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						  //기존데이터 조회
							Statement stmt = conn.createStatement();
							String sql = " SELECT COUNT(*) FROM ACCOUNT.ASTCLOSE "
												 + "	WHERE FDCODE ='"+ rows[j].getString(idxFDCODE)+"'" 
												 + "	  AND YEAR='"+rows[j].getString(idxYEAR)+"'"
												 + "	  AND MONTH='"+rows[j].getString(idxMONTH)+"'"
												 + "	  AND GUBUN='"+rows[j].getString(idxGUBUN)+"'";		
	
							ResultSet rs = stmt.executeQuery(sql); 
							if(rs.next()){
								 intcnt = rs.getInt(1);
							}
							rs.close();
							stmt.close();
		
							if(intcnt>0){ //데이터가 존재하는 경우  CLOSEYN 날짜 성명만...update

								GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

								gsmt.setGauceDataRow(rows[j]);
								gsmt.bindColumn(1, idxCLOSEYN);
								gsmt.bindColumn(2, idxUPID);
								gsmt.bindColumn(3, idxFDCODE);
								gsmt.bindColumn(4, idxYEAR);
								gsmt.bindColumn(5, idxMONTH);
								gsmt.bindColumn(6, idxGUBUN);

								gsmt.executeUpdate();
							  gsmt.close();

							}else{ //신규 insert

								GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

								gsmt.setGauceDataRow(rows[j]);
								gsmt.bindColumn(1, idxFDCODE);
								gsmt.bindColumn(2, idxYEAR);
								gsmt.bindColumn(3, idxMONTH);
								gsmt.bindColumn(4, idxGUBUN);
								gsmt.bindColumn(5, idxCLOSEYN);
								gsmt.bindColumn(6, idxWRID);
								gsmt.bindColumn(7, idxUPID);

								gsmt.executeUpdate();
							  gsmt.close();

							}
				 } //getJobType
			}  //for j 
     			
			} //try
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::");
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
      conn.commit();
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