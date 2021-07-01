package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a080003_t1 extends HttpServlet{
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

				String str1  = reqGauce.getParameter("v_str1");		//신청서번호              
				String str2  = reqGauce.getParameter("v_str2");		//저장구분[mst(A)-I,U] OR [dtl_1(B)-I,U]

				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"FDCODE", "BGTRQNO",  "BGTYY",  "BGTDIV", "BGTDPT",  
					"DEPTCD", "EMPNO",    "WRDT",   "COSTCD", "BGTRQST", 
					"ATCODE", "FSREFCD",  "SATCODE","BGTGBCD","BGTTYPE", 
					"BGTMACT","BGTRQNOTE","WHYRQNOTE"																	
				};

				int[] idx = new int[18];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();
				
				StringBuffer InsertSql  = null;	//예산Master
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;
		
				StringBuffer DeleteSql2 = null;	//예산Detail(1)
				StringBuffer DeleteSql3 = null;	//예산Detail(2)
				StringBuffer DeleteSql4 = null;	//예산Detail(3)
				
				Statement stmt = null;
				ResultSet rs = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						/*******************************************************************
								예산 신청 Master InSert 
						********************************************************************/
						String Sbgtrqno1 = rows[j].getString(idx[1]);
						String Chk01     = "";
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT												 /*신청서번호*/				\n"); 
						sql.append( " CAST(MAX(SUBSTR(BGTRQNO,3,12)) AS INTEGER)+1 CNT				\n"); 
						sql.append( " FROM ACCOUNT.BGTRQMST														\n"); 
						sql.append( " WHERE FDCODE='"+rows[j].getString(idx[0])+"'								\n");
						sql.append( " AND SUBSTR(BGTRQNO,1,8)=SUBSTR('BR"+str1+"',1,8)					\n");

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while(rs.next())	{
							Sbgtrqno1 = rs.getInt(1) + "";
						}

						if (Sbgtrqno1.equals("0")) { 
							Sbgtrqno1 = "BR" + str1 + "0001";		Chk01 = "N";		//최초생성
						}else{	
							Sbgtrqno1 = "BR" + Sbgtrqno1 + "";	Chk01 = "N";		//추가생성
						}

						if (Chk01.equals("N"))	{	//New Create
							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO ACCOUNT.BGTRQMST (								");  
							InsertSql.append( " FDCODE,  BGTRQNO, BGTYY,   BGTDIV,  BGTDPT, 	");  
							InsertSql.append( " DEPTCD,  EMPNO,   WRDT,    COSTCD,  BGTRQST,	");  
							InsertSql.append( " ATCODE,  FSREFCD, SATCODE, BGTGBCD, BGTTYPE,	");  
							InsertSql.append( " BGTMACT, BGTRQNOTE,WHYRQNOTE                 	"); 
 
							InsertSql.append( " ) VALUES(																			");
  
							InsertSql.append( " ?,'"+Sbgtrqno1+"',?,?,?,		  							  ");  
							InsertSql.append( " ?, ?, ?, ?, ?,																");  
							InsertSql.append( " ?, ?, ?, ?, ?,																");
  
							InsertSql.append( " ?, ?, ?																				");  
							InsertSql.append( " )																							");

							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1, idx[0]);
							for(int s=2;s<=17;s++) {
								gsmt.bindColumn(s, idx[s]);
							}

							gsmt.executeUpdate();
							gsmt.close();
						}
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						/*******************************************************************
								예산 Master Update
						********************************************************************/
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.BGTRQMST SET														\n");
						UpdateSql.append( " BGTYY = ?,   BGTDIV = ?,  BGTDPT = ?,   DEPTCD = ?,		\n");
						UpdateSql.append( " EMPNO = ?,   WRDT = ?,	  COSTCD = ?,   BGTRQST = ?,	\n");
						UpdateSql.append( " ATCODE = ?,	 FSREFCD = ?, SATCODE = ?,  BGTGBCD = ?,	\n");
						UpdateSql.append( " BGTTYPE = ?, BGTMACT = ?, BGTRQNOTE = ?,WHYRQNOTE=?		\n");
						UpdateSql.append( " WHERE FDCODE=? AND BGTRQNO=? 													\n");

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for(int t=1;t<=16;t++) {
							gsmt.bindColumn(t, idx[t+1]);
						}

						gsmt.bindColumn(17, idx[0]);
						gsmt.bindColumn(18, idx[1]);
						gsmt.executeUpdate(); 
						gsmt.close();
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						/*******************************************************************
								예산 Master Delete
						********************************************************************/
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM ACCOUNT.BGTRQMST					");
						DeleteSql.append( " WHERE FDCODE = ? AND BGTRQNO = ?			");
			
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.executeUpdate(); 
						gsmt.close();

						/*******************************************************************
								예산 Detail(1) Delete
						********************************************************************/
						DeleteSql2 = new StringBuffer();
						DeleteSql2.append( " DELETE FROM ACCOUNT.BGTRQDTL1			 ");
						DeleteSql2.append( " WHERE FDCODE = ? AND BGTRQNO = ?    ");
			
						GauceStatement gsmt3 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt3.setGauceDataRow(rows[j]);
						gsmt3.bindColumn(1, idx[0]);
						gsmt3.bindColumn(2, idx[1]);
						gsmt3.executeUpdate(); 
						gsmt3.close();

						/*******************************************************************
								예산 Detail(2) Delete
						********************************************************************/
						DeleteSql3 = new StringBuffer();
						DeleteSql3.append( " DELETE FROM ACCOUNT.BGTRQDTL2			 ");
						DeleteSql3.append( " WHERE FDCODE = ? AND BGTRQNO = ?    ");
			
						GauceStatement gsmt4 = conn.getGauceStatement(DeleteSql3.toString());
						gsmt4.setGauceDataRow(rows[j]);
						gsmt4.bindColumn(1, idx[0]);
						gsmt4.bindColumn(2, idx[1]);
						gsmt4.executeUpdate(); 
						gsmt4.close();

						/*******************************************************************
								예산 Detail(3) Delete
						********************************************************************/
						DeleteSql4 = new StringBuffer();
						DeleteSql4.append( " DELETE FROM ACCOUNT.BGTRQDTL3			 ");
						DeleteSql4.append( " WHERE FDCODE = ? AND BGTRQNO = ?    ");
			
						GauceStatement gsmt5 = conn.getGauceStatement(DeleteSql4.toString());
						gsmt5.setGauceDataRow(rows[j]);
						gsmt5.bindColumn(1, idx[0]);
						gsmt5.bindColumn(2, idx[1]);
						gsmt5.executeUpdate(); 
						gsmt5.close();
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