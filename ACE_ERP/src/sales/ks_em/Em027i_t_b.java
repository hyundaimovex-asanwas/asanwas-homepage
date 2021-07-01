//**참고사항. delete,update할떼는 where절 이후에 primary key 컬럼을 꼭 추가해서 써준다***
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

public class Em027i_t_b extends HttpServlet{ 

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
				String strATT_DT =reqGauce.getParameter("v_str1");
				String strto = reqGauce.getParameter("v_str2");
				String strscnt = reqGauce.getParameter("v_str3");
				String strdcnt = reqGauce.getParameter("v_str4");
				String strEmpno = reqGauce.getParameter("v_str5"); //로그인 사원
				
			    int intscnt= Integer.parseInt(strscnt);
		    	int intdcnt= Integer.parseInt(strdcnt);

				int intfr=Integer.parseInt(strATT_DT);  //일괄등록할때 사용
				int intto=Integer.parseInt(strto);      //일괄등록할때 사용


				/*********************************************************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				GauceDataRow[] rows = userSet.getDataRows();
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT)  { 

           /**********************************************
            일자별생성
					 **********************************************/
          
           
           /**********************************************
            일괄생성
					 **********************************************/

	
           for(int i = intfr ; i<=intto; i++){ 
               StringBuffer InsertSql = new StringBuffer();
							 InsertSql.append( " INSERT INTO SALES.TCM450(                                                 \n" )
												.append( " APPDT, S_CNT, D_CNT,    I_EMPNO  ,I_DATE,  U_EMPNO  ,U_DATE                    )        \n" )											
			      					            .append( "       VALUES('"+i+"', "+intscnt+","+ intdcnt+" ,  \n")
												.append( "  '"+strEmpno+"' , CURRENT TIMESTAMP , '"+strEmpno+"' , CURRENT TIMESTAMP)  \n") ;

							 logger.dbg.println(this,InsertSql.toString() );
							 
							 GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); //로그남기는것
							 gsmt.setGauceDataRow(rows[j]);
								
							 gsmt.executeUpdate();
							 gsmt.close();
					 }//for 	
				}//if 
					/******************************** **********************************************
						* Update 처리
						*********************************************************************************/
         
				}	
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/
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
