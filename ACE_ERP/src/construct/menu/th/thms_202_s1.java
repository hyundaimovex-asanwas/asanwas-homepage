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
public class thms_202_s1 extends HttpServlet {

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
				//logger.dbg.println(this,"뭥미?");
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  
					
															"BID_NUM",	"BID_STYLE", "BID_STYLE_NM",
																
															"SITE_CD",	"SITE_NM", "CNST_CD",	"CNST_NM",															
															
															"BID_DAY",	"ORDER_CD",	"ORDER_NM",		//

															"START_DT",		"END_DT",	"ACT_AMT",		"ACT_AMT_KOR",					//

															"START_DT_HA",		"END_DT_HA",	"ACT_AMT_HA",	"ACT_AMT_HA_KOR", 	"RECO_CD"			//
         									                                 
																}; 

				int[] intArrCN = new int[] {    					
																20, 3, 20, 
																	
																10, 50, 10, 50,	
																	
																10,10, 50,

																10,10,12, 100,

																10,10,12, 100, 10
																	
																			}; 
			
				int[] intArrCN2 = new int[]{ 
															-1, -1, -1, 
																
															-1, -1, -1, -1, 				
															
															-1, -1, -1,

															-1, -1, 0, -1,

                                     						-1, -1, 0, -1, -1
																
															}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "			SELECT																																			\n");
						sql.append( "			A.BID_NUM,		A.BID_STYLE,	D.CDNAM  AS BID_STYLE_NM,														\n");
						sql.append( "			A.SITE_CD,	B.CDNAM AS SITE_NM,	A.CNST_CD,	C.CDNAM AS CNST_NM,									\n");
						sql.append( "			A.BID_DAY,			A.ORDER_CD, 	E.CDNAM AS ORDER_NM,															\n");										
						sql.append( "			A.START_DT,				A.END_DT,			A.ACT_AMT,		A.ACT_AMT_KOR,										\n");			
						sql.append( "			A.START_DT_HA,		A.END_DT_HA,		A.ACT_AMT_HA,	A.ACT_AMT_HA_KOR,	A.RECO_CD		\n");


						sql.append( "			FROM THMS.THMS010	A																												\n");
						sql.append( "			LEFT JOIN THMS.COMMDTIL B ON RTRIM(B.CDCODE) = RTRIM(A.SITE_CD)									\n");
						sql.append( "			LEFT JOIN THMS.COMMDTIL C ON RTRIM(C.CDCODE) = RTRIM(A.CNST_CD)									\n");
						sql.append( "			LEFT JOIN THMS.COMMDTIL D ON RTRIM(D.CDCODE) = RTRIM(A.BID_STYLE)								\n");
						sql.append( "			LEFT JOIN THMS.COMMDTIL E ON RTRIM(E.CDCODE) = RTRIM(A.ORDER_CD)									\n");

						sql.append("			WHERE																																	\n");	
						sql.append("				1=1																																	\n");	

						if(str1!="")sql.append( "	  AND SITE_CD = '"+str1+"'																						\n");
						if(str2!="")sql.append( "	  AND CNST_CD = '"+str2+"'																						\n");		

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