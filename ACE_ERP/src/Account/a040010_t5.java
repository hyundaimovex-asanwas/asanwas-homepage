package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040010_t5 extends HttpServlet{
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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				String strBfyyyymm="";
				String[] StrArrCN = new String[] {"FDCODE","BFYYYYMM","AFYYYYMM","WRDT","WRID"};

				int[] idx = new int[5];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();
      
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						strBfyyyymm = rows[j].getString(idx[2]);
						
						/*******************************************************************
								수정분개 - 분개 MST 상태변경(결재취소)
						********************************************************************/
						StringBuffer InsertSql = null;
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.MFSLIPMST	 \n");
						InsertSql.append( " SELECT FDCODE,  'A'||'"+strBfyyyymm+"'||SUBSTR(FSDAT,8,2) FSDAT,   FSNBR,   FSKND,   FSWRTDAT,   \n");
						InsertSql.append( "        COCODE,  DEPTCD,  EMPNO,   DIVCD,   FSAMT,                                       \n");
						InsertSql.append( "        FSVAT,   DETOT,   CRTOT,   REMARK,  SGNDAT,                                      \n");
						InsertSql.append( "        'N',  '"+strBfyyyymm+"'||SUBSTR(ACTDAT,7,2) ACTDAT,   \n");
						InsertSql.append( "        '"+rows[j].getString(idx[3])+"' WRDT,   '"+rows[j].getString(idx[4])+"' WRID ,  '"+rows[j].getString(idx[3])+"' UPDT,   '"+rows[j].getString(idx[4])+"' UPID   \n");
						InsertSql.append( "  FROM ACCOUNT.MFSLIPMST                                                                 \n");
						InsertSql.append( "  WHERE FDCODE ='"+rows[j].getString(idx[0])+"'  \n");
						InsertSql.append( "    AND ACTDAT LIKE '"+rows[j].getString(idx[1])+"%'  \n");

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.executeUpdate(); 
						gsmt.close();

						StringBuffer InsertSql2 = null;
						InsertSql2 = new StringBuffer();
						InsertSql2.append( " INSERT INTO ACCOUNT.MFSLIPDTL	 \n");
						InsertSql2.append( " SELECT A.FDCODE, 'A'||'"+strBfyyyymm+"'||SUBSTR(A.FSDAT,8,2) FSDAT,    A.FSNBR,   A.FSSEQ,    A.ATCODE, 	 \n");
						InsertSql2.append( "        A.ATDECR,  A.FSAMT,    A.ACNNBR,  A.BANJAEYN, A.PRIMCOST,                               	 \n");
						InsertSql2.append( "        A.DOCUMCD, A.DOCUVAL,  A.FSWRKDIV,A.REMARK,                                   	 \n");
						InsertSql2.append( "        '"+rows[j].getString(idx[3])+"' WRDT,  '"+rows[j].getString(idx[4])+"' WRID,  '"+rows[j].getString(idx[3])+"'  UPDT,     '"+rows[j].getString(idx[4])+"' UPID  , A.FSNUM  	 \n");
						InsertSql2.append( "   FROM ACCOUNT.MFSLIPDTL A , ACCOUNT.MFSLIPMST B                                               	 \n");
						InsertSql2.append( " WHERE A.FDCODE = B.FDCODE                                                                      	 \n");
						InsertSql2.append( "   AND A.FSDAT = B.FSDAT                                                                        	 \n");
						InsertSql2.append( "   AND A.FSNBR = B.FSNBR                                                                        	 \n");
						InsertSql2.append( "   AND A.FDCODE='"+rows[j].getString(idx[0])+"'                       	 \n");
						InsertSql2.append( "   AND B.ACTDAT LIKE '"+rows[j].getString(idx[1])+"%'                   	 \n");

						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.executeUpdate(); 
						gsmt2.close();
							
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						
					}
				}
			}	catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}	catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}	finally {
			if (conn != null) try {conn.close(true);} catch (Exception e) {}
			loader.restoreService(service);
	 	}
	}
}