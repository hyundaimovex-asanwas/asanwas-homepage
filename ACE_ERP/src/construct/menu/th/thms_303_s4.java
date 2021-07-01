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
public class thms_303_s4 extends HttpServlet {

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
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  
															"BID_NUM", "BID_STYLE", "BID_NM",	  "SITE_NM",   "CNST_NM",
															"SEQ",	"BID_COM", "BID_COM_NM", "BID_DAY",
																

															"ACT_AMT", 							
															"RESULT_AMT", 
															"RECO_NM",	 
															"REMARK"
																}; 

				int[] intArrCN = new int[] {   
															20, 3, 20,	 30,  30,
															1, 10, 30, 10, 			
															12, 12, 20, 50
					                           
																			}; 
			
				int[] intArrCN2 = new int[]{
															-1, -1, -1,  -1,  -1,
															-1, -1, -1, -1, 
                                     						0,	-1, -1, -1     
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	SELECT  Y.BID_NUM, X.BID_STYLE, G.CDNAM AS BID_NM,																				\n"); 						
						sql.append( "	C.CDNAM AS SITE_NM,  D.CDNAM AS CNST_NM,																							\n"); 						
						sql.append( "	Y.SEQ,	Y.BID_COM, E.CDNAM AS BID_COM_NM ,	X.BID_DAY, X.ACT_AMT,													\n"); 																					
						sql.append( "	IFNULL(Y.RESULT_AMT, ' ') RESULT_AMT, F.CDNAM AS RECO_NM,	Y.REMARK													\n"); 
						sql.append( "	FROM																																							\n");		
						sql.append( "	(SELECT  A.BID_NUM, A.BID_STYLE, A.SITE_CD, 	A.CNST_CD	,B.BID_COM, A.BID_DAY, A.ACT_AMT			\n");							
						sql.append( "	FROM THMS.THMS010	A																																\n");													
						sql.append( "	LEFT JOIN THMS.THMS015 B ON RTRIM(B.BID_NUM) = RTRIM(A.BID_NUM)													\n"); 			
						sql.append( "	WHERE 1=1																																					\n"); 													
						sql.append( "	AND B.BID_COM =		'"+str1+"') X																												\n"); 
						sql.append( "	LEFT JOIN THMS.THMS015 Y ON X.BID_NUM = Y.BID_NUM																			\n"); 
						sql.append( "	LEFT JOIN THMS.COMMDTIL C ON RTRIM(C.CDCODE) = RTRIM(X.SITE_CD)  AND C.CMTYPE = '0001'				\n"); 	
						sql.append( "	LEFT JOIN THMS.COMMDTIL D ON RTRIM(D.CDCODE) = RTRIM(X.CNST_CD)  AND D.CMTYPE = '0002'			\n"); 	
						sql.append( "	LEFT JOIN THMS.COMMDTIL E ON RTRIM(E.CDCODE) = RTRIM(Y.BID_COM)	AND E.CMTYPE = '0003'			\n"); 	
						sql.append( "	LEFT JOIN THMS.COMMDTIL F ON RTRIM(F.CDCODE) = RTRIM(Y.RECO_CD)	AND F.CMTYPE = '0008'			\n"); 	
						sql.append( "	LEFT JOIN THMS.COMMDTIL G ON RTRIM(G.CDCODE) = RTRIM(X.BID_STYLE)	AND G.CMTYPE = '0007'		\n");  

			
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