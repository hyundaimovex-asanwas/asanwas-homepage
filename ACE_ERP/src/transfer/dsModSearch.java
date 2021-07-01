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
public class dsModSearch extends HttpServlet {

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
				String[] strArrCN = new String[]{ "ORDER_NO","IN_OUT","ETD_DT","REQ_DATE","USERNM",
																					"MOD_REMARK","MODIFY_NO","LINE_PART","MOD_STS","REQ_USER",
																					"APP_USER"
																				}; 
				int[] intArrCN	= new int[]{  10,  1,  8,  8,  30,
																		 200, 10,  4,  1,  10,
																			10
																	 }; 
				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
																		 -1, -1, -1, -1, -1,
																		 -1
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
					query.append(" SELECT B.ORDER_NO, B.IN_OUT, B.ETD_DT, SUBSTR(CHAR(DATE(B.REQ_DATE)),1,4)||SUBSTR(CHAR(DATE(B.REQ_DATE)),6,2)||SUBSTR(CHAR(DATE(B.REQ_DATE)),9,2) REQ_DATE, C.USERNM, \n")
							 .append("				B.MOD_REMARK, B.MODIFY_NO, B.LINE_PART, B.MOD_STS, B.REQ_USER, \n")
							 .append("				B.APP_USER \n")
							 .append("	 FROM TRANSFER.LTMODUSER A, \n")
							 .append("				TRANSFER.LTMODREQ B, \n")
							 .append("				TRANSFER.LTUSER C \n")
							 .append("	WHERE A.USER_ID = '" + gstr1 + "' \n")
							 .append("		AND CASE WHEN A.LINE_PART='0000' THEN B.LINE_PART ELSE A.LINE_PART END = B.LINE_PART \n")
							 .append("		AND B.REQ_USER = C.USERID ")
							 .append("		AND B.MOD_STS = 'R' ")
							 .append("		AND A.USE_STS = 'Y' ");

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



