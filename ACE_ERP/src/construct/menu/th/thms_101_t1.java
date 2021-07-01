package THMS;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class thms_101_t1 extends HttpServlet{

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

						logger.dbg.println(this,"�o��??");//�α׳���°�
/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/

				// ������������ ���ǰ��� �Ѱܹ���
				String  str1 = reqGauce.getParameter("v_str1");   //  ��������� ���������� ����
						logger.dbg.println(this,"�o��??");//�α׳���°�
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String[] strArrCN = new String[]{  								
										
															"SITE_CD","SITE_NM",		
																
															"CNST_CD","CNST_NM",

															"T_DAY","ORDER_NM",

															"START_DT","END_DT","ACT_AMT",

															"START_DT_HA","END_DT_HA","ACT_AMT_HA"

																	};
																			  
				int[] idx = new int[12]; //�÷������� �־��ش�.
						logger.dbg.println(this,"�o��??");//�α׳���°�				

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();					

				for (int j = 0; j < rows.length; j++){


/******************************************************************************
** INSERT ó��
*********************************************************************************/
    
        	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_INSERT) {


						StringBuffer InsertSql = new StringBuffer();			

								InsertSql.append( " INSERT INTO THMS.THMS010(                                                 \n")		
											 .append( "SITE_CD, SITE_NM, CNST_CD, CNST_NM,									\n" )	
											 .append( "T_DAY, ORDER_NM,																	\n" )	
											 .append( "START_DT, END_DT, ACT_AMT,													\n" )	
											 .append( "START_DT_HA, END_DT_HA, ACT_AMT_HA)								\n" )	
											 .append( " VALUES																					\n" )
											 .append( " (?,?,?,?,?,?,?,?,?,?,?,?)																\n" );//2

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());			
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

						logger.dbg.println(this,InsertSql.toString());//�α׳���°�

						gsmt.executeUpdate();					
						gsmt.close();									

					}


/******************************************************************************
* Update ó��
*********************************************************************************/
    
        	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						StringBuffer UpdateSql = new StringBuffer();			

						//logger.dbg.println(this,UpdateSql.toString());//�α׳���°�

						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql.toString());
						gsmt2.setGauceDataRow(rows[j]);

						gsmt2.executeUpdate();					
						gsmt2.close();									

					}
				

/**********************************************************************************************

**********************************************************************************************/
				}

			}
			catch(Exception e){
				logger.err.println(this,e);
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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