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

public class bm053i_t1 extends HttpServlet{

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
				conn.setAutoCommit(false);

				//파라메타 받아오는것 선언
				String strUserid = reqGauce.getParameter("v_str1"); //사용자

				logger.dbg.println(this,"step1");
				         
				/*********************************************************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				                                // 순서,   날짜,   사용번호  전화번호 통화종료시간
																				// 통화시간, 요금
				String[] strArrCN = new String[]{ "PARM0", "PARM1", "PARM2",  "PARM3", "PARM4",
					                                "PARM5", "PARM6"
																			  };
				int[] idx = new int[7]; //컬럼갯수를 넣어준다.

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j<rows.length; j++){
				
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					 StringBuffer InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO SALES.TCM090                             \n" )
										 .append( " ( UP_DATE,  UP_NUM,   TEL_NUM,  END_TIME,  TEL_DURA, \n" )
										 .append( "   TEL_FEE,  I_EMPNO,  I_DATE,   U_EMPNO,   U_DATE )   \n" )
										 .append( "  VALUES                                              \n" )
										 .append( " ( ?,?,?,?,?,                                         \n" )
										 .append( "   ?,'"+strUserid+"',CURRENT TIMESTAMP,'"+strUserid+"',CURRENT TIMESTAMP )   \n" );
						logger.dbg.println(this,"InsertSql::"+InsertSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); //로그남기는것
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1, idx[1]);
						gsmt.bindColumn(2, idx[2]);
						gsmt.bindColumn(3, idx[3]);
						gsmt.bindColumn(4, idx[4]);
						gsmt.bindColumn(5, idx[5]);
						gsmt.bindColumn(6, idx[6]);

						gsmt.executeUpdate();
						gsmt.close();
					
					}
					/******************************** **********************************************
					* Update 처리
					*********************************************************************************/
					/*
					if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
	
						
					}
					*/
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/
          /*
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

						
			   	}
					*/
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
