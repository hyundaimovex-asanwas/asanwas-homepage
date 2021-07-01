package THMS;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class thms_101_t2 extends HttpServlet{

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

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/

				// 웹페이지에서 조건값을 넘겨받음
				String  str1 = reqGauce.getParameter("v_str1");   //  현장명인지 공종명인지 구분

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
			
				String[] strArrCN = new String[]{  																
																"COM_CODE", "COM_SNAME"
																	};
																			  
				int[] idx = new int[2]; //컬럼갯수를 넣어준다.
				

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();					

				for (int j = 0; j < rows.length; j++){


/******************************************************************************
** INSERT 처리
*********************************************************************************/
    
        	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_INSERT) {


            //현장 코드 생성 : 
						StringBuffer sql = new StringBuffer();
						Statement stmt= null;
						ResultSet rs = null;
						String strSeq = "000";
						String site_cd = "";

						sql.append( "	 SELECT IFNULL(MAX(SUBSTR(DETAIL,0,4)),0)+1 AS DETAIL					\n" )		//PK DETAIL
							.append( "					FROM THMS.THMS000															\n" )
							.append( "			WHERE HEAD = '"+str1+"'																\n" );


						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while (rs.next())	{
							strSeq = rs.getString(1);
						}
						rs.close();
						stmt.close();

						site_cd = strSeq;

						rows[j].setString(idx[0], site_cd);			

						StringBuffer InsertSql = new StringBuffer();			

								InsertSql.append( " INSERT INTO THMS.THMS000(                                                 \n")		
											 .append( "HEAD,  DETAIL, DETAIL_NM, ITEM1)											\n" )		
											 .append( " VALUES																					\n" )
											 .append( " ('"+str1+"',?,?,'Y')																	\n" );//2

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());			
						gsmt.setGauceDataRow(rows[j]);
											
						gsmt.bindColumn(1,  idx[0]);
						gsmt.bindColumn(2,  idx[1]);
   
						//logger.dbg.println(this,InsertSql.toString());//로그남기는것

						gsmt.executeUpdate();					
						gsmt.close();									

					}


/******************************************************************************
* Update 처리
*********************************************************************************/
    
        	if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						StringBuffer UpdateSql = new StringBuffer();			

								UpdateSql.append( " UPDATE THMS.THMS000														\n")
												.append( " SET																						\n")
												.append( " DETAIL_NM = ?																		\n")                  				
												.append( " WHERE HEAD ='"+str1+"'														\n")
												.append( "   AND DETAIL ='"+rows[j].getString(idx[0])+"'						\n");

						//logger.dbg.println(this,UpdateSql.toString());//로그남기는것

						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql.toString());
						gsmt2.setGauceDataRow(rows[j]);

						gsmt2.bindColumn(1,  idx[1]);

						gsmt2.executeUpdate();					
						gsmt2.close();									

					}
				

/**********************************************************************************************

**********************************************************************************************/
				}

			}
			catch(Exception e){
				logger.err.println(this,e);
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
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