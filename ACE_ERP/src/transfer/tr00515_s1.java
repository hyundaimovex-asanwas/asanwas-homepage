package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class tr00515_s1 extends HttpServlet {

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
				String  str1	= req.getParameter("v_str1");    //프로젝트
				String  str2	= req.getParameter("v_str2");    //거래처코드
				String  str3	= req.getParameter("v_str3");    //거래처명

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "LINE_PART","PROJECT","TR_PROJECT","PROJECT_NM","DETAIL_NM",
																					"CONT_NM","CONT_DT","CONT_OWN","CONT_AMT","CONT_PED",
																					"CONT_DESC","STAY_DIV","FOOD_DIV","TRANS_DIV","USE_STS",
																					"REMARK", "CREATE_DT","CREATE_USR","UPDATE_DT","UPDATE_USR",
																					"DSP_SORT"
																				}; 
				int[] intArrCN	= new int[]{   4, 10, 10, 100, 200,
																		 100,  8, 50,  13,  16,
																		 100,  1,  1,   1,   1,
																		 100, 10, 10,  10,  10,
																		   4
																	 }; 
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1, -1,
																		  -1, -1, -1,  2, -1,
																		  -1, -1, -1, -1, -1,
																		  -1, -1, -1, -1, -1,
																		  -1
																	 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT	LINE_PART, RTRIM(PROJECT) PROJECT, RTRIM(TR_PROJECT) TR_PROJECT, PROJECT_NM, RTRIM(DETAIL_NM) DETAIL_NM,   \n" )
						 .append( "					RTRIM(CONT_NM) CONT_NM, CONT_DT, RTRIM(CONT_OWN) CONT_OWN, COALESCE(CONT_AMT,0) CONT_AMT, RTRIM(CONT_PED) CONT_PED,\n")
						 .append( "					CONT_DESC, STAY_DIV, FOOD_DIV,TRANS_DIV,USE_STS, \n" )
						 .append( "					REMARK, CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_USR, RTRIM(DSP_SORT) DSP_SORT \n" )
						 .append( "		FROM TRANSFER.LTUNTCOD \n" )
						 .append( "  WHERE LINE_PART <> ''  \n");
					
					if (!str1.equals("")) sql.append( " AND LINE_PART = '" + str1 + "' \n" );
					if (!str2.equals("")) sql.append( " AND PROJECT = '" + str2 + "' \n" );
					if (!str3.equals("")) sql.append( " AND PROJECT_NM LIKE '" + str3 + "%'  \n");

				logger.dbg.println(this,sql.toString());

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
	}
}