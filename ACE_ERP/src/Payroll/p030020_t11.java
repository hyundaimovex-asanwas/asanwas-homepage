package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p030020_t11 extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String str1 = reqGauce.getParameter("v_str1");			//귀속년도
				String str2 = reqGauce.getParameter("v_str2");			//출력날짜

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql1 = null;
				StringBuffer InsertSql2 = null;
				StringBuffer InsertSql3 = null;
				StringBuffer InsertSql4 = null;

				StringBuffer UpdateSql = null;


				StringBuffer DeleteSql1 = null;
				StringBuffer DeleteSql2 = null;
				StringBuffer DeleteSql3 = null;
				StringBuffer DeleteSql4 = null;

				//logger.dbg.println(this,"아 썅");


				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {


						DeleteSql1 = new StringBuffer();
						DeleteSql1.append( "DELETE FROM PAYROLL.YCG_SUBA									\n");
						DeleteSql1.append( "WHERE APPYY = '"+str1+"'												\n");

						GauceStatement gsmt0 = conn.getGauceStatement(DeleteSql1.toString());
						gsmt0.setGauceDataRow(rows[j]);
						gsmt0.executeUpdate();
						gsmt0.close();

						InsertSql1 = new StringBuffer();
						InsertSql1.append( " INSERT INTO PAYROLL.YCG_SUBA (			    					\n");
						InsertSql1.append( " APPYY, RECORD,  DATA,    SEMU,  SUBMITDT,						\n");
						InsertSql1.append( " SUBMITGB, SEMUNO, HOMETAXID, SEMUPGM, BIZNO,		\n");
						InsertSql1.append( " BIZNM, 	CHARGEDEPT, 	CHARGENM,									\n");
						InsertSql1.append( " CHARGETEL, 	DUTYCNT, 	KORCD,		SPACE						\n");
						InsertSql1.append( " ) VALUES (													      				\n");	
						InsertSql1.append( " '"+str1+"','A','27','227', '"+str2+"',									\n");
						InsertSql1.append( " '2','      ','asan99              ','9000','2218113834',				\n");
						InsertSql1.append( " '현대아산주식회사                        ','인재지원부                    ',	\n");
						InsertSql1.append( " '하나진                        ',														\n");
						InsertSql1.append( " '0236693867     ','00001','101','  '									\n");
						InsertSql1.append( " )																						\n");

						GauceStatement gsmt = conn.getGauceStatement(InsertSql1.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();


						DeleteSql2 = new StringBuffer();
						DeleteSql2.append( "DELETE FROM PAYROLL.YCG_SUBB									\n");
						DeleteSql2.append( "WHERE APPYY = '"+str1+"'												\n");

						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.executeUpdate();
						gsmt2.close();

						InsertSql2 = new StringBuffer();

						InsertSql2.append( " INSERT INTO PAYROLL.YCG_SUBB (			    							\n");
						InsertSql2.append( " APPYY, RECORD,  DATA,    SEMU,  SEQ,									\n");
						InsertSql2.append( " BIZNO, BIZNM, CRECORDCNT, DRECORDCNT, 							\n");
						InsertSql2.append( " GIBUAMTSUM, DEDAMTSUM, 													\n");
						InsertSql2.append( " TERMCODE, 	SPACE															\n");
						InsertSql2.append( " ) 													      								\n");	
						InsertSql2.append( " SELECT																				\n"); 																								
						InsertSql2.append( " '2010' AS APPYY,																	\n"); 
						InsertSql2.append( " 'B' AS RECORD,																	\n"); 
						InsertSql2.append( " '27' AS DATA,																		\n"); 
						InsertSql2.append( " '227' AS SEMU,																	\n"); 
						InsertSql2.append( " '000001' AS SEQ,																	\n");	
						InsertSql2.append( " '2218113834' AS BIZNO,														\n"); 
						InsertSql2.append( " '현대아산주식회사                        ' AS BIZNM,						\n"); 
						InsertSql2.append( " ' ' AS CRECORDCNT,																\n"); 
						InsertSql2.append( " ' ' AS DRECORDCNT,																\n"); 
						InsertSql2.append( " SUM(A.CONAMT01 + A.CONAMT02 + A.CONAMT03 + A.CONAMT04 + A.CONAMT05 + A.CONAMT06 + A.CONAMT07) AS GIBUAMTSUM,				\n");  
						InsertSql2.append( " SUM(A.CONAMT01 + A.CONAMT02 + A.CONAMT03 + A.CONAMT04 + A.CONAMT05 + A.CONAMT06 + A.CONAMT07) AS DEDAMTSUM,				\n"); 
						InsertSql2.append( " '1' AS TERMCODE,																\n"); 
						InsertSql2.append( " ' '	AS SPACE																		\n"); 
						InsertSql2.append( " FROM PAYROLL.YCENTRY10 A													\n"); 																													
						InsertSql2.append( " WHERE A.APPYY = '2010'														\n");																		
						InsertSql2.append( " GROUP BY A.APPYY																\n"); 

						
						GauceStatement gsmt3 = conn.getGauceStatement(InsertSql2.toString());
						gsmt3.setGauceDataRow(rows[j]);
						gsmt3.executeUpdate();
						gsmt3.close();


						DeleteSql3 = new StringBuffer();
						DeleteSql3.append( "DELETE FROM PAYROLL.YCG_SUBC									\n");
						DeleteSql3.append( "WHERE APPYY = '"+str1+"'												\n");

						GauceStatement gsmt4 = conn.getGauceStatement(DeleteSql3.toString());
						gsmt4.setGauceDataRow(rows[j]);
						gsmt4.executeUpdate();
						gsmt4.close();


						InsertSql3 = new StringBuffer();
						InsertSql3.append( " INSERT INTO PAYROLL.YCG_SUBC (																									\n");
						InsertSql3.append( " APPYY, EMPNO, RECORD,  DATA,    SEMU,  SEQ,																		\n");
						InsertSql3.append( " BIZNO, JUMINNO,	FOREIGNER,																										\n");
						InsertSql3.append( " NAME, DUDGB, GIBUYY,																													  \n");
						InsertSql3.append( " GIBUAMT, DEDEDAMT, APPLYAMT,	YEARDEDAMT,																				\n");
						InsertSql3.append( " EXITAMT, CARRYAMT, CRECORDSEQ, SPACE																						\n");
						InsertSql3.append( " )																																				      \n");	
						InsertSql3.append( " SELECT																																		      \n");   
						InsertSql3.append( " '"+str1+"' AS APPYY, X.EMPNO, 'C' AS RECORD,'27' AS DATA,'227' AS SEMU,				\n");   
						InsertSql3.append( " X.NO AS SEQ,'2218113834' AS BIZNO,	X.RESINO AS JUMINNO,												\n");   
						InsertSql3.append( " '1' AS FOREIGNER,X.EMPNMK AS NAME,																							\n"); 
						InsertSql3.append( " X.GIVCOD AS DUDGB,SUBSTR(X.APPDT,0,5) AS GIBUYY,X.GIVAMT AS GIBUAMT,						\n");
						InsertSql3.append( " '0', X.GIVAMT AS APPLYAMT, 																										\n");
						InsertSql3.append( " (COALESCE(X.GIVAMT,0)-COALESCE(C.CARAMT,0)) AS YEARDEDAMT,	  									\n");
						InsertSql3.append( " COALESCE(C.EXTAMT,0) AS EXITAMT,																						    \n");
						InsertSql3.append( " COALESCE(C.CARAMT,0) AS CARRYAMT,																						  \n");						
						InsertSql3.append( " X.CRECORDSEQ  AS CRECORDSEQ, '' AS SPACE																				\n"); 
						InsertSql3.append( " FROM(																																		      \n");
						InsertSql3.append( "	 SELECT																																		    \n");
						InsertSql3.append( "	 A.APPDT, A.EMPNO,B.EMPNMK,																										\n");
						InsertSql3.append( "	 CONCAT('00000', ROW_NUMBER() OVER(PARTITION BY A.EMPNO)) AS NO,							\n");
						InsertSql3.append( "	 CONCAT('0000' , ROW_NUMBER() OVER(PARTITION BY A.EMPNO)) AS CRECORDSEQ,			\n");
						InsertSql3.append( "	 B.RESINO,A.GIVCOD,																														\n");
						InsertSql3.append( "	 CASE WHEN (A.GIVCOD = 20 AND (SUM(A.GIVAMT1) >= 100000 OR SUM(A.GIVAMT2) >= 100000))	\n");
						InsertSql3.append( "	      THEN SUM(A.GIVAMT1+A.GIVAMT2)-100000				                                  	\n");
						InsertSql3.append( "	 	    WHEN (A.GIVCOD = 20 AND SUM(A.GIVAMT1) < 100000 AND SUM(A.GIVAMT2) < 100000) 		\n");
						InsertSql3.append( "	 	    THEN 0 ELSE SUM(A.GIVAMT1+A.GIVAMT2) END GIVAMT 		                          	\n");
						//InsertSql3.append( "	 SUM(C.EXTAMT) AS EXTAMT,																											  \n");
						//InsertSql3.append( "	 IFNULL(SUM(C.CARAMT),0) CARAMT																								  \n");
						InsertSql3.append( "	 FROM PAYROLL.YCPRSNG A																											    \n");
						InsertSql3.append( "	 JOIN PAYROLL.YIPERSON B ON A.EMPNO = B.EMPNO																	  \n");
						//InsertSql3.append( "	 LEFT JOIN PAYROLL.YCPRSNGC C ON C.EMPNO = A.EMPNO AND C.GIVCOD = A.GIVCOD 			\n");
						InsertSql3.append( "	 WHERE A.APPDT = '"+str1+"12'																									  \n");
						InsertSql3.append( "	 GROUP BY A.APPDT, A.EMPNO, B.EMPNMK,B.RESINO, A.GIVCOD													\n");
   					InsertSql3.append( " ) X                         																										  \n");
						InsertSql3.append( "	 LEFT JOIN PAYROLL.YCPRSNGC C ON C.EMPNO = X.EMPNO AND C.GIVCOD = X.GIVCOD 			\n");
						InsertSql3.append( "	                             AND X.APPDT = '"+str1+"12'		              	 			\n");
						InsertSql3.append( "  WHERE X.GIVAMT != 0																											        \n");
						InsertSql3.append( "  ORDER BY X.EMPNO, X.GIVCOD, X.CRECORDSEQ																		    \n");

						//logger.dbg.println(this,InsertSql3.toString());

						GauceStatement gsmt5 = conn.getGauceStatement(InsertSql3.toString());
						gsmt5.setGauceDataRow(rows[j]);
						gsmt5.executeUpdate();
						gsmt5.close();


						DeleteSql4 = new StringBuffer();
						DeleteSql4.append( "DELETE FROM PAYROLL.YCG_SUBD														\n");
						DeleteSql4.append( "WHERE APPYY = '"+str1+"'																	\n");

						GauceStatement gsmt6 = conn.getGauceStatement(DeleteSql4.toString());
						gsmt6.setGauceDataRow(rows[j]);
						gsmt6.executeUpdate();
						gsmt6.close();

						InsertSql4 = new StringBuffer();

						InsertSql4.append( " INSERT INTO PAYROLL.YCG_SUBD(																			\n");
						InsertSql4.append( " APPYY, EMPNO, RECORD,  DATA,    SEMU,  SEQ,												\n");
						InsertSql4.append( " BIZNO, JUMINNO,																										\n");
						InsertSql4.append( " DUDGB, GIBUBIZNO, GIBUNM, RELATION,																\n");
						InsertSql4.append( " FOREIGNER, NAME, GIBUZAJUMINNO, GIBUYYCNT,													\n");
						InsertSql4.append( " GIBUYYAMT, DRECORDSEQ, SPACE																				\n");
						InsertSql4.append( "  )																																	\n");	
						InsertSql4.append( " SELECT																															\n"); 									
						InsertSql4.append( " '"+str1+"' AS APPYY,																								\n"); 
						InsertSql4.append( " X.EMPNO,																														\n"); 
						InsertSql4.append( " 'D' AS RECORD,																											\n"); 
						InsertSql4.append( " '27' AS DATA,																											\n"); 
						InsertSql4.append( " '227' AS SEMU,																											\n");	
						InsertSql4.append( " X.SEQ AS  SEQ,																											\n"); 
						InsertSql4.append( " '2218113834' AS BIZNO,																							\n"); 
						InsertSql4.append( " X.RESINO AS JUMINNO,																								\n"); 
						InsertSql4.append( " X.GIVCOD AS DUDGB,																									\n"); 
						InsertSql4.append( " X.GIVSAUP AS GIBUBIZNO,																						\n"); 
						InsertSql4.append( " X.GIVCOMP AS GIBUNM,																								\n"); 
						InsertSql4.append( " X.GIVPRCD AS RELATION,																							\n"); 
						InsertSql4.append( " X.FOREIGNER AS FOREIGNER,																					\n"); 
						InsertSql4.append( " X.GIVPRNM AS NAME,																									\n"); 
						InsertSql4.append( " X.GIVPRNO AS GIBUJUMINNO,																					\n"); 
						InsertSql4.append( " X.GIVCNT AS GIBUYYCNT,																							\n"); 
						InsertSql4.append( " X.GIVAMT AS GIBUYYAMT,																							\n"); 
						InsertSql4.append( " ROW_NUMBER() OVER() AS DRECORDSEQ, '' AS SPACE											\n"); 
						InsertSql4.append( " FROM(																															\n"); 
						InsertSql4.append( "	 SELECT 																														\n"); 
						InsertSql4.append( "	 A.EMPNO, 																													\n"); 
						InsertSql4.append( "	 A.GIVPRNM,																													\n"); 
						InsertSql4.append( "	 ROW_NUMBER() OVER() AS DRECORDSEQ,																	\n");
						InsertSql4.append( "	 C.RESINO,																													\n"); 
						InsertSql4.append( "	 B.SEQ,																															\n");	
						InsertSql4.append( "	 A.GIVPRNO,																													\n"); 
						InsertSql4.append( "	 A.GIVCOD,																													\n"); 
						InsertSql4.append( "	 A.GIVSAUP,																													\n"); 
						InsertSql4.append( "	 A.GIVCOMP,																													\n"); 
						InsertSql4.append( "	 A.GIVPRCD,																													\n"); 
						InsertSql4.append( "	 B.FOREIGNER,																												\n"); 
						InsertSql4.append( "	 SUM(A.GIVCNT1+A.GIVCNT2) AS GIVCNT,																\n"); 
//					InsertSql4.append( " SUM(A.GIVAMT1 + A.GIVAMT2) AS GIVAMT																	\n"); 

						InsertSql4.append( "   CASE WHEN A.GIVCOD = 20 AND (SUM(A.GIVAMT1) >= 100000 OR SUM(A.GIVAMT2) >= 100000) THEN SUM(A.GIVAMT1+A.GIVAMT2)-100000					\n");
						InsertSql4.append( " 	 WHEN A.GIVCOD = 20 AND SUM(A.GIVAMT1) < 100000 AND SUM(A.GIVAMT2) < 100000 THEN 0 ELSE SUM(A.GIVAMT1+A.GIVAMT2) END GIVAMT 			\n");
						
						InsertSql4.append( "   FROM PAYROLL.YCPRSNG A																							 \n"); 
						InsertSql4.append( "   JOIN PAYROLL.YCG_SUBC B ON A.EMPNO = B.EMPNO AND A.GIVCOD = B.DUDGB \n"); 
						InsertSql4.append( "   JOIN PAYROLL.YIPERSON C ON A.EMPNO = C.EMPNO												 \n"); 
						InsertSql4.append( "  WHERE APPDT =  '"+str1+"12'																				 \n"); 
						InsertSql4.append( " GROUP BY A.EMPNO, A.GIVPRNM, C.RESINO,B.SEQ, A.GIVPRNO, A.GIVCOD,	 \n");
						InsertSql4.append( " A.GIVCOD,A.GIVSAUP,A.GIVCOMP,A.GIVPRCD,B.FOREIGNER									 \n");
						InsertSql4.append( " ) X  WHERE X.GIVAMT != 0																						 \n");
						InsertSql4.append( " ORDER BY X.EMPNO, X.DRECORDSEQ																		   \n");

						GauceStatement gsmt7 = conn.getGauceStatement(InsertSql4.toString());
						gsmt7.setGauceDataRow(rows[j]);
						gsmt7.executeUpdate();
						gsmt7.close();

					}
				
				}
			
			}

			catch(Exception e){
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