//사업자 출국신청 입력&수정
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

public class bm026i_t01 extends HttpServlet{

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

				String str1 = reqGauce.getParameter("v_str1");	//TRV020.RSV_SID
				if (str1==null || str1=="") {logger.dbg.println(this,"TRV020.RSV_SID Null");}

				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");

				String[] strArrCN = new String[]{
													"T1_RSV_SID",		"DEPART_DATE",	"NS_PLAN",		"SN_PLAN",	"CAR_YN", 
													"BIGO",					"I_EMPNO",			"I_DATE",			"U_EMPNO",	"U_DATE", 
													"ARRIVE_DATE",		"T1_U_EMPNO",		"T1_U_DATE",	"RSV_SID"																			
														  }; 

				int[] idx = new int[14]; //컬럼갯수를 넣어준다.

		        for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;

				StringBuffer InsertSql2 = null;
				StringBuffer UpdateSql2 = null;
				
				StringBuffer InsertSql3 = null;
				StringBuffer UpdateSql3 = null;

				for (int j = 0; j < rows.length; j++){

//					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
							StringBuffer sql = new StringBuffer();

							Statement stmt= null;
							ResultSet rs = null;
							int strInt = 0;  //내가 추가

//							if(!str1.equals("")){
									sql.append( " SELECT COUNT(RSV_SID) RSV_SID FROM SALES.TCM050	\n" )
										 .append( " WHERE  RSV_SID ="+str1+" 				       				\n" );

									stmt = conn.createStatement();
									rs = stmt.executeQuery(sql.toString());

									while (rs.next())	{
										strInt = rs.getInt(1);
									}

									rs.close();
									stmt.close();
									logger.dbg.println(this, "str1::" + str1 + "::");
									int ichk = strInt;
									logger.dbg.println(this, "ichk::" + ichk + "::");
									if(ichk==0){//입력할테이블에 값이 없으면                     
											//logger.dbg.println("찍히는것:RSV_SID",rows[j].getString(idx[13]));
											InsertSql = new StringBuffer();
											InsertSql.append( " INSERT INTO SALES.TCM050 (                                         \n" )
															 .append( "			RSV_SID, NS_PLAN, SN_PLAN, CAR_YN, BIGO,                       \n" )
															 .append( "			I_EMPNO, I_DATE                                                \n" )
															 .append( "	) VALUES (                                                         \n" )
															 .append( "	?,?,?,?,?,                                                         \n" )
															 .append( "	?,CURRENT TIMESTAMP                                                \n" )
															 .append( "	)                                                                    " );

											GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
											gsmt.setGauceDataRow(rows[j]);
											gsmt.bindColumn(1,  idx[0]);
											gsmt.bindColumn(2,  idx[2]); 
											gsmt.bindColumn(3,  idx[3]); 
											gsmt.bindColumn(4,  idx[4]); 
											gsmt.bindColumn(5,  idx[5]); 
											gsmt.bindColumn(6,  idx[6]); 

										  //logger.dbg.println(this,InsertSql.toString());
											gsmt.executeUpdate();
											gsmt.close();
											logger.dbg.println(this, "insert");
											UpdateSql = new StringBuffer();
											UpdateSql.append( " UPDATE SALES.TRV020                                                                     \n" )
															 .append( "		 SET ARRIVE_DATE=?, U_EMPNO=?, U_DATE=CURRENT TIMESTAMP                               \n" )
															 .append( "	WHERE RSV_SID = "+str1+"                                                                         " );

											GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql.toString());
											//logger.dbg.println(this,UpdateSql.toString());
											gsmt2.setGauceDataRow(rows[j]);
											gsmt2.bindColumn(1,  idx[10]); 
											gsmt2.bindColumn(2,  idx[11]); 
//											gsmt2.bindColumn(3,  idx[0]); 

											gsmt2.executeUpdate();
											gsmt2.close();
											logger.dbg.println(this, "updateTRV020:1");
									} else {//업데이트 처리
											UpdateSql2 = new StringBuffer();
											UpdateSql2.append( " UPDATE SALES.TCM050                                                                     \n" )
															 .append( "		 SET NS_PLAN=?, SN_PLAN=?, CAR_YN=?, BIGO=?, U_EMPNO=?,                                \n" )
															 .append( "		     U_DATE=CURRENT TIMESTAMP                                                          \n" )
															 .append( "	 WHERE RSV_SID = "+str1+"                                                                         " );

											GauceStatement gsmt = conn.getGauceStatement(UpdateSql2.toString());

											//logger.dbg.println(this,UpdateSql2.toString());
											gsmt.setGauceDataRow(rows[j]);
											gsmt.bindColumn(1,  idx[2]); 
											gsmt.bindColumn(2,  idx[3]); 
											gsmt.bindColumn(3,  idx[4]); 
											gsmt.bindColumn(4,  idx[5]); 
											gsmt.bindColumn(5,  idx[8]); 
//											gsmt.bindColumn(6,  idx[0]);

											gsmt.executeUpdate();
											gsmt.close();
											logger.dbg.println(this, "updateTCM050:1");									

											UpdateSql3 = new StringBuffer();
											UpdateSql3.append( " UPDATE SALES.TRV020                                                                       \n" )
															  .append( "		 SET ARRIVE_DATE=?, U_EMPNO=?, U_DATE=CURRENT TIMESTAMP                                \n" )
														    .append( " WHERE RSV_SID = "+str1+"                                                                           " );

											GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql3.toString());

											//logger.dbg.println(this,UpdateSql3.toString());
											gsmt3.setGauceDataRow(rows[j]);
											gsmt3.bindColumn(1,  idx[10]); 
											gsmt3.bindColumn(2,  idx[11]); 
//											gsmt3.bindColumn(3,  idx[0]); 

											gsmt3.executeUpdate();
											gsmt3.close();
											logger.dbg.println(this, "updateTRV020:2");
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
