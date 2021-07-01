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
public class thms_101_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1"); if (str1 == null) { str1 = ""; }				//현장명
				String  str2	= req.getParameter("v_str2"); if (str2 == null) { str2 = ""; }				//공종명
				//logger.dbg.println(this,"뭥미?");
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  
					
															"SITE_CD",	"SITE_NM",	"CNST_CD",	"CNST_NM",		"T_DAY",		//5
															"ORDER_NM",	"START_DT",		"END_DT",	"ACT_AMT",					//9
															"START_DT_HA",		"END_DT_HA",	"ACT_AMT_HA",					//12
															"RECO_CD",		"RECO_NM",																//14
															"BID1_COM",	"BID1_AMT",		"BID1_AMT2",									//17
															"BID2_COM",	"BID2_AMT",		"BID2_AMT2",	
															"BID3_COM",	"BID3_AMT",		"BID3_AMT2",									//23
															"BID4_COM",	"BID4_AMT",		"BID4_AMT2",
															"BID5_COM",	"BID5_AMT",		"BID5_AMT2",									//27
															"BID6_COM",	"BID6_AMT",		"BID6_AMT2",
															"BID7_COM",	"BID7_AMT",		"BID7_AMT2",									//33
															"BID8_COM",	"BID8_AMT",		"BID8_AMT2",
															"BID9_COM",	"BID9_AMT",		"BID9_AMT2",
															"BID10_COM",	"BID10_AMT",		"BID10_AMT2",								//44
															"RESULT_CP",		"RESULT_AMT"														//46

             									                                 
																}; 

				int[] intArrCN = new int[] {    					

																10,30,10,30,10,
																30,10,10,12,
																10,10,12,
																10,30,
										
																10,12,12,
																10,12,12,
																10,12,12,
																10,12,12,
																10,12,12,
																10,12,12,
																10,12,12,
																10,12,12,
																10,12,12,
																10,12,12,
																10,12					           
																	
																			}; 
			
				int[] intArrCN2 = new int[]{ 
															-1, -1, -1, -1, -1,					
															-1,-1, -1, 0,
                                     						-1,-1, 0, 
															-1,-1,

                                     						-1,0, 0,
															-1,0, 0,
					                         				-1,0, 0,
					                         				-1,0, 0, 
					                         				-1,0, 0, 					                           
                                     						-1,0, 0,
															-1,0, 0,
					                         				-1,0, 0,
					                         				-1,0, 0, 
					                         				-1,0, 0,	
					                         				-1,0								
																
															}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( "	SELECT	SITE_CD,	SITE_NM,	CNST_CD,	 CNST_NM, T_DAY,				\n");
						sql.append( "				 ORDER_NM,	START_DT,	END_DT,	ACT_AMT,						\n");
						sql.append( "				 START_DT_HA,		END_DT_HA,		ACT_AMT_HA,					\n");
						sql.append( "				 RECO_CD,	 RECO_NM,														\n");

						sql.append( "				 BID1_COM,	BID1_AMT,	BID1_AMT2,									\n");
						sql.append( "				 BID2_COM,	BID2_AMT,	BID2_AMT2,									\n");
						sql.append( "				 BID3_COM,	BID3_AMT,	BID3_AMT2,									\n");
						sql.append( "				 BID4_COM,	BID4_AMT,	BID4_AMT2,									\n");
						sql.append( "				 BID5_COM,	BID5_AMT,	BID5_AMT2,									\n");
						sql.append( "				 BID6_COM,	BID6_AMT,	BID6_AMT2,									\n");
						sql.append( "				 BID7_COM,	BID7_AMT,	BID7_AMT2,									\n");
						sql.append( "				 BID8_COM,	BID8_AMT,	BID8_AMT2,									\n");
						sql.append( "				 BID9_COM,	BID9_AMT,	BID9_AMT2,									\n");
						sql.append( "				 BID10_COM,	BID10_AMT,	BID10_AMT2,							\n");
						sql.append( "				 RESULT_CP,	RESULT_AMT														\n");
						sql.append( "		FROM THMS.THMS010																	\n");
						sql.append("			WHERE																						\n");	
						sql.append("				1=1																						\n");	

						if(!str1.equals(""))sql.append( "	  AND SITE_CD = '"+str1+"'      							\n");
						if(!str2.equals(""))sql.append( "	  AND CNST_CD = '"+str2+"'      							\n");		

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