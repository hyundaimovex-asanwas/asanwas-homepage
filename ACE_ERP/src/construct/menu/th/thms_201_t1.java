package THMS;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class thms_201_t1 extends HttpServlet{

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
			
				String[] strArrCN = new String[]{  
																"COOP_NM",		"COOP_VGB",

																"COOP_DIRECT",		"COOP_CERT",

																"ADDRESS",		"COOP_STYLE",		"CREAT_DT",

																"VD_TELNO",		"VD_FAXNO"
                         					                               	
																			  };
																			  
				int[] idx = new int[9]; //컬럼갯수를 넣어준다.
				
				logger.dbg.println(this,"뭥미?");//로그남기는것

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();					
		
				for (int j = 0; j < rows.length; j++){

/******************************************************************************
* Update 처리
*********************************************************************************/
    
        	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

				logger.dbg.println(this,"뭥미?");//로그남기는것

						StringBuffer UpdateSql = new StringBuffer();			

								UpdateSql.append( " UPDATE THMS.THMS020									\n")
												.append( " SET																	\n")
												.append( " COOP_NM = ?,													\n")
												.append( " COOP_VGB = ?,												\n")
												.append( " COOP_DIRECT = ?,											\n")
												.append( " COOP_CERT = ?,												\n")
												.append( " ADDRESS = ?,													\n")
												.append( " COOP_STYLE = ?,												\n")	
												.append( " CREAT_DT = ?,													\n")
												.append( " VD_TELNO = ?,													\n")
												.append( " VD_FAXNO = ?,															\n")				
												.append( " U_DATE=CURRENT TIMESTAMP												\n")
												.append( " WHERE COOP_CD ='"+rows[j].getString(idx[1])+"'					\n")



						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						
						logger.dbg.println(this,UpdateSql.toString());//로그남기는것

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