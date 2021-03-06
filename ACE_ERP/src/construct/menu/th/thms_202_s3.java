package THMS;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class thms_202_s3 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; }				//업체명
				String  str2	= req.getParameter("v_str2"); if (str2 == null) { str2 = ""; }				//공종명
				
				
				//logger.dbg.println(this," 이런 개같은!!");
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  
					
															"SEQ",														
															"BID_COM_NM",																		//
															"BID_AMT",		"BID_AMT_PCT1",	 "BID_AMT_PCT2",
															"BID_AMT2",		"BID_AMT2_PCT1",	 "BID_AMT2_PCT2",																		//
															"RESULT_AMT"																			//10
         									                                 
																}; 

				int[] intArrCN = new int[] {    					
																1,												
																30,
																12, 10, 10,
																12, 10, 10, 
																12
																			}; 
			
				int[] intArrCN2 = new int[]{ 
															-1, 				
															-1, 
															0, -1, -1,
															0, -1, -1,
                                     						0
																
															}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

								sql.append( "	SELECT		A.SEQ,																													\n");
								sql.append( "				 B.CDNAM AS BID_COM_NM,																						\n");
								sql.append( "				 IFNULL(A.BID_AMT,	0) AS BID_AMT,																		\n");
								sql.append( "				 A.BID_AMT_PCT1,	 A.BID_AMT_PCT2,																	\n");
								sql.append( "				 IFNULL(A.BID_AMT2, 0) AS BID_AMT2,																		\n");
								sql.append( "				 A.BID_AMT2_PCT1,	 A.BID_AMT2_PCT2,																	\n");
								sql.append( "				 IFNULL(A.RESULT_AMT	, 0) AS RESULT_AMT																\n");

								sql.append( "		FROM THMS.THMS015	A																									\n");
								sql.append( "				 	LEFT JOIN THMS.COMMDTIL B ON RTRIM(B.CDCODE) = RTRIM(A.BID_COM)			\n");

								sql.append("			WHERE																															\n");	
								sql.append("				1=1																															\n");	

						if(str1!="")sql.append( "	  AND A.SITE_CD = '"+str1+"'      																				\n");
						if(str2!="")sql.append( "	  AND A.CNST_CD = '"+str2+"'      																				\n");		

						//logger.dbg.println(this,sql.toString());
						
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