package purch;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;


// class 이름은 화일명과 항상 동일해야 함.
public class np00111_s1 extends HttpServlet {



	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();


/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/

				// 웹페이지에서 조건값을 넘겨받음
				String  str1	= req.getParameter("v_str1");				// 현장코드
				String  str2	= req.getParameter("v_str2");				// 상태
				String  str3	= req.getParameter("v_str3");				// 기간 from
				String  str4	= req.getParameter("v_str4");				// 기간 to  


				if (str1==null) str1=""; 
				if (str2==null) str2=""; 
				if (str3==null) str3=""; 
				if (str4==null) str4=""; 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
															"ESTM_NO",			"ESTM_DATE",			"ESTM_NM",
															"SITE_CD",			"SITE_NM",				"ESTM_SDT",		"ESTM_DT",
															"DELV_SDT",		"DELV_DT",				"EXPL_YN",			"EXPL_DT",				"EXPL_PL",
															"DELV_CND",		"DELV_CND_NM",		"PAY_CND",			"PAY_CND_NM",
															"ESTM_STEP",		"ESTM_DS",				"CREAT_DT",		"CREAT_NM"

																			}; 	


				int[] intArrCN = new int[] { 
																				20, 8, 100, 	
																				6, 50, 8, 8,																					
																				8, 8, 1, 8, 50,
																				6, 50, 6, 50,	
																				3, 100, 8, 8

																			};  
			
				int[] intArrCN2 = new int[]{
																				-1, -1, -1, 
																				-1, -1, -1, -1,
																				-1, -1, -1, -1, -1,
																				-1, -1, -1, -1,
																				-1, -1, -1, -1

																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

										sql.append( "	SELECT																         						\n");		
										sql.append( "		A.ESTM_NO, A.ESTM_DATE, A.ESTM_NM,		           								\n");
										sql.append( "		A.SITE_CD, A.SITE_NM, A.ESTM_SDT,  A.ESTM_DT,           					\n");										
										sql.append( "		A.DELV_SDT, A.DELV_DT, A.EXPL_YN,  A.EXPL_DT,     A.EXPL_PL,       		\n");
										sql.append( "		A.DELV_CND, A.DELV_CND_NM, A.PAY_CND,  A.PAY_CND_NM,           		\n");
										sql.append( "		A.ESTM_STEP, A.ESTM_DS, A.CREAT_DT,  A.CREAT_NM         					\n");
										sql.append( "		FROM PURCH.ESTIMATE_HEAD A                                                         \n");
										sql.append( "	WHERE 1=1                           																\n");
				if(!str1.equals(""))sql.append( "		AND A.SITE_CD = '"+str1+"'																\n");
				if(!str2.equals(""))sql.append( "		AND A.ESTM_STEP = '"+str2+"'															\n");
				if(!str3.equals("")&&!str4.equals(""))sql.append( "		AND A.ESTM_DATE BETWEEN '"+str3+"' AND '"+str4+"'		\n");

										logger.dbg.println(this,sql.toString());
						   
										stmt = conn.getGauceStatement(sql.toString());
										stmt.executeQuery(dSet);
		 				
					}
				
/*********************************************************************************************/

			} catch(Exception e) {
			logger.err.println(this,e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		} finally {
			loader.restoreService(service);
	}
	}
}
