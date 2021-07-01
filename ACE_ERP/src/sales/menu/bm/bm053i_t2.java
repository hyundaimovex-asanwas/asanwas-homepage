package sales.menu.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class bm053i_t2 extends HttpServlet{

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
				int intTELHIS_SID=0;
				int intUP_SID=0;
				         
				/*********************************************************************************
				 * 통화이력 update
				 *********************************************************************************/
				GauceDataSet userSet1 = reqGauce.getGauceDataSet("USER1");
				                                
				String[] strArrCN = new String[]{ "TELHIS_SID", "UP_SID" , "U_EMPNO"
																			  };
				int[] idx = new int[3]; //컬럼갯수를 넣어준다.

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet1.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet1.getDataRows();

				for (int j = 0; j<rows.length; j++){
				
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
				  /*
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					
					}
					*/
					/******************************** **********************************************
					* Update 처리
					*********************************************************************************/
					if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
						StringBuffer UpdateSql = new StringBuffer();	
					  UpdateSql.append( " UPDATE SALES.TCM080			         \n")
											.append( "   SET UP_SID=?,                 \n")
							        .append( "       U_EMPNO=?,                \n")
							        .append( "       U_DATE=CURRENT TIMESTAMP  \n")
											.append( " WHERE TELHIS_SID=?              \n");

  					GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						rows[j].setString(idx[2],strUserid);
							
						gsmt.bindColumn(1,  idx[1]);
						gsmt.bindColumn(2,  idx[2]);
						gsmt.bindColumn(3,  idx[0]);	
						gsmt.executeUpdate();					
						gsmt.close();		
						
					}
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/
          /*
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						
			   	}
					*/
				}

        GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");
				                             
				String[] strArrCN2 = new String[]{ "PARM8", "PARM7", "PARM9"
																			  };
				int[] idx2 = new int[3]; //컬럼갯수를 넣어준다.

				for (int i=0; i<strArrCN2.length; i++) {
						idx2[i] = userSet2.indexOfColumn(strArrCN2[i]);
				}
				GauceDataRow[] rows2 = userSet2.getDataRows();

				for (int j = 0; j<rows2.length; j++){
				
				/******************************** **********************************************
				* 통화 업로드 update
				*********************************************************************************/
					/*
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					
					}
					*/
					/******************************** **********************************************
					* Update 처리
					*********************************************************************************/
					if (rows2[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
							StringBuffer UpdateSql = new StringBuffer();	
					  UpdateSql.append( " UPDATE SALES.TCM090			\n")
										 .append( "   SET TELHIS_SID=?,     \n")
							       .append( "       U_EMPNO=?,                \n")
							       .append( "       U_DATE=CURRENT TIMESTAMP  \n")
										 .append( " WHERE UP_SID=?         \n");
						
  					GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql.toString());
						gsmt2.setGauceDataRow(rows2[j]);

						rows2[j].setString(idx2[2],strUserid);
							
						gsmt2.bindColumn(1,  idx2[1]);	
						gsmt2.bindColumn(2,  idx2[2]);	
						gsmt2.bindColumn(3,  idx2[0]);	

						gsmt2.executeUpdate();					
						gsmt2.close();		
						
					}
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
