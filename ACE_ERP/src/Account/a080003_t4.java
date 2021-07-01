package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a080003_t4 extends HttpServlet{
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

				String str1  = reqGauce.getParameter("v_str1");		//지점코드              
				String str2  = reqGauce.getParameter("v_str2");		//신청서번호
				String str3  = reqGauce.getParameter("v_str3");		//순번
				String str4  = reqGauce.getParameter("v_str4");		//요청서상태				

				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"FDCODE", "BGTRQNO","BGTRQSEQ","BGTRQST"																
				};

				int[] idx = new int[4];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();				
				StringBuffer InsertSql  = null;	
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						/*******************************************************************
								예산 Master Update
						********************************************************************/
						InsertSql = new StringBuffer();
						InsertSql.append( " UPDATE ACCOUNT.BGTRQDTL1 SET	                \n");
						InsertSql.append( " BGTRQST = '"+rows[j].getString(idx[3])+"'		\n");
						InsertSql.append( " WHERE FDCODE  ='"+rows[j].getString(idx[0])+"'  \n");
						InsertSql.append( "   AND BGTRQNO ='"+rows[j].getString(idx[1])+"' 	\n");
                        InsertSql.append( "   AND BGTRQSEQ='"+rows[j].getString(idx[2])+"' 	\n");

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.executeUpdate();
						gsmt.close();

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						/*******************************************************************
								예산 Master Update
						********************************************************************/
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.BGTRQDTL1 SET	                \n");
						UpdateSql.append( " BGTRQST = '"+rows[j].getString(idx[3])+"'	    \n");
						UpdateSql.append( " WHERE FDCODE='"+rows[j].getString(idx[0])+"'    \n");
						UpdateSql.append( "   AND BGTRQNO='"+rows[j].getString(idx[1])+"' 	\n");
                        UpdateSql.append( "   AND BGTRQSEQ='"+rows[j].getString(idx[2])+"' 	\n");

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.executeUpdate(); 
						gsmt.close();
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
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