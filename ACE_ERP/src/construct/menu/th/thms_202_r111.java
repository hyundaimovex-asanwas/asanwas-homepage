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
public class thms_202_r111 extends HttpServlet {

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

				logger.dbg.println(this,"뭥미?");
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  
					
															"BID_NUM",	 "SITE_CD",	"CNST_CD",		"SEQ",														
															"BID_COM",	"BID_COM_NM",													//
															"BID_AMT",		"BID_AMT2",	"RESULT_CP",								//
															"RESULT_AMT"																			//10
         									                                 
																}; 

				int[] intArrCN = new int[] {    					
																20, 10,10, 1,												
																10,30,
																12,12,10,
																12
																			}; 
			
				int[] intArrCN2 = new int[]{ 
															-1, -1, -1, -1, 				
															-1, -1, 
															0, 0, -1,
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

								sql.append( "	SELECT		A.BID_NUM,				A.SITE_CD,		A.CNST_CD,		A.SEQ,									\n");
								sql.append( "				 A.BID_COM,		B.CDNAM AS BID_COM_NM,																\n");
								sql.append( "				 A.BID_AMT,	 	A.BID_AMT2,				A.RESULT_CP,													\n");
								sql.append( "				 A.RESULT_AMT																											\n");

								sql.append( "		FROM THMS.THMS015	A																									\n");
								sql.append( "				 	LEFT JOIN THMS.COMMDTIL B ON RTRIM(B.CDCODE) = RTRIM(A.BID_COM)			\n");

								sql.append("			WHERE																															\n");	
								sql.append("				1=1																															\n");	

						if(str1!="")sql.append( "	  AND A.BID_NUM = '"+str1+"'      																			\n");


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