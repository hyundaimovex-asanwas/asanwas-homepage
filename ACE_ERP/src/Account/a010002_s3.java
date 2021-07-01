package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
 
// class 이름은 화일명과 항상 동일해야 함.
public class a010002_s3 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
				String  str1	= req.getParameter("v_str1");
				String  str2	= req.getParameter("v_str2");
				
				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ATCODE",	"ATKORNAM",	"LEVEL2",	
                                          "WRDT",	  "WRID",	  "UPDT",	  "UPID",	  "DSUDT"																	 
																				 }; 

				int[] intArrCN = new int[]{ 7, 66, 1,
					                        
					                          8, 7, 8, 7, 8}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1,
					             
					                           -1, -1, -1, -1, -1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					sql.append( " SELECT 																								\n");
					sql.append( " A.ATCODE, A.ATKORNAM, 																		\n");
					sql.append( " A.ATGRP  LEVEL2,																				\n");
					sql.append( " A.WRDT,	      A.WRID,	      A.UPDT,	      A.UPID,	      A.DSUDT              \n");
					sql.append( " FROM ACCOUNT.ACTCODE A 																\n");
					
					if (!str1.equals(""))sql.append( " WHERE A.ATKORNAM LIKE '%"+str1+"%' 							\n");
					else if(!str2.equals(""))sql.append( " WHERE A.ATCODE = '"+str2+"' 								\n");
         
					sql.append( " UNION ALL 																							\n");
					
					sql.append( " SELECT DISTINCT '0000000' ATCODE,'계 정 과 목' ATKORNAM , 					\n");
					sql.append( " '0' LEVEL2,'' WRDT,'' WRID,'' UPDT,'' UPDT,'' DSUDT 								\n");					
					sql.append( " FROM ACCOUNT.ACTCODE B 																\n");
					sql.append( " ORDER BY ATCODE, LEVEL2 																	\n");    					

					//logger.dbg.println(this,sql.toString());
/*********************************************************************************************/

					stmt = conn.getGauceStatement(sql.toString());
	 		    stmt.executeQuery(dSet);
				}
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
	} //public void
} //public class