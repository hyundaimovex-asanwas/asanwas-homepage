package THMS;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class thms_202_t extends HttpServlet{

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
				//String  str1 = reqGauce.getParameter("v_str1");   //  현장명인지 공종명인지 구분

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String[] strArrCN = new String[]{  								
										
															"BID_NUM",	"BID_STYLE", "SITE_CD",	"CNST_CD",								
															"BID_DAY",	"ORDER_CD",			                                                 
															"START_DT",		"END_DT",	"ACT_AMT",						                 		
															"START_DT_HA",		"END_DT_HA",		"ACT_AMT_HA", 	"RECO_CD"

															};

				int[] idx = new int[13]; //컬럼갯수를 넣어준다.
		

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

								InsertSql.append( " INSERT INTO THMS.THMS010(																					\n")		
											 .append( "BID_NUM, BID_STYLE, SITE_CD,  CNST_CD, BID_DAY, ORDER_CD, 							\n" )	
											 .append( "START_DT, END_DT, ACT_AMT, 																				\n" )	
											 .append( "START_DT_HA, END_DT_HA, ACT_AMT_HA, RECO_CD )											\n" )	
											 .append( " VALUES																													\n" )
											 .append( " (?,?,?,?,?,?,?,?,?,?,?,?,?)																								\n" );//11

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
						gsmt.bindColumn(13,  idx[12]);

						logger.dbg.println(this,InsertSql.toString());//로그남기는것

						gsmt.executeUpdate();					
						gsmt.close();									

					}


/******************************************************************************
* Update 처리
*********************************************************************************/
    
        			if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						StringBuffer UpdateSql = new StringBuffer();			

						//logger.dbg.println(this,UpdateSql.toString());//로그남기는것

						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql.toString());
						gsmt2.setGauceDataRow(rows[j]);

						gsmt2.executeUpdate();					
						gsmt2.close();									

					}
				

/**********************************************************************************************
	USER1의 DELETE 까지...
**********************************************************************************************/
				}









/**********************************************************************************************
	USER2의 새롭게 데이타셋 받아서 처리할 부분
**********************************************************************************************/
        GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER3");

				                             
			String[] strArrCN2 = new String[]{ 

																"BID_NUM", "SITE_CD",	"CNST_CD",  "SEQ", 
																	
																"BID_COM", "BID_COM_NM", "BID_AMT","BID_AMT2",
																	
																"RESULT_CP", "RESULT_AMT"

																			  };


				int[] idx2 = new int[10]; //컬럼갯수를 넣어준다.


				for (int i=0; i<strArrCN2.length; i++) {
						idx2[i] = userSet2.indexOfColumn(strArrCN2[i]);
				}


				GauceDataRow[] rows2 = userSet2.getDataRows();


				for (int j = 0; j<rows2.length; j++){

/******************************** **********************************************
*
*********************************************************************************/

					if(rows2[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					

						StringBuffer InsertSql2 = new StringBuffer();			

							  InsertSql2.append( " INSERT INTO THMS.THMS015(															\n")		
											 .append( " BID_NUM, SITE_CD,	CNST_CD, SEQ,   												\n" )	
											 .append( " BID_COM, BID_AMT, BID_AMT2, 														\n" )	
											 .append( " RESULT_CP, RESULT_AMT )																\n" )	
											 .append( " VALUES																							\n" )
											 .append( " (?,?,?,?,?,?,?,?,?)																				\n" );

						GauceStatement gsmt3 = conn.getGauceStatement(InsertSql2.toString());			
						gsmt3.setGauceDataRow(rows2[j]);
											

/*
						logger.dbg.println(this,"rows[j].getString(idx2[0])::"+rows2[j].getString(idx2[0]));    
						logger.dbg.println(this,"rows[j].getString(idx2[1])::"+rows2[j].getString(idx2[1]));    
						logger.dbg.println(this,"rows[j].getString(idx2[2])::"+rows2[j].getString(idx2[2]));    
						logger.dbg.println(this,"rows[j].getString(idx2[3])::"+rows2[j].getString(idx2[3]));    
						logger.dbg.println(this,"rows[j].getString(idx2[4])::"+rows2[j].getString(idx2[4]));    
						logger.dbg.println(this,"rows[j].getString(idx2[5])::"+rows2[j].getString(idx2[5]));    
						logger.dbg.println(this,"rows[j].getString(idx2[6])::"+rows2[j].getString(idx2[6]));    
						logger.dbg.println(this,"rows[j].getString(idx2[7])::"+rows2[j].getString(idx2[7]));    
*/


						gsmt3.bindColumn(1,  idx2[0]);
						gsmt3.bindColumn(2,  idx2[1]);
						gsmt3.bindColumn(3,  idx2[2]);
						gsmt3.bindColumn(4,  idx2[3]);   
						gsmt3.bindColumn(5,  idx2[4]);
						gsmt3.bindColumn(6,  idx2[6]);
						gsmt3.bindColumn(7,  idx2[7]);
						gsmt3.bindColumn(8,  idx2[8]);
						gsmt3.bindColumn(9,  idx2[9]);


						//logger.dbg.println(this,InsertSql2.toString());//로그남기는것

						gsmt3.executeUpdate();					
						gsmt3.close();	
					}

/******************************** **********************************************
* Update 처리
********************************************************************************
					if (rows2[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

							StringBuffer UpdateSql = new StringBuffer();	

					  UpdateSql.append( " UPDATE SALES.TCM090			\n")

										 .append( "   SET TELHIS_SID=?,     \n")

							       .append( "       U_EMPNO=?,                \n")

							       .append( "       U_DATE=CURRENT TIMESTAMP  \n")

										 .append( " WHERE UP_SID=?         \n");

						

  					GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql.toString());
						gsmt2.setGauceDataRow(rows2[j]);


							
						gsmt2.bindColumn(1,  idx2[1]);	
						gsmt2.bindColumn(2,  idx2[2]);	
						gsmt2.bindColumn(3,  idx2[0]);	

						gsmt2.executeUpdate();					
						gsmt2.close();		
						
					}
*/

/******************************** **********************************************
 * DELETE 처리
*********************************************************************************/
          /*
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						
			   	}
					*/
				}




			}
			catch(Exception e){
				logger.err.println(this,e);
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