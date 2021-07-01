package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a050013_t1 extends HttpServlet{
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
       
				GauceStatement gsmt = null;
				GauceStatement gsmt2 = null;
				GauceStatement gsmt3 = null;


				String str1 = reqGauce.getParameter("v_str1");
				String str2 = reqGauce.getParameter("v_str2");
				String strGB = "";


				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");

				int idxFDCODE    = userSet.indexOfColumn("FDCODE");
				int idxDATADIV   = userSet.indexOfColumn("DATADIV");
				int idxACCYM     = userSet.indexOfColumn("ACCYM");
				int idxRPTGB     = userSet.indexOfColumn("RPTGB");
				int idxVENDID    = userSet.indexOfColumn("VENDID");
				int idxVENDNM    = userSet.indexOfColumn("VENDNM");
				int idxVDDIRECT  = userSet.indexOfColumn("VDDIRECT");
				int idxVDADDR    = userSet.indexOfColumn("VDADDR");
				int idxBSNSCND   = userSet.indexOfColumn("BSNSCND");
				int idxBSNSKND   = userSet.indexOfColumn("BSNSKND");
				int idxPERIOD    = userSet.indexOfColumn("PERIOD");
				int idxWRDT      = userSet.indexOfColumn("WRDT");
				int idxFILLER    = userSet.indexOfColumn("FILLER");

				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");

				int idx2FDCODE       = userSet2.indexOfColumn("FDCODE");
				int idx2DATADIV      = userSet2.indexOfColumn("DATADIV");
				int idx2ACCYM        = userSet2.indexOfColumn("ACCYM");
				int idx2RPTGB        = userSet2.indexOfColumn("RPTGB");
				int idx2VENDID       = userSet2.indexOfColumn("VENDID");
				int idx2CNT_SUM      = userSet2.indexOfColumn("CNT_SUM");
				int idx2FOAMT_SUM    = userSet2.indexOfColumn("FOAMT_SUM");
				int idx2KOAMT_SUM    = userSet2.indexOfColumn("KOAMT_SUM");
				int idx2EXCNT        = userSet2.indexOfColumn("EXCNT");
				int idx2EXFOAMT      = userSet2.indexOfColumn("EXFOAMT");
				int idx2EXKOAMT      = userSet2.indexOfColumn("EXKOAMT");
				int idx2ETCNT        = userSet2.indexOfColumn("ETCNT");
				int idx2ETFOAMT      = userSet2.indexOfColumn("ETFOAMT");
				int idx2ETKOAMT      = userSet2.indexOfColumn("ETKOAMT");
				int idx2FILLER       = userSet2.indexOfColumn("FILLER");

				GauceDataSet userSet3 = reqGauce.getGauceDataSet("USER3");

				int idx3FDCODE     = userSet3.indexOfColumn("FDCODE");
				int idx3DATADIV    = userSet3.indexOfColumn("DATADIV");
				int idx3ACCYM      = userSet3.indexOfColumn("ACCYM");
				int idx3RPTGB      = userSet3.indexOfColumn("RPTGB");
				int idx3VENDID     = userSet3.indexOfColumn("VENDID");
				int idx3SEQNO      = userSet3.indexOfColumn("SEQNO");
				int idx3EXPTNO     = userSet3.indexOfColumn("EXPTNO");
				int idx3SHIPDT     = userSet3.indexOfColumn("SHIPDT");
				int idx3CURRCD     = userSet3.indexOfColumn("CURRCD");
				int idx3EXCHANGE   = userSet3.indexOfColumn("EXCHANGE");
				int idx3FOAMT      = userSet3.indexOfColumn("FOAMT");
				int idx3KOAMT      = userSet3.indexOfColumn("KOAMT");
				int idx3FILLER     = userSet3.indexOfColumn("FILLER");

				GauceDataRow[] rows  = userSet.getDataRows();
				GauceDataRow[] rows2 = userSet2.getDataRows();
				GauceDataRow[] rows3 = userSet3.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer InsertSql2 = null;
				StringBuffer InsertSql3 = null;

				StringBuffer DeleteSql  = null;
				StringBuffer DeleteSql2 = null;
				StringBuffer DeleteSql3 = null;

				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.AVATRPT91 (                 \n " );
				InsertSql.append( "        FDCODE,DATADIV,ACCYM,RPTGB,VENDID,       \n " );
				InsertSql.append( "        VENDNM,VDDIRECT,VDADDR,BSNSCND,BSNSKND,  \n " );
				InsertSql.append( "        PERIOD,WRDT,FILLER  )                     \n " );
				InsertSql.append( " VALUES ( \n " );
				InsertSql.append( "         ?,?,?,?,?,?,?,?,?,?,?,?,? \n " );
				InsertSql.append( "        ) \n " );

				InsertSql2 = new StringBuffer();
				InsertSql2.append( " INSERT INTO ACCOUNT.AVATRPT92 (                        \n " );
				InsertSql2.append( "        FDCODE,	 DATADIV,	  ACCYM,	   RPTGB,	VENDID,	  \n " );
				InsertSql2.append( "        CNT_SUM, FOAMT_SUM,	KOAMT_SUM, EXCNT,	EXFOAMT,  \n " );
				InsertSql2.append( "        EXKOAMT, ETCNT,	    ETFOAMT,   ETKOAMT, FILLER )\n " );
				InsertSql2.append( " VALUES ( \n " );
				InsertSql2.append( "         ?,?,?,?,?,?,?,?,?,?,?,?,?,?,? \n " );
				InsertSql2.append( "        ) \n " );
 
				InsertSql3 = new StringBuffer();
				InsertSql3.append( " INSERT INTO ACCOUNT.AVATRPT93 (                       \n " );
				InsertSql3.append( "        FDCODE,	DATADIV, ACCYM,	 RPTGB,	 VENDID,	     \n " );
				InsertSql3.append( "        SEQNO,	EXPTNO,	 SHIPDT, CURRCD, EXCHANGE,     \n " );
				InsertSql3.append( "        FOAMT,	KOAMT,	 FILLER )                      \n " );
				InsertSql3.append( " VALUES ( \n " );
				InsertSql3.append( "         ?,?,?,?,?,?,?,?,?,?,?,?,? \n " );
				InsertSql3.append( "        ) \n " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( " DELETE FROM ACCOUNT.AVATRPT91 WHERE FDCODE = ? AND DATADIV=? AND ACCYM=?  \n " );

				DeleteSql2 = new StringBuffer();
				DeleteSql2.append( " DELETE FROM ACCOUNT.AVATRPT92 WHERE FDCODE = ? AND DATADIV=? AND ACCYM=?  \n " );

				DeleteSql3 = new StringBuffer();
				DeleteSql3.append( " DELETE FROM ACCOUNT.AVATRPT93 WHERE FDCODE = ? AND DATADIV=? AND ACCYM=?  AND RPTGB=?  AND VENDID =? \n " );

				for (int j = 0; j < rows.length; j++){
					//////////////////////////////////////////////////////////////////////////
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						//삭제
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxFDCODE);   
						gsmt.bindColumn(2,  idxDATADIV);  
						gsmt.bindColumn(3,  idxACCYM);  
		
						gsmt.executeUpdate();
						gsmt.close();

						gsmt=null;

					
						//신규 생성 - A
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxFDCODE);   
						gsmt.bindColumn(2,  idxDATADIV);  
						gsmt.bindColumn(3,  idxACCYM);  
						gsmt.bindColumn(4,  idxRPTGB);  
						gsmt.bindColumn(5,  idxVENDID);  
						gsmt.bindColumn(6,  idxVENDNM);  
						gsmt.bindColumn(7,  idxVDDIRECT);  
						gsmt.bindColumn(8,  idxVDADDR);  
						gsmt.bindColumn(9,  idxBSNSCND);  
						gsmt.bindColumn(10, idxBSNSKND);  
						gsmt.bindColumn(11, idxPERIOD);  
						gsmt.bindColumn(12, idxWRDT);  
						gsmt.bindColumn(13, idxFILLER);  
		
						gsmt.executeUpdate();
						gsmt.close();

						gsmt=null;
					}
				} //for


				for (int j2 = 0; j2 < rows2.length; j2++){
					//////////////////////////////////////////////////////////////////////////
					if(rows2[j2].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						//삭제
						gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows2[j2]);
						gsmt2.bindColumn(1,  idx2FDCODE);   
						gsmt2.bindColumn(2,  idx2DATADIV);  
						gsmt2.bindColumn(3,  idx2ACCYM);  
		
						gsmt2.executeUpdate();
						gsmt2.close();

						gsmt2=null;

					
						//신규 생성 - A
						gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows2[j2]);
						gsmt2.bindColumn(1,  idx2FDCODE);  
						gsmt2.bindColumn(2,  idx2DATADIV);  
						gsmt2.bindColumn(3,  idx2ACCYM);  
						gsmt2.bindColumn(4,  idx2RPTGB);  
						gsmt2.bindColumn(5,  idx2VENDID);  
						gsmt2.bindColumn(6,  idx2CNT_SUM);  
						gsmt2.bindColumn(7,  idx2FOAMT_SUM);  
						gsmt2.bindColumn(8,  idx2KOAMT_SUM);  
						gsmt2.bindColumn(9,  idx2EXCNT);  
						gsmt2.bindColumn(10, idx2EXFOAMT);  
						gsmt2.bindColumn(11, idx2EXKOAMT);  
						gsmt2.bindColumn(12, idx2ETCNT);  
						gsmt2.bindColumn(13, idx2ETFOAMT);  
						gsmt2.bindColumn(14, idx2ETKOAMT);  
						gsmt2.bindColumn(15, idx2FILLER);  
								
						gsmt2.executeUpdate();
						gsmt2.close();

						gsmt2=null;
					}
				} //for


				for (int j3 = 0; j3 < rows3.length; j3++){
					//////////////////////////////////////////////////////////////////////////
					if(rows3[j3].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						if(j3==0){
							gsmt3 = conn.getGauceStatement(DeleteSql3.toString());
							gsmt3.setGauceDataRow(rows3[j3]);
							gsmt3.bindColumn(1,  idx3FDCODE);   
							gsmt3.bindColumn(2,  idx3DATADIV);  
							gsmt3.bindColumn(3,  idx3ACCYM);  
							gsmt3.bindColumn(4,  idx3RPTGB);  
							gsmt3.bindColumn(5,  idx3VENDID); 

							gsmt3.executeUpdate();
							gsmt3.close();
							gsmt3=null;
						}

							
						//신규 생성 - A
						gsmt3 = conn.getGauceStatement(InsertSql3.toString());
						gsmt3.setGauceDataRow(rows3[j3]);
						gsmt3.bindColumn(1,  idx3FDCODE);  
						gsmt3.bindColumn(2,  idx3DATADIV);  
						gsmt3.bindColumn(3,  idx3ACCYM);  
						gsmt3.bindColumn(4,  idx3RPTGB);  
						gsmt3.bindColumn(5,  idx3VENDID);  
						gsmt3.bindColumn(6,  idx3SEQNO);  
						gsmt3.bindColumn(7,  idx3EXPTNO);  
						gsmt3.bindColumn(8,  idx3SHIPDT);  
						gsmt3.bindColumn(9,  idx3CURRCD);  
						gsmt3.bindColumn(10, idx3EXCHANGE);  
						gsmt3.bindColumn(11, idx3FOAMT);  
						gsmt3.bindColumn(12, idx3KOAMT);  
						gsmt3.bindColumn(13, idx3FILLER);  
							
						gsmt3.executeUpdate();
						gsmt3.close();
						gsmt3=null;

					}
				} //for


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
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
		}
	}
}