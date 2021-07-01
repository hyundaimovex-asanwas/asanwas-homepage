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

public class bm052i_t01 extends HttpServlet{

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
				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");
//				logger.dbg.println(this,"step1");//로그남기는것
				String[] strArrCN = new String[]{
															"TELHIS_SID",	"CUST_SID",		"CT",					"WORK_NO",		"TEL_SID",
															"TEL_NUM",		"TEL_DATE",		"TEL_STIME",		"TEL_ETIME",		"TEL_DURA",
															"TEL_FEE",			"OP",					"CAL_YN",			"I_EMPNO",		"U_EMPNO"
																}; 

				int[] idx = new int[15]; //컬럼갯수를 넣어준다.

              for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
//					logger.dbg.println(this, "i:::" +i+"::::"+idx[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;

				for (int j = 0; j < rows.length; j++){
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/   
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
/*
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO SALES.TCM080 (                               \n" )
										.append( "					CUST_SID,		CT,				WORK_NO,		TEL_SID,           \n" )
										.append( "					TEL_NUM,		TEL_DATE,		TEL_STIME,		TEL_ETIME,		TEL_DURA,           \n" )
										.append( "					TEL_FEE,		OP,				CAL_YN,			I_EMPNO,			I_DATE           \n" )
										.append( "	) VALUES (  " + "                                             \n" )
										.append( "" + rows[j].getInt(idx[1]) + ",	\n")
										.append( "'" + rows[j].getString(idx[2]) + "',	\n")
										.append( "'" + rows[j].getString(idx[3]) + "',	\n")
										.append( "" + rows[j].getInt(idx[4]) + ",	\n")
										.append( "'" + rows[j].getString(idx[5]) + "',	\n")
										.append( "'" + rows[j].getString(idx[6]) + "',	\n")
										.append( "'" + rows[j].getString(idx[7]) + "',	\n")
										.append( "'" + rows[j].getString(idx[8]) + "',	\n")
										.append( "'" + rows[j].getString(idx[9]) + "',	\n")
										.append( "'" + rows[j].getString(idx[10]) + "',	\n")
										.append( "'" + rows[j].getString(idx[11]) + "',	\n")
										.append( "'" + rows[j].getString(idx[12]) + "',	\n")
										.append( "'" + rows[j].getString(idx[13]) + "',	\n")
										.append( "	 CURRENT TIMESTAMP                  \n" )
										.append( "	)                                                          " );
*/
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO SALES.TCM080 (																							\n" )
										.append( "					CUST_SID,		CT,				WORK_NO,		TEL_SID,										\n" )
										.append( "					TEL_NUM,		TEL_DATE,		TEL_STIME,		TEL_ETIME,		TEL_DURA,			\n" )
										.append( "					TEL_FEE,		OP,				CAL_YN,			I_EMPNO,			I_DATE					\n" )
										.append( "	) VALUES (																														\n" )
										.append( "	?, ?, ?, ?,																														\n" )
										.append( "	?, ?, ?, ?, ?,																													\n" )
										.append( "	?, ?, ?, ?, CURRENT TIMESTAMP																						\n" )
										.append( "	)																																		" );

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
/*
						logger.dbg.println(this, "1:" + rows[j].getInt(idx[1]));
						logger.dbg.println(this, "2:" + rows[j].getString(idx[2]));
						logger.dbg.println(this, "3:" + rows[j].getString(idx[3]));
						logger.dbg.println(this, "4:" + rows[j].getInt(idx[4]));
						logger.dbg.println(this, "5:" + rows[j].getString(idx[5]));
						logger.dbg.println(this, "6:" + rows[j].getString(idx[6]));
						logger.dbg.println(this, "7:" + rows[j].getString(idx[7]));
						logger.dbg.println(this, "8:" + rows[j].getString(idx[8]));
						logger.dbg.println(this, "9:" + rows[j].getString(idx[9]));
						logger.dbg.println(this, "10:" + rows[j].getString(idx[10]));
						logger.dbg.println(this, "11:" + rows[j].getString(idx[11]));
						logger.dbg.println(this, "12:" + rows[j].getString(idx[12]));
						logger.dbg.println(this, "13:" + rows[j].getString(idx[13]));
						logger.dbg.println(this, "14:" + rows[j].getString(idx[14]));
			            logger.dbg.println(this,InsertSql.toString());//로그남기는것
*/
						gsmt.bindColumn(1,  idx[1]);
						gsmt.bindColumn(2,  idx[2]);
						gsmt.bindColumn(3,  idx[3]);
						gsmt.bindColumn(4,  idx[4]);
						gsmt.bindColumn(5,  idx[5]);
						gsmt.bindColumn(6,  idx[6]);
						gsmt.bindColumn(7,  idx[7]);
						gsmt.bindColumn(8,  idx[8]);
						gsmt.bindColumn(9,  idx[9]);
						gsmt.bindColumn(10, idx[10]);
						gsmt.bindColumn(11, idx[11]);
						gsmt.bindColumn(12, idx[12]);
						gsmt.bindColumn(13, idx[14]);

						//logger.dbg.println(this,rows[j].getString(idx[2]));
						gsmt.executeUpdate();
						gsmt.close();

				}

				/*********************************************************************************
				 * UPDATE 처리
				 *********************************************************************************/
				if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE SALES.TCM080																								\n" )
										 .append( "		 SET CUST_SID=?, CT=?, WORK_NO=?, TEL_SID=?, TEL_NUM=?,							\n" )
										 .append( "		  		TEL_DATE=?, TEL_STIME=?, TEL_ETIME=?, TEL_DURA=?,							\n" )
 										 .append( "				TEL_FEE=?, OP=?, CAL_YN=?, U_EMPNO=?, U_DATE=CURRENT TIMESTAMP	\n" )
										 .append( "	WHERE TELHIS_SID=?																								" );
//										 .append( "	WHERE TELHIS_SID=? AND CUST_SID=?                                                 " );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						//logger.dbg.println(this,UpdateSql.toString());//로그남기는것
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idx[1]); 
						gsmt.bindColumn(2,  idx[2]); 
						gsmt.bindColumn(3,  idx[3]); 
						gsmt.bindColumn(4,  idx[4]); 
						gsmt.bindColumn(5,  idx[5]);
						gsmt.bindColumn(6,  idx[6]); 
						gsmt.bindColumn(7,  idx[7]); 
						gsmt.bindColumn(8,  idx[8]);
						gsmt.bindColumn(9,  idx[9]);
						gsmt.bindColumn(10, idx[10]);//add
						gsmt.bindColumn(11, idx[11]); 
						gsmt.bindColumn(12, idx[12]); 
						gsmt.bindColumn(13, idx[14]); 
						gsmt.bindColumn(14, idx[0]); 
						//logger.dbg.println(this,rows[j].getString(idx[2]));
						gsmt.executeUpdate();
						gsmt.close();
				}

				}	//for loop 끝
			}	//try 끝
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