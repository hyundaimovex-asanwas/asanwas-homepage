package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a050020_t11 extends HttpServlet{
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
				
				String strUserid = reqGauce.getParameter("v_str1");

				//HEAD
				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");
				
				int idxFDCODE       = userSet.indexOfColumn("FDCODE");
				int idxRD_GB        = userSet.indexOfColumn("RD_GB");
				int idxYYYY         = userSet.indexOfColumn("YYYY");
				int idxHF_GB        = userSet.indexOfColumn("HF_GB");
				int idxHF_SEQ       = userSet.indexOfColumn("HF_SEQ");
				int idxCO_CRNO      = userSet.indexOfColumn("CO_CRNO");
				int idxCO_NM        = userSet.indexOfColumn("CO_NM");
				int idxCO_RENM      = userSet.indexOfColumn("CO_RENM");
				int idxCO_NO        = userSet.indexOfColumn("CO_NO");
				int idxCO_DT        = userSet.indexOfColumn("CO_DT");
				int idxPH_NO        = userSet.indexOfColumn("PH_NO");
				int idxSPACE        = userSet.indexOfColumn("SPACE");
				int idxCREATE_ID    = userSet.indexOfColumn("CREATE_ID");
				int idxUPDATE_ID    = userSet.indexOfColumn("UPDATE_ID");

				//TAIL
				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");

				int idx2FDCODE              = userSet2.indexOfColumn("FDCODE");
				int idx2RD_GB               = userSet2.indexOfColumn("RD_GB");
				int idx2YYYY                = userSet2.indexOfColumn("YYYY");
				int idx2HF_GB               = userSet2.indexOfColumn("HF_GB");
				int idx2HF_SEQ              = userSet2.indexOfColumn("HF_SEQ");
				int idx2CO_CRNO             = userSet2.indexOfColumn("CO_CRNO");
				int idx2DATA_CNT            = userSet2.indexOfColumn("DATA_CNT");
				int idx2RD_SEQ_GB           = userSet2.indexOfColumn("RD_SEQ_GB");
				int idx2RE_POSITION         = userSet2.indexOfColumn("RE_POSITION");
				int idx2RE_DEP_SUM          = userSet2.indexOfColumn("RE_DEP_SUM");
				int idx2RE_MON_SUM          = userSet2.indexOfColumn("RE_MON_SUM");
				int idx2RE_SUM_SUM          = userSet2.indexOfColumn("RE_SUM_SUM");
				int idx2RE_DEP_INT_SUM      = userSet2.indexOfColumn("RE_DEP_INT_SUM");
				int idx2RE_INCOME_SUM       = userSet2.indexOfColumn("RE_INCOME_SUM");
				int idx2RE_CNT              = userSet2.indexOfColumn("RE_CNT");
				int idx2MINOR_NO            = userSet2.indexOfColumn("MINOR_NO");
				int idx2SPACE               = userSet2.indexOfColumn("SPACE");
				int idx2CREATE_ID           = userSet2.indexOfColumn("CREATE_ID");
				int idx2UPDATE_ID           = userSet2.indexOfColumn("UPDATE_ID");
				
				
				//DATA
				GauceDataSet userSet3 = reqGauce.getGauceDataSet("USER3");

				int idx3FDCODE            = userSet3.indexOfColumn("FDCODE");
				int idx3RD_GB             = userSet3.indexOfColumn("RD_GB");
				int idx3YYYY              = userSet3.indexOfColumn("YYYY");
				int idx3HF_GB             = userSet3.indexOfColumn("HF_GB");
				int idx3HF_SEQ            = userSet3.indexOfColumn("HF_SEQ");
				int idx3CO_CRNO           = userSet3.indexOfColumn("CO_CRNO");
				int idx3RD_SEQ_GB         = userSet3.indexOfColumn("RD_SEQ_GB");
				int idx3RD_SEQ            = userSet3.indexOfColumn("RD_SEQ");
				int idx3FLOOR             = userSet3.indexOfColumn("FLOOR");
				int idx3FR_NO             = userSet3.indexOfColumn("FR_NO");
				int idx3AREA              = userSet3.indexOfColumn("AREA");
				int idx3HI_NM             = userSet3.indexOfColumn("HI_NM");
				int idx3HI_CRNO           = userSet3.indexOfColumn("HI_CRNO");
				int idx3RE_IN_DT          = userSet3.indexOfColumn("RE_IN_DT");
				int idx3RE_OUT_DT         = userSet3.indexOfColumn("RE_OUT_DT");
				int idx3RE_DEP_AMT        = userSet3.indexOfColumn("RE_DEP_AMT");
				int idx3RE_MON_AMT        = userSet3.indexOfColumn("RE_MON_AMT");
				int idx3RE_SUM_AMT        = userSet3.indexOfColumn("RE_SUM_AMT");
				int idx3RE_DEP_INT_AMT    = userSet3.indexOfColumn("RE_DEP_INT_AMT");
				int idx3RE_INCOME_AMT     = userSet3.indexOfColumn("RE_INCOME_AMT");
				int idx3UND_YN            = userSet3.indexOfColumn("UND_YN");
				int idx3MINOR_NO          = userSet3.indexOfColumn("MINOR_NO");
				int idx3COMPLEX           = userSet3.indexOfColumn("COMPLEX");
				int idx3UP_DT             = userSet3.indexOfColumn("UP_DT");
				int idx3SPACE             = userSet3.indexOfColumn("SPACE");
				int idx3CREATE_ID         = userSet3.indexOfColumn("CREATE_ID");
				int idx3UPDATE_ID         = userSet3.indexOfColumn("UPDATE_ID");
                
				GauceDataRow[] rows  = userSet.getDataRows();
				GauceDataRow[] rows2 = userSet2.getDataRows();
				GauceDataRow[] rows3 = userSet3.getDataRows();

				StringBuffer InsertSql  = null;
				StringBuffer InsertSql2 = null;
				StringBuffer InsertSql3 = null;

				StringBuffer DeleteSql  = null;
				StringBuffer DeleteSql2 = null;
				StringBuffer DeleteSql3 = null;

				//HEAD 
				InsertSql = new StringBuffer();
				InsertSql.append( " INSERT INTO ACCOUNT.EHDT001 (                         \n " );
				InsertSql.append( "         FDCODE,RD_GB,YYYY,HF_GB,HF_SEQ,               \n " );
				InsertSql.append( "         CO_CRNO,CO_NM,CO_RENM,CO_NO,CO_DT,            \n " );
				InsertSql.append( "         PH_NO,SPACE,                                  \n " );
				InsertSql.append( "         CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE   \n " );
				InsertSql.append( "        )                                              \n " );
				InsertSql.append( " VALUES ( \n " );
				InsertSql.append( "         ?,?,?,?,?, \n " );
				InsertSql.append( "         ?,?,?,?,?, \n " );
				InsertSql.append( "         ?,?,       \n " );
				InsertSql.append( "         ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP   \n " );
				InsertSql.append( "        ) \n " );
				
				
                //TAIL  
				InsertSql2 = new StringBuffer();
				InsertSql2.append( " INSERT INTO ACCOUNT.EHDT003 (                                    \n " );
				InsertSql2.append( "        FDCODE,RD_GB,YYYY,HF_GB,HF_SEQ,	                          \n " );
				InsertSql2.append( "        CO_CRNO,DATA_CNT,RD_SEQ_GB,RE_POSITION,RE_DEP_SUM,        \n " );
				InsertSql2.append( "        RE_MON_SUM,RE_SUM_SUM,RE_DEP_INT_SUM,RE_INCOME_SUM,RE_CNT,\n " );
				InsertSql2.append( "        MINOR_NO,SPACE,                                           \n " );
				InsertSql2.append( "        CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE               \n " );
				InsertSql2.append( "         )                                                        \n " );
				InsertSql2.append( " VALUES ( \n " );
				InsertSql2.append( "         ?,?,?,?,?, \n " );
				InsertSql2.append( "         ?,?,?,?,?, \n " );
				InsertSql2.append( "         ?,?,?,?,?, \n " );
				InsertSql2.append( "         ?,?,       \n " );
				InsertSql2.append( "         ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP \n " );
				InsertSql2.append( "        ) \n " );
				
				
                //DATA 
				InsertSql3 = new StringBuffer();
				InsertSql3.append( " INSERT INTO ACCOUNT.EHDT002 (                                              \n " );
				InsertSql3.append( "        FDCODE,RD_GB,YYYY,HF_GB,HF_SEQ,                                     \n " );
				InsertSql3.append( "        CO_CRNO,RD_SEQ_GB,RD_SEQ,FLOOR,FR_NO,                               \n " );
				InsertSql3.append( "        AREA,HI_NM,HI_CRNO,RE_IN_DT,RE_OUT_DT,                              \n " );
				InsertSql3.append( "        RE_DEP_AMT,RE_MON_AMT,RE_SUM_AMT,RE_DEP_INT_AMT,RE_INCOME_AMT,      \n " );
				InsertSql3.append( "        UND_YN,MINOR_NO,COMPLEX,UP_DT,SPACE,                                \n " );
				InsertSql3.append( "        CREATE_ID,CREATE_DATE,UPDATE_ID,UPDATE_DATE                         \n " );
				InsertSql3.append( "        )                                                                   \n " );
				InsertSql3.append( " VALUES ( \n " );
				InsertSql3.append( "         ?,?,?,?,?, \n " );
				InsertSql3.append( "         ?,?,?,?,?, \n " );
				InsertSql3.append( "         ?,?,?,?,?, \n " );
				InsertSql3.append( "         ?,?,?,?,?, \n " );
				InsertSql3.append( "         ?,?,?,?,?, \n " );
				InsertSql3.append( "          ?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP   \n " );
				InsertSql3.append( "        ) \n " );
				
				DeleteSql = new StringBuffer();
				DeleteSql.append( "  DELETE FROM ACCOUNT.EHDT001 WHERE FDCODE = ? AND YYYY=? AND HF_GB=?  AND HF_SEQ=?  \n " );

				
				DeleteSql2 = new StringBuffer();
				DeleteSql2.append( " DELETE FROM ACCOUNT.EHDT003 WHERE FDCODE = ? AND YYYY=? AND HF_GB=?  AND HF_SEQ=?  \n " );

				
				DeleteSql3 = new StringBuffer();
				DeleteSql3.append( " DELETE FROM ACCOUNT.EHDT002 WHERE FDCODE = ? AND YYYY=? AND HF_GB=?  AND HF_SEQ=? \n " );
                

				for (int j = 0; j < rows.length; j++){
					//////////////////////////////////////////////////////////////////////////
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						//삭제
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idxFDCODE);   
						gsmt.bindColumn(2,  idxYYYY);   
						gsmt.bindColumn(3,  idxHF_GB);   
						gsmt.bindColumn(4,  idxHF_SEQ);   
								
						gsmt.executeUpdate();
						gsmt.close();

						gsmt=null;
					
						rows[j].setString(idxCREATE_ID, strUserid);
						rows[j].setString(idxUPDATE_ID, strUserid);
					
						//신규 생성 - A
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxFDCODE);   
						gsmt.bindColumn(2,  idxRD_GB);   
						gsmt.bindColumn(3,  idxYYYY);   
						gsmt.bindColumn(4,  idxHF_GB);   
						gsmt.bindColumn(5,  idxHF_SEQ);   
						gsmt.bindColumn(6,  idxCO_CRNO);   
						gsmt.bindColumn(7,  idxCO_NM);   
						gsmt.bindColumn(8,  idxCO_RENM);   
						gsmt.bindColumn(9,  idxCO_NO);   
						gsmt.bindColumn(10, idxCO_DT);   
						gsmt.bindColumn(11, idxPH_NO);   
						gsmt.bindColumn(12, idxSPACE);   
						gsmt.bindColumn(13, idxCREATE_ID);   
						gsmt.bindColumn(14, idxUPDATE_ID);   
		
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
						gsmt2.bindColumn(2,  idx2YYYY);   
						gsmt2.bindColumn(3,  idx2HF_GB);   
						gsmt2.bindColumn(4,  idx2HF_SEQ);   
		
						gsmt2.executeUpdate();
						gsmt2.close();

						gsmt2=null;

						rows2[j2].setString(idx2CREATE_ID, strUserid);
						rows2[j2].setString(idx2UPDATE_ID, strUserid);
						
						//신규 생성 - A
						gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows2[j2]);
						gsmt2.bindColumn(1,  idx2FDCODE);
						gsmt2.bindColumn(2,  idx2RD_GB);
						gsmt2.bindColumn(3,  idx2YYYY);
						gsmt2.bindColumn(4,  idx2HF_GB);
						gsmt2.bindColumn(5,  idx2HF_SEQ);
						gsmt2.bindColumn(6,  idx2CO_CRNO);
						gsmt2.bindColumn(7,  idx2DATA_CNT);
						gsmt2.bindColumn(8,  idx2RD_SEQ_GB);
						gsmt2.bindColumn(9,  idx2RE_POSITION);
						gsmt2.bindColumn(10, idx2RE_DEP_SUM);
						gsmt2.bindColumn(11, idx2RE_MON_SUM);
						gsmt2.bindColumn(12, idx2RE_SUM_SUM);
						gsmt2.bindColumn(13, idx2RE_DEP_INT_SUM);
						gsmt2.bindColumn(14, idx2RE_INCOME_SUM);
						gsmt2.bindColumn(15, idx2RE_CNT);
						gsmt2.bindColumn(16, idx2MINOR_NO);
						gsmt2.bindColumn(17, idx2SPACE);
						gsmt2.bindColumn(18, idx2CREATE_ID);
						gsmt2.bindColumn(19, idx2UPDATE_ID);
  
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
							gsmt3.bindColumn(2,  idx3YYYY);   
							gsmt3.bindColumn(3,  idx3HF_GB);   
							gsmt3.bindColumn(4,  idx3HF_SEQ);   

							gsmt3.executeUpdate();
							gsmt3.close();
							gsmt3=null;
						}
					
						rows3[j3].setString(idx3CREATE_ID, strUserid);
						rows3[j3].setString(idx3UPDATE_ID, strUserid);	
											
						//신규 생성 - A
						gsmt3 = conn.getGauceStatement(InsertSql3.toString());
						gsmt3.setGauceDataRow(rows3[j3]);
						gsmt3.bindColumn(1,  idx3FDCODE);
						gsmt3.bindColumn(2,  idx3RD_GB);
						gsmt3.bindColumn(3,  idx3YYYY);
						gsmt3.bindColumn(4,  idx3HF_GB);
						gsmt3.bindColumn(5,  idx3HF_SEQ);
						gsmt3.bindColumn(6,  idx3CO_CRNO);
						gsmt3.bindColumn(7,  idx3RD_SEQ_GB);
						gsmt3.bindColumn(8,  idx3RD_SEQ);
						gsmt3.bindColumn(9,  idx3FLOOR);
						gsmt3.bindColumn(10, idx3FR_NO);
						gsmt3.bindColumn(11, idx3AREA);
						gsmt3.bindColumn(12, idx3HI_NM);
						gsmt3.bindColumn(13, idx3HI_CRNO);
						gsmt3.bindColumn(14, idx3RE_IN_DT);
						gsmt3.bindColumn(15, idx3RE_OUT_DT);
						gsmt3.bindColumn(16, idx3RE_DEP_AMT);
						gsmt3.bindColumn(17, idx3RE_MON_AMT);
						gsmt3.bindColumn(18, idx3RE_SUM_AMT);
						gsmt3.bindColumn(19, idx3RE_DEP_INT_AMT);
						gsmt3.bindColumn(20, idx3RE_INCOME_AMT);
						gsmt3.bindColumn(21, idx3UND_YN);
						gsmt3.bindColumn(22, idx3MINOR_NO);
						gsmt3.bindColumn(23, idx3COMPLEX);
						gsmt3.bindColumn(24, idx3UP_DT);
						gsmt3.bindColumn(25, idx3SPACE);
						gsmt3.bindColumn(26, idx3CREATE_ID);
						gsmt3.bindColumn(27, idx3UPDATE_ID);
							
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