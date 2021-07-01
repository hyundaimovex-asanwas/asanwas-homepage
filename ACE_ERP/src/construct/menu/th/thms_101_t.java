package construct.menu.th;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class thms_101_t extends HttpServlet{

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


/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/

				// 웹페이지에서 조건값을 넘겨받음
				String  str1 = reqGauce.getParameter("v_str1");   //  현장명인지 공종명인지 구분

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String[] strArrCN = new String[]{  								
										
															"SITE_CD","SITE_NM",		
																
															"CNST_CD","CNST_NM",

															"T_DAY","ORDER_NM",

															"START_DT","END_DT","ACT_AMT",

															"START_DT_HA","END_DT_HA","ACT_AMT_HA"

																	};
																			  
				int[] idx = new int[12]; //컬럼갯수를 넣어준다.
		

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();					

				for (int j = 0; j < rows.length; j++){


/******************************************************************************
** INSERT 처리
*********************************************************************************/
    
        	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_INSERT) {


						StringBuffer InsertSql = new StringBuffer();			

								InsertSql.append( " INSERT INTO CONSTRUCT.THMS010(                                                 \n")		
											 .append( "SITE_CD, SITE_NM, CNST_CD, CNST_NM,									\n" )	
											 .append( "T_DAY, ORDER_NM,																	\n" )	
											 .append( "START_DT, END_DT, ACT_AMT,													\n" )	
											 .append( "START_DT_HA, END_DT_HA, ACT_AMT_HA)								\n" )	
											 .append( " VALUES																					\n" )
											 .append( " (?,?,?,?,?,?,?,?,?,?,?,?)																\n" );//2

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());			
						gsmt.setGauceDataRow(rows[j]);
											
						gsmt.bindColumn(1,  idx[0]);
						gsmt.bindColumn(2,  idx[1]);
						gsmt.bindColumn(3,  idx[2]);
						gsmt.bindColumn(4,  idx[3]);   
						gsmt.bindColumn(5,  idx[4]);
						gsmt.bindColumn(6,  idx[5]);
						gsmt.bindColumn(7,  idx[6]);
						gsmt.bindColumn(8,  idx[7]);   
						gsmt.bindColumn(9,  idx[8]);
						gsmt.bindColumn(10,  idx[9]);
						gsmt.bindColumn(11,  idx[10]);
						gsmt.bindColumn(12,  idx[11]);   

						//logger.dbg.println(this,InsertSql.toString());//로그남기는것

						gsmt.executeUpdate();					
						gsmt.close();									

					}


/******************************************************************************
* Update 처리
*********************************************************************************/
    
        	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						StringBuffer UpdateSql = new StringBuffer();			

						////logger.dbg.println(this,UpdateSql.toString());//로그남기는것

						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql.toString());
						gsmt2.setGauceDataRow(rows[j]);

						gsmt2.executeUpdate();					
						gsmt2.close();									

					}
				}			



