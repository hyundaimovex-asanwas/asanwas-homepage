package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

//JNDI 관련 
import com.hmm.ejb.common.UtilDB;

public class a040093_t1 extends HttpServlet{
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
		Connection vndus_conn = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;

			try {
				conn = service.getDBConnection();		
				//ehr_conn = UtilDB.getConnection("jdbc/asanhr");

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				String str1 = reqGauce.getParameter("v_str1");
				
				
				int idxBS_ID	        = userSet.indexOfColumn("BS_ID");
				int idxBS_TAXKND        = userSet.indexOfColumn("BS_TAXKND");
				int idxBS_DAT	        = userSet.indexOfColumn("BS_DAT");
				int idxBS_AMT	        = userSet.indexOfColumn("BS_AMT");
				int idxBS_TAXAMT        = userSet.indexOfColumn("BS_TAXAMT");
				int idxBS_TOTAMT        = userSet.indexOfColumn("BS_TOTAMT");
				int idxBS_REMARK        = userSet.indexOfColumn("BS_REMARK");
				int idxBS_VENDID        = userSet.indexOfColumn("BS_VENDID");
				int idxBS_VENDNM        = userSet.indexOfColumn("BS_VENDNM");
				int idxBS_DIRCNM        = userSet.indexOfColumn("BS_DIRCNM");
				int idxBS_CND	        = userSet.indexOfColumn("BS_CND");
				int idxBS_KND	       = userSet.indexOfColumn("BS_KND");
				int idxBS_COMYN	       = userSet.indexOfColumn("BS_COMYN");
				int idxBS_PNO1	       = userSet.indexOfColumn("BS_PNO1");
				int idxBS_PNO2         = userSet.indexOfColumn("BS_PNO2");
				int idxBS_ADDR1	       = userSet.indexOfColumn("BS_ADDR1");
				int idxBS_ADDR2	       = userSet.indexOfColumn("BS_ADDR2");
				int idxBS_USE	       = userSet.indexOfColumn("BS_USE");
				int idxBS_STS	       = userSet.indexOfColumn("BS_STS");
				int idxBS_EMPNM	       = userSet.indexOfColumn("BS_EMPNM");
				int idxBS_EMAIL	       = userSet.indexOfColumn("BS_EMAIL");
				int idxBS_HPNO         = userSet.indexOfColumn("BS_HPNO");
				int idxBS_TELNO	       = userSet.indexOfColumn("BS_TELNO");
				int idxBS_INGB         = userSet.indexOfColumn("BS_INGB");
				int idxBS_SEQNO	       = userSet.indexOfColumn("BS_SEQNO");
				int idxBS_DNO	       = userSet.indexOfColumn("BS_DNO");
				int idxBS_HNO	       = userSet.indexOfColumn("BS_HNO");
				int idxBS_TAXNO	       = userSet.indexOfColumn("BS_TAXNO");
				int idxBS_VENDCD       = userSet.indexOfColumn("BS_VENDCD");
				int idxBS_PDTNM	       = userSet.indexOfColumn("BS_PDTNM");
				int idxI_EMPNO	       = userSet.indexOfColumn("I_EMPNO");
				int idxI_DATE	       = userSet.indexOfColumn("I_DATE");
				int idxU_EMPNO	       = userSet.indexOfColumn("U_EMPNO");
				int idxU_DATE          = userSet.indexOfColumn("U_DATE");
												
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer UpdateSql2 = null;
				
				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
							
					
							InsertSql = new StringBuffer();
							InsertSql.append( "INSERT INTO VNDUS.TBS010 ( " );
							InsertSql.append( " BS_ID,	            BS_TAXKND,	BS_DAT,	    BS_AMT,	        BS_TAXAMT, \n " );
							InsertSql.append( " BS_TOTAMT,	BS_REMARK,	BS_VENDID,	BS_VENDNM,	BS_DIRCNM, \n " );
							InsertSql.append( " BS_CND,       	BS_KND,	        BS_COMYN,	BS_PNO1,	    BS_PNO2,   \n " );
							InsertSql.append( " BS_ADDR1,	    BS_ADDR2,	    BS_USE,	    BS_STS,	        BS_EMPNM,	 \n " );
							InsertSql.append( " BS_EMAIL,	    BS_HPNO,  	    BS_TELNO,	BS_INGB,  	    BS_SEQNO,	 \n " );
							InsertSql.append( " BS_DNO,	        BS_HNO,	        BS_TAXNO,	BS_VENDCD,	BS_PDTNM,	 \n " );
							InsertSql.append( " I_EMPNO,	        I_DATE	                        \n " );

							InsertSql.append( ") VALUES( " );
							InsertSql.append( "  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "  );
						    InsertSql.append( "  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, "  );
							InsertSql.append( "  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,  '"+str1+"', sysdate  ) " );

							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							//logger.dbg.println(this, InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							gsmt.bindColumn(1,idxBS_ID);
							gsmt.bindColumn(2,idxBS_TAXKND);
							gsmt.bindColumn(3,idxBS_DAT);
							gsmt.bindColumn(4,idxBS_AMT);
							gsmt.bindColumn(5,idxBS_TAXAMT);
							gsmt.bindColumn(6,idxBS_TOTAMT);
							gsmt.bindColumn(7,idxBS_REMARK);
							gsmt.bindColumn(8,idxBS_VENDID);
							gsmt.bindColumn(9,idxBS_VENDNM);
							gsmt.bindColumn(10,idxBS_DIRCNM);
							gsmt.bindColumn(11,idxBS_CND);
							gsmt.bindColumn(12,idxBS_KND);
							gsmt.bindColumn(13,idxBS_COMYN);
							gsmt.bindColumn(14,idxBS_PNO1);
							gsmt.bindColumn(15,idxBS_PNO2);
							gsmt.bindColumn(16,idxBS_ADDR1);
							gsmt.bindColumn(17,idxBS_ADDR2);
							gsmt.bindColumn(18,idxBS_USE);
							gsmt.bindColumn(19,idxBS_STS);
							gsmt.bindColumn(20,idxBS_EMPNM);
							gsmt.bindColumn(21,idxBS_EMAIL);
							gsmt.bindColumn(22,idxBS_HPNO);
							gsmt.bindColumn(23,idxBS_TELNO);
							gsmt.bindColumn(24,idxBS_INGB);
							gsmt.bindColumn(25,idxBS_SEQNO);
							gsmt.bindColumn(26,idxBS_DNO);
							gsmt.bindColumn(27,idxBS_HNO);
							gsmt.bindColumn(28,idxBS_TAXNO);
							gsmt.bindColumn(29,idxBS_VENDCD);
							gsmt.bindColumn(30,idxBS_PDTNM);

							gsmt.executeUpdate();
							gsmt.close();
							
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						
					}
					
					//jndi 접속하여 e-HR에 UPDATE 처리함.													
					//vndus_conn = UtilDB.getConnection("jdbc/hdvndus");
					vndus_conn = UtilDB.getConnection("hdvndus"); 
					
					UpdateSql2 = new StringBuffer();
					UpdateSql2.append( "UPDATE hdas.TBS010 SET  BS_STS	= 'Y'  " );  
					UpdateSql2.append( " WHERE BS_ID = "+ rows[j].getDouble(idxBS_ID) );
					PreparedStatement vndus_pstmt = vndus_conn.prepareStatement(UpdateSql2.toString());
					
					//logger.dbg.println(this,":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"+UpdateSql2.toString());
					
					vndus_pstmt.executeUpdate();
					vndus_pstmt.close();
					vndus_conn.close();
					
				}//for
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