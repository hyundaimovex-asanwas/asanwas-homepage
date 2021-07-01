//**�������. delete,update�Ҷ��� where�� ���Ŀ� primary key �÷��� �� �߰��ؼ� ���ش�***
package sales.menu.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class Em022_T2 extends HttpServlet{

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

				String useid = reqGauce.getParameter("v_str1");//�Ķ��Ÿ �޾ƿ��°� ����
				
				/******************************** **********************************************
				 * Insert ó��
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
//				logger.dbg.println(this,"step1");//�α׳���°�
				
				String[] strArrCN = new String[]{
																					"EMPNO", "DAV_DT", "CUST_SID", "VEND_CD","DEPT_CD",
																					"TEAM_CD","WORK_CD","PAY_YM","PAY_AMT","REMARK",
																					"I_EMPNO","U_EMPNO","I_DATE", "U_DATE"
																			}; //14


				int[] idx = new int[14]; //�÷������� �־��ش�.

        for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){
/******************************** **********************************************
* INSERT ó��
*********************************************************************************/   

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

							rows[j].setString(idx[10],useid);
							rows[j].setString(idx[11],useid);

						 InsertSql = new StringBuffer();
		         InsertSql.append( " INSERT INTO SALES.TCM440                       \n" )
											.append( " (EMPNO,DAV_DT,CUST_SID,VEND_CD,DEPT_CD,        \n" )//PK EMPNO
											.append( " TEAM_CD,WORK_CD,PAY_YM,PAY_AMT,REMARK,         \n" )
											.append( " I_EMPNO,U_EMPNO,I_DATE,U_DATE)                 \n" )
											.append( " VALUES																					\n" )
											.append( " (?,?,?,?,?,																		\n" )
											.append( " ?,?,?,?,?,																			\n" )
											.append( " ?,?,CURRENT TIMESTAMP,CURRENT TIMESTAMP)       \n" );
					 
                    GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
                    gsmt.setGauceDataRow(rows[j]);

                      gsmt.bindColumn(1, idx[0]);
                      gsmt.bindColumn(2, idx[1]);
                      gsmt.bindColumn(3, idx[2]);
                      gsmt.bindColumn(4, idx[3]);
                      gsmt.bindColumn(5, idx[4]);
                      gsmt.bindColumn(6, idx[5]);
                      gsmt.bindColumn(7, idx[6]);
                      gsmt.bindColumn(8, idx[7]);
                      gsmt.bindColumn(9, idx[8]);
                      gsmt.bindColumn(10,idx[9]);
                      gsmt.bindColumn(11,idx[10]);
                      gsmt.bindColumn(12,idx[11]);

                    gsmt.executeUpdate();
                    gsmt.close();
					}
/******************************************************************************
* Update ó��
*********************************************************************************/

         		if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						rows[j].setString(idx[11],useid);//�����ͼ� setString���� ��������

						 UpdateSql = new StringBuffer();
						 UpdateSql.append( " UPDATE SALES.TCM440      \n")
											.append( " SET                      \n")
											.append( " VEND_CD=?,               \n")
											.append( " DEPT_CD=?,               \n")
											.append( " TEAM_CD=?,               \n")
											.append( " WORK_CD=?,               \n")
											.append( " PAY_YM=?,                \n")
											.append( " PAY_AMT=?,               \n")
											.append( " REMARK=?,                \n")
											.append( " U_EMPNO=?,               \n")
											.append( " U_DATE=CURRENT TIMESTAMP \n")
											.append( " WHERE EMPNO=?            \n")
											.append( " AND DAV_DT=?             \n");

											GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());

											gsmt.setGauceDataRow(rows[j]);

												gsmt.bindColumn(1,  idx[3]);
												gsmt.bindColumn(2,  idx[4]);
												gsmt.bindColumn(3,  idx[5]);
												gsmt.bindColumn(4,  idx[6]);
												gsmt.bindColumn(5,  idx[7]);
												gsmt.bindColumn(6,  idx[8]);
												gsmt.bindColumn(7,  idx[9]);
												gsmt.bindColumn(8,  idx[11]);
												gsmt.bindColumn(9,  idx[0]);
												gsmt.bindColumn(10, idx[1]);

											gsmt.executeUpdate();
											gsmt.close();
					}
/******************************************************************************
* DELETE ó��
*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

						  DeleteSql = new StringBuffer();
							DeleteSql.append( " DELETE  FROM SALES.TCM440		\n")
											 .append( "	WHERE EMPNO=?								\n")
                       .append( " AND DAV_DT=?                \n");
							GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());

							gsmt.setGauceDataRow(rows[j]);

								gsmt.bindColumn(1, idx[0]);
								gsmt.bindColumn(2, idx[1]);

							gsmt.executeUpdate();
							gsmt.close();
					}
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