/**********************************************************************************************
새로운 user2
**********************************************************************************************/

				GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");

				//logger.dbg.println(this,"뭔가 남겨보자고!");				//로그남기는것

				String[] strArrCN2 = new String[]{  
														"SITE_CD",		"CNST_CD",
														"BID1_COM",	"BID1_AMT",		"BID1_AMT2",
														"BID2_COM",	"BID2_AMT",		"BID2_AMT2",
														"BID3_COM",	"BID3_AMT",		"BID3_AMT2",
														"BID4_COM",	"BID4_AMT",		"BID4_AMT2",
														"BID5_COM",	"BID5_AMT",		"BID5_AMT2",
														"BID6_COM",	"BID6_AMT",		"BID6_AMT2",
														"BID7_COM",	"BID7_AMT",		"BID7_AMT2",
														"BID8_COM",	"BID8_AMT",		"BID8_AMT2",
														"BID9_COM",	"BID9_AMT",		"BID9_AMT2",
														"BID10_COM",	"BID10_AMT",	"BID10_AMT2",
														"RESULT_CP",		"RESULT_AMT"
																	
																};
																			  
				int[] idx2 = new int[34]; //컬럼갯수를 넣어준다.
		
				for (int i=0; i<strArrCN2.length; i++) {
						idx2[i] = userSet2.indexOfColumn(strArrCN2[i]);
				}

				GauceDataRow[] rows2 = userSet2.getDataRows();					

				for (int j = 0; j < rows2.length; j++){

/******************************************************************************
** INSERT 처리
*********************************************************************************/
				//logger.dbg.println(this,"뭔가 남겨보자고!");				//로그남기는것
					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						StringBuffer InsertSql2 = null;

						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);

						InsertSql2 = new StringBuffer();

						InsertSql2.append( " INSERT INTO CONSTRUCT.THMS015(								\n")	
										.append( " SITE_CD,		CNST_CD,											\n")	
										.append( " BID1_COM,	BID1_AMT,	BID1_AMT2,					\n")	
										.append( " BID2_COM,	BID2_AMT,	BID2_AMT2,					\n")	
										.append( " BID3_COM,	BID3_AMT,	BID3_AMT2,					\n")	
										.append( " BID4_COM,	BID4_AMT,	BID4_AMT2,					\n")	
										.append( " BID5_COM,	BID5_AMT,	BID5_AMT2,					\n")	
										.append( " BID6_COM,	BID6_AMT,	BID6_AMT2,					\n")	
										.append( " BID7_COM,	BID7_AMT,	BID7_AMT2,					\n")	
										.append( " BID8_COM,	BID8_AMT,	BID8_AMT2,					\n")	
										.append( " BID9_COM,	BID9_AMT,	BID9_AMT2,					\n")	
										.append( " BID10_COM,	BID10_AMT,	BID10_AMT2,			\n")	
										.append( " RESULT_CP,	RESULT_AMT										\n")	
										.append( "  )																			\n")	

										.append( " VALUES ( ?,?,														\n")
										.append( " 	?,?,?,?,?,?,															\n")
										.append( " 	?,?,?,?,?,?,															\n")
										.append( " 	?,?,?,?,?,?,															\n")										
										.append( " 	?,?,?,?,?,?,															\n")
										.append( " 	?,?,?,?,?,?,															\n")
										.append( " 	?,?)																	\n");


						gsmt2.bindColumn(1,  idx2[0]);
						gsmt2.bindColumn(2,  idx2[1]);
						gsmt2.bindColumn(3,  idx2[2]);
						gsmt2.bindColumn(4,  idx2[3]);   
						gsmt2.bindColumn(5,  idx2[4]);
						gsmt2.bindColumn(6,  idx2[5]);
						gsmt2.bindColumn(7,  idx2[6]);
						gsmt2.bindColumn(8,  idx2[7]);   
						gsmt2.bindColumn(9,  idx2[8]);
						gsmt2.bindColumn(10,  idx2[9]);
						gsmt2.bindColumn(11,  idx2[10]);
						gsmt2.bindColumn(12,  idx2[11]);   
						gsmt2.bindColumn(13,  idx2[12]);
						gsmt2.bindColumn(14,  idx2[13]);
						gsmt2.bindColumn(15,  idx2[14]);
						gsmt2.bindColumn(16,  idx2[15]);   
						gsmt2.bindColumn(17,  idx2[16]);
						gsmt2.bindColumn(18,  idx2[17]);
						gsmt2.bindColumn(19,  idx2[18]);
						gsmt2.bindColumn(20,  idx2[19]);   
						gsmt2.bindColumn(21,  idx2[20]);
						gsmt2.bindColumn(22,  idx2[21]);
						gsmt2.bindColumn(23,  idx2[22]);
						gsmt2.bindColumn(24,  idx2[23]);   
						gsmt2.bindColumn(25,  idx2[24]);   
						gsmt2.bindColumn(26,  idx2[25]);
						gsmt2.bindColumn(27,  idx2[26]);
						gsmt2.bindColumn(28,  idx2[27]);
						gsmt2.bindColumn(29,  idx2[28]);   
						gsmt2.bindColumn(30,  idx2[29]);
						gsmt2.bindColumn(31,  idx2[30]);
						gsmt2.bindColumn(32,  idx2[31]);
						gsmt2.bindColumn(33,  idx2[32]);   
						gsmt2.bindColumn(34,  idx2[33]);
						


						gsmt2.executeUpdate();
						gsmt2.close();

					}

/******************************************************************************
* Update 처리 - USER2
*********************************************************************************/
/*
					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						StringBuffer UpdateSql2 = null;

						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);

						UpdateSql2 = new StringBuffer();
						UpdateSql2.append( " UPDATE ACCOUNT.MFSLIPDTL SET " );
						UpdateSql2.append( "        ATCODE = ?," );
						UpdateSql2.append( "        ATDECR = ?," );
						UpdateSql2.append( "        FSAMT = ?," );
						UpdateSql2.append( "        REMARK = ?," );
						UpdateSql2.append( "        PRIMCOST = ?," );
						UpdateSql2.append( "        WRDT = ?, " );
						UpdateSql2.append( "        WRID = ?, " );
						UpdateSql2.append( "        UPDT = ?, " );
						UpdateSql2.append( "        UPID = ? " );
						UpdateSql2.append( " WHERE FDCODE = ? AND FSDAT = ? AND FSNBR = ? AND FSSEQ = ? " );

						gsmt2.bindColumn(1,  idxATCODE2);
						gsmt2.bindColumn(2,  idxATDECR2);
						gsmt2.bindColumn(3,  idxFSAMT2);
						gsmt2.bindColumn(4,  idxREMARK2);
						gsmt2.bindColumn(5,  idx1FSREFVAL2);
						gsmt2.bindColumn(6,  idxWRDT2);
						gsmt2.bindColumn(7,  idxWRID2);
						gsmt2.bindColumn(8,  idxUPDT2);
						gsmt2.bindColumn(9,  idxUPID2);			
						gsmt2.bindColumn(10, idxFDCODE2);
						gsmt2.bindColumn(11, idxFSDAT2);
						gsmt2.bindColumn(12, idxFSNBR2);
						gsmt2.bindColumn(13, idxFSSEQ2);
						gsmt2.executeUpdate(); 
						gsmt2.close();
					}    
						
*/
/******************************************************************************
* Delete 처리 - USER2
*********************************************************************************/
/*
						if(rows2[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

						StringBuffer DeleteSql2 = null;

						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows2[j]);

						DeleteSql2 = new StringBuffer();
						DeleteSql2.append( " DELETE FROM ACCOUNT.MFSLIPDTL " );
						DeleteSql2.append( " WHERE FDCODE = ? AND FSDAT = ? AND FSNBR = ? AND FSSEQ = ? "  );


						gsmt2.bindColumn(1, idxFDCODE2);
						gsmt2.bindColumn(2, idxFSDAT2);
						gsmt2.bindColumn(3, idxFSNBR2);
						gsmt2.bindColumn(4, idxFSSEQ2);
						gsmt2.executeUpdate();
						gsmt2.close();
					}
*/



/**********************************************************************************************
 user2 끝
**********************************************************************************************/
				}
			}
			catch(Exception e){
				//logger.err.println(this,e);
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}