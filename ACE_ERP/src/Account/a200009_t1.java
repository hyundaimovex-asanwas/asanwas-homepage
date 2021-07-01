package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a200009_t1 extends HttpServlet{
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
					"FDCODE", "ATCODE", "FUNDDIV","REFCODE2","STRDATE",
					"ENDDATE","DRAMT",  "CRAMT",  "VEND_CD", "BANCOD",
					"INRATE", "OUTRATE","DRFAMT", "CRFAMT",  "CURDIV",
					"EXRATE", "STATDIV","REMARK", "FSDAT",   "FSNBR",
					"FSSEQ",  "ACTDAT", "FSDAT1", "FSNBR1",  "FSSEQ1",
					"ACTDAT1", "FSREFCD","FSREFVAL", "UPDT", "UPID"
				};

				int[] idx = new int[30];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer InsertSql2  = null;
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;

				Statement stmt = null;
				ResultSet rs = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.AFUNDLDG (					");
				InsertSql.append( " FDCODE,ATCODE,FUNDDIV,REFCODE2,STRDATE,	");
				InsertSql.append( " ENDDATE,DRAMT,CRAMT,VEND_CD,BANCOD,			");
				InsertSql.append( " INRATE,OUTRATE,DRFAMT,CRFAMT,CURDIV,		");
				InsertSql.append( " EXRATE,STATDIV,REMARK,FSDAT,FSNBR,			");
				InsertSql.append( " FSSEQ,ACTDAT,FSDAT1,FSNBR1,FSSEQ1,			");
				InsertSql.append( " ACTDAT1,FSREFCD,FSREFVAL								");
				InsertSql.append( " ) VALUES(																");
				InsertSql.append( " ?, ?, ?, ?, ?,						            	");
				InsertSql.append( " ?, ?, ?, ?, ?,													");
				InsertSql.append( " ?, ?, ?, ?, ?,													");
				InsertSql.append( " ?, ?, ?, ?, ?,													");
				InsertSql.append( " ?, ?, ?, ?, ?,													");
				InsertSql.append( " ?, ?, ?																	");
				InsertSql.append( " )																				");

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE ACCOUNT.AFUNDLDG SET																");
				UpdateSql.append( " STRDATE = ?,	ENDDATE = ?,	DRAMT = ?,	CRAMT = ?,				");
				UpdateSql.append( " VEND_CD = ?,	BANCOD = ?,		INRATE = ?,	OUTRATE = ?,			");
				UpdateSql.append( " DRFAMT = ?,		CRFAMT = ?,		CURDIV = ?,	EXRATE = ?,				");
				UpdateSql.append( " STATDIV = ?,	REMARK = ?,		FSDAT = ?,	FSNBR = ?,				");
				UpdateSql.append( " FSSEQ = ?,		ACTDAT = ?,		FSDAT1 = ?,	FSNBR1 = ?,				");
				UpdateSql.append( " FSSEQ1 = ?,		ACTDAT1 = ?,	FSREFCD=?,  FSREFVAL=?,  			");
				UpdateSql.append( " UPDT = '"+str1+"',	UPID = '"+str2+"'											");
				UpdateSql.append( " WHERE FDCODE=? AND ATCODE=?	AND FUNDDIV=? AND REFCODE2=?	");

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.AFUNDLDG 		 ");
				DeleteSql.append( " WHERE FDCODE = ? AND ATCODE = ?  ");
				DeleteSql.append( " AND FUNDDIV = ? AND REFCODE2 = ? ");

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						/*******************************************************************
								자금관리[원장관리]
						********************************************************************/

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						for(int k=1;k<=28;k++) {
							gsmt.bindColumn(k, idx[k-1]);
						}
					
						gsmt.executeUpdate();
						gsmt.close();
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
			
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for(int s=1;s<=24;s++) {
							gsmt.bindColumn(s, idx[s+3]);
						}
						
						gsmt.bindColumn(25, idx[0]);
						gsmt.bindColumn(26, idx[1]);
						gsmt.bindColumn(27, idx[2]);
						gsmt.bindColumn(28, idx[3]);

						gsmt.executeUpdate(); 
						gsmt.close();
						
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						
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