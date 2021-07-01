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

public class p030030_t0 extends HttpServlet{

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
         프로그램 : 전산매체 생성 ( A B C D 레코드 생성 )
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
						DeleteSql.append( "	DELETE FROM PAYROLL.YCW_A10   \n  " );
						DeleteSql.append( "	 WHERE APPYY=?                \n  " );
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxAPPYY);
						gsmt.executeUpdate();
						gsmt.close();

            DeleteSql =null;
            DeleteSql = new StringBuffer();
						DeleteSql.append( "	DELETE FROM PAYROLL.YCW_B10   \n  " );
						DeleteSql.append( "	 WHERE APPYY=?                \n  " );
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxAPPYY);
						gsmt.executeUpdate();
						gsmt.close();

  					DeleteSql =null;
            DeleteSql = new StringBuffer();
						DeleteSql.append( "	DELETE FROM PAYROLL.YCW_C10   \n  " );
						DeleteSql.append( "	 WHERE APPYY=?                \n  " );
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxAPPYY);
						gsmt.executeUpdate();
						gsmt.close();

						DeleteSql =null;
            DeleteSql = new StringBuffer();
						DeleteSql.append( "	DELETE FROM PAYROLL.YCW_D10   \n  " );
						DeleteSql.append( "	 WHERE APPYY=?                \n  " );
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxAPPYY);
						gsmt.executeUpdate();
						gsmt.close();



						//A레코드
						InsertSql = new StringBuffer();
						InsertSql.append( "	INSERT INTO PAYROLL.YCW_A10 (																					 	\n  " );
						InsertSql.append( "	    APPYY,																														 	\n  " );
						InsertSql.append( "	    A001,    A002,    A003,    A004,    A005,													 	\n  " );
						InsertSql.append( "	    A006,    A007,    A008,    A009,    A010,													 	\n  " );
						InsertSql.append( "	    A011,    A012,    A013,    A014,    A015,    A016									 	\n  " );
						InsertSql.append( "	)VALUES(																															 	\n  " );
						InsertSql.append( "	    '2010',																														 	\n  " );
						InsertSql.append( "	    'A','20','227','20110228',2,																			 	\n  " );
						InsertSql.append( "	    '','ASAN99','9000','2218113834','현대아산 주식회사',							 	\n  " );
						InsertSql.append( "	    '인재지원팀','하나진','02-3669-3867',1,'101',''										 	\n  " );
						InsertSql.append( "	)																																			 	\n  " );
						gsmt = conn.getGauceStatement(InsertSql.toString());
            gsmt.executeUpdate();
						gsmt.close();

            InsertSql = null;
					
						//B레코드
						InsertSql = new StringBuffer();
						InsertSql.append( "	INSERT INTO PAYROLL.YCW_B10 (                                          	\n  " );
						InsertSql.append( "	    APPYY,                                                             	\n  " );
						InsertSql.append( "	    B001,   B002,   B003,   B004,   B005,                              	\n  " );
						InsertSql.append( "	    B006,   B007,   B008,   B009,   B010,                              	\n  " );
						InsertSql.append( "	    B011,   B012,   B013,   B014,   B015,                              	\n  " );
						InsertSql.append( "	    B016,   B017,   B018                                               	\n  " );
						InsertSql.append( "	)                                                                      	\n  " );
						InsertSql.append( "	SELECT '2010',                                                         	\n  " );
						InsertSql.append( "	       'B','20','227',1,'2218113834',                                  	\n  " );
						InsertSql.append( "	       '현대아산 주식회사','장경작','1401110011714',                   	\n  " );
						InsertSql.append( "	       X.C_CNT+COALESCE(Z.C_CNT,0), Y.D_CNT,  	                        \n  " );
						InsertSql.append( "	       X.CBPSUM+COALESCE(Z.CBPSUM,0), X.CCP41000+COALESCE(Z.CCP41000,0), 0,   \n  " );
						InsertSql.append( "	       X.CCP42000+COALESCE(Z.CCP42000,0), X.CCP43000+COALESCE(Z.CCP43000,0), 	\n  " );
						InsertSql.append( "	       X.CCP40000+COALESCE(Z.CCP40000,0),1,''                          	\n  " );
						InsertSql.append( "	  FROM PAYROLL.YCPAY10 A                                               	\n  " );
						InsertSql.append( "	  LEFT JOIN ( SELECT B.APPYY, COUNT(*) C_CNT, SUM(B.CBPSUM) CBPSUM,    	\n  " );
						InsertSql.append( "	                     SUM(B.CCP41000)CCP41000,SUM(B.CCP42000)CCP42000,  	\n  " );
						InsertSql.append( "	                     SUM(B.CCP43000)CCP43000,SUM(B.CCP40000)CCP40000   	\n  " );
						InsertSql.append( "	                FROM PAYROLL.YCPAY10 B                                 	\n  " );
						InsertSql.append( "	               WHERE APPYY=?                                          	\n  " );
						InsertSql.append( "	               GROUP BY B.APPYY                                        	\n  " );
						InsertSql.append( "	             )X ON A.APPYY=X.APPYY                                     	\n  " );
						InsertSql.append( "	  LEFT JOIN ( SELECT C.YYYY, COUNT(*) D_CNT                            	\n  " );
						InsertSql.append( "	                FROM PAYROLL.YCBEFOFF C                                	\n  " );
						InsertSql.append( "	               WHERE C.YYYY=?                                         	\n  " );
						InsertSql.append( "	               GROUP BY C.YYYY                                         	\n  " );
						InsertSql.append( "	             )Y ON A.APPYY=Y.YYYY                                      	\n  " );
            InsertSql.append( "	  LEFT JOIN ( SELECT B.APPYY, COUNT(*) C_CNT, SUM(B.CBPSUM) CBPSUM,    	\n  " );
						InsertSql.append( "	                     SUM(B.CCP41000)CCP41000,SUM(B.CCP42000)CCP42000,  	\n  " );
						InsertSql.append( "	                     SUM(B.CCP43000)CCP43000,SUM(B.CCP40000)CCP40000   	\n  " );
						InsertSql.append( "	                FROM PAYROLL.YCMIDPAY10 B                              	\n  " );
						InsertSql.append( "	               WHERE APPYY=?                                          	\n  " );
						InsertSql.append( "	               GROUP BY B.APPYY                                        	\n  " );
						InsertSql.append( "	             )Z ON A.APPYY=X.APPYY                                     	\n  " );         
						InsertSql.append( "	 FETCH FIRST 1 ROWS ONLY                                               	\n  " );
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxAPPYY);
						gsmt.bindColumn(2, idxAPPYY);
						gsmt.bindColumn(3, idxAPPYY);
						gsmt.executeUpdate();
						gsmt.close();

            InsertSql=null;
						//C레코드
						InsertSql = new StringBuffer();
						InsertSql.append( "	INSERT INTO PAYROLL.YCW_C10                                                                                               \n  " ); 
						InsertSql.append( "	SELECT                                                                                                                    \n  " ); 
						InsertSql.append( "	    A.APPYY,  '1',   A.EMPNO,                                                                                             \n  " ); 
						InsertSql.append( "	    'C','20','227',                                                                                                       \n  " ); 
						InsertSql.append( "	    (RANK() OVER( PARTITION BY APPYY ORDER BY A.EMPNO)) AS C004,                                                          \n  " ); 
						InsertSql.append( "	    '2218113834', COALESCE(X.D_CNT,0)D_CNT,A.RESIGB, A.RESINACD, A.FSINGLE, A.EMPNMK,                                     \n  " ); 
						InsertSql.append( "	    A.COTRYGB, A.RESINO,  A.NATIONCD, A.HOUSEYN, A.YETAGB,                                                                \n  " ); 
						InsertSql.append( "	    A.CWORKNO, A.CWORKNM, A.CWORKFR,  A.CWORKTO, 0 AS C020,                                                               \n  " ); 
						InsertSql.append( "	    0 AS C021, A.CP11000, A.CP12000,  A.CP13000, 0 AS C025 , 0 AS C026, 0 AS C027, A.CP10000,  A.CNTAX01, 0,              \n  " ); 
						InsertSql.append( "	    A.CNTAXSUM, A.REDSUM,  A.TOTPAY,   A.DUDPAY,  A.LABPAY,  A.BAAMT01,  A.BAAMT02,                                        \n  " ); 
						InsertSql.append( "	    A.BACNT03, A.BAAMT03, A.ADCNT01,  A.ADAMT01, A.ADCNT02, A.ADAMT02,  A.ADAMT03,  A.ADCNT04,  A.ADAMT04, A.ADCNT05,     \n  " ); 
						InsertSql.append( "	    A.ADAMT05, 0 AS C072, A.ADCNT06,  A.ADAMT06, A.PENAMT01,                                                              \n  " ); 
						InsertSql.append( "	    A.PENAMT03,A.INSAMT01,A.INSAMT02, A.INSAMT03,A.INSAMT04,A.MEDSUM,   A.EDUSUM,   A.HOUAMT01, A.HOUAMT02, A.HOUAMT03,   \n  " ); 
						InsertSql.append( "	    A.CONAMT,  0 AS C092, A.SPCSUM,   A.STDSUM,  A.OFFSUM,  A.PESAMT01, A.PESAMT02, A.SMAAMT,   A.SAVAMT01, A.SAVAMT03,   \n  " ); 
						InsertSql.append( "	    A.SAVAMT04,A.SAVAMT02,A.INVSUM,   A.CRDSUM,  A.ASSSUM,  A.FNDSUM,   0 AS C107,  0 AS C108,  A.ETCSUM,   A.TAXSTDAMT,  \n  " ); 
						InsertSql.append( "	    A.TAXSUM,  A.TREDAMT01,A.TREDAMT02,0 AS C114,A.TREDSUM, A.DEDAMT01, A.DEDAMT02, A.DEDAMT03, A.DEDAMT04, A.DEDAMT05,   \n  " ); 
						InsertSql.append( "	    0 AS C121, A.DEDSUM,  A.CCP41000, A.CCP42000,A.CCP43000,A.CCP40000, A.CP41000,  A.CP42000,  A.CP43000,  A.CP40000,    \n  " ); 
						InsertSql.append( "	    CASE WHEN A.BA41000>=0 THEN 0 ELSE 1 END AS C131_1, ABS(A.BA41000)C131,                                               \n  " ); 
						InsertSql.append( "	    CASE WHEN A.BA42000>=0 THEN 0 ELSE 1 END AS C132_1, ABS(A.BA42000)C132,                                               \n  " ); 
						InsertSql.append( "	    CASE WHEN A.BA43000>=0 THEN 0 ELSE 1 END AS C133_1, ABS(A.BA43000)C133,                                               \n  " ); 
						InsertSql.append( "	    CASE WHEN A.BA40000>=0 THEN 0 ELSE 1 END AS C134_1, ABS(A.BA40000)C134, '' AS C135                                    \n  " ); 
						InsertSql.append( "	  FROM PAYROLL.YCPAY10 A                                                                                                  \n  " ); 
						InsertSql.append( "	  LEFT JOIN ( SELECT B.YYYY, B.EMPNO, COUNT(*)D_CNT                                                                       \n  " ); 
						InsertSql.append( "	                FROM PAYROLL.YCBEFOFF B                                                                                   \n  " ); 
						InsertSql.append( "	               WHERE B.YYYY=?                                                                                             \n  " ); 
						InsertSql.append( "	               GROUP BY B.YYYY, B.EMPNO                                                                                   \n  " ); 
						InsertSql.append( "	            )X ON X.YYYY = A.APPYY  AND X.EMPNO = A.EMPNO                                                                 \n  " ); 
						InsertSql.append( "	WHERE A.APPYY=?                                                                                                           \n  " ); 
            InsertSql.append( "	UNION ALL                                                                                                                 \n  " ); 
						InsertSql.append( "	SELECT                                                                                                                    \n  " ); 
						InsertSql.append( "	    A.APPYY,  '2',   A.EMPNO,                                                                                             \n  " ); 
						InsertSql.append( "	    'C','20','227',                                                                                                       \n  " ); 
						InsertSql.append( "	    307+(RANK() OVER( PARTITION BY APPYY ORDER BY A.EMPNO)) AS C004,                                                      \n  " ); 
						InsertSql.append( "	    '2218113834', 0 D_CNT,A.RESIGB, A.RESINACD, A.FSINGLE, A.EMPNMK,                                                      \n  " ); 
						InsertSql.append( "	    A.COTRYGB, A.RESINO,  A.NATIONCD, A.HOUSEYN, A.YETAGB,                                                                \n  " ); 
						InsertSql.append( "	    A.CWORKNO, A.CWORKNM, A.CWORKFR,  A.CWORKTO, 0 AS C020,                                                               \n  " ); 
						InsertSql.append( "	    0 AS C021, A.CP11000, A.CP12000,  A.CP13000, 0 AS C025 , 0 AS C026, 0 AS C027, A.CP10000,  A.CNTAX01, 0,              \n  " ); 
						InsertSql.append( "	    A.CNTAXSUM, A.REDSUM,  A.TOTPAY,   A.DUDPAY,  A.LABPAY,  A.BAAMT01,  A.BAAMT02,                                       \n  " ); 
						InsertSql.append( "	    A.BACNT03, A.BAAMT03, A.ADCNT01,  A.ADAMT01, A.ADCNT02, A.ADAMT02,  A.ADAMT03,  A.ADCNT04,  A.ADAMT04, A.ADCNT05,     \n  " ); 
						InsertSql.append( "	    A.ADAMT05, 0 AS C072, A.ADCNT06,  A.ADAMT06, A.PENAMT01,                                                              \n  " ); 
						InsertSql.append( "	    A.PENAMT03,A.INSAMT01,A.INSAMT02, A.INSAMT03,A.INSAMT04,A.MEDSUM,   A.EDUSUM,   A.HOUAMT01, A.HOUAMT02, A.HOUAMT03,   \n  " ); 
						InsertSql.append( "	    A.CONAMT,  0 AS C092, A.SPCSUM,   A.STDSUM,  A.OFFSUM,  A.PESAMT01, A.PESAMT02, A.SMAAMT,   A.SAVAMT01, A.SAVAMT03,   \n  " ); 
						InsertSql.append( "	    A.SAVAMT04,A.SAVAMT02,A.INVSUM,   A.CRDSUM,  A.ASSSUM,  A.FNDSUM,   0 AS C107,  0 AS C108,  A.ETCSUM,   A.TAXSTDAMT,  \n  " ); 
						InsertSql.append( "	    A.TAXSUM,  A.TREDAMT01,A.TREDAMT02,0 AS C114,A.TREDSUM, A.DEDAMT01, A.DEDAMT02, A.DEDAMT03, A.DEDAMT04, A.DEDAMT05,   \n  " ); 
						InsertSql.append( "	    0 AS C121, A.DEDSUM,  A.CCP41000, A.CCP42000,A.CCP43000,A.CCP40000, A.CP41000,  A.CP42000,  A.CP43000,  A.CP40000,    \n  " ); 
						InsertSql.append( "	    CASE WHEN A.BA41000>=0 THEN 0 ELSE 1 END AS C131_1, ABS(A.BA41000)C131,                                               \n  " ); 
						InsertSql.append( "	    CASE WHEN A.BA42000>=0 THEN 0 ELSE 1 END AS C132_1, ABS(A.BA42000)C132,                                               \n  " ); 
						InsertSql.append( "	    CASE WHEN A.BA43000>=0 THEN 0 ELSE 1 END AS C133_1, ABS(A.BA43000)C133,                                               \n  " ); 
						InsertSql.append( "	    CASE WHEN A.BA40000>=0 THEN 0 ELSE 1 END AS C134_1, ABS(A.BA40000)C134, '' AS C135                                    \n  " ); 
						InsertSql.append( "	  FROM PAYROLL.YCMIDPAY10 A                                                                                               \n  " ); 
						InsertSql.append( "	WHERE A.APPYY=?                                                                                                           \n  " ); 
						InsertSql.append( "	ORDER BY C004                                                                                                             \n  " ); 

						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxAPPYY);
						gsmt.bindColumn(2, idxAPPYY);
						gsmt.bindColumn(3, idxAPPYY);
						gsmt.executeUpdate();
						gsmt.close();

						InsertSql = new StringBuffer();
						InsertSql.append( "	 INSERT INTO PAYROLL.YCW_D10                                                                               \n  " ); 
						InsertSql.append( "	 SELECT                                                                                                    \n  " ); 
						InsertSql.append( "	     A.YYYY,  '1',  A.EMPNO,                                                                               \n  " ); 
						InsertSql.append( "	     'D','20','227', X.C004, '2218113834', '' AS D006, X.C012, 2, A.WKNM, A.WKRESINO,                      \n  " ); 
						InsertSql.append( "	     STRTDT,ENDDT, 0 AS D013,0 AS D014, A.BP11000, A.BP12000, A.BP13000, 0 AS D018, 0 AS D019, 0 AS D020,  \n  " ); 
						InsertSql.append( "	     A.BP10SUM, 0 D035, 0 D036, A.BP22000 AS D038,                                                         \n  " ); 
						InsertSql.append( "	     (A.BP22000+A.BTAXAMT01+BTAXAMT02) D047, 0 D048, A.BP41000, A.BP42000,                                 \n  " ); 
						InsertSql.append( "	     A.BP43000, (A.BP41000+A.BP42000),(RANK() OVER( PARTITION BY A.YYYY, A.EMPNO ORDER BY A.EMPNO)) AS D053, '' D054   \n  " ); 
						InsertSql.append( "	 FROM PAYROLL.YCBEFOFF A                                                                                   \n  " ); 
						InsertSql.append( "	 LEFT JOIN ( SELECT B.APPYY, B.EMPNO, B.C004, B.C012 FROM PAYROLL.YCW_C10 B                                \n  " ); 
						InsertSql.append( "	              WHERE APPYY=?                                                                                \n  " ); 
						InsertSql.append( "	           ) X ON X.APPYY = A.YYYY                                                                         \n  " ); 
						InsertSql.append( "	              AND X.EMPNO = A.EMPNO                                                                        \n  " ); 
						InsertSql.append( "	 WHERE A.YYYY =?                                                                                           \n  " ); 
            gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxAPPYY);
						gsmt.bindColumn(2, idxAPPYY);
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