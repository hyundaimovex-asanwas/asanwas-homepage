package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class loss_popup_t1 extends HttpServlet{
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
				
				String str1 = reqGauce.getParameter("v_str1");	//수정일자
				String str2 = reqGauce.getParameter("v_str2");	//수정자

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
				"FDCODE","ATCODE","FUNDDIV","REFCODE2","LOSDATE",
				"LOSPLACE","RTNDATE","RTNPLACE","REMARK"//,"UPDT","UPID"
				};

				int[] idx = new int[9];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql   = null;
				StringBuffer InsertSql2  = null;
				StringBuffer UpdateSql   = null;
				StringBuffer UpdateSql2  = null;
				StringBuffer DeleteSql   = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						/*******************************************************************
								어음원장 처리구분 '0' 설정
						********************************************************************/
						/*String p_fdcode = rows[j].getString(idx[0]);
						String p_fundiv = rows[j].getString(idx[1]);
						String p_refcod = rows[j].getString(idx[3]);
						InsertSql2.append( " UPDATE ACCOUNT.ABILLCHK SET		");
						InsertSql2.append( " STATDIV='0'										");	
						InsertSql2.append( " WHERE FDCODE='"+p_fdcode+"'		");	
						InsertSql2.append( " AND ATCODE='"+p_fundiv+"'			");	
						InsertSql2.append( " AND FUNDDIV='60'								"); 
						InsertSql2.append( " AND REFCODE2='"+p_refcod+"'		"); 

						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.executeUpdate();
						gsmt2.close();
						*/

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.ABILLOSS (					");
						InsertSql.append( " FDCODE,ATCODE,FUNDDIV,REFCODE2,LOSDATE,	");
						InsertSql.append( " LOSPLACE,RTNDATE,RTNPLACE,REMARK				");
						InsertSql.append( " ) VALUES(																");
						InsertSql.append( " '"+rows[j].getString(idx[0])+"', ");
						InsertSql.append( " '"+rows[j].getString(idx[1])+"', ");
						InsertSql.append( " '"+rows[j].getString(idx[2])+"', ");
						InsertSql.append( " '"+rows[j].getString(idx[3])+"', ");
						InsertSql.append( " '"+rows[j].getString(idx[4])+"', ");
						InsertSql.append( " '"+rows[j].getString(idx[5])+"', ");
						InsertSql.append( " '"+rows[j].getString(idx[6])+"', ");
						InsertSql.append( " '"+rows[j].getString(idx[7])+"', ");
						InsertSql.append( " '"+rows[j].getString(idx[8])+"'	 ");
						InsertSql.append( " )																 ");

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.ABILLOSS SET													");
						UpdateSql.append( " LOSDATE=?,LOSPLACE=?,RTNDATE=?,RTNPLACE=?,REMARK=?,	");
						UpdateSql.append( " UPDT='"+str1+"',	UPID='"+str2+"'										");
						UpdateSql.append( " WHERE FDCODE=?	AND ATCODE=?												");
						UpdateSql.append( " AND   FUNDDIV=? AND REFCODE2 = ?										");

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idx[4]);
						gsmt.bindColumn(2,  idx[5]);
						gsmt.bindColumn(3,  idx[6]);
						gsmt.bindColumn(4,  idx[7]);
						gsmt.bindColumn(5,  idx[8]);
						gsmt.bindColumn(6,  idx[0]);
						gsmt.bindColumn(7,  idx[1]);
						gsmt.bindColumn(8,  idx[2]);
						gsmt.bindColumn(9,  idx[3]);

						gsmt.executeUpdate(); 
						gsmt.close();

						/*******************************************************************
								어음원장 처리구분 '0' 설정
						********************************************************************/
						/*UpdateSql2.append( " UPDATE ACCOUNT.ABILLCHK SET		");
						UpdateSql2.append( " STATDIV='0'										");
						UpdateSql2.append( " WHERE FDCODE=?	AND ATCODE=?		");
						UpdateSql2.append( " AND FUNDDIV=? AND REFCODE2 = ?	");
						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						for(int k=1;k<=4;k++) {
							gsmt.bindColumn(k, idx[k-1]);
						}
						gsmt2.executeUpdate();
						gsmt2.close();
						*/
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM ACCOUNT.ABILLOSS 															");
						DeleteSql.append( " WHERE FDCODE=? AND ATCODE=? AND FUNDDIV=? AND REFCODE2=?	");
						
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);
						gsmt.bindColumn(4, idx[3]);
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(Exception e){
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
			if (conn != null) try {conn.close(true);} catch (Exception e) {}
			loader.restoreService(service);
	 	}
	}
}