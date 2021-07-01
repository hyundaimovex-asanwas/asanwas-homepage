package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a200001_t1 extends HttpServlet{
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
				
				String str1 = reqGauce.getParameter("v_str1");	//수정일자
				String str2 = reqGauce.getParameter("v_str2");	//수정자

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"FDCODE","ATCODE","FUNDDIV","BANCOD","REFCODE2",
					"GETDATE","GETMEN","BCDIV","STDIV","STDATE",
					"UPDT","UPID"};

				int[] idx = new int[12];
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
								어음관리
						********************************************************************/

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.ABILLCHK (			");
						InsertSql.append( " FDCODE,ATCODE,FUNDDIV,BANCOD,REFCODE2,	");
						InsertSql.append( " GETDATE,GETMEN,BCDIV,STATDIV,STDATE		");
						InsertSql.append( " ) VALUES(								");
						InsertSql.append( " ?, ?, ?, ?, ?,				");
						InsertSql.append( " ?, ?, ?, ?, ?							");
						InsertSql.append( " )										");

						//logger.dbg.println(this, "T2-"+InsertSql.toString());

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for(int k=1;k<=10;k++) {
							gsmt.bindColumn(k, idx[k-1]);
						}
					
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.ABILLCHK SET								");
						UpdateSql.append( " BANCOD = ?,	GETDATE = ?, GETMEN = ?, BCDIV = ?,				");
						UpdateSql.append( " STATDIV = ?,    STDATE = ?,		");
						UpdateSql.append( " UPDT = '"+str1+"',	UPID = '"+str2+"'			");
						UpdateSql.append( " WHERE FDCODE=?	AND ATCODE=?	");
						UpdateSql.append( " AND   FUNDDIV=? AND REFCODE2 = ?	");

						//logger.dbg.println(this, "T3-"+UpdateSql.toString());
			
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idx[3]);
						gsmt.bindColumn(2,  idx[5]);
						gsmt.bindColumn(3,  idx[6]);
						gsmt.bindColumn(4,  idx[7]);
						gsmt.bindColumn(5,  idx[8]);
						gsmt.bindColumn(6,  idx[9]);
						gsmt.bindColumn(7,  idx[0]);
						gsmt.bindColumn(8,  idx[1]);
						gsmt.bindColumn(9,  idx[2]);
						gsmt.bindColumn(10, idx[4]);

						gsmt.executeUpdate(); 
						gsmt.close();
						
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
				
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM ACCOUNT.ABILLCHK WHERE FDCODE = ?		");
						DeleteSql.append( " AND ATCODE = ? AND FUNDDIV = ? AND REFCODE2 = ? ");
						
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);
						gsmt.bindColumn(4, idx[4]);
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
			if (conn != null) try {conn.close(true);} catch (Exception e) {}
			loader.restoreService(service);
	 	}
	}
}