package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class comtax_popup_t1 extends HttpServlet{
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

				String str1 = reqGauce.getParameter("v_str1");			//계산서일자

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"TAXNBR","COCODE","TAXIODIV","TAXDIV","TAXKND",
					"CCCODE","TAXDAT","TAXSUM","TAXVATAMT","TAXTOT",
					"REMARK","TAXCDNBR","FSDAT","FSNBR","TAXKIDIV",
					"WRDT","WRID","UPDT","UPID","FDCODE"
				};

				int[] idx = new int[20];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;
				StringBuffer DeleteSql2 = null;

				Statement stmt = null;
				ResultSet rs = null;
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

							String taxch = rows[j].getString(idx[0]);
							StringBuffer sql = new StringBuffer();

							sql.append( " SELECT CAST(MAX(TAXNBR) AS INTEGER)+1 CNT					");
							sql.append( " FROM ACCOUNT.ATTAXMST															");
							sql.append( " WHERE SUBSTR(TAXNBR,1,4) = SUBSTR('"+str1+"',1,4) ");

							stmt = conn.createStatement();
							rs = stmt.executeQuery(sql.toString());

							while(rs.next())	{
								taxch = rs.getInt(1) + "";
							}

						if (taxch==null||taxch.length()<10) taxch = str1.substring(0,6) + "0001";
						else taxch = taxch + "";
						
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.ATTAXMST ( ");
						InsertSql.append( " TAXNBR,COCODE,TAXIODIV,TAXDIV,TAXKND, ");
						InsertSql.append( " CCCODE,TAXDAT,TAXSUM,TAXVATAMT,TAXTOT, ");
						InsertSql.append( " REMARK,TAXCDNBR,FSDAT,FSNBR,TAXKIDIV, ");
						InsertSql.append( " WRDT,WRID,UPDT,UPID,FDCODE ");
						InsertSql.append( " ) VALUES( " );
						InsertSql.append( " '"+taxch+"',?, ?, ?, ?, " );
						InsertSql.append( " ?, ?, ?, ?, ?, " );
						InsertSql.append( " ?, ?, ?, ?, ?, " );
						InsertSql.append( " ?, ?, ?, ?, ? ) " );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for(int k=1;k<=19;k++) {
							gsmt.bindColumn(k, idx[k]);
						}
						
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql=null;
						taxch = "";
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.ATTAXMST SET																					");
						UpdateSql.append( " COCODE = ?,		TAXIODIV = ?, TAXDIV = ?,			TAXKND = ?, CCCODE = ?, ");
						UpdateSql.append( " TAXDAT = ?,		TAXSUM = ?,		TAXVATAMT = ?,	TAXTOT = ?, REMARK = ?, ");
						UpdateSql.append( " TAXCDNBR = ?, FSDAT = ?,		FSNBR = ?,			TAXKIDIV = ?, WRDT = ?,	");
						UpdateSql.append( " WRID = ?,				UPDT = ?,		UPID = ?,       FDCODE = ?							");
						UpdateSql.append( " WHERE TAXNBR = ?																										");
			
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for(int s=1;s<=19;s++) {
							gsmt.bindColumn(s, idx[s]);
						}
						
						gsmt.bindColumn(20, idx[0]);

						gsmt.executeUpdate(); 
						gsmt.close();         
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();		/*세금계산서 MST*/
						DeleteSql.append( " DELETE FROM ACCOUNT.ATTAXMST WHERE TAXNBR = ? ");
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.executeUpdate();
						gsmt.close();

						DeleteSql2 = new StringBuffer();	/*세금계산서 DTL*/
						DeleteSql2.append( " DELETE FROM ACCOUNT.ATTAXDTL WHERE TAXNBR = ? ");
						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.bindColumn(1, idx[0]);
						gsmt2.executeUpdate();
						gsmt2.close();
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