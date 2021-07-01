package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a080005_t2 extends HttpServlet{
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
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1  = reqGauce.getParameter("v_str1");		//지점구분
				String str2  = reqGauce.getParameter("v_str2");		//신청서번호
				
				if(str1==null) str1="";
				if(str2==null) str2="";
				
				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
				"CHK",       "BGTRQNO",   "FDCODE",    "BGTYY",     "BGTMM",     
				"BGTDIV",    "BGTDPT",    "ATCODE",    "FSREFC",    "SATCODE",   
				"BGTRQST",   "ATKORNAM",  "SATNAM",    "DEPTNM",    "BGTRQDIV",  
				"BGTRQAMT",  "M_ATCODE",  "M_FSREFCD", "M_SATCODE", "BGTFRMON",  
				"P_BGTDEPT", "P_BGTDIV"

				};

				int[] idx = new int[22];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();
				
				StringBuffer InsertSql = null;
				StringBuffer InsertSql2 = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						/*******************************************************************
							예산 Detail Update 
						********************************************************************/
						InsertSql = new StringBuffer();
						
						InsertSql.append( " UPDATE ACCOUNT.BGTRQDTL1 SET							\n");
						InsertSql.append( "		BGTRQST   = 'B'	/*신청서구분*/							\n");
						InsertSql.append( " WHERE FDCODE = '"+rows[j].getString(idx[2])+"'			\n");
						InsertSql.append( " AND  BGTRQNO = '"+rows[j].getString(idx[1])+"'				\n");
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql = null;

						/*******************************************************************
								예산 Master Update 
						********************************************************************/
						InsertSql2 = new StringBuffer();
						
						InsertSql2.append( " UPDATE ACCOUNT.BGTRQMST SET							\n");
						InsertSql2.append( "		BGTRQST =  'B'	/*신청서구분*/							\n");
						InsertSql2.append( " WHERE FDCODE = '"+rows[j].getString(idx[2])+"'			\n");
						InsertSql2.append( " AND  BGTRQNO = '"+rows[j].getString(idx[1])+"'			\n");

						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.executeUpdate();
						gsmt2.close();
						InsertSql2 = null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
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