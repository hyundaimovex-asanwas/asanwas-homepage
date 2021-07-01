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
public class tr00601_s1 extends HttpServlet {

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

				String[] strArrCN = new String[]{ "VEND_CD","VEND_NM","PROJECT_CD","VEND_PRS","VEND_PST",
														"VEND_TEL","VEND_CPHN","VEND_FAX","VEND_EMAIL","VEND_ADD1",
																"VEND_ADD2","VEND_ADD3","REMARK","CREATE_DT","CREATE_USR",
																		"UPDATE_DT","UPDATE_UST"
																				}; 
				int[] intArrCN	= new int[]{  13,  62, 4, 30,  30,
												 25, 25, 25, 50, 35,
													 35, 35, 100, 10, 10,
														 10, 10
																	 }; 
				int[] intArrCN2 = new int[]{	-1, -1, -1, -1, -1,
													 -1, -1, -1, -1, -1,
														 -1, -1, -1, -1, -1,
															 -1, -1
																	 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
		
					sql.append( " SELECT IFNULL(VEND_CD,'') VEND_CD,  IFNULL(VEND_NM,'') VEND_NM, RTRIM(PROJECT_CD) PROJECT_CD, VEND_PRS, RTRIM(VEND_PST) VEND_PST,   \n" );
					sql.append( " RTRIM(VEND_TEL) VEND_TEL, RTRIM(VEND_CPHN) VEND_CPHN, RTRIM(VEND_FAX) VEND_FAX, RTRIM(VEND_EMAIL) VEND_EMAIL, RTRIM(VEND_ADD1) VEND_ADD1,\n");
					sql.append( " RTRIM(VEND_ADD2) VEND_ADD2, RTRIM(VEND_ADD3) VEND_ADD3, RTRIM(REMARK) REMARK, CREATE_DT, CREATE_USR, \n");
					sql.append( " UPDATE_DT, UPDATE_UST \n" );
					sql.append( " FROM TRANSFER.LTCUSTMST \n" );
				
					sql.append( " WHERE PROJECT_CD <> ''  \n");
					
					if (!str1.equals("")) sql.append( " AND PROJECT_CD = '"+str1+"' \n" );
					if (!str2.equals("")) sql.append( " AND VEND_CD = '"+str2+"' \n" );
					
					if (!str3.equals("")) sql.append( " AND VEND_NM LIKE '%"+str3+"%'  \n");
				
						
					//logger.dbg.println( this, sql.toString() );
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