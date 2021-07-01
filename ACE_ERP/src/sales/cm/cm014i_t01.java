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

public class cm014i_t01 extends HttpServlet{

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

				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");
//				logger.dbg.println(this,"step1");//로그남기는것
				String[] strArrCN = new String[]{
																"VIOL_SID", "CARNO_SID", "WORK_NO", "VIOL_DATE", "VIOL_PLACE", 
																  "VIOL_CONTENT", "BLACK_MARK", "VIOL_FU"
																}; 

				int[] idx = new int[8]; //컬럼갯수를 넣어준다.

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

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO SALES.TCM180 (                                              \n" )
									 .append( "		   CARNO_SID, WORK_NO, VIOL_DATE, VIOL_PLACE, VIOL_CONTENT, BLACK_MARK, VIOL_FU, I_EMPNO, I_DATE		\n" )
									 .append( "	) VALUES (                                                              \n" )
									 .append( "	    ?, ?, ?, ?, ?, ?, ?, " + userid + ", CURRENT TIMESTAMP         \n" )
									 .append( "	)                                                                         " );
						//logger.dbg.println(this,InsertSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idx[1]);
						//logger.dbg.println(this,"1:"+rows[j].getInt(idx[1]));
						gsmt.bindColumn(2,  idx[2]);
						gsmt.bindColumn(3,  idx[3]);
						gsmt.bindColumn(4,  idx[4]);
						gsmt.bindColumn(5,  idx[5]);
						gsmt.bindColumn(6,  idx[6]);
						gsmt.bindColumn(7,  idx[7]);

						gsmt.executeUpdate();
						gsmt.close();

				}

				/*********************************************************************************
				 * UPDATE 처리
				 *********************************************************************************/
				if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					UpdateSql = new StringBuffer();
					UpdateSql.append( " UPDATE SALES.TCM180                                                 \n" )
									 .append("			SET WORK_NO=?, VIOL_DATE=?, VIOL_PLACE=?, VIOL_CONTENT=?, \n" )
									 .append("				BLACK_MARK=?, VIOL_FU=?, U_EMPNO=" + userid + " , U_DATE=CURRENT TIMESTAMP    \n" )
									 .append("	WHERE ACCI_SID="+str1+" 	                                      " );
					//logger.dbg.println(this,UpdateSql.toString());//로그남기는것
					GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

					gsmt.setGauceDataRow(rows[j]);

					gsmt.bindColumn(1,  idx[2]);
					gsmt.bindColumn(2,  idx[3]);
					gsmt.bindColumn(3,  idx[4]);
					gsmt.bindColumn(4,  idx[5]);
					gsmt.bindColumn(5,  idx[6]);
					gsmt.bindColumn(6,  idx[7]);

					gsmt.executeUpdate();
					gsmt.close();	
				}

					/*********************************************************************************
					 * DELETE 처리
					 *********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

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