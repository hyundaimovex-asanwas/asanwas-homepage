package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class comtax_popup_t2 extends HttpServlet{
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

				String str1 = reqGauce.getParameter("v_str1");			//계산서번호

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"TAXNBR","TAXSEQ","TAXPDTNAM","TAXSTD","TAXQTY",
					"TAXPRIC","TAXSUM","TAXVATAMT","BIGO","WRDT",
					"WRID","UPDT","UPID"
				};

				int[] idx = new int[13];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.ATTAXDTL ( ");
						InsertSql.append( " TAXNBR,TAXSEQ,TAXPDTNAM,TAXSTD,TAXQTY, ");
						InsertSql.append( " TAXPRIC,TAXSUM,TAXVATAMT,BIGO,WRDT, ");
						InsertSql.append( " WRID,UPDT,UPID ");
						InsertSql.append( " ) VALUES( " );
						InsertSql.append( " '"+str1+"',?, ?, ?, ?, " );
						InsertSql.append( " ?, ?, ?, ?, ?, " );
						InsertSql.append( " ?, ?, ? )      " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for(int k=1;k<=12;k++) {
							gsmt.bindColumn(k, idx[k]);
						}
						
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.ATTAXDTL SET																	");
						UpdateSql.append( " TAXPDTNAM = ?,TAXSTD = ?,TAXQTY = ?,TAXPRIC = ?,TAXSUM = ?,	");
						UpdateSql.append( " TAXVATAMT = ?,BIGO = ?,WRDT = ?,WRID = ?,UPDT = ?,					");
						UpdateSql.append( " UPID = ?																										");
						UpdateSql.append( " WHERE TAXNBR = '"+str1+"'	AND TAXSEQ = ?										");
			
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for(int s=1;s<=11;s++) {
							gsmt.bindColumn(s, idx[s+1]);
						}

						gsmt.bindColumn(12, idx[1]);

						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM ACCOUNT.ATTAXDTL WHERE TAXNBR = '"+str1+"' AND TAXSEQ = ? ");
						
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idx[1]);
						
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