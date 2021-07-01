package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

import java.util.*;

public class p030030_t2 extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				GauceStatement gsmt = null;
        /****************************************************
         프로그램 : 전산매체 생성 ( F 레코드 생성 )
				 작성일자 : 2011.01.17
				 작 성 자 : 정영식
				*****************************************************/
        int idxAPPYY = userSet.indexOfColumn("APPYY");   //귀속년도
				
					       
				GauceDataRow[] rows = userSet.getDataRows();

       	StringBuffer InsertSql = null;
				StringBuffer DeleteSql = null;

        for (int j = 0; j < rows.length; j++){ 
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					 
						DeleteSql = new StringBuffer();
						DeleteSql.append( "	DELETE FROM PAYROLL.YCW_F10   \n  " );
						DeleteSql.append( "	 WHERE APPYY=?                \n  " );
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxAPPYY);
						gsmt.executeUpdate();
						gsmt.close();

						//F레코드
						InsertSql = new StringBuffer();
						InsertSql.append( "	INSERT INTO PAYROLL.YCW_F10                                                                     	\n  " );
						InsertSql.append( "	SELECT Z.APPYY, '1', Z.EMPNO,                                                                   	\n  " );
						InsertSql.append( "	       (RANK() OVER( PARTITION BY Z.APPYY ORDER BY Z.APPYY,Z.EMPNO)) SEQ,                       	\n  " );
						InsertSql.append( "	       'F','20','227', X.C004, '2218113834', X.C012,                                            	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=1 THEN Z.DUDGB  END) F007,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=1 THEN Z.FINACD END) F008,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=1 THEN Z.FINANM END) F009,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=1 THEN Z.ACCNO  END) F010,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=1 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F011,                  	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=1 THEN Z.PAYAMT ELSE 0 END) F012,                                   	\n  " );
            InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=1 THEN Z.DEDAMT ELSE 0 END) F013,                                   	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=2 THEN Z.DUDGB  END) F014,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=2 THEN Z.FINACD END) F015,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=2 THEN Z.FINANM END) F016,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=2 THEN Z.ACCNO  END) F017,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=2 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F018,                  	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=2 THEN Z.PAYAMT ELSE 0 END) F019,                                   	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=2 THEN Z.DEDAMT ELSE 0 END) F020,                                   	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=3 THEN Z.DUDGB  END) F021,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=3 THEN Z.FINACD END) F022,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=3 THEN Z.FINANM END) F023,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=3 THEN Z.ACCNO  END) F024,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=3 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F025,                  	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=3 THEN Z.PAYAMT ELSE 0 END) F026,                                   	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=3 THEN Z.DEDAMT ELSE 0 END) F027,                                   	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=4 THEN Z.DUDGB  END) F028,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=4 THEN Z.FINACD END) F029,                                          	\n  " );
            InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=4 THEN Z.FINANM END) F030,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=4 THEN Z.ACCNO  END) F031,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=4 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F032,                  	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=4 THEN Z.PAYAMT ELSE 0 END) F033,                                   	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=4 THEN Z.DEDAMT ELSE 0 END) F034,                                   	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=5 THEN Z.DUDGB  END) F035,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=5 THEN Z.FINACD END) F036,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=5 THEN Z.FINANM END) F037,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=5 THEN Z.ACCNO  END) F038,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=5 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F039,                  	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=5 THEN Z.PAYAMT ELSE 0 END) F040,                                   	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=5 THEN Z.DEDAMT ELSE 0 END) F041,                                   	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=6 THEN Z.DUDGB  END) F042,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=6 THEN Z.FINACD END) F043,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=6 THEN Z.FINANM END) F044,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=6 THEN Z.ACCNO  END) F045,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=6 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F046,                  	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=6 THEN Z.PAYAMT ELSE 0 END) F047,                                   	\n  " );
            InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=6 THEN Z.DEDAMT ELSE 0 END) F048,                                   	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=7 THEN Z.DUDGB  END) F049,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=7 THEN Z.FINACD END) F050,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=7 THEN Z.FINANM END) F051,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=7 THEN Z.ACCNO  END) F052,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=7 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F053,                  	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=7 THEN Z.PAYAMT ELSE 0 END) F054,                                   	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=7 THEN Z.DEDAMT ELSE 0 END) F055,                                   	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=8 THEN Z.DUDGB  END) F056,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=8 THEN Z.FINACD END) F057,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=8 THEN Z.FINANM END) F058,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=8 THEN Z.ACCNO  END) F059,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=8 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F060,                  	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=8 THEN Z.PAYAMT ELSE 0 END) F061,                                   	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=8 THEN Z.DEDAMT ELSE 0 END) F062,                                   	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=9 THEN Z.DUDGB  END) F063,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=9 THEN Z.FINACD END) F064,                                          	\n  " );
            InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=9 THEN Z.FINANM END) F065,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=9 THEN Z.ACCNO  END) F066,                                          	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=9 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F067,                  	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=9 THEN Z.PAYAMT ELSE 0 END) F068,                                   	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=9 THEN Z.DEDAMT ELSE 0 END) F069,                                   	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=10 THEN Z.DUDGB  END) F070,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=10 THEN Z.FINACD END) F071,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=10 THEN Z.FINANM END) F072,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=10 THEN Z.ACCNO  END) F073,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=10 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F074,                 	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=10 THEN Z.PAYAMT ELSE 0 END) F075,                                  	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=10 THEN Z.DEDAMT ELSE 0 END) F076,                                  	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=11 THEN Z.DUDGB  END) F077,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=11 THEN Z.FINACD END) F078,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=11 THEN Z.FINANM END) F079,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=11 THEN Z.ACCNO  END) F080,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=11 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F081,                 	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=11 THEN Z.PAYAMT ELSE 0 END) F082,                                  	\n  " );
            InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=11 THEN Z.DEDAMT ELSE 0 END) F083,                                  	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=12 THEN Z.DUDGB  END) F084,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=12 THEN Z.FINACD END) F085,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=12 THEN Z.FINANM END) F086,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=12 THEN Z.ACCNO  END) F087,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=12 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F088,                 	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=12 THEN Z.PAYAMT ELSE 0 END) F089,                                  	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=12 THEN Z.DEDAMT ELSE 0 END) F090,                                  	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=13 THEN Z.DUDGB  END) F091,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=13 THEN Z.FINACD END) F092,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=13 THEN Z.FINANM END) F093,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=13 THEN Z.ACCNO  END) F094,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=13 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F095,                 	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=13 THEN Z.PAYAMT ELSE 0 END) F096,                                  	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=13 THEN Z.DEDAMT ELSE 0 END) F097,                                  	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=14 THEN Z.DUDGB  END) F098,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=14 THEN Z.FINACD END) F099,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=14 THEN Z.FINANM END) F100,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=14 THEN Z.ACCNO  END) F101,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=14 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F102,                 	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=14 THEN Z.PAYAMT ELSE 0 END) F103,                                  	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=14 THEN Z.DEDAMT ELSE 0 END) F104,                                  	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=15 THEN Z.DUDGB  END) F105,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=15 THEN Z.FINACD END) F106,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=15 THEN Z.FINANM END) F107,                                         	\n  " );
            InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=15 THEN Z.ACCNO  END) F108,                                         	\n  " );
						InsertSql.append( "	       MAX(CASE WHEN Z.SEQ2=15 AND Z.DUDGB='41' THEN Z.YEARLY ELSE 0 END) F109,                 	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=15 THEN Z.PAYAMT ELSE 0 END) F110,                                  	\n  " );
						InsertSql.append( "	       SUM(CASE WHEN Z.SEQ2=15 THEN Z.DEDAMT ELSE 0 END) F111,                                  	\n  " );
						InsertSql.append( "	       '' F120                                                                                  	\n  " );
						InsertSql.append( "	  FROM ( SELECT A.APPYY,  A.EMPNO,  A.SEQ,                                                      	\n  " );
						InsertSql.append( "	                A.DUDGB,  A.FINACD, A.FINANM, IFNULL(A.ACCNO,'') ACCNO,  A.YEARLY, A.PAYAMT,    	\n  " );
						InsertSql.append( "	                A.DEDAMT, A.STATDT,                                                             	\n  " );
						InsertSql.append( "	                (RANK() OVER( PARTITION BY A.APPYY, A.EMPNO  ORDER BY A.EMPNO,A.SEQ)) SEQ2      	\n  " );
						InsertSql.append( "	           FROM PAYROLL.YCPRSNPS A                                                              	\n  " );
						InsertSql.append( "	          WHERE A.APPYY=?                                                                       	\n  " );
            InsertSql.append( "	            AND A.DEDAMT!=0                                                                      	\n  " );
            InsertSql.append( "	          UNION ALL                                                                             	\n  " );
            InsertSql.append( "	         SELECT A.APPYY,  A.EMPNO,  A.SEQ,                                                      	\n  " );
						InsertSql.append( "	                A.DUDGB,  A.FINACD, A.FINANM, IFNULL(A.ACCNO,'') ACCNO,  A.YEARLY, A.PAYAMT,    	\n  " );
						InsertSql.append( "	                A.DEDAMT, A.STATDT,                                                             	\n  " );
						InsertSql.append( "	                (RANK() OVER( PARTITION BY A.APPYY, A.EMPNO  ORDER BY A.EMPNO,A.SEQ)) SEQ2      	\n  " );
						InsertSql.append( "	           FROM PAYROLL.YCMIDPRSNPS A                                                           	\n  " );
						InsertSql.append( "	          WHERE A.APPYY=?                                                                       	\n  " );
            InsertSql.append( "	            AND A.DEDAMT!=0                                                                      	\n  " );
						InsertSql.append( "	          ORDER BY EMPNO, SEQ                                                                   	\n  " );
						InsertSql.append( "	       )Z                                                                                       	\n  " );
						InsertSql.append( "	  LEFT JOIN ( SELECT B.APPYY, B.EMPNO, B.C004, B.C012                                           	\n  " );
						InsertSql.append( "	                FROM PAYROLL.YCW_C10 B                                                          	\n  " );
						InsertSql.append( "	               WHERE APPYY=?                                                                    	\n  " );
						InsertSql.append( "	             ) X ON X.APPYY = Z.APPYY                                                           	\n  " );
						InsertSql.append( "	                AND X.EMPNO = Z.EMPNO                                                           	\n  " );
						InsertSql.append( "	                AND X.APPYY=?                                                                   	\n  " );
						InsertSql.append( "	 GROUP BY Z.APPYY, Z.EMPNO,X.C004,X.C012                                                        	\n  " );
            InsertSql.append( "	 ORDER BY Z.APPYY, X.C004, Z.EMPNO                                                               	\n  " );
											
					  gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxAPPYY);
						gsmt.bindColumn(2, idxAPPYY);
						gsmt.bindColumn(3, idxAPPYY);
						gsmt.bindColumn(4, idxAPPYY);
						gsmt.executeUpdate();
						gsmt.close();

					}//if
				}//for  

			} //try
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::");
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
  /**
  public void Step(String strempno){

     ServiceLoader loader = null;
		 GauceService service = null;
		 GauceContext context = null;
		 Logger logger = null; 

		 loader = new ServiceLoader(req, res);
	 	 service = loader.newService();
	 	 context = service.getContext();
	 	 logger = context.getLogger();

		 logger.dbg.println(this,"strempno"+strempno);

     //System.out.println("strempno"+strempno); 
	}
	**/
}



/**
class Step{
  public Step(String strempno){
		System.out.println("strempno"+strempno); 
  }
};

**/