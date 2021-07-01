package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a050001_t1 extends HttpServlet{
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

				GauceStatement gsmt= null;
				GauceStatement gsmt2= null;
				GauceStatement gsmt3= null;


				//전자세금계산서 이외 발행분 합계 //////////////////////////////////////////////////////////////////////////////
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");
				String[] StrArrCN2 = new String[] {
					"FDCODE",  "ACCYY",   "ACCYYQT",  "DATADIV",  "VENDID",
					"VENDCNT", "SHTCNT",  "REQAMT",   "VATAMT",
		          "VENDCNT1","SHTCNT1", "REQAMT1",  "VATAMT1",					
		          "VENDCNT2","SHTCNT2", "REQAMT2",  "VATAMT2",					
					"FILLER"
				};			

				int[] idx2 = new int[18];
				for(int i=0;i<StrArrCN2.length;i++) {
					idx2[i] = userSet2.indexOfColumn(StrArrCN2[i]);
				}

				GauceDataRow[] rows2 = userSet2.getDataRows();
       
				StringBuffer InsertSql2  = null;
				StringBuffer DeleteSql2  = null;
				StringBuffer DeleteSql  = null;
	
				for (int k = 0; k < rows2.length; k++){
					if(rows2[k].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
						/**************************************************************************
								신고서 매입자료 상세 ( 전자세금계산서 이외 수취분 )
						 **************************************************************************/ 
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM ACCOUNT.AVATRPT2 								");
						DeleteSql.append( " WHERE FDCODE=? AND ACCYY=? AND ACCYYQT=?		");
						
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows2[k]);
						gsmt.bindColumn(1, idx2[0]);
						gsmt.bindColumn(2, idx2[1]);
						gsmt.bindColumn(3, idx2[2]);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;

						/**************************************************************************
							신고서 매입합계 ( 전자세금계산서 이외 수취 )
						**************************************************************************/
						DeleteSql2 = new StringBuffer();
						DeleteSql2.append( " DELETE FROM ACCOUNT.AVATRPT4 						");
						DeleteSql2.append( " WHERE FDCODE=? AND ACCYY=? AND ACCYYQT=? ");
						
						gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows2[k]);
						gsmt2.bindColumn(1, idx2[0]);
						gsmt2.bindColumn(2, idx2[1]);
						gsmt2.bindColumn(3, idx2[2]);
						gsmt2.executeUpdate();
						gsmt2.close();
						gsmt2=null;

						InsertSql2 = new StringBuffer();
						InsertSql2.append( " INSERT INTO ACCOUNT.AVATRPT4 (				\n");
						InsertSql2.append( " FDCODE,ACCYY,ACCYYQT,DATADIV,VENDID,	\n");
						InsertSql2.append( " VENDCNT,SHTCNT,REQAMT,VATAMT,				\n");
						InsertSql2.append( " VENDCNT1,SHTCNT1,REQAMT1,VATAMT1,		\n");
						InsertSql2.append( " VENDCNT2,SHTCNT2,REQAMT2,VATAMT2,		\n");
						InsertSql2.append( " FILLER																\n");
						InsertSql2.append( " ) VALUES(														\n");						
						InsertSql2.append( " ?,?,?,?,?, \n");
						InsertSql2.append( " ?,?,?,?,   \n");
						InsertSql2.append( " ?,?,?,?,   \n");
						InsertSql2.append( " ?,?,?,?,   \n");
						InsertSql2.append( " ?          \n");
						InsertSql2.append( " )					\n");

						gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows2[k]);
            
						gsmt2.bindColumn(1, idx2[0] );   
						gsmt2.bindColumn(2, idx2[1] );   
						gsmt2.bindColumn(3, idx2[2] );   
						gsmt2.bindColumn(4, idx2[3] );   
						gsmt2.bindColumn(5, idx2[4] );   
						gsmt2.bindColumn(6, idx2[5] );   
						gsmt2.bindColumn(7, idx2[6] );   
						gsmt2.bindColumn(8, idx2[7] );   
						gsmt2.bindColumn(9, idx2[8] );   
						gsmt2.bindColumn(10, idx2[9] );   
						gsmt2.bindColumn(11, idx2[10] );   
						gsmt2.bindColumn(12, idx2[11] );   
						gsmt2.bindColumn(13, idx2[12] );   
						gsmt2.bindColumn(14, idx2[13] );   
						gsmt2.bindColumn(15, idx2[14] );   
						gsmt2.bindColumn(16, idx2[15] );   
						gsmt2.bindColumn(17, idx2[16] );   
						gsmt2.bindColumn(18, idx2[17] );   
						
						gsmt2.executeUpdate();
						gsmt2.close();
						gsmt2=null;
					}
   			}

				////////////////////////////////////////////////////////////////////////////////////////////////////////

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"FDCODE", "ACCYY",  "ACCYYQT", "SEQNO",   "DATADIV",
					"VENDID", "VENDSEQ","VENDIDVS","VENDNAME","BSNSCND",
					"BSNSKND","SHTCNT", "BLKCNT",  "REQAMT",  "VATAMT",	
					"WINEGM", "WINESM", "BOOKNUM", "TAXATION","FILLER",
					"REQAMT4","VATAMT4"
				};

				int[] idx = new int[22];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;

				Statement stmt = null;
				ResultSet rs = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						/**************************************************************************
							신고서 매입자료 (SEQNO 생성)
						**************************************************************************/
						String seqno = "0000";
						int schk = 0;
						StringBuffer sql = new StringBuffer();
						sql.append(" SELECT nvl(CAST(MAX(SEQNO) AS INTEGER)+1,0) SEQNO	");
						sql.append(" FROM ACCOUNT.AVATRPT2												 ");
						sql.append(" WHERE FDCODE ='"+rows[j].getString(idx[0])+"' ");
						sql.append("	 AND ACCYY  ='"+rows[j].getString(idx[1])+"' ");
						sql.append("   AND ACCYYQT='"+rows[j].getString(idx[2])+"' ");

						stmt = conn.createStatement();
						rs   = stmt.executeQuery(sql.toString());

						while(rs.next()) {
							seqno = rs.getInt(1) + "";
						}

						if (seqno.equals("0"))	schk = 1;
						else schk = Integer.parseInt(seqno);

						if (schk<10)		   { seqno = "000"+schk+""; 
						}else if (schk<100)   { seqno = "00"+schk+""; 
						}else if (schk<1000)  { seqno = "0"+schk+""; 
						}else if (schk<10000) { seqno = ""+schk+"";			}

						/**************************************************************************
							신고서 매입자료
						**************************************************************************/
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.AVATRPT2 (						\n");
						InsertSql.append( " FDCODE,ACCYY,ACCYYQT,SEQNO,DATADIV,				\n");
						InsertSql.append( " VENDID,VENDSEQ,VENDIDVS,VENDNAME,BSNSCND,	\n");
						InsertSql.append( " BSNSKND,SHTCNT,BLKCNT,REQAMT,VATAMT,			\n");
						InsertSql.append( " WINEGM,WINESM,BOOKNUM,TAXATION,FILLER			\n");
						InsertSql.append( " ) VALUES(																	\n");
						InsertSql.append( " '"+rows[j].getString(idx[0])+"',	\n");
						InsertSql.append( " '"+rows[j].getString(idx[1])+"',	\n");
						InsertSql.append( " '"+rows[j].getString(idx[2])+"',	\n");
						InsertSql.append( " '"+seqno+"', \n");
						InsertSql.append( " '"+rows[j].getString(idx[4])+"',	\n");
						InsertSql.append( " '"+rows[j].getString(idx[5])+"',	\n");
						InsertSql.append( " '"+seqno+"', \n");
						InsertSql.append( " '"+rows[j].getString(idx[7])+"',	\n");
						InsertSql.append( " '"+rows[j].getString(idx[8])+"',	\n");
						InsertSql.append( " '"+rows[j].getString(idx[9])+"',	\n");
						InsertSql.append( " '"+rows[j].getString(idx[10])+"',	\n");
						InsertSql.append( "  "+rows[j].getString(idx[11])+",	\n");
						InsertSql.append( "  "+rows[j].getString(idx[12])+",	\n");
						InsertSql.append( "  "+rows[j].getString(idx[13])+",	\n");
						InsertSql.append( "  "+rows[j].getString(idx[14])+",	\n");
						InsertSql.append( " '"+rows[j].getString(idx[15])+"',	\n");
						InsertSql.append( " '"+rows[j].getString(idx[16])+"',	\n");
						InsertSql.append( " '"+rows[j].getString(idx[17])+"',	\n");
						InsertSql.append( " '"+rows[j].getString(idx[18])+"', \n");
						InsertSql.append( " '"+rows[j].getString(idx[19])+"'	\n");
						InsertSql.append( " )																	\n");

						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;
				}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
					}
				}

				 //전자세금계산서 매입 수취분 합계 
				GauceDataSet userSet3 = reqGauce.getGauceDataSet("USER3");

        		String[] StrArrCN3 = new String[] {
					"FDCODE",  "ACCYY",   "ACCYYQT",  "DATADIV",  "VENDID",
					"VENDCNT", "SHTCNT",  "REQAMT",   "VATAMT",
			        "VENDCNT1","SHTCNT1", "REQAMT1",  "VATAMT1",					
			        "VENDCNT2","SHTCNT2", "REQAMT2",  "VATAMT2",					
					"FILLER"
				};			

				int[] idx3 = new int[18];
				for(int i=0;i<StrArrCN3.length;i++) {
					idx3[i] = userSet2.indexOfColumn(StrArrCN3[i]);
				}

				GauceDataRow[] rows3 = userSet3.getDataRows();
       
				StringBuffer InsertSql3  = null;
				StringBuffer DeleteSql3  = null;
	
				for (int a = 0; a < rows3.length; a++){
					if(rows3[a].getJobType() == GauceDataRow.TB_JOB_INSERT) {
            /**************************************************************************
							신고서 매출합계 ( 전자세금계산서 이외 발행 )
						**************************************************************************/
						DeleteSql3 = new StringBuffer();
						DeleteSql3.append( " DELETE FROM ACCOUNT.AVATRPT6 						");
						DeleteSql3.append( " WHERE FDCODE=? AND ACCYY=? AND ACCYYQT=? ");
						
						gsmt3 = conn.getGauceStatement(DeleteSql3.toString());
						gsmt3.setGauceDataRow(rows3[a]);
						gsmt3.bindColumn(1, idx3[0]);
						gsmt3.bindColumn(2, idx3[1]);
						gsmt3.bindColumn(3, idx3[2]);
						gsmt3.executeUpdate();
						gsmt3.close();
						gsmt3=null;


						InsertSql3 = new StringBuffer();
						InsertSql3.append( " INSERT INTO ACCOUNT.AVATRPT6 (				\n");
						InsertSql3.append( " FDCODE,ACCYY,ACCYYQT,DATADIV,VENDID,	\n");
						InsertSql3.append( " VENDCNT,SHTCNT,REQAMT,VATAMT,				\n");
						InsertSql3.append( " VENDCNT1,SHTCNT1,REQAMT1,VATAMT1,		\n");
						InsertSql3.append( " VENDCNT2,SHTCNT2,REQAMT2,VATAMT2,		\n");
						InsertSql3.append( " FILLER																\n");
						InsertSql3.append( " ) VALUES(														\n");
						InsertSql3.append( " ?,?,?,?,?, \n");
						InsertSql3.append( " ?,?,?,?,   \n");
						InsertSql3.append( " ?,?,?,?,   \n");
						InsertSql3.append( " ?,?,?,?,   \n");
						InsertSql3.append( " ?          \n");
						InsertSql3.append( " )					\n");

						gsmt3 = conn.getGauceStatement(InsertSql3.toString());
						gsmt3.setGauceDataRow(rows3[a]);
 
						gsmt3.bindColumn(1, idx3[0] );   
						gsmt3.bindColumn(2, idx3[1] );   
						gsmt3.bindColumn(3, idx3[2] );   
						gsmt3.bindColumn(4, idx3[3] );   
						gsmt3.bindColumn(5, idx3[4] );   
						gsmt3.bindColumn(6, idx3[5] );   
						gsmt3.bindColumn(7, idx3[6] );   
						gsmt3.bindColumn(8, idx3[7] );   
						gsmt3.bindColumn(9, idx3[8] );   
						gsmt3.bindColumn(10, idx3[9] );   
						gsmt3.bindColumn(11, idx3[10] );   
						gsmt3.bindColumn(12, idx3[11] );   
						gsmt3.bindColumn(13, idx3[12] );   
						gsmt3.bindColumn(14, idx3[13] );   
						gsmt3.bindColumn(15, idx3[14] );   
						gsmt3.bindColumn(16, idx3[15] );   
						gsmt3.bindColumn(17, idx3[16] );   
						gsmt3.bindColumn(18, idx3[17] );   
						gsmt3.executeUpdate();
						gsmt3.close();
						gsmt3=null;
					}
   			}

			}
			catch(Exception e){
				conn.rollback();
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