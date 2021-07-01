// * ������������ : ���¾�ü���� (����,������Ʈ)
package sales.bm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class bm065i_t01 extends HttpServlet{

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
 
				String  str1	= reqGauce.getParameter("v_str1"); //�ŷ�ó�ڵ�

				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");

				String[] strArrCN = new String[]{ 
													"CLIENT_SID",		"LOCAL_MGR",		"LOCAL_STAFF",		"LOCAL_TEL",		"LOCAL_FAX"
														};

				int[] idx = new int[5]; //�÷������� �־��ش�.
        
        for (int i=0; i<strArrCN.length; i++) idx[i] = userSet.indexOfColumn(strArrCN[i]);

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
					/******************************** **********************************************
					 * Insert ó��
					 *********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
					}
					/******************************** **********************************************
					 * Update ó��
					 *********************************************************************************/
	         	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
						StringBuffer UpdateSql = new StringBuffer();

						UpdateSql.append( " UPDATE SALES.TCU030																				\n")
										 .append( "		 SET LOCAL_MGR=?, LOCAL_STAFF=?, LOCAL_TEL=?, LOCAL_FAX=?,	\n")
										 .append( "         U_EMPNO=" + str1 + ", U_DATE=CURRENT TIMESTAMP						\n")
										 .append( "	WHERE CLIENT_SID=?																				" );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idx[1]); 
						gsmt.bindColumn(2,  idx[2]); 
						gsmt.bindColumn(3,  idx[3]); 
						gsmt.bindColumn(4,  idx[4]);
						gsmt.bindColumn(5,  idx[0]);
						//logger.dbg.println(this,"5:"+rows[j].getString(idx[16]));
						//logger.dbg.println(this,"6:"+rows[j].getInt(idx[0]));
						//logger.dbg.println(this,UpdateSql.toString());//�α׳���°�
						gsmt.executeUpdate();
						gsmt.close();

					}

				}
			}
			catch(Exception e){
				logger.err.println(this,e.getMessage());	
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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