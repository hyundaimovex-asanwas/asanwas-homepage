//**�������. delete,update�Ҷ��� where�� ���Ŀ� primary key �÷��� �� �߰��ؼ� ���ش�***
package sales.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class Em010_T3 extends HttpServlet{

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
				String strEmpno = reqGauce.getParameter("v_str1");
				String useid = reqGauce.getParameter("v_str2");

				/******************************** **********************************************
				 * Insert ó��
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				String[] strArrCN = new String[]{
																					
																					"EMPNO",//PK
																					"SEQ",
																					"FAMI_NM",
																					"BIRTHDAY",
																					"JOB_NM",
																					"REF_CD",
																					"REMARK",
																					"I_EMPNO",
																					"U_EMPNO",
																					"I_DATE",//10
																					"U_DATE"
																					}; 

				int[] idx = new int[11]; //�÷������� �־��ش�.

        for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
					}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				/******************************** **********************************************
				* INSERT ó��
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					logger.dbg.println(this,"step_INSERT1");//�α׳���°�

					StringBuffer sql = new StringBuffer();

					Statement stmt= null;
					ResultSet rs = null;
					String v_date = "";
					int strSeq = 0;

					 sql.append( "SELECT IFNULL(MAX(SEQ),0)+1 AS SEQ \n" )
							.append( "FROM SALES.TCM315                  \n" )
							.append( "WHERE EMPNO ='"+strEmpno+"'        \n" );

					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql.toString());

					while (rs.next())	{
						v_date = rs.getString(1);
					}
					rs.close();
					stmt.close();

					strSeq = Integer.parseInt(v_date);

					rows[j].setString(idx[0],strEmpno);//�����ͼ� strEmpno ��������
					rows[j].setInt(idx[1],strSeq);//�����ͼ� strSeq ��������
					rows[j].setString(idx[7],useid);
					rows[j].setString(idx[8],useid);


						StringBuffer InsertSql = new StringBuffer();
		         InsertSql.append( " INSERT INTO SALES.TCM315												\n" )
											.append( " (EMPNO,	SEQ,	FAMI_NM,	BIRTHDAY,	JOB_NM,     \n" )
											.append( "  REF_CD,	REMARK,	I_EMPNO,	U_EMPNO,	I_DATE,	  \n" )
											.append( "  U_DATE)																			  \n" )
											.append( " VALUES																					\n" )
											.append( " (?,?,?,?,?,																		\n" )
											.append( "  ?,?,?,?,CURRENT TIMESTAMP,										\n" )
											.append( "  CURRENT TIMESTAMP)														\n" );

					 
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());//�α׳���°�
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

            logger.dbg.println(this,InsertSql.toString());//�α׳���°�
            logger.dbg.println(this,"TEST_INSERT");//�α׳���°�

						gsmt.executeUpdate();
						gsmt.close();
					}
						/******************************** **********************************************
						* Update ó��
						*********************************************************************************/

         			if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
	
						logger.dbg.println(this,"step_UPDATE");//�α׳���°�

						StringBuffer UpdateSql = new StringBuffer();

						 UpdateSql.append( " UPDATE SALES.TCM315				\n")
											.append( " SET												\n")
											.append( " FAMI_NM=?,									\n")	
											.append( " BIRTHDAY=?,								\n")	
											.append( " JOB_NM=?,									\n")	
											.append( " REF_CD=?,									\n")	
											.append( " REMARK=?,									\n")	
											.append( " U_EMPNO=?,									\n")	
											.append( " U_DATE=CURRENT TIMESTAMP		\n")	
											.append( " WHERE EMPNO=?							\n")	
											.append( " AND SEQ=?									\n");


						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						logger.dbg.println(this,UpdateSql.toString());//�α׳���°�

						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1,  idx[2]);
						gsmt.bindColumn(2,  idx[3]);
						gsmt.bindColumn(3,  idx[4]);
						gsmt.bindColumn(4,  idx[5]);
						gsmt.bindColumn(5,  idx[6]);
						gsmt.bindColumn(6,  idx[8]);
						gsmt.bindColumn(7,  idx[0]);
						gsmt.bindColumn(8,  idx[1]);
																		
						gsmt.executeUpdate();
						gsmt.close();
					}
					/******************************** **********************************************
					 * DELETE ó��
					 *********************************************************************************/

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

						logger.dbg.println(this,"step_DELETE");//�α׳���°�

						StringBuffer DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE  FROM SALES.TCM315		\n")
										 .append( "	WHERE EMPNO=?								\n")
										 .append( "	AND SEQ=?										\n");
	
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						logger.dbg.println(this,DeleteSql.toString());//�α׳���°�


								gsmt.setGauceDataRow(rows[j]);
								gsmt.bindColumn(1, idx[0]);
								gsmt.bindColumn(2, idx[1]);

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
