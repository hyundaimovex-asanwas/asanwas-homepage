package sales.cm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class cm010i_t01 extends HttpServlet{

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

				String str1 = reqGauce.getParameter("v_str1"); //T1_CAR_SID
				
				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");
//				logger.dbg.println(this,"step1");//로그남기는것
				
				String[] strArrCN = new String[]{
													"T1_CAR_SID",				"CAR_NO",		"CAR_TYPE",			"CAR_NM",					"CAR_FORM",
													"CAR_YEAR",					"CAR_CC",		"CAR_PERSONS",	"MAX_KG",					"CAR_TYPE_CD",
													"CAR_TYPE_CD_NAME",	"CAR_DNO",	"NORTH_YN",			"NORTH_YN_NAME",	"NORTH_DATE",
													"CLIENT_NM",				"TEAM_NM",	"CAR_SID",			"CLIENT_SID",			"TEAM_CD",
													"I_EMPNO",					"I_DATE",		"U_EMPNO",			"U_DATE"
													};

				int[] idx = new int[24]; //컬럼갯수를 넣어준다.

		        for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				StringBuffer InsertSql2 = null;
				StringBuffer UpdateSql2 = null;
				StringBuffer DeleteSql2 = null;

				for (int j = 0; j < rows.length; j++){
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/   

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

							StringBuffer sql = new StringBuffer();

							Statement stmt= null;
							ResultSet rs = null;
							int strInt = 0;  //내가 추가

							if(!str1.equals("")){
									sql.append( " SELECT COUNT(CAR_SID) CAR_SID FROM SALES.TCM140		\n" )
										 .append( " WHERE  CAR_SID = "+str1+"												\n" );

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
											InsertSql.append( " INSERT INTO SALES.TCM140 (													\n" )
															 .append( "		   CAR_SID, CLIENT_SID, TEAM_CD, I_EMPNO, I_DATE		\n" )
															 .append( "	) VALUES (																			\n" )
															 .append( "	     ?,?,?,?,CURRENT TIMESTAMP											\n" )
															 .append( "	)																							" );

											GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

											gsmt.setGauceDataRow(rows[j]);
											gsmt.bindColumn(1,  idx[17]); 
											gsmt.bindColumn(2,  idx[18]); 
											gsmt.bindColumn(3,  idx[19]); 
											gsmt.bindColumn(4,  idx[20]); 

											logger.dbg.println(this,InsertSql.toString());//로그남기는것

											gsmt.executeUpdate();
											gsmt.close();
									} else {//업데이트 처리		
											UpdateSql = new StringBuffer();
											UpdateSql.append( " UPDATE SALES.TCM140													\n" )
															 .append( "		 SET TEAM_CD=?, CLIENT_SID=?, U_EMPNO=?,		\n" )
															 .append( "				U_DATE=CURRENT TIMESTAMP						\n" )
															 .append( "	WHERE CAR_SID=?														" );

											GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
											//logger.dbg.println(this,UpdateSql.toString());//로그남기는것
											gsmt.setGauceDataRow(rows[j]);
											
											gsmt.bindColumn(1,  idx[19]); 
											gsmt.bindColumn(2,  idx[18]); 
											gsmt.bindColumn(3,  idx[22]); 
											gsmt.bindColumn(4,  idx[17]);

											gsmt.executeUpdate();
											gsmt.close();	
									}
							}

					}

					/*********************************************************************************
					 * DELETE 처리
					 *********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

					}
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
