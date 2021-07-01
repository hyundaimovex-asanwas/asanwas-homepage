package sales.menu.cm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class cm011i_t01 extends HttpServlet{

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

				//파라메타 받아오는것 선언
				String str1 = reqGauce.getParameter("v_str1"); 
				String  userid = reqGauce.getParameter("v_str2");

				if (str1 == null){	 	str1 = "";	}

				/*****			 * Insert 처리		****/
				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");
//				logger.dbg.println(this,"step1");//로그남기는것
				String[] strArrCN = new String[]{
													"CARNO_SID",	"CAR_SID",		"CAR_NO",		"CAR_DNO",
													"CAR_RNO",		"USE_SDATE",	"USE_EDATE"
												  };
				int[] idx = new int[7]; //컬럼갯수를 넣어준다.

              for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
//					logger.dbg.println(this, "i:::" +i+"::::"+idx[i]);
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

//					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

							StringBuffer sql = new StringBuffer();

							Statement stmt= null;
							ResultSet rs = null;
							int strInt = 0;  //내가 추가

							if(!str1.equals("")){
									sql.append( " SELECT COUNT(CARNO_SID) CARNO_SID2 FROM SALES.TCM150	\n" )
										 .append( " WHERE  CARNO_SID ="+str1+" 				       				\n" );

									stmt = conn.createStatement();
									rs = stmt.executeQuery(sql.toString());

									while (rs.next())	{
										strInt = rs.getInt(1);
									}
									rs.close();
									stmt.close();

									int ichk = strInt;
									  //rows[j].setString(idx[6],userid);
									if(ichk==0){//입력할테이블에 값이 없으면      
											InsertSql = new StringBuffer();
											InsertSql.append( " INSERT INTO SALES.TCM150 (												\n" )
															 .append( "		   CAR_SID, CAR_DNO, CAR_RNO, USE_SDATE,			\n" )
															 .append( "			USE_EDATE, I_EMPNO, I_DATE								\n" )
															 .append( "	) VALUES (																		\n" )
															 .append( "	    ?,  ?, ?, ?, ?, " + userid + ", CURRENT TIMESTAMP		\n" )
															 .append( "	)																						" );

//											logger.dbg.println(this,"1:"+rows[j].getInt(idx[1]));
//											logger.dbg.println(this,"2:"+rows[j].getString(idx[2]));
//											logger.dbg.println(this,InsertSql.toString());

											GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

											gsmt.setGauceDataRow(rows[j]);
											gsmt.bindColumn(1,  idx[1]);
											gsmt.bindColumn(2,  idx[3]);
											gsmt.bindColumn(3,  idx[4]);
											gsmt.bindColumn(4,  idx[5]);
											gsmt.bindColumn(5,  idx[6]);

											//logger.dbg.println(this,InsertSql.toString());//로그남기는것

											gsmt.executeUpdate();
											gsmt.close();
									} else {//업데이트 처리		
											UpdateSql = new StringBuffer();
											UpdateSql.append( " UPDATE SALES.TCM150																		\n" )
															 .append( "		 SET CAR_RNO=?, USE_SDATE=?, USE_EDATE=?,						\n" )
															 .append( "				U_EMPNO=" + userid + " , U_DATE=CURRENT TIMESTAMP	\n" )
															 .append( "	WHERE CARNO_SID="+str1+"																" );

											GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
												
											//logger.dbg.println(this,UpdateSql.toString());//로그남기는것

											gsmt.setGauceDataRow(rows[j]);

											gsmt.bindColumn(1,  idx[4]);
											gsmt.bindColumn(2,  idx[5]);
											gsmt.bindColumn(3,  idx[6]);

											gsmt.executeUpdate();
											gsmt.close();	
									}
							} else {
											InsertSql = new StringBuffer();
											InsertSql.append( " INSERT INTO SALES.TCM150 (												\n" )
															 .append( "		   CAR_SID, CAR_DNO, CAR_RNO, USE_SDATE,			\n" )
															 .append( "			USE_EDATE, I_EMPNO, I_DATE								\n" )
															 .append( "	) VALUES (																		\n" )
															 .append( "	    ?,  ?, ?, ?, ?, " + userid + ", CURRENT TIMESTAMP		\n" )
															 .append( "	)																						" );

											GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

											gsmt.setGauceDataRow(rows[j]);
											gsmt.bindColumn(1,  idx[1]);
											gsmt.bindColumn(2,  idx[3]);
											gsmt.bindColumn(3,  idx[4]);
											gsmt.bindColumn(4,  idx[5]);
											gsmt.bindColumn(5,  idx[6]);
 
//											logger.dbg.println(this,InsertSql.toString());//로그남기는것

											gsmt.executeUpdate();
											gsmt.close();
							}

//					}

					/*********************************************************************************
					 * DELETE 처리
					 *********************************************************************************/
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