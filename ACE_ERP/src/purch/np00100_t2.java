package purch;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class np00100_t2 extends HttpServlet{

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


				//파라메타 받아오는것 선언
				String str1 = reqGauce.getParameter("v_str1");

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
					
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String[] strArrCN = new String[]{  

															"RQ_NO",	"RQ_SEQ",	"RQ_PNAM",	 "RQ_STND",	"RQ_UNIT",	"RQ_QTY",

															"RQ_USE",	"RQ_ORDAMT",	"RQ_ACTAMT", "RQ_STEP",	"RQ_PNO",	"RQ_PSEQ",		"RQ_BIGO",	 "RQ_USER"
                         					                               	
																			  };
																	  
				int[] idx = new int[14]; //컬럼갯수를 넣어준다.
				
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

						InsertSql.append( " INSERT INTO PURCH.REQUEST_DETAIL(								\n")		
										.append( "				RQ_NO, RQ_SEQ,RQ_PNAM,       						\n")
										.append( "				RQ_STND, RQ_UNIT,  RQ_QTY,           				\n")
										.append( "				RQ_USE, RQ_ORDAMT, RQ_ACTAMT,            	\n")
										.append( "				RQ_STEP, RQ_PNO,            							\n")
										.append( "				RQ_PSEQ, RQ_BIGO,  RQ_USER           				\n")
										.append( "  ) 																			\n")	
										.append( " VALUES																	\n")
										.append( " (?,?,?,?,?,?, '',?,?,'','','','','')											\n");



						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());		
	
						gsmt.setGauceDataRow(rows[j]);


		/*				logger.dbg.println(this, "1 " + rows[j].getString(idx[0]));							
						logger.dbg.println(this, "2 " + rows[j].getString(idx[1]));	
						logger.dbg.println(this, "3 " + rows[j].getString(idx[2]));							
						logger.dbg.println(this, "4 " + rows[j].getString(idx[3]));	
						logger.dbg.println(this, "5 " + rows[j].getString(idx[4]));							
						logger.dbg.println(this, "6 " + rows[j].getString(idx[5]));	
						logger.dbg.println(this, "7 " + rows[j].getString(idx[6]));							
						logger.dbg.println(this, "8 " + rows[j].getString(idx[7]));	
						logger.dbg.println(this, "9 " + rows[j].getString(idx[8]));							
						logger.dbg.println(this, "10 " + rows[j].getString(idx[9]));	
						logger.dbg.println(this, "11 " + rows[j].getString(idx[10]));							
						logger.dbg.println(this, "12 " + rows[j].getString(idx[11]));	*/

						//rows[j].setString(idx[0],str1);

						gsmt.bindColumn(1,  idx[0]);
						gsmt.bindColumn(2,  idx[1]);
						gsmt.bindColumn(3,  idx[2]);
						gsmt.bindColumn(4,  idx[3]);   
						gsmt.bindColumn(5,  idx[4]);
						gsmt.bindColumn(6,  idx[5]);
						gsmt.bindColumn(7,  idx[7]);
						gsmt.bindColumn(8,  idx[8]);
		/*				gsmt.bindColumn(9,  idx[8]);
						gsmt.bindColumn(10,  idx[9]);   
						gsmt.bindColumn(11,  idx[10]);
						gsmt.bindColumn(12,  idx[11]);	*/

					//	logger.dbg.println(this,InsertSql.toString());//로그남기는것

						gsmt.executeUpdate();					
						gsmt.close();									

					}


/******************************************************************************
* Update 처리
*********************************************************************************/
 
        	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						StringBuffer UpdateSql = new StringBuffer();			

								UpdateSql.append( " UPDATE PURCH.REQUEST_DETAIL										\n")
												.append( " SET																			\n")
												.append( " RQ_SEQ = ?,																	\n")
												.append( " RQ_PNAM = ?,																\n")
												.append( " RQ_STND = ?,																\n")
												.append( " RQ_UNIT = ?,																\n")
												.append( " RQ_QTY = ?,																	\n")	
												.append( " RQ_ORDAMT = ?,															\n")
												.append( " RQ_ACTAMT = ?															\n")	
												.append( " WHERE RQ_NO = ?															\n")
												.append( " AND RQ_SEQ = ?															\n");


						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						


						gsmt.setGauceDataRow(rows[j]);
											
						gsmt.bindColumn(1,  idx[1]);
						gsmt.bindColumn(2,  idx[2]);
						gsmt.bindColumn(3,  idx[3]);
						gsmt.bindColumn(4,  idx[4]);
						gsmt.bindColumn(5,  idx[5]);
						gsmt.bindColumn(6,  idx[7]);
						gsmt.bindColumn(7,  idx[8]);
						gsmt.bindColumn(8,  idx[0]);
						gsmt.bindColumn(9,  idx[1]);

						//logger.dbg.println(this,UpdateSql.toString());//로그남기는것

						gsmt.executeUpdate();					
						gsmt.close();									

					}



/******************************** **********************************************
 * DELETE 처리
 *********************************************************************************/

			if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

							StringBuffer DeleteSql = new StringBuffer();	

							DeleteSql = new StringBuffer();

							DeleteSql.append( " DELETE  FROM PURCH.REQUEST_DETAIL					\n")
										.append( "	 WHERE  RQ_NO=?												\n")
										.append( "	 AND  RQ_SEQ=?													\n");
										
							GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
							gsmt.setGauceDataRow(rows[j]);

	  						gsmt.bindColumn(1, idx[0]);
	  						gsmt.bindColumn(2, idx[1]);

							gsmt.executeUpdate();
							gsmt.close();

					}

/**********************************************************************************************

**********************************************************************************************/

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

