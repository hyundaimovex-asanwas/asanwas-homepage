package THMS;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class thms_204_t1 extends HttpServlet{

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

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/

				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String[] strArrCN = new String[]{    "COOP_CD",	"COOP_NM",		"COOP_YYMM",
					
																	"COOP_CERT",		"COOP_DIRECT",		
																		
																	"ADDRESS",		"COOP_STYLE",		"CREAT_DT",		
	
																	"LICENSE1",		"CON_CAPA1",		
																		
																	"LICENSE2",		"CON_CAPA2",		
																		
																	"LICENSE3",		"CON_CAPA3",	

																	"DEBT_2008", 		"DEBT_2009",		"DEBT_2010",		"DEBT_2011",		

																	"CASH_2008", 		"CASH_2009",		"CASH_2010",		"CASH_2011",		

																	"CREDIT_2008", 	"CREDIT_2009",	"CREDIT_2010",	"CREDIT_2011",						
	
																	"DEFAULT", 			"PATENT",															
																		
																	"VD_TELNO",		"VD_FAXNO",	"REMARK",				

																	"I_EMPNO",		"I_DATE",		"U_EMPNO",		"U_DATE"
                         					                               	
																			  };
																			  
				int[] idx = new int[35]; //컬럼갯수를 넣어준다.
				
				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();					
		
				for (int j = 0; j < rows.length; j++){


/******************************** **********************************************
* INSERT 처리
*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
		
						StringBuffer InsertSql = new StringBuffer();
									
						InsertSql.append( " INSERT INTO THMS.THMS020														\n" )
									.append( " ( COOP_NM, COOP_CERT,COOP_DIRECT,										\n" )
									.append( " ADDRESS,COOP_STYLE,CREAT_DT,												\n" )//6
									.append( " LICENSE1,CON_CAPA1,																\n" )
									.append( " LICENSE2,CON_CAPA2,																\n" )
									.append( " LICENSE3,CON_CAPA3,																\n" )//12
									.append( " DEBT_2008,DEBT_2009,DEBT_2010,DEBT_2011,							\n" )//16
									.append( " CASH_2008,CASH_2009,CASH_2010,CASH_2011,						\n" )//20
									.append( " CREDIT_2008,CREDIT_2009,CREDIT_2010,CREDIT_2011,			\n" )//24
									.append( " DEFAULT,PATENT,																			\n" )
									.append( " VD_TELNO,VD_FAXNO,REMARK,													\n" )//29
									.append( " I_EMPNO,I_DATE,U_EMPNO,U_DATE )											\n" )//33
									.append( "  VALUES																						\n" )
									.append( " ( ?,?,?,?,?,																					\n" )
									.append( " ?,?,?,?,?,																						\n" )
									.append( " ?,?,?,?,?,																						\n" )
									.append( " ?,?,?,?,?,																						\n" )
									.append( " ?,?,?,?,?,																						\n" )
									.append( " ?,?,?,?,																							\n" )	//29									
									.append( " ?,CURRENT TIMESTAMP,?,CURRENT TIMESTAMP)							\n" );//31
						
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); //로그남기는것
						
						gsmt.setGauceDataRow(rows[j]);						

/*
						logger.dbg.println(this,InsertSql.toString());//로그남기는것
						logger.dbg.println(this,"HOL_DT,					rows[j].getString(idx[0])::"+rows[j].getString(idx[0]));         
						logger.dbg.println(this,"EMPNO,					rows[j].getString(idx[1])::"+rows[j].getString(idx[1]));         	
						logger.dbg.println(this,"DAY_CD,               	rows[j].getString(idx[2])::"+rows[j].getString(idx[2]));         
						logger.dbg.println(this,"DEPT_CD,				rows[j].getString(idx[3])::"+rows[j].getString(idx[3]));         
						logger.dbg.println(this,"HOL_GB,          		rows[j].getString(idx[4])::"+rows[j].getString(idx[4]));         
						logger.dbg.println(this,"I_EMPNO,				rows[j].getString(idx[5])::"+rows[j].getString(idx[5]));         
						logger.dbg.println(this,"U_EMPNO,          	rows[j].getString(idx[7])::"+rows[j].getString(idx[7]));         
*/

						gsmt.bindColumn(1,  idx[0]);
						gsmt.bindColumn(2,  idx[1]);
						gsmt.bindColumn(3,  idx[2]);
						gsmt.bindColumn(4,  idx[3]);
						gsmt.bindColumn(5,  idx[4]);
						gsmt.bindColumn(6,  idx[5]);
						gsmt.bindColumn(7,  idx[6]);
						gsmt.bindColumn(8,  idx[7]);
						gsmt.bindColumn(9,  idx[8]);
						gsmt.bindColumn(10,  idx[9]);
						gsmt.bindColumn(11,  idx[10]);
						gsmt.bindColumn(12,  idx[11]);
						gsmt.bindColumn(13,  idx[12]);
						gsmt.bindColumn(14,  idx[13]);
						gsmt.bindColumn(15,  idx[14]);
						gsmt.bindColumn(16,  idx[15]);
						gsmt.bindColumn(17,  idx[16]);
						gsmt.bindColumn(18,  idx[17]);
						gsmt.bindColumn(19,  idx[18]);
						gsmt.bindColumn(20,  idx[19]);
						gsmt.bindColumn(21,  idx[20]);
						gsmt.bindColumn(22,  idx[21]);
						gsmt.bindColumn(23,  idx[22]);
						gsmt.bindColumn(24,  idx[23]);
						gsmt.bindColumn(25,  idx[24]);
						gsmt.bindColumn(26,  idx[25]);
						gsmt.bindColumn(27,  idx[26]);
						gsmt.bindColumn(28,  idx[27]);
						gsmt.bindColumn(29,  idx[28]);
						gsmt.bindColumn(30,  idx[29]);
						gsmt.bindColumn(31,  idx[31]);
						
						gsmt.executeUpdate();						
						gsmt.close();							

					}


/******************************************************************************
* Update 처리
*********************************************************************************/
    
        	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						StringBuffer UpdateSql = new StringBuffer();			

								UpdateSql.append( " UPDATE THMS.THMS020														\n")
												.append( " SET																						\n")
												.append( " COOP_NM = ?,																		\n")
												.append( " COOP_CERT= ?,																	\n")		
												.append( " COOP_DIRECT= ?,																\n")			
												.append( " ADDRESS= ?,																		\n")		
												.append( " COOP_STYLE= ?,																	\n")		
												.append( " CREAT_DT= ?,																		\n")		
												.append( " LICENSE1= ?,																		\n")		
												.append( " CON_CAPA1= ?,																	\n")		
												.append( " LICENSE2= ?,																		\n")		
												.append( " CON_CAPA2= ?,																	\n")		//10
												.append( " LICENSE3= ?,																		\n")		
												.append( " CON_CAPA3= ?,																	\n")	
												.append( " DEBT_2008= ?,																	\n") 		
												.append( " DEBT_2009= ?,																	\n")		
												.append( " DEBT_2010= ?,																	\n")		
												.append( " DEBT_2011= ?,																	\n")		
												.append( " CASH_2008= ?,																	\n") 		
												.append( " CASH_2009= ?,																	\n")		
												.append( " CASH_2010= ?,																	\n")		
												.append( " CASH_2011= ?,																	\n")		//20
												.append( " CREDIT_2008= ?,																	\n") 	
												.append( " CREDIT_2009= ?,																	\n")	
												.append( " CREDIT_2010= ?,																	\n")	
												.append( " CREDIT_2011= ?,																	\n")							
												.append( " DEFAULT= ?,																		\n") 			
												.append( " PATENT= ?,																			\n")															
												.append( " VD_TELNO= ?,																		\n")		
												.append( " VD_FAXNO= ?,																		\n")	
												.append( " REMARK= ?,																			\n")																
												.append( " I_EMPNO= ?,																		\n")		//30
												.append( " I_DATE= CURRENT TIMESTAMP	,											\n")		
												.append( " U_EMPNO= ?,																		\n")		//31			
												.append( " U_DATE=CURRENT TIMESTAMP												\n")
												.append( " WHERE COOP_CD ='"+rows[j].getString(idx[1])+"'				\n")



						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						//logger.dbg.println(this,UpdateSql.toString());//로그남기는것

						gsmt.setGauceDataRow(rows[j]);
											
						gsmt.bindColumn(1,  idx[0]);
						gsmt.bindColumn(2,  idx[1]);
						gsmt.bindColumn(3,  idx[2]);
						gsmt.bindColumn(4,  idx[3]);
						gsmt.bindColumn(5,  idx[4]);
						gsmt.bindColumn(6,  idx[5]);
						gsmt.bindColumn(7,  idx[6]);
						gsmt.bindColumn(8,  idx[7]);
						gsmt.bindColumn(9,  idx[8]);
						gsmt.bindColumn(10,  idx[9]);
						gsmt.bindColumn(11,  idx[10]);
						gsmt.bindColumn(12,  idx[11]);
						gsmt.bindColumn(13,  idx[12]);
						gsmt.bindColumn(14,  idx[13]);
						gsmt.bindColumn(15,  idx[14]);
						gsmt.bindColumn(16,  idx[15]);
						gsmt.bindColumn(17,  idx[16]);
						gsmt.bindColumn(18,  idx[17]);
						gsmt.bindColumn(19,  idx[18]);
						gsmt.bindColumn(20,  idx[19]);
						gsmt.bindColumn(21,  idx[20]);
						gsmt.bindColumn(22,  idx[21]);
						gsmt.bindColumn(23,  idx[22]);
						gsmt.bindColumn(24,  idx[23]);
						gsmt.bindColumn(25,  idx[24]);
						gsmt.bindColumn(26,  idx[25]);
						gsmt.bindColumn(27,  idx[26]);
						gsmt.bindColumn(28,  idx[27]);
						gsmt.bindColumn(29,  idx[28]);
						gsmt.bindColumn(30,  idx[29]);

						gsmt.executeUpdate();					
						gsmt.close();									

					}

				}


/**********************************************************************************************

**********************************************************************************************/


			}
			catch(Exception e){
				logger.err.println(this,e);
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