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

				//�Ķ��Ÿ �޾ƿ��°� ����
				String strUserid = reqGauce.getParameter("v_str1"); //�����

				logger.dbg.println(this,"step1");
				         
				/*********************************************************************************
				 * Insert ó��
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				                                // ����,   ��¥,   ����ȣ  ��ȭ��ȣ ��ȭ����ð�
																				// ��ȭ�ð�, ���
				String[] strArrCN = new String[]{ "PARM0", "PARM1", "PARM2",  "PARM3", "PARM4",
					                                "PARM5", "PARM6"
																			  };
				int[] idx = new int[7]; //�÷������� �־��ش�.

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j<rows.length; j++){
				
				/******************************** **********************************************
				* INSERT ó��
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
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); //�α׳���°�
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
					* Update ó��
					*********************************************************************************/
					/*
					if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
	
						
					}
					*/
					/******************************** **********************************************
					 * DELETE ó��
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
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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
