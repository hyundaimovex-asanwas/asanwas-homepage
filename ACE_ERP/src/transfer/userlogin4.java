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
public class userlogin4 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Get 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection gconn = null;
		GauceStatement gstmt =null;
		GauceDataSet dSet = null;
		StringBuffer query = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
      GauceResponse GauceRes = service.getGauceResponse();

			try {
				gconn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String  gstr1	= req.getParameter("v_str1");

				GauceRes.enableFirstRow(dSet);

				// 실제로 조회를 해야 할 컬럼을 타입별로 정의
				String[] strArrCN = new String[]{ "VEND_CD","VEND_NM","PROJECT_CD","VEND_PRS","VEND_PST",
																					"VEND_TEL","VEND_CPHN","VEND_FAX","VEND_EMAIL","VEND_ADD1",
																					"VEND_ADD2","VEND_ADD3","REMARK","CREATE_DT","CREATE_USR",
																					"UPDATE_DT","UPDATE_UST"
																				}; 
				int[] intArrCN	= new int[]{  13, 62,   4, 30, 30,
																			25, 25,  25, 50, 35,
																			35, 35, 100, 10, 10,
																			10, 10
																	 }; 
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1, -1
																	 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING,intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				// 실제 쿼리문 작성
		   	if (!GauceReq.isBuilderRequest()) {
					query = new StringBuffer();
					query.append(" SELECT RTRIM(VEND_CD) VEND_CD, RTRIM(VEND_NM) VEND_NM, PROJECT_CD, RTRIM(VEND_PRS) VEND_PRS, RTRIM(VEND_PST) VEND_PST, \n")
							 .append("				VEND_TEL, VEND_CPHN, VEND_FAX, VEND_EMAIL, RTRIM(VEND_ADD1) VEND_ADD1, \n")
							 .append("				RTRIM(VEND_ADD2) VEND_ADD2, RTRIM(VEND_ADD3) VEND_ADD3, RTRIM(REMARK) REMARK, CREATE_DT, CREATE_USR, \n")
							 .append("				UPDATE_DT, UPDATE_UST \n")
							 .append("	 FROM TRANSFER.LTCUSTMST ")
							 .append("	WHERE VEND_CD = '" + gstr1 + "' ");

/*********************************************************************************************/

					gstmt = gconn.getGauceStatement(query.toString());
	 		    gstmt.executeQuery(dSet);
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
		  } finally {
				if (gstmt != null) try { gstmt.close(); } catch (Exception e) {}
				if (gconn != null) try {gconn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit(query.toString());
		  GauceRes.close();

		} catch (Exception e) {

			// GAUCE30/LOG/ERROR.LOG 화일로 메세지 확인
			logger.err.println(this,e);

			// GAUCE30/LOG/DEBUG.LOG 화일로 메세지 확인
			logger.dbg.println(this,e.toString());

		} finally {

			loader.restoreService(service);
  	}
	}
}



