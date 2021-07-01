package sales.menu.cm;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class cm016i_t01 extends HttpServlet{

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
				//�Ķ��Ÿ �޾ƿ��°� ����
				String str1 = reqGauce.getParameter("v_str1"); 
				String  userid = reqGauce.getParameter("v_str2");

				GauceDataSet userSet = reqGauce.getGauceDataSet("DATA");
//				logger.dbg.println(this,"step1");//�α׳���°�
				String[] strArrCN = new String[]{
													"INSU_SID",	"CARNO_SID",	"INSU_SDATE",	"INSU_EDATE",	"INSU_AMT"
													};

				int[] idx = new int[5]; //�÷������� �־��ش�.

              for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
//					logger.dbg.println(this, "i:::" +i+"::::"+idx[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;

				for (int j = 0; j < rows.length; j++){
				/******************************** **********************************************
				* INSERT ó��
				*********************************************************************************/   
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO SALES.TCM200 (																		\n" )
									 .append( "		   CARNO_SID, INSU_SDATE, INSU_EDATE, INSU_AMT, I_EMPNO, I_DATE	\n" )
									 .append( "	) VALUES (																									\n" )
									 .append( "	    ?, ?, ?, ?, " + userid + ", CURRENT TIMESTAMP											\n" )
									 .append( "	)																													" );
						//logger.dbg.println(this,InsertSql.toString());
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());

						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idx[1]);
						//logger.dbg.println(this,"1:"+rows[j].getInt(idx[1]));
						gsmt.bindColumn(2,  idx[2]);
						gsmt.bindColumn(3,  idx[3]);
						gsmt.bindColumn(4,  idx[4]);

						gsmt.executeUpdate();
						gsmt.close();

				}

				/*********************************************************************************
				 * UPDATE ó��
				 *********************************************************************************/
				if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					UpdateSql = new StringBuffer();
					UpdateSql.append( " UPDATE SALES.TCM200																		\n" )
									 .append("			SET INSU_SDATE=?, INSU_EDATE=?, INSU_AMT=?,						\n" )
									 .append("				   U_EMPNO=" + userid + " , U_DATE=CURRENT TIMESTAMP		\n" )
									 .append("	WHERE INSU_SID="+str1+"																		" );
					//logger.dbg.println(this,UpdateSql.toString());//�α׳���°�
					GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

					gsmt.setGauceDataRow(rows[j]);

					gsmt.bindColumn(1,  idx[2]);
					gsmt.bindColumn(2,  idx[3]);
					gsmt.bindColumn(3,  idx[4]);

					gsmt.executeUpdate();
					gsmt.close();	
				}

					/*********************************************************************************
					 * DELETE ó��
					 *********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

					}


				}	//for loop ��
			}	//try ��
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