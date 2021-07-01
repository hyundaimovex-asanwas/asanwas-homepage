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

public class Em015_t1 extends HttpServlet{

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
				String strEmpno = reqGauce.getParameter("v_str1");
			  String strYYYY="9999"; //의미없는 필드라서 9999를 넣는다.

				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
         
				String[] strArrCN = new String[]{ "EMPNO",  "YYYY",   "SEQ",    "CUST_SID","VEND_CD",
					                                "DEPT_CD","TEAM_CD","WORK_CD","START_DT","END_DT",
                                          "H_DAY",  "H_RES",  "H_YN",   "SEQ2",  "REWARD_YM",
																					"I_EMPNO","I_DATE","U_EMPNO","U_DATE"
																			  };

				int[] idx = new int[19]; //컬럼갯수를 넣어준다.

        for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){
				
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						StringBuffer sql = new StringBuffer();

						Statement stmt= null;
						ResultSet rs = null;
						String v_date = "";
						int intSeq = 0;

						sql.append( "SELECT IFNULL(MAX(SEQ),0)+1 AS SEQ \n" )
							 .append( "FROM SALES.TCM355                  \n" )
							 .append( "WHERE EMPNO ='"+rows[j].getString(idx[0])+"'  \n" );

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while (rs.next())	{
							intSeq = rs.getInt(1);
						}
						rs.close();
						stmt.close();

						rows[j].setInt(idx[2],intSeq);
						rows[j].setString(idx[1],strYYYY);
						rows[j].setString(idx[15],strEmpno);
						rows[j].setString(idx[17],strEmpno);

						StringBuffer InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO SALES.TCM355                          \n" )
										 .append( " ( EMPNO,    YYYY,    SEQ,     CUST_SID, VEND_CD,  \n" )
										 .append( "   DEPT_CD,  TEAM_CD, WORK_CD, START_DT, END_DT,   \n" )
										 .append( "   H_DAY,    H_RES,   H_YN,    SEQ2,  REWARD_YM,  \n" )
										 .append( "   I_EMPNO,  I_DATE,	 U_EMPNO,	U_DATE ) \n" )
										 .append( "  VALUES      \n" )
										 .append( " ( ?,?,?,?,?, \n" )
										 .append( "   ?,?,?,?,?, \n" )
							       .append( "   ?,?,?,?,?, \n" )
										 .append( "   ?,CURRENT TIMESTAMP,?,CURRENT TIMESTAMP)      \n" );
										
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); //로그남기는것
						gsmt.setGauceDataRow(rows[j]);
					
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);
						gsmt.bindColumn(4, idx[3]);
						gsmt.bindColumn(5, idx[4]);
						gsmt.bindColumn(7, idx[6]);
						gsmt.bindColumn(6, idx[5]);
						gsmt.bindColumn(8, idx[7]);
						gsmt.bindColumn(9, idx[8]);
						gsmt.bindColumn(10, idx[9]);
						gsmt.bindColumn(11, idx[10]);
						gsmt.bindColumn(12, idx[11]);
						gsmt.bindColumn(13, idx[12]);
						gsmt.bindColumn(14, idx[13]);
						gsmt.bindColumn(15, idx[14]);
						gsmt.bindColumn(16, idx[15]);
						gsmt.bindColumn(17, idx[17]);
					
						gsmt.executeUpdate();
						gsmt.close();

					}
						/******************************** **********************************************
						* Update 처리
						*********************************************************************************/
            
         	 if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						StringBuffer UpdateSql = new StringBuffer();		
						 
						 rows[j].setString(idx[17],strEmpno);
						 //rows[j].setString(idx[1],strYYYY);
             /*
						 UpdateSql.append( " UPDATE SALES.TCM355	    \n")
											.append( " SET                      \n")
											.append( " VEND_CD="+rows[j].getInt(idx[4])+",         \n")
							        .append( " DEPT_CD='"+rows[j].getString(idx[5])+"',    \n")
                      .append( " TEAM_CD='"+rows[j].getString(idx[6])+"',    \n")
							        .append( " WORK_CD='"+rows[j].getString(idx[7])+"',    \n")
							        .append( " START_DT='"+rows[j].getString(idx[8])+"',   \n")
							        .append( " END_DT='"+rows[j].getString(idx[9])+"',     \n")
  						        .append( " H_DAY="+rows[j].getInt(idx[10])+",          \n") 
 						          .append( " H_RES='"+rows[j].getString(idx[11])+"',     \n")
							        .append( " H_YN='"+rows[j].getString(idx[12])+"',      \n")
							        .append( " SEQ2="+rows[j].getInt(idx[13])+",           \n")
                      .append( " U_EMPNO='"+rows[j].getString(idx[16])+"',   \n")
							        .append( " U_DATE=CURRENT TIMESTAMP    \n")
						          .append( " WHERE EMPNO='"+rows[j].getString(idx[0])+"' \n")
							        .append( "   AND YYYY='"+rows[j].getString(idx[1])+"'  \n")
											.append( "   AND SEQ="+rows[j].getInt(idx[2])+"        \n");
               */
                
           
					  UpdateSql.append( " UPDATE SALES.TCM355			  \n")
											.append( " SET                      \n")
											.append( " VEND_CD=?,  DEPT_CD=?,  TEAM_CD=?,  WORK_CD=?,   \n")
											.append( " START_DT=?, END_DT=?,   H_DAY=?,    H_RES=?,     \n")
											.append( " H_YN=?,     SEQ2=?,     REWARD_YM =?, \n")
							       	.append( " U_EMPNO=?,               \n")
											.append( " U_DATE=CURRENT TIMESTAMP \n")
											.append( " WHERE EMPNO=?						\n")
							        .append( "   AND YYYY=?             \n")
											.append( "   AND SEQ=?              \n");

						rows[j].setString(idx[16],strEmpno);
					

  					GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
						gsmt.bindColumn(1,  idx[4]);	
						gsmt.bindColumn(2,  idx[5]);	
						gsmt.bindColumn(3,  idx[6]);	
						gsmt.bindColumn(4,  idx[7]);	
						gsmt.bindColumn(5,  idx[8]);	
						gsmt.bindColumn(6,  idx[9]);	
						gsmt.bindColumn(7,  idx[10]);	
						gsmt.bindColumn(8,  idx[11]);	
						gsmt.bindColumn(9,  idx[12]);	
						gsmt.bindColumn(10, idx[13]);	
						gsmt.bindColumn(11, idx[14]);	
						gsmt.bindColumn(12, idx[17]);	
						gsmt.bindColumn(13, idx[0]);	
						gsmt.bindColumn(14, idx[1]);	
						gsmt.bindColumn(15, idx[2]);	
					
						gsmt.executeUpdate();					
						gsmt.close();									
					}
					
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/
         
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
            
						StringBuffer DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM SALES.TCM355		\n")
										 .append( "	 WHERE EMPNO=?							\n")
							       .append( "	   AND YYYY=?							  \n")
				  					 .append( "    AND SEQ=?							  \n");
	
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);

						gsmt.executeUpdate();
						gsmt.close();

			   	}
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
