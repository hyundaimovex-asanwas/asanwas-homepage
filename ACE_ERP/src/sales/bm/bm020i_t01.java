//입출국 등록(남 -> 북)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class bm020i_t01 extends HttpServlet{

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

				String str1 = reqGauce.getParameter("v_str1"); //guser_id

				
				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");
				//logger.dbg.println(this,"step1");//로그남기는것
				
				String[] strArrCN = new String[]{
															"RSV_SID", "CUST_SID", "CHK"
															  }; 

				int[] idx = new int[3]; //컬럼갯수를 넣어준다.

		        for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;

				for (int j = 0; j < rows.length; j++){
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/   

//					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

							StringBuffer sql = new StringBuffer();

							Statement stmt= null;
							ResultSet rs = null;
							int strInt = 0;  //내가 추가
							String s = String.valueOf(rows[j].getInt(idx[0]));
							//logger.dbg.println(this,s);//로그남기는것

//							logger.dbg.println(this, rows[j].getInt(idx[0]));//로그남기는것
//							if(rows[j].getInt(idx[0]) != 0 || rows[j].getInt(idx[0]) <> null){
									sql.append( " SELECT COUNT(RSV_SID) RSV_SID FROM SALES.TCM040	 	\n" )
										 .append( " WHERE  RSV_SID = " + rows[j].getInt(idx[0]) + " 				       				\n" );
//logger.dbg.println(this,sql.toString());//로그남기는것
//									GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
//									gsmt.setGauceDataRow(rows[j]);
									stmt = conn.createStatement();
									rs = stmt.executeQuery(sql.toString());

									while (rs.next())	{
										strInt = rs.getInt(1);
									}
									rs.close();
									stmt.close();

								  int ichk = strInt;
				                  //rows[j].setInt(idx[0],ichk);
									if(ichk==0){//입력할테이블에 값이 없으면      

											InsertSql = new StringBuffer();
											InsertSql.append( " INSERT INTO SALES.TCM040 (														\n" )
															 .append( "			RSV_SID, CUST_SID, SN_YN, I_EMPNO, I_DATE, NS_YN	\n" )
															 .append( "	) VALUES (																				\n" )
															 .append( "	?,?,?, " + str1 + ", CURRENT TIMESTAMP, 'F'							\n" )
															 .append( "	)																								");

											GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
										    //logger.dbg.println(this,InsertSql.toString());//로그남기는것
											gsmt.setGauceDataRow(rows[j]);
											gsmt.bindColumn(1,  idx[0]);  
											gsmt.bindColumn(2,  idx[1]); 
											gsmt.bindColumn(3,  idx[2]); 

										    //logger.dbg.println(this,InsertSql.toString());//로그남기는것
											gsmt.executeUpdate();
											gsmt.close();
									} else {//업데이트 처리

											UpdateSql = new StringBuffer();
											UpdateSql.append( " UPDATE SALES.TCM040                                                                     \n" )
															 .append( "		 SET SN_YN=?, U_EMPNO= " + str1 + ", U_DATE=CURRENT TIMESTAMP          \n" )
															 .append( "	WHERE RSV_SID = ?                                                                         " );

											GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

											//logger.dbg.println(this,UpdateSql.toString());//로그남기는것
											gsmt.setGauceDataRow(rows[j]);
											gsmt.bindColumn(1,  idx[2]); 
											gsmt.bindColumn(2,  idx[0]); 

											gsmt.executeUpdate();
											gsmt.close();
									
									}
//							}

//					}

				}
			}
			catch(Exception e){
				logger.err.println(this,e.getMessage());	
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e.getMessage());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}
