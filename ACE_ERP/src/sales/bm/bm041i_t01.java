// * 식수관리 : 개인별 식수내역:(저장,등록)
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

public class bm041i_t01 extends HttpServlet{

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
				String str1 = reqGauce.getParameter("v_str1");	//날짜
				//logger.dbg.println(this,str1);
				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");

				String[] strArrCN = new String[]{
														"T1_CUST_SID",		"WORK_NO",		"CUST_NM",		"CUST_SID",		"EATING_DATE", 
														"I_EMPNO",			"I_DATE",			"U_EMPNO",		"U_DATE",			"EATING_BRE" ,
														"BRE_CHK",			"EATING_LUN",	"LUN_CHK",		"EATING_DIN",	"DIN_CHK",
														"EATING_SID"
															  }; 

				int[] idx = new int[16]; //컬럼갯수를 넣어준다.

		        for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/   
//					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
							StringBuffer sql = new StringBuffer();

							Statement stmt= null;
							ResultSet rs = null;
							int strInt = 0;  //내가 추가


									sql.append( " SELECT COUNT(CUST_SID) CUST_SID FROM SALES.TCM020	\n" )
										 .append( " WHERE  EATING_SID = " + rows[j].getInt(idx[15]) + "  	\n" );
//										 .append( " WHERE  CUST_SID ='"+str1+"' 				       				\n" )
//										 .append( " AND EATING_DATE ='"+str2+"' 				       				\n" );
//logger.dbg.println(this, "eating_sid::" + rows[j].getInt(idx[15]) + "::");
									stmt = conn.createStatement();
									rs = stmt.executeQuery(sql.toString());

									while (rs.next())	{
										strInt = rs.getInt(1);
									}
									rs.close();
									stmt.close();

									int ichk = strInt;
									//rows[j].setInt(idx[0],ichk);

									if(ichk==0){//count == 0이면    
											InsertSql = new StringBuffer();
											//logger.dbg.println(this,"1");
											InsertSql.append( " INSERT INTO SALES.TCM020 (                                         \n" )
														 .append( "			CUST_SID, EATING_DATE, EATING_BRE, EATING_LUN,EATING_DIN,      \n" )
														 .append( "			BRE_CHK, LUN_CHK, DIN_CHK,					\n")
														 .append( "			I_EMPNO, I_DATE                                                \n" )
														 .append( "	) VALUES (                                                         \n" )
														 .append( "	?,'"+str1+"',?,?,?,                                                \n" )
														 .append( "	?,?,?,					                                                \n" )
														 .append( "	?,CURRENT TIMESTAMP                                                \n" )
														 .append( "	)                                                                     ");

											GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
											//logger.dbg.println(this,InsertSql.toString());
											gsmt.setGauceDataRow(rows[j]);
											gsmt.bindColumn(1,  idx[0]); 
											gsmt.bindColumn(2,  idx[9]); 
											gsmt.bindColumn(3,  idx[11]); 
											gsmt.bindColumn(4,  idx[13]); 
											gsmt.bindColumn(5,  idx[10]);
											gsmt.bindColumn(6,  idx[12]);
											gsmt.bindColumn(7,  idx[14]);
											gsmt.bindColumn(8,  idx[5]);
											
											gsmt.executeUpdate();
											gsmt.close();
									}
									else
								{
											UpdateSql = new StringBuffer();
											UpdateSql.append( " UPDATE SALES.TCM020                                                                       \n" )
															.append( "	SET EATING_BRE=?, EATING_LUN=?, EATING_DIN=?,					\n")
															.append( "			BRE_CHK=?, LUN_CHK=?, DIN_CHK=?,					\n")
															.append( "			U_EMPNO=?, U_DATE=CURRENT TIMESTAMP      \n" )
															.append( "	WHERE EATING_SID = ?                \n" );

											GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

											//logger.dbg.println(this,UpdateSql.toString());
											gsmt.setGauceDataRow(rows[j]);
											gsmt.bindColumn(1,  idx[9]); 
											gsmt.bindColumn(2,  idx[11]); 
											gsmt.bindColumn(3,  idx[13]); 
											gsmt.bindColumn(4,  idx[10]); 
											gsmt.bindColumn(5,  idx[12]); 
											gsmt.bindColumn(6,  idx[14]);
											gsmt.bindColumn(7,  idx[7]);
											gsmt.bindColumn(8,  idx[15]);

											gsmt.executeUpdate();
											gsmt.close();
								}

//TB_JOB_INSERT					}

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