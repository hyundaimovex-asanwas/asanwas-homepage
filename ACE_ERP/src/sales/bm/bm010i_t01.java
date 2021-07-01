// * 개인정보관리 : 개인정보관리 (저장,업데이트)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class bm010i_t01 extends HttpServlet{

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
 
				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");
				
				String[] strArrCN = new String[]{
/*														"TEAM_CD"  ,"DETAIL_NM"      ,"CUST_SID"      ,"CUST_NM"    ,"MANAGE_NO" ,
														"SEX"      ,"SEX_NAME"       ,"LAST_NM"       ,"FIRST_NM"   ,"WORK_NO"   ,
														"BIRTHDAY" , "CUST_GU"       ,"SAUP_GU_NAME"  ,"REGI_NO"    ,"COUNTRY_GU",
														"SAUP_GU"  ,"CUST_TYPE"      ,"CUST_TYPE_NAME","ZIP_CD"     ,"ZIP_NAME"  ,
														"ADDRESS1" ,"ADDRESS2"       ,"TEL_NO"        ,"MOBILE_NO"  ,"COMPANY_NM",
														"POSITIONS","COUNTRY_GU_NAME","NATION_CD"     ,"NATION_NAME","VEND_SID"   ,
														"VEND_NM"  ,"ORDER_DATE"     ,"WORK_PLACE"    , "I_EMPNO"   ,"U_EMPNO",
														"REAL_VEND"	 .*/
														"CUST_SID",		"TEAM_CD",		"ORDER_DATE",		"WORK_PLACE",		"U_EMPNO"
														};

				int[] idx = new int[5]; //컬럼갯수를 넣어준다.

        for (int i=0; i<strArrCN.length; i++) idx[i] = userSet.indexOfColumn(strArrCN[i]);

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){

					/******************************** **********************************************
					 * Insert 처리
					 *********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
/*
						StringBuffer InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO SALES.TCM010 (                                     \n" )
										 .append( "			TEAM_CD, CUST_SID, WORK_NO, VEND_SID, ORDER_DATE, WORK_PLACE,	       \n" )
										 .append( "			I_EMPNO,U_EMPNO, REAL_VEND                  \n" )
										 .append( "	) VALUES (                                                     \n" )
										 .append( "	?, ?, ?, ?, ?, ?,                                                     \n" )
										 .append( "	?, ?, ?                                                            \n" )
										 .append( "	)                                                                 ");

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
           
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1,  idx[0]);
						gsmt.bindColumn(2,  idx[2]);
						gsmt.bindColumn(3,  idx[9]);
						gsmt.bindColumn(4,  idx[29]);
						gsmt.bindColumn(5,  idx[31]);
						gsmt.bindColumn(6,  idx[32]);
						gsmt.bindColumn(7,  idx[33]);
						gsmt.bindColumn(8,  idx[34]);
						gsmt.bindColumn(9,  idx[35]);

						//logger.dbg.println(this,InsertSql.toString());

						gsmt.executeUpdate();
						gsmt.close();
*/
					}
					/******************************** **********************************************
					 * Update 처리
					 *********************************************************************************/

         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
						StringBuffer UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE SALES.TCM010																				\n" )
										 .append( "		 SET TEAM_CD =?, ORDER_DATE=?, WORK_PLACE=?,U_EMPNO=?		\n" )
										 .append( "	WHERE CUST_SID=?																					" );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

						//logger.dbg.println(this,UpdateSql.toString());//로그남기는것
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idx[1]);
						gsmt.bindColumn(2,  idx[2]);
						gsmt.bindColumn(3,  idx[3]);
						gsmt.bindColumn(4,  idx[4]);
						gsmt.bindColumn(5,  idx[0]);

						gsmt.executeUpdate();
						gsmt.close();
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