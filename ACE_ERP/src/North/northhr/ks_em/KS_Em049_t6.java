//**참고사항. delete,update할떼는 where절 이후에 primary key 컬럼을 꼭 추가해서 써준다***
package North.northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
//import java.util.*;

public class KS_Em049_t6 extends HttpServlet{

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
				conn.setAutoCommit(false);

				//파라메타 받아오는것 선언
				/*******************************************************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String strPaycd="";
				String strMemo="";


				//파라메타 받아오는것 선언
				String usrid = reqGauce.getParameter("v_str1");
			
				String[] strArrCN = new String[]{ "PAY_YM","PAY_GB","EMPNO"                         
																			  };

				int[] idx = new int[3]; //컬럼갯수를 넣어준다.

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){

				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					 /*+++++++++++++++++++++++++++++++++++++++++++++++ 
							급여계산작업 시작 : 보조금 계산
					  +++++++++++++++++++++++++++++++++++++++++++++++*/


						for(int k=1;k<=1;k++) { 

							 if (k==1){
								 strPaycd ="005"; 
								 strMemo="보조금 계산중";  //기본급
							 }

							 StringBuffer InsertSql_2 = new StringBuffer();
						
							 InsertSql_2.append("  INSERT INTO ATP.KST299 (													\n" )
													.append("   APPDT,	PAYDIV,	 PAYDT,	  PBDIV,	PAYCD,					\n" )
													.append("    FRDT,	FRTM,	    TODT, 	 TOTM, 	WRKSTS,			\n" )
													.append("    MEMO,  I_EMPNO,I_DATE,	U_EMPNO,	U_DATE			\n" )
													.append("  ) VALUES (																\n" )
													.append("  '"+rows[j].getString(idx[0])+"',										\n" )
													.append("  '"+rows[j].getString(idx[1])+"',										\n" )
													.append("  '','1',																		\n" )
													.append("  '"+strPaycd+"',															\n" )
													.append("   '','',																		\n" )													
													//.append("   REPLACE(CHAR(CURRENT DATE ,ISO),'-',''),				\n" )
													//.append("   REPLACE(REPLACE(CHAR(CURRENT TIME ,ISO),'.',''),':',''),  \n" )
													.append("   '','',																		\n" )
													.append("   '1',																		\n" ) //진행중
													.append("   '"+strMemo+"',															\n" )
													.append("  '"+rows[j].getString(idx[2])+"', sysdate,						\n" )
													.append("  '"+rows[j].getString(idx[2])+"', sysdate) 						\n" );		
							
							GauceStatement gsmt_2 = conn.getGauceStatement(InsertSql_2.toString()); 
							gsmt_2.setGauceDataRow(rows[j]);

							gsmt_2.executeUpdate();
							gsmt_2.close();

						}


		           /*+++++++++++++++++++++++++++++++++++++++++++++++ 
						보조금 계산 : 보조휴가 * 일로임 * 0.6
					+++++++++++++++++++++++++++++++++++++++++++++++*/

						StringBuffer InsertSql = new StringBuffer();

						InsertSql.append("  UPDATE ATP.KST200 SET																\n" )
						 				.append("         SUB_PAY  = ROUND((HOL_2*D_PAY*0.6),4)	 						\n" )		
										.append( "	 WHERE PAY_YM=?																	\n" )
				  						.append( "    AND PAY_GB=?																		\n" );

						GauceStatement gsmt_1 = conn.getGauceStatement(InsertSql.toString()); //로그남기는것
						gsmt_1.setGauceDataRow(rows[j]);

						gsmt_1.bindColumn(1, idx[0]);
						gsmt_1.bindColumn(2, idx[1]);

						gsmt_1.executeUpdate();
						gsmt_1.close();
						

				    /*+++++++++++++++++++++++++++++++++++++++++++++++ 
						급여계산작업 종료 : 						보조금 계산
					+++++++++++++++++++++++++++++++++++++++++++++++*/

						for(int m=1;m<=1;m++) { 

							 strPaycd="";

							 if (m==1){ 
								 strPaycd ="005"; 
								 strMemo="보조금 계산완료";  //기본급
							 }

							StringBuffer UpdateSql = new StringBuffer();			

							UpdateSql.append( " UPDATE ATP.KST299														\n")
												.append( " SET																		\n")
												.append("  WRKSTS='2',															\n")												
												//.append( " TODT=REPLACE(CHAR(CURRENT DATE ,ISO),'-',''), \n")
												//.append( " TOTM=REPLACE(REPLACE(CHAR(CURRENT TIME ,ISO),'.',''),':',''),  WRKSTS='2',   \n")
												.append("  MEMO = '"+strMemo+"', 												\n")
												.append( " U_DATE=sysdate 														\n")
												.append( " WHERE APPDT='"+rows[j].getString(idx[0])+"'				\n")
												.append( "   AND PAYDIV='"+rows[j].getString(idx[1])+"' 					\n")
												.append( "   AND PAYCD='"+strPaycd+"'       								\n");

							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);
								
							gsmt.executeUpdate();					
							gsmt.close();									

					  }
				
					}

					
						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/
            
						if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

           
						}
					
						/******************************** **********************************************
						 * DELETE 처리
						 *********************************************************************************/
	         
						if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
	            
	
						}
				}
			}
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,e.getMessage());	
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			conn.commit();
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
