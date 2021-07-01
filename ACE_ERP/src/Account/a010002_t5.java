package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a010002_t5 extends HttpServlet{
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

				String str1 = reqGauce.getParameter("v_str1");  //original atcode

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"PRTCODE","PRTNBR","ATCODE","PRTNAM","LRDIV",
					"PRTLT","PRTRT","PRTSEQ", "PRTNO"
				};

				int[] idx = new int[9];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {						
						//레포트출력순서
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.RPTPRTACT ( 														\n");
						InsertSql.append( " PRTCODE,PRTNBR,ATCODE,PRTNAM,LRDIV,PRTLT,PRTRT,PRTSEQ,PRTNO 	\n");
						InsertSql.append( " ) VALUES( 																							\n");
						InsertSql.append( " ?, ?, ?, ?, ?, ?, ?, ?, ? 																			\n");
						InsertSql.append( " ) 																										\n");
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for(int k=1;k<=9;k++) {
							gsmt.bindColumn(k, idx[k-1]);
						}
						
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.RPTPRTACT SET																				\n");
						UpdateSql.append( " PRTNAM = ?,	LRDIV = ?, PRTLT = ?, PRTRT = ?,	PRTSEQ = ?, PRTNO = ?, ATCODE = ?		\n");
						UpdateSql.append( " WHERE PRTCODE = ?	AND PRTNBR = ? 	AND ATCODE = '"+str1+"'									\n");

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[3]);
						gsmt.bindColumn(2, idx[4]);
						gsmt.bindColumn(3, idx[5]);
						gsmt.bindColumn(4, idx[6]);
						gsmt.bindColumn(5, idx[7]);
						gsmt.bindColumn(6, idx[8]);
						gsmt.bindColumn(7, idx[2]);
						gsmt.bindColumn(8, idx[0]);
						gsmt.bindColumn(9, idx[1]);

						gsmt.executeUpdate(); 
						gsmt.close();
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM ACCOUNT.RPTPRTACT WHERE PRTCODE = ? AND PRTNBR = ? AND ATCODE = ? \n");						
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);
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