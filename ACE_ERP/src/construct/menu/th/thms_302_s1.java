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
public class thms_302_s1 extends HttpServlet {

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
				String  str2	= req.getParameter("v_str2"); if (str2 == null) { str2 = ""; }				//입찰일자fr
				String  str3	= req.getParameter("v_str3"); if (str3 == null) { str3 = ""; }				//입찰일자to
				String  str4	= req.getParameter("v_str4"); if (str4 == null) { str4 = ""; }				//입찰구분

				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  

															"BID_NUM", "BID_STYLE", "BID_NM",	 "SITE_CD", "SITE_NM",  "CNST_CD", "CNST_NM",

															"SEQ",	"BID_COM", "BID_COM_NM", "BID_AMT1",	"BID_DAY",	"ORDER_CD", 				//10											

															"ACT_AMT", "START_DT", "END_DT", 								
																
															"ACT_AMT_HA", "START_DT_HA", "END_DT_HA",			
																
															"RESULT_AMT", "RECO_NM",	 "REMARK"

																}; 

				int[] intArrCN = new int[] {   20, 3, 20, 10, 30, 10, 30,
					
															1, 10, 30, 12,10, 10, 
															
															12, 10, 10, 
																
															12, 10, 10,

															12, 10,	50
					                           
																			}; 
			
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1, -1, -1,
					
															-1, -1, -1, 0, -1, -1,

                                     						0,-1, -1, 								//13		

															0, -1, -1,								//16

															0, -1, -1
					                           
																			}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

				sql.append( "	SELECT  A.BID_NUM, A.BID_STYLE, G.CDNAM AS BID_NM,	A.SITE_CD,															\n");
				sql.append( "				 C.CDNAM AS SITE_NM,  A.CNST_CD, D.CDNAM AS CNST_NM,															\n");
				sql.append( "				 B.SEQ,	B.BID_COM, E.CDNAM AS BID_COM_NM ,																				\n");
				sql.append( "				 IFNULL(B.BID_AMT, 0) AS BID_AMT1 , A.BID_DAY,																			\n");
				sql.append( "				 A.ORDER_CD, 																																	\n");
				sql.append( "				 IFNULL(A.ACT_AMT, 0) AS ACT_AMT, A.START_DT, A.END_DT, 															\n");						
				sql.append( "				 IFNULL(A.ACT_AMT_HA, 0) AS ACT_AMT_HA, A.START_DT_HA, A.END_DT_HA,									\n");						
				sql.append( "				 IFNULL(B.RESULT_AMT,0) RESULT_AMT, F.CDNAM AS RECO_NM,	B.REMARK										\n");				

				sql.append( "							FROM THMS.THMS010	A																										\n");
				sql.append( "					LEFT JOIN THMS.THMS015 B ON RTRIM(B.BID_NUM) = RTRIM(A.BID_NUM)									\n");
				sql.append( "				 	LEFT JOIN THMS.COMMDTIL C ON RTRIM(C.CDCODE) = RTRIM(A.SITE_CD)  AND C.CMTYPE = '0001'			\n");
				sql.append( "				 	LEFT JOIN THMS.COMMDTIL D ON RTRIM(D.CDCODE) = RTRIM(A.CNST_CD)  AND D.CMTYPE = '0002'        \n");
				sql.append( "				 	LEFT JOIN THMS.COMMDTIL E ON RTRIM(E.CDCODE) = RTRIM(B.BID_COM)	AND E.CMTYPE = '0003'		\n");
				sql.append( "				 	LEFT JOIN THMS.COMMDTIL F ON RTRIM(F.CDCODE) = RTRIM(B.RECO_CD)	AND F.CMTYPE = '0008'		\n");
				sql.append( "					LEFT JOIN THMS.COMMDTIL G ON RTRIM(G.CDCODE) = RTRIM(A.BID_STYLE)	AND G.CMTYPE = '0007'		\n");  
				sql.append( "				WHERE 1=1																																				\n");

				if(!str1.equals(""))sql.append( "	  AND B.BID_COM =		'"+str1+"'																								\n");
				if(!str2.equals("")&&!str3.equals(""))sql.append( "AND A.BID_DAY BETWEEN '"+str2+"' AND '"+str3+"'										\n");
				if(!str4.equals(""))sql.append( "	  AND A.BID_STYLE =		'"+str4+"'																							\n");

								

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