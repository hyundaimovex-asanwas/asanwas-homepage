package North.northhr.ks_em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class KS_Em039_t1 extends HttpServlet{

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
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String  str1	= req.getParameter("v_str1");  //출근날짜
				String  str2 = null;
				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] strArrCN = new String[]{  "EMPNO",    "SAYU_GB",  
					
																	"A_TM",  "L_TM" , "M_H", "A_H", "O_H", "N1_H", "N2_H"                              					                               	
																			  
																	};
																			  
				int[] idx = new int[9]; //컬럼갯수를 넣어준다.

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();		


				for (int j = 0; j < rows.length; j++){

					//////////////////////////////////////////////////////////////////////////
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						//logger.dbg.println(this,"step1");

						StringBuffer InsertSql = new StringBuffer();





						if(rows[j].getString(idx[1]).equals("근무")){					//
						str2 = "0";
						}else if(rows[j].getString(idx[1]).equals("결근")){ 
						str2 = "1";
						}else if(rows[j].getString(idx[1]).equals("정기휴가")){ 
						str2 = "2";
						}else if(rows[j].getString(idx[1]).equals("생활휴가")){ 
						str2 = "3";
						}else if(rows[j].getString(idx[1]).equals("산전휴가")){ 
						str2 = "5";
						}else if(rows[j].getString(idx[1]).equals("산후휴가")){ 
						str2 = "6";
						}

						
						InsertSql.append( " INSERT INTO ATP.KST100 (														\n " );
						InsertSql.append( " ATT_DT, EMPNO,  																	\n " );
						InsertSql.append( " SAYU_GB, A_TM, L_TM, 															\n " );
						InsertSql.append( " M_H, A_H, O_H, N1_H, N2_H,													\n " );
						InsertSql.append( " M_PAY, D_PAY, T_PAY, E_H, T_H, G_H)									\n " );

						InsertSql.append( " VALUES													\n " );
						InsertSql.append( " ( '" + str1 + "',?,											\n " );
						InsertSql.append( "  '" + str2 + "',?, ?,										\n " );
						InsertSql.append( " '0','0','0','0','0', 										\n " );
						InsertSql.append( " '0','0','0','0','0','0')									\n " );
						

//						logger.dbg.println(this,"EMPNO,				rows[j].getString(idx[0])::"+rows[j].getString(idx[0]));         						
//						logger.dbg.println(this,"SAYU_GB,			rows[j].getString(idx[4])::"+rows[j].getString(idx[4]));         
//						logger.dbg.println(this,"A_TM,				rows[j].getString(idx[2])::"+rows[j].getString(idx[2]));         
//						logger.dbg.println(this,"L_TM,          		rows[j].getString(idx[3])::"+rows[j].getString(idx[3]));         
//						logger.dbg.println(this,"M_H,					rows[j].getString(idx[4])::"+rows[j].getString(idx[4]));         
//						logger.dbg.println(this,"A_H,          			rows[j].getString(idx[5])::"+rows[j].getString(idx[5]));         
//						logger.dbg.println(this,"O_H,					rows[j].getString(idx[6])::"+rows[j].getString(idx[6]));         
//						logger.dbg.println(this,"N1_H,    			rows[j].getString(idx[7])::"+rows[j].getString(idx[7]));                    
 //						logger.dbg.println(this,"N2_H,    			rows[j].getString(idx[8])::"+rows[j].getString(idx[8]));    
  

//						logger.dbg.println(this,InsertSql.toString());//로그남기는것

						//신규 생성
						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[0]);                                  
						gsmt.bindColumn(2, idx[2]);									               																														               
						gsmt.bindColumn(3, idx[3]);							
						
						gsmt.executeUpdate();
						gsmt.close();
						
					}
				} 


			}
			catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
      conn.commit(); 
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