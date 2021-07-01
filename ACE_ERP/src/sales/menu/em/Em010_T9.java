//**참고사항. delete,update할떼는 where절 이후에 primary key 컬럼을 꼭 추가해서 써준다***
package sales.menu.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class Em010_T9 extends HttpServlet{

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
				String strEmpno = reqGauce.getParameter("v_str1");
				String useid = reqGauce.getParameter("v_str2");

				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				String[] strArrCN = new String[]{
																					"EMPNO",
																					"SEQ",
																					"SUB_DT",
																					"MAN_YY",
																					"MAN_SEX",
																					"MAN_CD",
																					"SUP_NM",
																					"CLOTH_CD",
																					"CLOTH_SIZE",
																					"RTN_DT",//10
																					"RTN_RK",
																					"RTN_RE",
																					"I_EMPNO",
																					"U_EMPNO",
																					"I_DATE",
																					"U_DATE"
																			};

				int[] idx = new int[16]; //컬럼갯수를 넣어준다.

        for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
					}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

					logger.dbg.println(this,"step_INSERT1");//로그남기는것

					StringBuffer sql = new StringBuffer();

					Statement stmt= null;
					ResultSet rs = null;
					String v_date = "";
					int strSeq = 0;

					 sql.append( "SELECT IFNULL(MAX(SEQ),0)+1 AS SEQ \n" )
							.append( "FROM SALES.TCM330                  \n" )
							.append( "WHERE EMPNO ='"+strEmpno+"'        \n" );

					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql.toString());

					while (rs.next())	{
						v_date = rs.getString(1);
					}
					rs.close();
					stmt.close();

					strSeq = Integer.parseInt(v_date);

					rows[j].setString(idx[0],strEmpno);//데이터셋 strEmpno 가져오기
					rows[j].setInt(idx[1],strSeq);
					rows[j].setString(idx[12],useid);
					rows[j].setString(idx[13],useid);


/*
logger.dbg.println(this,UpdateSql.toString());//로그남기는것
logger.dbg.println(this,"1_idx[1]:: "+rows[j].getString(idx[1]));
*/
						StringBuffer InsertSql = new StringBuffer();
		         InsertSql.append( " INSERT INTO SALES.TCM330                       \n" )
											.append( " (EMPNO,	SEQ,	SUB_DT,	MAN_YY,	MAN_SEX,        \n" )
											.append( " MAN_CD,	SUP_NM,	CLOTH_CD,	CLOTH_SIZE,	RTN_DT, \n" )
											.append( " RTN_RK,	RTN_RE,	I_EMPNO,	U_EMPNO,	I_DATE,   \n" )
											.append( " U_DATE)                                        \n" )
											.append( " VALUES                                         \n" )
											.append( " (?,?,?,?,?,                                    \n" )
											.append( "  ?,?,?,?,?,                                    \n" )
											.append( "  ?,?,?,?,CURRENT TIMESTAMP,                    \n" )
											.append( "  CURRENT TIMESTAMP)                            \n" );
					
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());//로그남기는것
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
							gsmt.bindColumn(10, idx[9]);
							gsmt.bindColumn(11, idx[10]);
							gsmt.bindColumn(12, idx[11]);
							gsmt.bindColumn(13, idx[12]);
							gsmt.bindColumn(14, idx[13]);

            logger.dbg.println(this,InsertSql.toString());//로그남기는것
            logger.dbg.println(this,"TEST_INSERT");//로그남기는것

						gsmt.executeUpdate();
						gsmt.close();
					}
						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/

         			if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
	
						logger.dbg.println(this,"step_UPDATE");//로그남기는것

						StringBuffer UpdateSql = new StringBuffer();			

						 UpdateSql.append( " UPDATE SALES.TCM330			\n")
											.append( " SET											\n")
											.append( " SUB_DT=?,                \n")
											.append( " MAN_YY=?,                \n")
											.append( " MAN_SEX=?,               \n")
											.append( " MAN_CD=?,                \n")
											.append( " SUP_NM=?,                \n")
											.append( " CLOTH_CD=?,              \n")
											.append( " CLOTH_SIZE=?,            \n")
											.append( " RTN_DT=?,                \n")
											.append( " RTN_RK=?,                \n")
											.append( " RTN_RE=?,                \n")
											.append( " U_EMPNO=?,								\n")
											.append( " U_DATE=CURRENT TIMESTAMP	\n")
											.append( " WHERE EMPNO=?						\n")
											.append( " AND SEQ=?								\n");


						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
//						logger.dbg.println(this,UpdateSql.toString());//로그남기는것

						gsmt.setGauceDataRow(rows[j]);
							
						gsmt.bindColumn(1,  idx[2]);	
						gsmt.bindColumn(2,  idx[3]);	
						gsmt.bindColumn(3,  idx[4]);	
						gsmt.bindColumn(4,  idx[5]);	
						gsmt.bindColumn(5,  idx[6]);	
						gsmt.bindColumn(6,  idx[7]);	
						gsmt.bindColumn(7,  idx[8]);	
						gsmt.bindColumn(8,  idx[9]);	
						gsmt.bindColumn(9,  idx[10]);	
						gsmt.bindColumn(10,  idx[11]);
						gsmt.bindColumn(11,  idx[13]);	
						gsmt.bindColumn(12,  idx[0]);	
						gsmt.bindColumn(13,  idx[1]);	
																					
						gsmt.executeUpdate();					
						gsmt.close();									
					}
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

						logger.dbg.println(this,"step_DELETE");//로그남기는것

						StringBuffer DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE  FROM SALES.TCM330		\n")
										 .append( "	WHERE EMPNO=?								\n")
				  					 .append( " AND SEQ=?									  \n");
	
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
